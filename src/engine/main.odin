package AnimationEngine

AnimationProperties :: struct {
	duration, elapsed: f32,
	easing_function:   proc(t, b, c, d: f32) -> f32,
}

Position :: struct {
	start_position, current_position, target_position: [2]f32,
	animation_properties:                              AnimationProperties,
}

RectSize :: struct {
	start_size, current_size, target_size: [2]f32,
	animation_properties:                  AnimationProperties,
}

Radius :: struct {
	start_radius, current_radius, target_radius: f32,
	animation_properties:                        AnimationProperties,
}

Rotation :: struct {
	start_rotation, current_rotation, target_rotation: f32,
	animation_properties:                              AnimationProperties,
}

Color :: struct {
	start_color, current_color, target_color: [4]u8,
	animation_properties:                     AnimationProperties,
}


GetAnimationProperties :: proc(
	duration: f32,
	easing_function: proc(t, b, c, d: f32) -> f32,
) -> AnimationProperties {
	return AnimationProperties{duration = duration, elapsed = 0, easing_function = easing_function}
}

GetPosition :: proc(
	start_pos, target_pos: [2]f32,
	duration: f32,
	easing_function: proc(t, b, c, d: f32) -> f32,
) -> Position {
	return Position {
		start_position = start_pos,
		current_position = start_pos,
		target_position = target_pos,
		animation_properties = GetAnimationProperties(duration, easing_function),
	}
}

GetSize :: proc(
	start_size, target_size: [2]f32,
	duration: f32,
	easing_function: proc(t, b, c, d: f32) -> f32,
) -> RectSize {
	return RectSize {
		start_size = start_size,
		current_size = start_size,
		target_size = target_size,
		animation_properties = GetAnimationProperties(duration, easing_function),
	}
}

GetRadius :: proc(
	start_radius, target_radius: f32,
	duration: f32,
	easing_function: proc(t, b, c, d: f32) -> f32,
) -> Radius {
	return Radius {
		start_radius = start_radius,
		current_radius = start_radius,
		target_radius = target_radius,
		animation_properties = GetAnimationProperties(duration, easing_function),
	}
}

GetColor :: proc(
	start_color, target_color: [4]u8,
	duration: f32,
	easing_function: proc(t, b, c, d: f32) -> f32,
) -> Color {
	return Color {
		start_color = start_color,
		current_color = start_color,
		target_color = target_color,
		animation_properties = GetAnimationProperties(duration, easing_function),
	}
}

GetCircle :: proc(
	start_pos, target_pos: [2]f32,
	start_radius, target_radius: f32,
	start_color, target_color: [4]u8,
	duration: f32,
	easing_function: proc(t, b, c, d: f32) -> f32,
) -> Circle {
	return Circle {
		position = GetPosition(start_pos, target_pos, duration, easing_function),
		radius = GetRadius(start_radius, target_radius, duration, easing_function),
		color = GetColor(start_color, target_color, duration, easing_function),
	}
}

GetRect :: proc(
	start_pos, target_pos: [2]f32,
	start_size, target_size: [2]f32,
	start_color, target_color: [4]u8,
	duration: f32,
	easing_function: proc(t, b, c, d: f32) -> f32,
) -> Rect {
	return Rect {
		position = GetPosition(start_pos, target_pos, duration, easing_function),
		size = GetSize(start_size, target_size, duration, easing_function),
		color = GetColor(start_color, target_color, duration, easing_function),
	}
}
