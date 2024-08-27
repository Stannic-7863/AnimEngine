package AnimationEngine

import "core:math/linalg"

Animate :: proc(object: ^Object, animation: ^Animation, delta: f32) {
	using animation

	switch animation.type {
	case .Move:
		object.position = AnimateVector2(
			delta,
			{start[0], start[1]},
			{end[0], end[1]},
			&properties,
		)
	case .Color:
		object.color = AnimateColor(delta, start, end, &properties)
	case .Resize:
		object.size = AnimateVector2(delta, {start[0], start[1]}, {end[0], end[1]}, &properties)
	}
}

AnimateVector2 :: proc(
	delta: f32,
	start, end: [2]f32,
	properties: ^AnimationProperties,
) -> [2]f32 {
	using properties

	elapsed = UpdateAnimationElapsedTime(elapsed, duration, delta)

	eased_x: f32 = easing_function(elapsed, start[0], end[0] - start[0], duration)
	eased_y: f32 = easing_function(elapsed, start[1], end[1] - start[1], duration)

	return {eased_x, eased_y}
}

//AnimateRadius :: proc(delta: f32, start, end: f32, properties: ^AnimationProperties) -> [2]f32 {
//	using properties
//
//	elapsed = UpdateAnimationElapsedTime(elapsed, duration, delta)
//
//	eased_radius: f32 = easing_function(elapsed, start, end - start, duration)
//
//	return eased_radius
//}

AnimateColor :: proc(delta: f32, start, end: [4]f32, properties: ^AnimationProperties) -> [4]f32 {
	using properties

	elapsed = UpdateAnimationElapsedTime(elapsed, duration, delta)

	eased_r: f32 = easing_function(elapsed, start[0], end[0] - start[0], duration)
	eased_g: f32 = easing_function(elapsed, start[1], end[1] - start[1], duration)
	eased_b: f32 = easing_function(elapsed, start[2], end[2] - start[2], duration)
	eased_a: f32 = easing_function(elapsed, start[3], end[3] - start[3], duration)


	return {eased_r, eased_g, eased_b, eased_a}
}
//
//AnimateOriginateFromCenter :: proc(size: Size, delta: f32) {
//
//
//	switch v in size {
//	case ^Radius:
//		{
//			if v.animation_properties.elapsed == 0 {
//				v.start_radius = 0
//			}
//			AnimateRadius(v, delta)
//		}
//	case ^RectSize:
//		{
//			if v.animation_properties.elapsed == 0 {
//				v.start_size = {0, 0}
//			}
//			AnimateRectSize(v, delta)
//		}
//	}
//}

UpdateAnimationElapsedTime :: proc(elapsed, duration, delta: f32) -> f32 {
	t: f32 = elapsed + delta

	if t >= duration {
		return duration
	}

	return t
}
