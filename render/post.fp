#version 140
in mediump vec2 var_uv;
out vec4 color;
uniform lowp sampler2D scene_texture;
uniform lowp sampler2D mask_texture;
uniform fs_uniforms { highp vec4 light; highp vec4 camera_info; highp vec4 view_size; };
void main(){
 vec2 world=(var_uv-0.5)*view_size.xy+camera_info.xy;
 float d=distance(world,light.xy);
 float f=(1.0-0.55*clamp(d/light.z,0.0,1.0))*(1.0-smoothstep(0.65*light.z,light.z,d));
 float mask=texture(mask_texture,var_uv).r;
 vec3 scene=texture(scene_texture,var_uv).rgb;
 vec3 lit=scene*mix(vec3(0.65,0.77,0.73),vec3(1.24,1.01,0.72),f)*light.w;
 color=vec4(mix(vec3(0.012,0.02,0.022),lit,mask*f),1.0);
}
