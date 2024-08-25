package AnimationEngine

import "core:math/linalg"

AnimatePosition :: proc(using position: ^Position, delta: f32) {
	using animation_properties

	elapsed = UpdateAnimationElapsedTime(elapsed, duration, delta)

	eased_x: f32 = easing_function(
		elapsed,
		start_position[0],
		target_position[0] - start_position[0],
		duration,
	)
	eased_y: f32 = easing_function(
		elapsed,
		start_position[1],
		target_position[1] - start_position[1],
		duration,
	)
	current_position = [2]f32{eased_x, eased_y}
}

AnimateRectSize :: proc(using size: ^RectSize, delta: f32) {
	using animation_properties

	elapsed = UpdateAnimationElapsedTime(elapsed, duration, delta)

	eased_width: f32 = easing_function(
		elapsed,
		start_size[0],
		target_size[0] - start_size[0],
		duration,
	)
	eased_height: f32 = easing_function(
		elapsed,
		start_size[1],
		target_size[1] - start_size[1],
		duration,
	)

	current_size = [2]f32{eased_width, eased_height}
}

AnimateRadius :: proc(using radius: ^Radius, delta: f32) {
	using animation_properties
	elapsed = UpdateAnimationElapsedTime(elapsed, duration, delta)
	current_radius = easing_function(elapsed, start_radius, target_radius - start_radius, duration)
}

AnimateColor :: proc(using color: ^Color, delta: f32) {
	using animation_properties

	elapsed = UpdateAnimationElapsedTime(elapsed, duration, delta)

	eased_red: u8 = cast(u8)easing_function(
		elapsed,
		auto_cast start_color.r,
		auto_cast target_color.r - auto_cast start_color.r,
		duration,
	)
	eased_green: u8 = cast(u8)easing_function(
		elapsed,
		auto_cast start_color.g,
		auto_cast target_color.g - auto_cast start_color.g,
		duration,
	)
	eased_blue: u8 = cast(u8)easing_function(
		elapsed,
		auto_cast start_color.b,
		auto_cast target_color.b - auto_cast start_color.b,
		duration,
	)
	eased_alpha: u8 = cast(u8)easing_function(
		elapsed,
		auto_cast start_color.a,
		auto_cast target_color.a - auto_cast start_color.a,
		duration,
	)

	current_color = {eased_red, eased_green, eased_blue, eased_alpha}
}

AnimateOriginateFromCenter :: proc(size: Size, delta: f32) {


	switch v in size {
	case ^Radius:
		{
			if v.animation_properties.elapsed == 0 {
				v.start_radius = 0
			}
			AnimateRadius(v, delta)
		}
	case ^RectSize:
		{
			if v.animation_properties.elapsed == 0 {
				v.start_size = {0, 0}
			}
			AnimateRectSize(v, delta)
		}
	}
}

UpdateAnimationElapsedTime :: proc(elapsed, duration, delta: f32) -> f32 {
	t: f32 = elapsed + delta

	if t >= duration {
		return duration
	}

	return t
}
