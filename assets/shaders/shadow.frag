#version 460 core

#include <flutter/runtime_effect.glsl>

precision mediump float;

uniform vec2 uSize;
out vec4 fragColor;

void main() {
  vec2 coord = FlutterFragCoord().xy;
  vec2 uv = (coord  - 0.5 * uSize.xy) / uSize.y;

  fragColor = vec4(vec3(1.0 - length(uv)), 1.0);
}