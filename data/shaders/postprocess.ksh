   postprocess      SAMPLER    +         CC_LERP                     ndc.vs�   attribute vec3 POSITION;
attribute vec2 TEXCOORD0;

varying vec2 PS_TEXCOORD;

void main()
{
	gl_Position = vec4( POSITION.xyz, 1.0 );
	PS_TEXCOORD.xy = TEXCOORD0.xy;
}

    postprocess.psH  #if defined( GL_ES )
precision highp float;
#endif

#if defined( ENABLE_BLOOM )

	uniform sampler2D SAMPLER[4];
#	define BLOOM_BUFFER		SAMPLER[3]	

#else
	uniform sampler2D SAMPLER[3];
#endif

uniform float CC_LERP;

#define SRC_IMAGE			SAMPLER[0]
#define COLOUR_CUBE_SRC		SAMPLER[1]
#define COLOUR_CUBE_DEST	SAMPLER[2]

varying vec2 PS_TEXCOORD;

#define CUBE_DIMENSION 32.0
#define CUBE_WIDTH ( CUBE_DIMENSION * CUBE_DIMENSION )
#define CUBE_HEIGHT ( CUBE_DIMENSION )

void main()
{
	vec3 base_colour = texture2D( SRC_IMAGE, PS_TEXCOORD.xy ).rgb; // rgb all 0:1 - colour space

#if defined( ENABLE_BLOOM )
	vec4 bloom = texture2D( BLOOM_BUFFER, PS_TEXCOORD.xy ).rgba;
	base_colour.rgb += bloom.rgb;
#endif

    vec3 intermediate = base_colour.rgb * vec3( CUBE_DIMENSION - 1.0, CUBE_DIMENSION, CUBE_DIMENSION - 1.0 / CUBE_WIDTH ); // rgb all 0:31 - cube space

    // 0:1 - uv space
    vec2 cube_uv = vec2( ( min( intermediate.r + 0.5, 31.0 ) + floor( intermediate.b ) * CUBE_DIMENSION ) / CUBE_WIDTH,
                          1.0 - ( min( intermediate.g, 31.0 ) / CUBE_HEIGHT ) );
                          
	vec3 cc_src = texture2D( COLOUR_CUBE_SRC, cube_uv.xy ).rgb;
	vec3 cc_dest = texture2D( COLOUR_CUBE_DEST, cube_uv.xy ).rgb;

    gl_FragColor = vec4( mix( cc_src, cc_dest, CC_LERP ), 1.0 );
}

               