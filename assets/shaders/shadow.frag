#version 460 core

#include <flutter/runtime_effect.glsl>

precision mediump float;

uniform vec2 uSize;
uniform vec2 points[100];
out vec4 fragColor;

void main() {
    vec2 coord = FlutterFragCoord().xy;
    vec2 uv = (coord - 0.5 * uSize.xy) / uSize.y;

    vec4 color = vec4(vec3(0.2), 1.0);

    float d = 1.0;
    for (int i = 0; i < 100; i++) {
        vec2 p = points[i];
        d = min(d, distance(uv, p));
    }
    
    if (d < 0.1) {
        fragColor = vec4(color.rgb, smoothstep(0, 1, d / 0.1));
        return;
    }

  fragColor = color;
}