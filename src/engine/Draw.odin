package AnimationEngine

import "core:math/linalg"
import rl "vendor:raylib"


Draw :: proc(object: Object) {
	switch object.type {
	case .Circle:
		DrawCircle(object.position, object.size[0], object.color)
	case .Rectangle, .Sqaure:
		DrawRect(object.position, object.size, object.color)
	}
}

DrawCircle :: proc(position: [2]f32, radius: f32, color: [4]f32) {
	color_u8 := rl.ColorFromNormalized(color / 255)
	rl.DrawCircleV(position, radius, color_u8)
}

DrawRect :: proc(position, size: [2]f32, color: [4]f32) {

	rect_DrawRect: rl.Rectangle = rl.Rectangle {
		x      = position[0],
		y      = position[1],
		width  = size[0],
		height = size[1],
	}

	origin: [2]f32 = [2]f32{size[0] / 2, size[1] / 2}

	color_u8 := rl.ColorFromNormalized(color / 255)

	rl.DrawRectanglePro(rect_DrawRect, origin, 0, color_u8)
}
