// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Midget/Fish Eye"
{
	Properties
	{
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_CircleTexture("Circle - Texture", Range( 0 , 5)) = 1.5
		_Crazypower("Crazy power", Float) = 6
		_Speed("Speed", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _TextureSample0;
		uniform float _Speed;
		uniform float _CircleTexture;
		uniform float _Crazypower;

		inline fixed4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return fixed4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult132 = (float2(0 , _Speed));
			float2 uv_TexCoord91 = i.uv_texcoord * float2( 1,1 ) + float2( 0,0 );
			float2 temp_cast_0 = (1.0).xx;
			float2 temp_output_95_0 = ( ( uv_TexCoord91 * 2.0 ) - temp_cast_0 );
			float temp_output_88_0 = sin( ( 0.5 * 168.0 * ( UNITY_PI / 180.0 ) ) );
			float2 uv_TexCoord126 = i.uv_texcoord * float2( 1,1 ) + float2( 0,0 );
			float2 temp_cast_1 = (1.0).xx;
			float2 temp_cast_2 = (1.0).xx;
			float temp_output_114_0 = atan2( temp_output_95_0.x , temp_output_95_0.y );
			float2 temp_cast_3 = (1.0).xx;
			float temp_output_104_0 = length( ( temp_output_95_0 * temp_output_88_0 ) );
			float temp_output_112_0 = atan2( temp_output_104_0 , sqrt( ( 1.0 - ( temp_output_104_0 * temp_output_104_0 ) ) ) );
			float2 appendResult125 = (float2(( ( cos( temp_output_114_0 ) + _Crazypower ) * temp_output_112_0 ) , ( ( sin( temp_output_114_0 ) + _Crazypower ) * temp_output_112_0 )));
			float2 ifLocalVar98 = 0;
			if( length( temp_output_95_0 ) >= ( _CircleTexture - temp_output_88_0 ) )
				ifLocalVar98 = uv_TexCoord126;
			else
				ifLocalVar98 = appendResult125;
			float2 panner129 = ( ifLocalVar98 + 1 * _Time.y * appendResult132);
			float4 tex2DNode127 = tex2D( _TextureSample0, panner129 );
			o.Emission = tex2DNode127.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15001
7;29;1906;1004;1732.033;586.5844;1.174567;True;True
Node;AmplifyShaderEditor.CommentaryNode;92;-2621.201,-166.5012;Float;False;906;580.3094;Comment;7;88;86;85;87;83;82;81;Max Factor;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;87;-2513.705,298.856;Float;False;Constant;_Float3;Float 3;2;0;Create;True;0;0;False;0;180;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;99;-2624.088,-768.8508;Float;False;937.9031;476.5393;Comment;5;95;96;94;90;91;xy;1,1,1,1;0;0
Node;AmplifyShaderEditor.PiNode;85;-2533.08,148.6771;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;91;-2447.025,-616.5739;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleDivideOpNode;86;-2339.302,175.3217;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;81;-2427.346,1.758986;Float;False;Constant;_aperture;aperture;2;0;Create;True;0;0;False;0;168;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;82;-2418.025,-81.43542;Float;False;Constant;_Float2;Float 2;2;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;94;-2366.327,-483.6793;Float;False;Constant;_Float4;Float 4;2;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;96;-2130.159,-490.5618;Float;False;Constant;_Float5;Float 5;2;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;90;-2128.366,-603.4198;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;83;-2200.026,-24.513;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;88;-1875.448,-98.39105;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;95;-1839.579,-601.0135;Float;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;103;-1669.926,-650.8441;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LengthOpNode;104;-1521.338,-638.4617;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;116;-1484.667,-911.3368;Float;False;207;183;phi;1;114;;1,1,1,1;0;0
Node;AmplifyShaderEditor.BreakToComponentsNode;115;-1756.605,-877.2589;Float;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;108;-1367.455,-649.0715;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;109;-1233.02,-638.4568;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ATan2OpNode;114;-1434.667,-861.3368;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;110;-1120.271,-686.6886;Float;False;204;160;z;1;105;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SinOpNode;121;-992.4476,-1165.586;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CosOpNode;118;-988.9093,-1078.912;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;120;-1024.287,-988.1713;Float;False;Property;_Crazypower;Crazy power;3;0;Create;True;0;0;False;0;6;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SqrtOpNode;105;-1070.271,-636.6886;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;113;-1104.36,-888.3423;Float;False;207;183;r;1;112;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;122;-761.0495,-1167.684;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ATan2OpNode;112;-1045.516,-834.8044;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;119;-769.5657,-1057.684;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;123;-618.6481,-1044.743;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;124;-610.26,-1166.37;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;101;-1822.051,-265.2228;Float;False;Property;_CircleTexture;Circle - Texture;2;0;Create;True;0;0;False;0;1.5;2.61;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;126;-654.296,-558.2384;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;117;-274.365,-834.9917;Float;False;248;252;c;1;98;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;102;-1673.463,-265.2228;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;125;-377.4931,-1113.945;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LengthOpNode;97;-1629.788,-496.4945;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;130;-404.7723,-363.4167;Float;False;Property;_Speed;Speed;6;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;132;-266.1735,-254.1819;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ConditionalIfNode;98;-233.2099,-774.3785;Float;False;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;129;-207.759,-435.4827;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.5,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;128;-808.8446,-53.11621;Float;False;Property;_Float8;Float 8;5;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;127;-25.19385,-356.9257;Float;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;False;0;None;b5b2d55334b4b5443b2464c94b94039a;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;78;-386.2126,-2.591404;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GrabScreenPosition;11;-892.8646,219.392;Float;False;0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;77;-352.6522,155.9253;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-7.93155,340.9121;Float;False;Constant;_Float1;Float 1;0;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenColorNode;6;-134.9315,9.912266;Float;False;Global;_GrabScreen1;Grab Screen 1;0;0;Create;True;0;0;False;0;Object;-1;False;True;1;0;FLOAT4;0,0,0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;9;-124.9315,193.9123;Float;False;Constant;_Float0;Float 0;0;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenColorNode;5;-329.5718,1203.184;Float;False;Global;_GrabScreen0;Grab Screen 0;0;0;Create;True;0;0;False;0;Object;-1;False;False;1;0;FLOAT2;0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;39;-614.568,350.3819;Float;True;Property;_TextureSample1;Texture Sample 1;4;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;8;85.26854,70.11227;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;362.6402,-56.27176;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;Midget/Fish Eye;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;0;False;0;Custom;0.21;True;True;0;True;TransparentCutout;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;OFF;OFF;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;0;0;False;0;0;0;False;-1;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;131;-333.1238,-174.3114;Float;False;100;100;v;0;;1,1,1,1;0;0
WireConnection;86;0;85;0
WireConnection;86;1;87;0
WireConnection;90;0;91;0
WireConnection;90;1;94;0
WireConnection;83;0;82;0
WireConnection;83;1;81;0
WireConnection;83;2;86;0
WireConnection;88;0;83;0
WireConnection;95;0;90;0
WireConnection;95;1;96;0
WireConnection;103;0;95;0
WireConnection;103;1;88;0
WireConnection;104;0;103;0
WireConnection;115;0;95;0
WireConnection;108;0;104;0
WireConnection;108;1;104;0
WireConnection;109;0;108;0
WireConnection;114;0;115;0
WireConnection;114;1;115;1
WireConnection;121;0;114;0
WireConnection;118;0;114;0
WireConnection;105;0;109;0
WireConnection;122;0;121;0
WireConnection;122;1;120;0
WireConnection;112;0;104;0
WireConnection;112;1;105;0
WireConnection;119;0;118;0
WireConnection;119;1;120;0
WireConnection;123;0;119;0
WireConnection;123;1;112;0
WireConnection;124;0;122;0
WireConnection;124;1;112;0
WireConnection;102;0;101;0
WireConnection;102;1;88;0
WireConnection;125;0;123;0
WireConnection;125;1;124;0
WireConnection;97;0;95;0
WireConnection;132;1;130;0
WireConnection;98;0;97;0
WireConnection;98;1;102;0
WireConnection;98;2;126;0
WireConnection;98;3;126;0
WireConnection;98;4;125;0
WireConnection;129;0;98;0
WireConnection;129;2;132;0
WireConnection;127;1;129;0
WireConnection;78;0;127;0
WireConnection;78;1;128;0
WireConnection;77;0;78;0
WireConnection;77;1;11;0
WireConnection;6;0;77;0
WireConnection;8;0;6;0
WireConnection;8;1;9;0
WireConnection;8;2;10;0
WireConnection;0;2;127;0
ASEEND*/
//CHKSM=43C4FFE46C948460AC9FAC4E231C32E09387E466