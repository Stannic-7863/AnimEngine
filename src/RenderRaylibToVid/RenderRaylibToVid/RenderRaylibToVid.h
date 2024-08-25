#ifndef RenderRaylibToVid
#define RenderRaylibToVid

#include <stddef.h>
#include <sys/types.h>

typedef struct {

  int read;
  int write;

} Pipe;

Pipe *CreatePipe();
void WriteToPipe(Pipe *pipe_fd, void *data, size_t buf_size);
void ClosePipe(Pipe *pipe_fd);
void StartFFMPEG(Pipe *pipe_fd, size_t width, size_t height, size_t fps);

#endif // RenderRaylibToVid
