shader_type canvas_item;

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV); // Sample the texture
    float red_intensity = tex_color.r; // Get the red component

    // Darken only the red areas
    vec3 darkened_color = vec3(red_intensity * 0.6, tex_color.g, tex_color.b);

    COLOR = vec4(darkened_color, tex_color.a); // Apply the new color
}
