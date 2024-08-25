package RenderRaylibToVid

foreign import LibRenderRaylibToVid "./RenderRaylibToVid/RenderRaylibToVid.a"

import "core:c"

Pipe :: struct {
	read:  c.int,
	write: c.int,
}

foreign LibRenderRaylibToVid {

	CreatePipe :: proc() -> ^Pipe ---
	WriteToPipe :: proc(pipe_fd: ^Pipe, data: rawptr, buf_size: c.size_t) ---
	ClosePipe :: proc(pipe_fd: ^Pipe) ---
	StartFFMPEG :: proc(pipe_fd: ^Pipe, width: c.size_t, height: c.size_t, fps: c.size_t) ---
}
