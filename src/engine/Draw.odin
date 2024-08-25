package AnimationEngine

import rl "vendor:raylib"

Draw :: proc(objects: ^[dynamic]AnimationObject) {
	for object_union in objects {
		switch object in object_union {
		case ^Circle:
			DrawCircle(object^)
		case ^Rect:
			DrawRect(object^)
		}
	}
}

DrawCircle :: proc(circle: Circle) {
	rl.DrawCircleV(
		circle.position.current_position,
		circle.radius.current_radius,
		cast(rl.Color)circle.color.current_color,
	)
}

DrawRect :: proc(rect: Rect) {

	rect_DrawRect: rl.Rectangle = rl.Rectangle {
		x      = rect.position.current_position[0],
		y      = rect.position.current_position[1],
		width  = rect.size.current_size[0],
		height = rect.size.current_size[1],
	}

	origin: [2]f32 = [2]f32{rect.size.current_size[0] / 2, rect.size.current_size[1] / 2}

	rl.DrawRectanglePro(rect_DrawRect, origin, 0, cast(rl.Color)rect.color.current_color)

}
