shader_type canvas_item;

uniform float circle_radius : hint_range(0.0, 1.5) = 0.0;  // Start fully transparent (small circle radius)
uniform vec2 screen_center = vec2(0.5, 0.5);  // Center of the screen

void fragment() {
    vec2 uv = SCREEN_UV - screen_center;
    float dist = length(uv);

    // Make the area outside the circle black, inside it transparent
    if (dist > circle_radius) {
        COLOR = vec4(0.0, 0.0, 0.0, 1.0);  // Black outside the circle
    } else {
        COLOR = vec4(0.0, 0.0, 0.0, 0.0);  // Transparent inside the circle
    }
}