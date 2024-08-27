// Example/Test Code 
package main

import render "RenderRaylibToVid"
import "core:fmt"
import anim "engine"
import rl "vendor:raylib"

Queue :: [dynamic][dynamic]anim.Animation

main :: proc() {


	rl.SetConfigFlags({rl.ConfigFlag.WINDOW_HIGHDPI, rl.ConfigFlag.MSAA_4X_HINT})
	rl.InitWindow(4096, 2160, "Anim window")
	scr_width: i32 = cast(i32)rl.GetMonitorWidth(rl.GetCurrentMonitor())
	scr_height: i32 = cast(i32)rl.GetMonitorHeight(rl.GetCurrentMonitor())

	rl.SetWindowPosition(0, 0)
	rl.SetTargetFPS(120)

	rect_object := anim.GetObject(
		position = {40, 40},
		size = {50, 50},
		color = {1, 255, 255, 255},
		type = anim.ObjectType.Rectangle,
	)
	rect_object_animation := anim.GetAnimation(
		start = {40, 40, 0, 0},
		end = {1000, 1000, 0, 0},
		type = anim.AnimationType.Move,
		duration = 10,
		easing_function = rl.EaseBounceInOut,
	)
	rect_object_animation_color := anim.GetAnimation(
		start = {1, 255, 255, 255},
		end = {255, 0, 255, 255},
		type = anim.AnimationType.Color,
		duration = 10,
		easing_function = rl.EaseBounceInOut,
	)

	animate_queue: Queue = make(Queue)

	AddAnimationToQueue(&animate_queue, rect_object_animation)
	AddAnimationToQueue(&animate_queue, rect_object_animation_color)

	fmt.println(animate_queue)

	frames := make([dynamic]rl.Image)

	queue_current_progress := 0

	for (!rl.WindowShouldClose()) {

		delta := rl.GetFrameTime()

		rl.BeginDrawing()
		rl.ClearBackground(rl.BLACK)

		animation_arr := animate_queue[queue_current_progress]
		sub_quene_len := len(animation_arr)
		for &animation, index in animation_arr {
			anim.Animate(&rect_object, &animation, delta)
			if animation.elapsed == animation.duration {
				sub_quene_len -= 1
			}
		}
		if sub_quene_len <= 0 {
			queue_current_progress += 1
			queue_current_progress %= len(animate_queue)
		}

		anim.Draw(rect_object)
		rl.EndDrawing()

		image: rl.Image = rl.LoadImageFromScreen()

		append(&frames, image)

	}


	pipe := render.CreatePipe()
	render.StartFFMPEG(pipe, 4096, 2160, 120)

	buf_size: uint = auto_cast (4096 * 2160 * 4)

	for image in frames {
		render.WriteToPipe(pipe, image.data, buf_size)
	}
	render.ClosePipe(pipe)

	rl.CloseWindow()
	delete(frames)
}


AddAnimationToQueue :: proc(queue: ^Queue, animations: ..anim.Animation) {

	animation_arr := make([dynamic]anim.Animation)

	for animation in animations {
		append(&animation_arr, animation)
	}

	append(queue, animation_arr)
}
