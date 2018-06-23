// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Midget/Grabpass Color Change"
{
	Properties
	{
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_TexResolution("Tex Resolution", Float) = 1024
		_TextureMultiplier("Texture Multiplier", Float) = 3
		_TimeSpeed("Time Speed", Float) = 0
		_Multiplier("Multiplier", Float) = 0
		_Saturation("Saturation", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Front
		ZWrite Off
		ZTest Always
		Blend SrcAlpha OneMinusSrcAlpha
		GrabPass{ }
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float4 screenPos;
			float2 uv_texcoord;
		};

		uniform sampler2D _GrabTexture;
		uniform float _Saturation;
		uniform float _Multiplier;
		uniform sampler2D _TextureSample0;
		uniform float _TexResolution;
		uniform float _TimeSpeed;
		uniform float _TextureMultiplier;


		inline float4 ASE_ComputeGrabScreenPos( float4 pos )
		{
			#if UNITY_UV_STARTS_AT_TOP
			float scale = -1.0;
			#else
			float scale = 1.0;
			#endif
			float4 o = pos;
			o.y = pos.w * 0.5f;
			o.y = ( pos.y - o.y ) * _ProjectionParams.x * scale + o.y;
			return o;
		}


		inline fixed4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return fixed4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_grabScreenPos = ASE_ComputeGrabScreenPos( ase_screenPos );
			float4 ase_grabScreenPosNorm = ase_grabScreenPos / ase_grabScreenPos.w;
			float4 screenColor1 = tex2Dproj( _GrabTexture, UNITY_PROJ_COORD( ase_grabScreenPosNorm ) );
			float3 desaturateVar58 = lerp( screenColor1.rgb,dot(screenColor1.rgb,float3(0.299,0.587,0.114)).xxx,0.5);
			float4 lerpResult48 = lerp( float4( desaturateVar58 , 0.0 ) , ( 1.0 - screenColor1 ) , _Saturation);
			float4 temp_cast_2 = (0.0).xxxx;
			float2 uv_TexCoord14 = i.uv_texcoord * float2( 1,1 ) + float2( 0,0 );
			float mulTime27 = _Time.y * _TimeSpeed;
			float2 appendResult31 = (float2(mulTime27 , mulTime27));
			float4 lerpResult44 = lerp( temp_cast_2 , ( tex2D( _TextureSample0, ( ( uv_TexCoord14 / _TexResolution ) + ( appendResult31 / _TexResolution ) ) ) * _TextureMultiplier ) , _Saturation);
			o.Emission = ( ( lerpResult48 * _Multiplier ) + lerpResult44 ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15001
7;29;1906;1004;1628.912;435.566;1.334901;True;True
Node;AmplifyShaderEditor.RangedFloatNode;35;-1063.362,516.1528;Float;False;Property;_TimeSpeed;Time Speed;4;0;Create;True;0;0;False;0;0;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;27;-923.1821,608.7664;Float;False;1;0;FLOAT;90;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;18;-784.8922,343.6448;Float;False;Property;_TexResolution;Tex Resolution;2;0;Create;True;0;0;False;0;1024;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;31;-504.1157,526.346;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;14;-799.3159,145.8703;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GrabScreenPosition;43;-1176.499,-271.5125;Float;False;0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleDivideOpNode;17;-506.7713,194.2835;Float;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;22;-398.9218,344.3968;Float;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;19;-333.718,196.3438;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScreenColorNode;1;-542.9464,-270.8692;Float;False;Global;_GrabScreen0;Grab Screen 0;0;0;Create;True;0;0;False;0;Object;-1;False;True;1;0;FLOAT4;0,0,0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;45;-228.8802,419.3603;Float;False;Property;_Saturation;Saturation;6;0;Create;True;0;0;False;0;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;23;-308.7253,391.8015;Float;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;False;0;None;2a05952914e892047b954226f16ab689;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;30;-226.9982,-113.4381;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DesaturateOpNode;58;-780.196,-101.2509;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;0.5;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;29;22.87265,486.8394;Float;False;Property;_TextureMultiplier;Texture Multiplier;3;0;Create;True;0;0;False;0;3;0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;46;-123.423,184.4178;Float;False;Constant;_Float6;Float 6;6;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;39;-317.0809,-42.96861;Float;False;Property;_Multiplier;Multiplier;5;0;Create;True;0;0;False;0;0;0.11;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;139.2303,347.3157;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;48;-453.1448,34.90882;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;44;126.2035,137.6963;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;-262.5805,62.97863;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;32;-785.5374,435.684;Float;False;Constant;_Float2;Float 2;3;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;34;21.96686,-3.458802;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;291.1652,-58.73487;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;Midget/Grabpass Color Change;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;Front;2;False;-1;7;False;-1;False;0;0;False;0;Custom;0.5;True;True;0;True;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;SrcAlpha;OneMinusSrcAlpha;0;Zero;Zero;OFF;OFF;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;1;-1;-1;-1;0;0;0;False;0;0;0;False;-1;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;27;0;35;0
WireConnection;31;0;27;0
WireConnection;31;1;27;0
WireConnection;17;0;14;0
WireConnection;17;1;18;0
WireConnection;22;0;31;0
WireConnection;22;1;18;0
WireConnection;19;0;17;0
WireConnection;19;1;22;0
WireConnection;1;0;43;0
WireConnection;23;1;19;0
WireConnection;30;0;1;0
WireConnection;58;0;1;0
WireConnection;33;0;23;0
WireConnection;33;1;29;0
WireConnection;48;0;58;0
WireConnection;48;1;30;0
WireConnection;48;2;45;0
WireConnection;44;0;46;0
WireConnection;44;1;33;0
WireConnection;44;2;45;0
WireConnection;37;0;48;0
WireConnection;37;1;39;0
WireConnection;34;0;37;0
WireConnection;34;1;44;0
WireConnection;0;2;34;0
ASEEND*/
//CHKSM=6BEBCB389CBED98BB168414F6A9424E5A998BFE6