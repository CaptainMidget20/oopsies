// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Midget/Barrel Distort"
{
	Properties
	{
		_cCircle("cCircle", Range( 0 , 1)) = 1
		_power("power", Float) = 1
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_PanningXworksonlyifrotated("Panning X (works only if rotated", Float) = 0
		_PanningY("Panning Y", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _TextureSample0;
		uniform float _PanningXworksonlyifrotated;
		uniform float _PanningY;
		uniform float _cCircle;
		uniform float _power;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 appendResult52 = (float2(_PanningXworksonlyifrotated , _PanningY));
			float2 uv_TexCoord4 = i.uv_texcoord * float2( 1,1 ) + float2( 0,0 );
			float2 temp_cast_0 = (1.0).xx;
			float2 temp_output_7_0 = ( ( uv_TexCoord4 * 2.0 ) - temp_cast_0 );
			float temp_output_9_0 = length( temp_output_7_0 );
			float2 temp_cast_1 = (1.0).xx;
			float2 temp_cast_2 = (1.0).xx;
			float temp_output_12_0 = atan2( temp_output_7_0.y , temp_output_7_0.x );
			float temp_output_14_0 = pow( temp_output_9_0 , _power );
			float2 appendResult16 = (float2(( cos( temp_output_12_0 ) * temp_output_14_0 ) , ( sin( temp_output_12_0 ) * temp_output_14_0 )));
			float2 uv_TexCoord25 = i.uv_texcoord * float2( 1,1 ) + float2( 0,0 );
			float2 ifLocalVar10 = 0;
			if( temp_output_9_0 <= _cCircle )
				ifLocalVar10 = uv_TexCoord25;
			else
				ifLocalVar10 = ( 0.5 * ( appendResult16 + 1.0 ) );
			float2 panner35 = ( ifLocalVar10 + 1 * _Time.y * appendResult52);
			float cos34 = cos( 0.5 * _Time.y );
			float sin34 = sin( 0.5 * _Time.y );
			float2 rotator34 = mul( panner35 - float2( 0.5,0.5 ) , float2x2( cos34 , -sin34 , sin34 , cos34 )) + float2( 0.5,0.5 );
			o.Emission = tex2D( _TextureSample0, rotator34 ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15001
7;29;1906;1004;864.3358;763.444;1;True;True
Node;AmplifyShaderEditor.TextureCoordinatesNode;4;-2133.807,-515.7703;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;3;-1759,-335.5;Float;False;Constant;_Float0;Float 0;0;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-1531,-354.5;Float;False;Constant;_Float1;Float 1;0;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-1581.016,-476.1508;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;7;-1382,-468.5;Float;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;13;-1528,-726.5;Float;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;15;-1228,-619.5;Float;False;Property;_power;power;2;0;Create;True;0;0;False;0;1;-3.14;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ATan2OpNode;12;-1235,-721.5;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LengthOpNode;9;-1207.342,-505.2089;Float;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;20;-1089,-785.5;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;14;-1046,-633.5;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CosOpNode;18;-1088,-717.5;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;-840,-728.5;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;-835,-831.5;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;16;-676,-788.2;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;24;-666,-636.5;Float;False;Constant;_Float5;Float 5;1;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;22;-675,-883.5;Float;False;Constant;_Float4;Float 4;1;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;23;-530,-757.5;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-384,-774.5;Float;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;53;-275.1039,-356.2976;Float;False;Property;_PanningXworksonlyifrotated;Panning X (works only if rotated;5;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-1231.988,-221.1159;Float;False;Property;_cCircle;cCircle;1;0;Create;True;0;0;False;0;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;54;-255.9041,-282.6974;Float;False;Property;_PanningY;Panning Y;6;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;25;-802.2108,-310.3756;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ConditionalIfNode;10;-440,-462.5;Float;False;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;52;-102.3039,-333.8975;Float;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;35;-48.85503,-509.5135;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;-0.5,-0.5;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RotatorNode;34;330.2044,-403.3371;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;2;FLOAT;0.5;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;26;-485.7622,-128.4895;Float;True;Property;_TextureSample0;Texture Sample 0;3;0;Create;True;0;0;False;0;None;b5b2d55334b4b5443b2464c94b94039a;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;60;188.6642,-182.444;Float;False;Constant;_Float2;Float 2;7;0;Create;True;0;0;False;0;100;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;57;128.4961,-354.0971;Float;False;Property;_Rotate;Rotate;4;0;Create;True;0;0;False;0;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;428.5363,-131.877;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Midget/Barrel Distort;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;0;False;0;Custom;0.5;True;True;0;True;TransparentCutout;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;OFF;OFF;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;0;0;False;0;0;0;False;-1;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;6;0;4;0
WireConnection;6;1;3;0
WireConnection;7;0;6;0
WireConnection;7;1;8;0
WireConnection;13;0;7;0
WireConnection;12;0;13;1
WireConnection;12;1;13;0
WireConnection;9;0;7;0
WireConnection;20;0;12;0
WireConnection;14;0;9;0
WireConnection;14;1;15;0
WireConnection;18;0;12;0
WireConnection;17;0;18;0
WireConnection;17;1;14;0
WireConnection;19;0;20;0
WireConnection;19;1;14;0
WireConnection;16;0;17;0
WireConnection;16;1;19;0
WireConnection;23;0;16;0
WireConnection;23;1;24;0
WireConnection;21;0;22;0
WireConnection;21;1;23;0
WireConnection;10;0;9;0
WireConnection;10;1;11;0
WireConnection;10;2;21;0
WireConnection;10;3;25;0
WireConnection;10;4;25;0
WireConnection;52;0;53;0
WireConnection;52;1;54;0
WireConnection;35;0;10;0
WireConnection;35;2;52;0
WireConnection;34;0;35;0
WireConnection;26;1;34;0
WireConnection;0;2;26;0
ASEEND*/
//CHKSM=27A8234E209853DBD483E078267668C897596279