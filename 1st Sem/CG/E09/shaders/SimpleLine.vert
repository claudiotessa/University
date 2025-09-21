#version 450
#extension GL_ARB_separate_shader_objects : enable

// An array of bindings that are used in this shader.
// Set 0, Binding 0
layout(set = 0, binding = 0) uniform GlobalUniformBufferObject {
    vec3 lightDir;
    vec4 lightColor;
    vec3 eyePos;
} gubo;

// Set 1, Binding 0
layout(set = 1, binding = 0) uniform UniformBufferObjectSimp {
    mat4 mvpMat;
    mat4 mMat;
    mat4 nMat;
} ubos;

// Input vertex data from the vertex buffer
layout(location = 0) in vec3 inPos;

void main() {
    // Transform the input position using the MVP matrix
    gl_Position = ubos.mvpMat * vec4(inPos, 1.0);
}