	   triplanar      MatrixP                                                                                MatrixV                                                                                MatrixW                                                                                SAMPLER    +         AMBIENT                            LIGHTMAP_WORLD_EXTENTS                                triplanar.vsg  uniform mat4 MatrixP;
uniform mat4 MatrixV;
uniform mat4 MatrixW;

attribute vec3 POSITION;
attribute vec3 NORMAL;
attribute vec2 TEXCOORD0;
attribute vec2 TEXCOORD1;

varying vec2 PS_TEXCOORD0;
varying vec2 PS_TEXCOORD1;
varying vec2 PS_TEXCOORD2;

varying vec3 PS_NORMAL;
varying vec3 PS_POSITION;

varying vec3 PS_POS;

varying float TILE_TYPE;

// TODO: MASK

void main ()
{
 

    float texure_scale = 0.125;
   	PS_TEXCOORD0 = POSITION.xz*texure_scale;
   	PS_TEXCOORD1 = POSITION.zy*texure_scale;
    PS_TEXCOORD2 = POSITION.xy*texure_scale;

   	PS_POSITION = POSITION;

    PS_NORMAL = NORMAL;
    
    TILE_TYPE = TEXCOORD1.x;
         
	mat4 mtxPVW = MatrixP * MatrixV * MatrixW;
	gl_Position = mtxPVW * vec4( POSITION.xyz, 1.0 );

	vec4 world_pos = MatrixW * vec4( POSITION.xyz, 1.0 );
	PS_POS.xyz = world_pos.xyz;
}    triplanar.psS  #if defined( GL_ES )
precision mediump float;
#endif

uniform sampler2D SAMPLER[8]; // SAMPLER[3] used in lighting.h

#define ROCK_TEXTURE        SAMPLER[0]
#define DIRT_TEXTURE        SAMPLER[1]
#define MARSH_TEXTURE       SAMPLER[2]
// SAMPLER[3] used in lighting.h
#define CAVE_TEXTURE        SAMPLER[4]
#define FUNGUS_TEXTURE      SAMPLER[5]
#define SINKHOLE_TEXTURE    SAMPLER[6]
#define MUD_TEXTURE         SAMPLER[7]
//#define CEILING_TOP_TEXTURE SAMPLER[8]

#define ROCK_TILE           151.5
#define DIRT_TILE           152.5
#define MARSH_TILE          153.5
#define CAVE_TILE           154.5
#define FUNGUS_TILE         155.5
#define SINKHOLE_TILE       156.5
#define MUD_TILE            157.5
#define CEILING_TOP_TILE    158.5

varying vec2 PS_TEXCOORD0;
varying vec2 PS_TEXCOORD1;
varying vec2 PS_TEXCOORD2;
varying vec3 PS_NORMAL;


varying vec3 PS_POSITION;
varying float TILE_TYPE;

// Already defined by lighting.h
// varying vec3 PS_POS

#ifndef LIGHTING_H
#define LIGHTING_H

// Lighting
varying vec3 PS_POS;
uniform vec3 AMBIENT;

// xy = min, zw = max
uniform vec4 LIGHTMAP_WORLD_EXTENTS;

#define LIGHTMAP_TEXTURE SAMPLER[3]

#ifndef LIGHTMAP_TEXTURE
	#error If you use lighting, you must #define the sampler that the lightmap belongs to
#endif

vec3 CalculateLightingContribution()
{
	vec2 range = LIGHTMAP_WORLD_EXTENTS.zw - LIGHTMAP_WORLD_EXTENTS.xy;
	vec2 uv = ( PS_POS.xz - LIGHTMAP_WORLD_EXTENTS.xy ) / range.xy;

	vec3 colour = texture2D( LIGHTMAP_TEXTURE, uv.xy ).rgb + AMBIENT.rgb;

	return clamp( colour.rgb, vec3( 0, 0, 0 ), vec3( 1, 1, 1 ) );
}

vec3 CalculateLightingContribution( vec3 normal )
{
	return vec3( 1, 1, 1 );
}

#endif //LIGHTING.h



void main (void)
{
	vec4 noise_colour;                
    vec4 weights = vec4(1.0, 1.0, 1.0, 1.0);
   
    vec2 Z_TEXCOORD = PS_TEXCOORD2;
    vec2 X_TEXCOORD = PS_TEXCOORD1;
    vec2 Y_TEXCOORD = PS_TEXCOORD0; // Y - CEILING
                       
    // this comes from the gpu gems 3 article:
    // generating complex procedural terrains using the gpu
    // used to determine how much of each planar lookup to use
    // for each texture
    vec3 weighting = abs(PS_NORMAL);
    weighting = (weighting - 0.2) * 7.0;
    weighting = max(weighting, vec3(0.0, 0.0, 0.0));
    weighting /= weighting.x + weighting.y + weighting.z;

    // Debugging - force plane
    // weighting.z = 0.0;
    // weighting.y = 1.0; // CEILING
    // weighting.x = 1.0;
              
    vec4 finalColor = vec4(0.0, 0.0, 0.0, 1.0);
    vec4 tempColor = vec4(0.0, 0.0, 0.0, 1.0);
              
    if(TILE_TYPE < ROCK_TILE) 
    {         
        // ROCK_TEXTURE
        tempColor = weighting.z * texture2D(ROCK_TEXTURE, Z_TEXCOORD);
        tempColor += weighting.x * texture2D(ROCK_TEXTURE, X_TEXCOORD);
        tempColor += weighting.y * texture2D(ROCK_TEXTURE, Y_TEXCOORD);
        //finalColor += weights.y * tempColor;
        finalColor += tempColor;      
        noise_colour = vec4(1.0, 1.0, 0.0, 1.0);
    }
    else if(TILE_TYPE < DIRT_TILE) 
    {
        // DIRT_TEXTURE
        tempColor = weighting.z * texture2D(DIRT_TEXTURE, Z_TEXCOORD);
        tempColor += weighting.x * texture2D(DIRT_TEXTURE, X_TEXCOORD);
        tempColor += weighting.y * texture2D(DIRT_TEXTURE, Y_TEXCOORD);
        finalColor += tempColor;
        //finalColor += weights.w * tempColor;
        noise_colour = vec4(0.0, 1.0, 0.0, 1.0);
    }
    else if(TILE_TYPE < MARSH_TILE) 
    {
       
        // MARSH_TEXTURE
        tempColor = weighting.z * texture2D(MARSH_TEXTURE, Z_TEXCOORD);
        tempColor += weighting.x * texture2D(MARSH_TEXTURE, X_TEXCOORD);
        tempColor += weighting.y * texture2D(MARSH_TEXTURE, Y_TEXCOORD);
        //finalColor += weights.x * tempColor;
        finalColor += tempColor;
        noise_colour = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else if(TILE_TYPE < CAVE_TILE) 
    {
       
        // CAVE_TEXTURE
        tempColor = weighting.z * texture2D(CAVE_TEXTURE, Z_TEXCOORD);
        tempColor += weighting.x * texture2D(CAVE_TEXTURE, X_TEXCOORD);
        tempColor += weighting.y * texture2D(CAVE_TEXTURE, Y_TEXCOORD);
        //finalColor += weights.x * tempColor;
        finalColor += tempColor;
        noise_colour = vec4(1.0, 0.0, 1.0, 1.0);
    }
    else if(TILE_TYPE < FUNGUS_TILE) 
    {
       
        // FUNGUS_TEXTURE
        tempColor = weighting.z * texture2D(FUNGUS_TEXTURE, Z_TEXCOORD);
        tempColor += weighting.x * texture2D(FUNGUS_TEXTURE, X_TEXCOORD);
        tempColor += weighting.y * texture2D(FUNGUS_TEXTURE, Y_TEXCOORD);
        //finalColor += weights.x * tempColor;
        finalColor += tempColor;
        noise_colour = vec4(0.0, 1.0, 1.0, 1.0);
    }
    else if(TILE_TYPE < SINKHOLE_TILE) 
    {
  
        // SINKHOLE_TEXTURE
        tempColor = weighting.z * texture2D(SINKHOLE_TEXTURE, Z_TEXCOORD);
        tempColor += weighting.x * texture2D(SINKHOLE_TEXTURE, X_TEXCOORD);
        tempColor += weighting.y * texture2D(SINKHOLE_TEXTURE, Y_TEXCOORD);
        //finalColor += weights.z * tempColor;
        finalColor += tempColor;

        noise_colour = vec4(0.5, 1.0, 0.5, 1.0);
     }
    else if(TILE_TYPE < MUD_TILE) 
    {
  
        // MUD_TEXTURE
        tempColor = weighting.z * texture2D(MUD_TEXTURE, Z_TEXCOORD);
        tempColor += weighting.x * texture2D(MUD_TEXTURE, X_TEXCOORD);
        tempColor += weighting.y * texture2D(MUD_TEXTURE, Y_TEXCOORD);
        //finalColor += weights.z * tempColor;
        finalColor += tempColor;

        noise_colour = vec4(0.5, 0.8, 0.5, 1.0);
     }
    else if(TILE_TYPE < CEILING_TOP_TILE) 
    {
  
        // SINKHOLE_TEXTURE
        //tempColor = weighting.z * texture2D(CEILING_TOP_TEXTURE, Z_TEXCOORD);
        //tempColor += weighting.x * texture2D(CEILING_TOP_TEXTURE, X_TEXCOORD);
        //tempColor += weighting.y * texture2D(CEILING_TOP_TEXTURE, Y_TEXCOORD);
        //finalColor += weights.z * tempColor;
        //finalColor += tempColor;
        finalColor = vec4(0.0, 0.0, 0.0, 1.0);
        noise_colour = vec4(0.0, 0.5, 0.0, 1.0);
     }
    else 
    {
        noise_colour = vec4(1.0, 0.0, 0.0, 1.0);
        finalColor += noise_colour;
    }

    finalColor.rgb *= CalculateLightingContribution();             
    gl_FragColor = finalColor;//+noise_colour*0.5; 

}                           