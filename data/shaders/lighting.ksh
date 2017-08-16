   lighting      MatrixP                                                                                MatrixV                                                                                MatrixW                                                                             	   LIGHT_POS                            LIGHT_COLOUR                            LIGHT_PARAMETERS                            LIGHT_CONSTANTS                         A   c:\users\jkwan~1.kle\appdata\local\temp\tmpyjku5n\lighting.vs.tmpL  uniform mat4 MatrixP;
uniform mat4 MatrixV;
uniform mat4 MatrixW;

attribute vec3 POSITION;

varying vec4 PS_POS;

void main()
{
	mat4 mtxPVW = MatrixP * MatrixV * MatrixW;

	gl_Position = mtxPVW * vec4( POSITION.xyz, 1.0 );

	vec4 world_pos = MatrixW * vec4( POSITION.xyz, 1.0 );
	PS_POS.xyz = world_pos.xyz;
}

 A   c:\users\jkwan~1.kle\appdata\local\temp\tmpyjku5n\lighting.ps.tmpL  #if defined( GL_ES )
precision highp float;
#endif

varying vec4 PS_POS;

uniform vec3 LIGHT_POS;
uniform vec3 LIGHT_COLOUR;
uniform vec3 LIGHT_PARAMETERS;
uniform vec3 LIGHT_CONSTANTS;


#define FC LIGHT_PARAMETERS.x
#define RC LIGHT_PARAMETERS.y
#define S LIGHT_PARAMETERS.z

#define K0 LIGHT_CONSTANTS.x
#define K1 LIGHT_CONSTANTS.y

void main()
{
	
	float dist = distance(PS_POS.xz, LIGHT_POS.xz);
	float t = clamp( exp(K0* pow((dist/RC), -K1)), 0.0, 1.0);
	vec3 colour = mix( vec3( 0, 0, 0 ), LIGHT_COLOUR.rgb, t );
	gl_FragColor = vec4( colour, 1 );
}

                             