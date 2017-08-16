   anim      MatrixP                                                                                MatrixV                                                                                MatrixW                                                                                SAMPLER    +         AMBIENT                            LIGHTMAP_WORLD_EXTENTS                                TINT_ADD                             	   TINT_MULT                                anim.vs�  uniform mat4 MatrixP;
uniform mat4 MatrixV;
uniform mat4 MatrixW;

attribute vec3 POSITION;
attribute vec3 TEXCOORD0;

varying vec3 PS_TEXCOORD;
varying vec3 PS_POS;

void main()
{
	mat4 mtxPVW = MatrixP * MatrixV * MatrixW;
	gl_Position = mtxPVW * vec4( POSITION.xyz, 1.0 );

	vec4 world_pos = MatrixW * vec4( POSITION.xyz, 1.0 );

	PS_TEXCOORD = TEXCOORD0;
	PS_POS = world_pos.xyz;
}

    anim.psP  #if defined( GL_ES )
precision mediump float;
#endif

uniform sampler2D SAMPLER[4];

#ifndef LIGHTING_H
#define LIGHTING_H

// Lighting
varying vec3 PS_POS;
uniform vec3 AMBIENT;

// xy = min, zw = max
uniform vec4 LIGHTMAP_WORLD_EXTENTS;

#define LIGHTMAP_TEXTURE SAMPLER[3]

#ifndef LIGHTMAP_TEXTURE
	#error "If you use lighting, you must #define the sampler that the lightmap belongs to"
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


varying vec3 PS_TEXCOORD;

uniform vec4 TINT_ADD;
uniform vec4 TINT_MULT;

void main()
{
	vec4 colour;
	if( PS_TEXCOORD.z < 0.5 )
	{
		colour.rgba = texture2D( SAMPLER[0], PS_TEXCOORD.xy );
	}
	else
	{
		colour.rgba = texture2D( SAMPLER[1], PS_TEXCOORD.xy );
	}

	vec3 light = CalculateLightingContribution();

	colour.rgb *= light.rgb;

	gl_FragColor.rgba = colour.rgba;
	gl_FragColor.rgba *= TINT_MULT.rgba;
	gl_FragColor.rgba += vec4( TINT_ADD.rgb * colour.a, TINT_ADD.a );
}

                                