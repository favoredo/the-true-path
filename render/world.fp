#version 140
in mediump vec2 var_uv;
out vec4 color;
uniform lowp sampler2D texture_sampler;
void main(){color=texture(texture_sampler,var_uv);if(color.a<0.02)discard;}
