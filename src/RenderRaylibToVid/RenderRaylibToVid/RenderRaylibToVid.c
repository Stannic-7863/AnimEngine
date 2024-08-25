#include "RenderRaylibToVid.h"
#include <raylib.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <unistd.h>

Pipe *CreatePipe() {
  Pipe *p = malloc(sizeof(Pipe));

  if (!p) {
    exit(0);
  }

  int pipe_fd[2];

  if (pipe(pipe_fd) == -1) {
    free(p);
    exit(0);
  }

  p->read = pipe_fd[0];
  p->write = pipe_fd[1];

  return p;
}

void StartFFMPEG(Pipe *pipe_fd, size_t width, size_t height, size_t fps) {
  pid_t pid = fork();
  if (pid == -1) {
    perror("fork");
    exit(EXIT_FAILURE);
  } else if (pid == 0) {
    close(pipe_fd->write);

    dup2(pipe_fd->read, STDIN_FILENO);
    close(pipe_fd->read);

    // Prepare the ffmpeg command
    char *ffmpeg_cmd[] = {"ffmpeg",
                          "-y", // Overwrite output file if it exists
                          "-f",
                          "rawvideo", // Input format: raw video
                          "-pixel_format",
                          "rgba", // Input pixel format
                          "-video_size",
                          "1920x1080", // Frame size
                          "-framerate",
                          "30", // Frame rate
                          "-i",
                          "-", // Input comes from stdin
                          "-c:v",
                          "libx264", // Video codec
                          "-pix_fmt",
                          "yuv420p",    // Output pixel format
                          "output.mp4", // Output file
                          NULL};

    execvp("ffmpeg", ffmpeg_cmd);
    perror("execvp");
    exit(EXIT_FAILURE);
  } else {
    close(pipe_fd->read);
  }
}

void WriteToPipe(Pipe *pipe_fd, void *data, size_t buf_size) {
  write(pipe_fd->write, data, buf_size);
}

void ClosePipe(Pipe *pipe_fd) {
  close(pipe_fd->write);
  free(pipe_fd);
  int status;
  waitpid(-1, &status, 0);
}
