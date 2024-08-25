package main

import render "RenderRaylibToVid"
import "core:fmt"
import anim "engine"
import rl "vendor:raylib"

main :: proc() {

	rl.InitWindow(800, 640, "Anim window")
	defer rl.CloseWindow()
	scr_width: i32 = cast(i32)rl.GetMonitorWidth(rl.GetCurrentMonitor())
	scr_height: i32 = cast(i32)rl.GetMonitorHeight(rl.GetCurrentMonitor())

	rl.SetWindowSize(scr_width, scr_height)

	rect: anim.Rect = anim.GetRect(
		start_pos = {500, 500},
		target_pos = {400, 400},
		start_size = {70, 20},
		target_size = {100, 30},
		start_color = {100, 200, 255, 255},
		target_color = {233, 24, 200, 255},
		duration = 2,
		easing_function = rl.EaseBounceInOut,
	)

	circle: anim.Circle = anim.GetCircle(
		start_pos = {300, 300},
		target_pos = {500, 500},
		start_radius = 20,
		target_radius = 40,
		start_color = {50, 50, 50, 255},
		target_color = {100, 100, 200, 255},
		duration = 3,
		easing_function = rl.EaseSineInOut,
	)

	frames: [dynamic]rawptr

	rl.SetTargetFPS(60)

	for (!rl.WindowShouldClose()) {
		delta: f32 = rl.GetFrameTime()

		anim.AnimatePosition(&rect.position, delta)
		anim.AnimateColor(&rect.color, delta)
		anim.AnimateOriginateFromCenter(&rect.size, delta)

		anim.AnimatePosition(&circle.position, delta)
		anim.AnimateOriginateFromCenter(&circle.radius, delta)
		anim.AnimateColor(&circle.color, delta)

		rl.BeginDrawing()
		rl.ClearBackground(rl.BLACK)
		anim.DrawRect(rect)
		anim.DrawCircle(circle)
		rl.EndDrawing()

		image := rl.LoadImageFromScreen()
		append(&frames, image.data)
	}

	pipe: ^render.Pipe = render.CreatePipe()
	render.StartFFMPEG(pipe, auto_cast scr_width, auto_cast scr_height, 60)

	for data in frames {
		render.WriteToPipe(pipe, data, auto_cast (scr_width * scr_height * 4))
	}
	render.ClosePipe(pipe)
	clear(&frames)
}
