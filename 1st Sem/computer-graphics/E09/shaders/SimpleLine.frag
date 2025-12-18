#version 450
#extension GL_ARB_separate_shader_objects : enable

// This is the output color that will be written to the framebuffer
layout(location = 0) out vec4 outColor;

void main() {
    // Set the output color to solid black
    outColor = vec4(0.0, 0.0, 0.0, 1.0);
}