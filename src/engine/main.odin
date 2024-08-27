package AnimationEngine

import rl "vendor:raylib"

AnimationProperties :: struct {
	duration, elapsed: f32,
	easing_function:   proc(t, b, c, d: f32) -> f32,
}

AnimationType :: enum {
	Move,
	Resize,
	Color,
}

ObjectType :: enum {
	Circle,
	Sqaure,
	Rectangle,
}

Object :: struct {
	size, position: [2]f32,
	color:          [4]f32,
	type:           ObjectType,
}

Animation :: struct {
	type:             AnimationType,
	start, end:       [4]f32,
	using properties: AnimationProperties,
}

GetObject :: proc(position: [2]f32, size: [2]f32, color: [4]f32, type: ObjectType) -> Object {
	return Object{position = position, size = size, color = color, type = type}
}

GetAnimation :: proc(
	start, end: [4]f32,
	type: AnimationType,
	duration: f32,
	easing_function: proc(t, b, c, d: f32) -> f32,
) -> Animation {
	return Animation {
		type = type,
		start = start,
		end = end,
		properties = AnimationProperties {
			duration = duration,
			elapsed = 0,
			easing_function = easing_function,
		},
	}
}
