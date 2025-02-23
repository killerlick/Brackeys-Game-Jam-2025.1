shader_type canvas_item;

void fragment() {
    vec2 distortedUV = UV;
    distortedUV.x =distortedUV.x + sin(distortedUV.y * 20.0 + TIME) * 0.01;
    COLOR = texture(TEXTURE, distortedUV);
}