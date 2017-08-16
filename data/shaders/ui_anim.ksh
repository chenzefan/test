   ui_anim      MatrixP                                                                                MatrixV                                                                                MatrixW                                                                                SAMPLER    +      	   TINT_MULT                             =   c:\users\jkwan~1.kle\appdata\local\temp\tmp7yi40f\anim.vs.tmp�  uniform mat4 MatrixP;
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

 @   c:\users\jkwan~1.kle\appdata\local\temp\tmp7yi40f\ui_anim.ps.tmp
  #if defined( GL_ES )
precision mediump float;
#endif

uniform sampler2D SAMPLER[2];

varying vec3 PS_TEXCOORD;

uniform vec4 TINT_ADD;
uniform vec4 TINT_MULT;

void main()
{
    vec4 colour;
    
	if( PS_TEXCOORD.z < 1.5 )
	{
		if( PS_TEXCOORD.z < 0.5 )
		{
			colour.rgba = texture2D( SAMPLER[0], PS_TEXCOORD.xy );
		}
		else
		{
			colour.rgba = texture2D( SAMPLER[1], PS_TEXCOORD.xy );
		}
	}
	
	gl_FragColor = vec4( colour.rgb * TINT_MULT.rgb * TINT_MULT.a, colour.a * TINT_MULT.a );
}

                       