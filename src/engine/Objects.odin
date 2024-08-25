package AnimationEngine

import fmt "core:fmt"
import rl "vendor:raylib"

AnimationObject :: union {
	^Circle,
	^Rect,
}

Size :: union {
	^RectSize,
	^Radius,
}

Circle :: struct {
	position: Position,
	radius:   Radius,
	color:    Color,
}

Rect :: struct {
	position: Position,
	size:     RectSize,
	color:    Color,
}
