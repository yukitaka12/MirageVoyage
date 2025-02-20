precision mediump float;

uniform sampler2D tex1;
uniform sampler2D tex2;
uniform vec2 resolution;
uniform vec2 touch;

varying vec2 vUv;

#define waveSpeed 0.82
#define touchScale 0.003
#define Attenuation 0.96

void main(){
    vec2 stride = 1./resolution;

    float u = 0.0;
    float d = length(vUv-touch);
    if(d<touchScale){
        u = 1.;
    }
    else{
        //vec2 u;
        u = (2.*texture2D(tex1,vUv).r +
        waveSpeed*waveSpeed*(
            texture2D(tex1,vUv-vec2(stride.x,0.)).r+
            texture2D(tex1,vUv+vec2(stride.x,0.)).r+
            texture2D(tex1,vUv-vec2(0.,stride.y)).r+
            texture2D(tex1,vUv+vec2(0.,stride.y)).r-
            4.*texture2D(tex1,vUv).r
        )-texture2D(tex2,vUv).r) * Attenuation;
        //u = (u+1.)*0.5;
        //u*=0.01;

        /*u = texture2D(tex1,vUv-vec2(stride.x,0.)).r+
            texture2D(tex1,vUv+vec2(stride.x,0.)).r+
            texture2D(tex1,vUv-vec2(0.,stride.y)).r+
            texture2D(tex1,vUv+vec2(0.,stride.y)).r;
            u *= Attenuation;*/
            //u = texture2D(tex1,vUv).r * Attenuation;   
    }
    gl_FragColor = vec4(vec3(u),1.);
}