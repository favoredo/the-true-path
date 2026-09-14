#version 140
in mediump vec2 var_uv;
out vec4 color;
void main(){
 vec2 p=var_uv*2.0-1.0;
 float width=0.65*(1.0-var_uv.y)+0.04;
 float a=(1.0-smoothstep(width*0.7,width,abs(p.x)))*smoothstep(0.0,0.15,var_uv.y)*(1.0-smoothstep(0.85,1.0,var_uv.y));
 vec3 c=mix(vec3(0.9,0.32,0.055),vec3(1.0,0.78,0.3),1.0-var_uv.y);
 color=vec4(c*a,a);
}
