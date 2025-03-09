shader_type canvas_item;

uniform float speed = 0.5;      // Base speed of stars
uniform float density = 0.002;    // Number of stars
uniform float star_size = 2;  // Controls star size
uniform vec3 star_color = vec3(1.0, 1.0, 1.0); // Star color
uniform float flicker_intensity = 0.3; // How much stars flicker

void fragment() {
    vec2 uv = UV;

    // Time offset for smooth movement
    float time_offset = TIME * speed;

    // Create multiple layers of stars for depth effect
    float star_layer1 = fract(sin(dot(floor(uv * 100.0), vec2(12.9898, 78.233))) * 43758.5453);
    float star_layer2 = fract(sin(dot(floor(uv * 200.0), vec2(25.7689, 45.894))) * 35672.4843);
    float star_layer3 = fract(sin(dot(floor(uv * 300.0), vec2(37.6543, 89.123))) * 87563.2134);

    // Make stars sparser by filtering based on density
    star_layer1 = step(0.98 - density * 0.4, star_layer1);
    star_layer2 = step(0.98 - density * 0.5, star_layer2);
    star_layer3 = step(0.98 - density * 0.6, star_layer3);

    // Add smooth flickering effect
    float flicker1 = sin(TIME * 2.0 + uv.y * 10.0) * flicker_intensity;
    float flicker2 = sin(TIME * 3.0 + uv.x * 15.0) * flicker_intensity;
    float flicker3 = sin(TIME * 4.0 + uv.y * 20.0) * flicker_intensity;

    // Move stars at different speeds (parallax)
    float offset1 = mod(uv.y + time_offset * 0.3, 1.0);
    float offset2 = mod(uv.y + time_offset * 0.6, 1.0);
    float offset3 = mod(uv.y + time_offset * 1.0, 1.0);

    // Blend all layers
    float star_brightness = (star_layer1 * (offset1 + flicker1) +
                             star_layer2 * (offset2 + flicker2) +
                             star_layer3 * (offset3 + flicker3)) * star_size * 0.5;

    // Final output
    COLOR = vec4(star_color * star_brightness, star_brightness);
}
