
   anim_bloom      MatrixP                                                                                MatrixV                                                                                MatrixW                                                                                SAMPLER    +      C   c:\users\jkwan~1.kle\appdata\local\temp\tmpyspzch\anim_bloom.vs.tmp/  uniform mat4 MatrixP;
uniform mat4 MatrixV;
uniform mat4 MatrixW;

attribute vec3 POSITION;
attribute vec3 TEXCOORD0;

varying vec3 PS_TEXCOORD;

void main()
{
	mat4 mtxPVW = MatrixP * MatrixV * MatrixW;
	gl_Position = mtxPVW * vec4( POSITION.xyz, 1.0 );

	PS_TEXCOORD = TEXCOORD0;
}

 C   c:\users\jkwan~1.kle\appdata\local\temp\tmpyspzch\anim_bloom.ps.tmp�  #if defined( GL_ES )
precision mediump float;
#endif

uniform sampler2D SAMPLER[2];
varying vec3 PS_TEXCOORD;

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

    gl_FragColor.rgba = vec4( 0, 0, 0, colour.a );
}

                    