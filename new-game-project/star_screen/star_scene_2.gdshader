	shader_type canvas_item;

uniform float speed = 1.0;  // Speed of the zoom effect
uniform float density = 1.2;  // Number of stars
uniform float star_size = 1.2;  // Star glow size
uniform vec3 star_color = vec3(1.0, 1.0, 1.0);  // Star color
uniform float twist = 0.5; // Amount of warping/twisting
uniform float depth_effect = 2.0; // Controls zoom depth

void fragment() {
    vec2 uv = UV - 0.5;  // Center the UV coordinates
    float r = length(uv);  // Get radial distance from center
    float angle = atan(uv.y, uv.x);  // Get angle in polar coordinates

    // Apply twisting effect
    angle += twist * sin(r * 10.0 - TIME * speed);

    // Convert back to UV space
    vec2 warped_uv = vec2(cos(angle), sin(angle)) * r;

    // Simulate stars using noise function
    float depth = mix(0.3, 1.0, fract(sin(dot(floor(warped_uv * 200.0), vec2(12.9898, 78.233))) * 43758.5453));
    float star = fract(sin(dot(floor(warped_uv * 900.0 - TIME * speed * depth), vec2(12.9898, 78.233))) * 43758.5453);

    // Star density control
    star = step(0.98 - density * 0.4, star);

    // Twinkling effect
    float flicker = 0.5 + 0.5 * sin(TIME * (5.0 + depth * 2.0));
    star *= flicker;

    // Glow effect
    float glow = smoothstep(0.0, star_size * 0.1, star);

    // Create wormhole depth effect (makes center appear as if zooming in)
    float zoom = exp(-r * depth_effect);

    // Final color output
    COLOR = vec4(star_color * glow * zoom, glow * zoom);
}
