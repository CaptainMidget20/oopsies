// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Midget/Fire Distort"
{
	Properties
	{
		_ColorA("Color A", Color) = (0,0.04827571,1,0)
		_ColorB("Color B", Color) = (1,0,0,0)
		_EdgeA("Edge A", Color) = (1,0,0.972414,0)
		_EdgeB("Edge B", Color) = (1,0,0,0)
		_Offset("Offset", Range( -2 , 2)) = -0.1527804
		_Height("Height", Range( -4 , 10)) = -0.232062
		_ShapeTex("Shape Tex", 2D) = "white" {}
		[Toggle(_USEMASK_ON)] _UseMask("Use Mask?", Float) = 0
		_Cutoff( "Mask Clip Value", Float ) = 0.55
		_NoiseTex("NoiseTex", 2D) = "white" {}
		_NoiseMultiplier("Noise Multiplier", Range( 0 , 15)) = 0
		_DistortTex("DistortTex", 2D) = "white" {}
		_DistortTex2("DistortTex2", 2D) = "white" {}
		_HardCutoff("Hard Cutoff", Range( 0 , 40)) = 1
		_Distort("Distort", Range( 0 , 1)) = 1
		_Edge("Edge", Range( 0 , 2)) = 0
		_ScrollY("Scroll Y", Range( -10 , 10)) = 0
		_ScrollX("Scroll X", Range( -10 , 10)) = 0
		_Gradsmooth("Grad smooth", Range( -10 , 10)) = 1.25895
		_NoiseGradientCutoff("Noise Gradient Cutoff", Range( 0 , 3)) = 0
		_VertexDisplacement("Vertex Displacement", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Geometry+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 4.6
		#pragma shader_feature _USEMASK_ON
		#pragma surface surf Unlit keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float _HardCutoff;
		uniform sampler2D _NoiseTex;
		uniform float _ScrollX;
		uniform sampler2D _DistortTex;
		uniform float4 _DistortTex_ST;
		uniform float _Distort;
		uniform float _ScrollY;
		uniform sampler2D _DistortTex2;
		uniform float4 _DistortTex2_ST;
		uniform float _NoiseMultiplier;
		uniform float _NoiseGradientCutoff;
		uniform float _Height;
		uniform sampler2D _ShapeTex;
		uniform float4 _ShapeTex_ST;
		uniform float4 _ColorB;
		uniform float4 _ColorA;
		uniform float _Gradsmooth;
		uniform float _Offset;
		uniform float _Edge;
		uniform float4 _EdgeB;
		uniform float4 _EdgeA;
		uniform float _VertexDisplacement;
		uniform float _Cutoff = 0.55;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float2 uv_TexCoord92 = v.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
			float mulTime95 = _Time.y * _ScrollX;
			float2 uv_DistortTex = v.texcoord * _DistortTex_ST.xy + _DistortTex_ST.zw;
			float mulTime99 = _Time.y * _ScrollY;
			float2 uv_DistortTex2 = v.texcoord * _DistortTex2_ST.xy + _DistortTex2_ST.zw;
			float2 appendResult105 = (float2(( uv_TexCoord92.x + mulTime95 + ( tex2Dlod( _DistortTex, float4( uv_DistortTex, 0, 0) ) * _Distort ).r ) , ( uv_TexCoord92.y + mulTime99 + ( tex2Dlod( _DistortTex2, float4( uv_DistortTex2, 0, 0) ) * _Distort ).r )));
			float4 appendResult143 = (float4(_NoiseGradientCutoff , _NoiseGradientCutoff , _NoiseGradientCutoff , _NoiseGradientCutoff));
			float2 uv_TexCoord78 = v.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
			float4 lerpResult82 = lerp( appendResult143 , float4(0,0,0,0) , ( uv_TexCoord78.y + ( 1.0 - _Height ) ));
			float2 uv_ShapeTex = v.texcoord * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
			#ifdef _USEMASK_ON
				float4 staticSwitch148 = ( 1.0 - ( tex2Dlod( _ShapeTex, float4( uv_ShapeTex, 0, 0) ) * _HardCutoff ) );
			#else
				float4 staticSwitch148 = ( 1.0 - lerpResult82 );
			#endif
			float flame117 = saturate( ( _HardCutoff * ( 1.0 - ( ( tex2Dlod( _NoiseTex, float4( appendResult105, 0, 0) ) * _NoiseMultiplier ) + staticSwitch148 ) ).r ) );
			float flamerim124 = ( saturate( ( ( ( 1.0 - ( ( tex2Dlod( _NoiseTex, float4( appendResult105, 0, 0) ) * _NoiseMultiplier ) + staticSwitch148 ) ).r + _Edge ) * _HardCutoff ) ) - flame117 );
			float temp_output_133_0 = ( flame117 + flamerim124 );
			v.vertex.xyz += ( float3(0,1,0) * ( 1.0 - temp_output_133_0 ) * _VertexDisplacement );
		}

		inline fixed4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return fixed4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_TexCoord92 = i.uv_texcoord * float2( 1,1 ) + float2( 0,0 );
			float mulTime95 = _Time.y * _ScrollX;
			float2 uv_DistortTex = i.uv_texcoord * _DistortTex_ST.xy + _DistortTex_ST.zw;
			float mulTime99 = _Time.y * _ScrollY;
			float2 uv_DistortTex2 = i.uv_texcoord * _DistortTex2_ST.xy + _DistortTex2_ST.zw;
			float2 appendResult105 = (float2(( uv_TexCoord92.x + mulTime95 + ( tex2D( _DistortTex, uv_DistortTex ) * _Distort ).r ) , ( uv_TexCoord92.y + mulTime99 + ( tex2D( _DistortTex2, uv_DistortTex2 ) * _Distort ).r )));
			float4 appendResult143 = (float4(_NoiseGradientCutoff , _NoiseGradientCutoff , _NoiseGradientCutoff , _NoiseGradientCutoff));
			float2 uv_TexCoord78 = i.uv_texcoord * float2( 1,1 ) + float2( 0,0 );
			float4 lerpResult82 = lerp( appendResult143 , float4(0,0,0,0) , ( uv_TexCoord78.y + ( 1.0 - _Height ) ));
			float2 uv_ShapeTex = i.uv_texcoord * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
			#ifdef _USEMASK_ON
				float4 staticSwitch148 = ( 1.0 - ( tex2D( _ShapeTex, uv_ShapeTex ) * _HardCutoff ) );
			#else
				float4 staticSwitch148 = ( 1.0 - lerpResult82 );
			#endif
			float flame117 = saturate( ( _HardCutoff * ( 1.0 - ( ( tex2D( _NoiseTex, appendResult105 ) * _NoiseMultiplier ) + staticSwitch148 ) ).r ) );
			float smoothstepResult140 = smoothstep( 0 , _Gradsmooth , uv_TexCoord78.y);
			float temp_output_79_0 = ( smoothstepResult140 + _Offset );
			float4 lerpResult77 = lerp( _ColorB , _ColorA , temp_output_79_0);
			float flamerim124 = ( saturate( ( ( ( 1.0 - ( ( tex2D( _NoiseTex, appendResult105 ) * _NoiseMultiplier ) + staticSwitch148 ) ).r + _Edge ) * _HardCutoff ) ) - flame117 );
			float4 lerpResult81 = lerp( _EdgeB , _EdgeA , temp_output_79_0);
			o.Emission = ( ( flame117 * lerpResult77 ) + ( flamerim124 * lerpResult81 ) ).rgb;
			o.Alpha = 1;
			float temp_output_133_0 = ( flame117 + flamerim124 );
			clip( temp_output_133_0 - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15001
7;29;1906;1004;2707.855;-589.5552;1.455918;True;True
Node;AmplifyShaderEditor.SamplerNode;88;-2570.618,1736.803;Float;True;Property;_DistortTex;DistortTex;11;0;Create;True;0;0;False;0;None;e4eee4fe060d76e4c8620ad110e84243;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;90;-2568.645,1961.664;Float;False;Property;_Distort;Distort;14;0;Create;True;0;0;False;0;1;0.273;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;128;-2565.268,2049.936;Float;True;Property;_DistortTex2;DistortTex2;12;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;97;-2610.031,1587.92;Float;False;Property;_ScrollY;Scroll Y;16;0;Create;True;0;0;False;0;0;-0.18;-10;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;130;-2118.657,2039.479;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;96;-2590.759,1456.181;Float;False;Property;_ScrollX;Scroll X;17;0;Create;True;0;0;False;0;0;-0.07;-10;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;89;-2149.138,1748.47;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;87;-2051.505,721.6473;Float;False;Property;_Height;Height;5;0;Create;True;0;0;False;0;-0.232062;0.45;-4;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;99;-2269.703,1585.905;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;95;-2240.326,1461.985;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;129;-1945.389,1751.198;Float;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.BreakToComponentsNode;131;-1960.327,2127.606;Float;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;142;-2038.649,978.1329;Float;False;Property;_NoiseGradientCutoff;Noise Gradient Cutoff;19;0;Create;True;0;0;False;0;0;1.46;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;137;-1694.528,700.2119;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;92;-2304.776,1308.534;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;78;-1973.062,158.9457;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;100;-1847.199,1550.803;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;93;-1851.106,1357.973;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;143;-1747.386,959.2546;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.Vector4Node;84;-1347.713,1035.027;Float;False;Constant;_Vector1;Vector 1;7;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;85;-1549.751,676.9193;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;110;-1401.766,1752.803;Float;False;Property;_HardCutoff;Hard Cutoff;13;0;Create;True;0;0;False;0;1;7.5;0;40;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;101;-1399.999,1546.903;Float;True;Property;_ShapeTex;Shape Tex;6;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;82;-1045.395,906.3353;Float;True;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;105;-1608.421,1319.321;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;109;-1075.301,1553.349;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;106;-825.7,1547.685;Float;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;149;-1151.48,1460.193;Float;False;Property;_NoiseMultiplier;Noise Multiplier;10;0;Create;True;0;0;False;0;0;1;0;15;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;91;-1411.721,1271.739;Float;True;Property;_NoiseTex;NoiseTex;9;0;Create;True;0;0;False;0;None;783ee8848c41d6a438a8adb6aece70fe;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;138;-687.4021,1009.309;Float;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;107;-1030.593,1294.278;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;148;-736.561,1412.79;Float;False;Property;_UseMask;Use Mask?;7;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;9;1;FLOAT4;0,0,0,0;False;0;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;5;FLOAT4;0,0,0,0;False;6;FLOAT4;0,0,0,0;False;7;FLOAT4;0,0,0,0;False;8;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleAddOpNode;111;-599.5884,1548.343;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;112;-433.2082,1537.403;Float;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;120;-336.4514,1841.525;Float;False;Property;_Edge;Edge;15;0;Create;True;0;0;False;0;0;0.583;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;114;-236.0973,1540.782;Float;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleAddOpNode;119;96.5825,1688.896;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;115;93.1366,1546.609;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;121;282.8335,1693.288;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;113;84.96557,1463.021;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;122;468.2255,1696.62;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;141;-2066.856,446.4443;Float;False;Property;_Gradsmooth;Grad smooth;18;0;Create;True;0;0;False;0;1.25895;0.76;-10;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;117;65.34131,1313.429;Float;False;flame;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;140;-1545.218,293.5109;Float;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;80;-2072.856,267.8824;Float;False;Property;_Offset;Offset;4;0;Create;True;0;0;False;0;-0.1527804;0.01;-2;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;123;674.0035,1745.476;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;73;-1308.597,-37.76894;Float;False;Property;_ColorA;Color A;0;0;Create;True;0;0;False;0;0,0.04827571,1,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;74;-1327.686,-234.7681;Float;False;Property;_ColorB;Color B;1;0;Create;True;0;0;False;0;1,0,0,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;124;896.4259,1710.377;Float;False;flamerim;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;76;-1307.495,435.9761;Float;False;Property;_EdgeB;Edge B;3;0;Create;True;0;0;False;0;1,0,0,0;1,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;79;-1313.506,187.4221;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;75;-1298.394,625.4905;Float;False;Property;_EdgeA;Edge A;2;0;Create;True;0;0;False;0;1,0,0.972414,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;116;-1014.467,-237.3813;Float;False;117;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;125;-1024.434,356.9886;Float;False;124;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;133;566.6333,1384.813;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;77;-990.1915,-161.7588;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;81;-1049.639,506.1699;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;147;732.5634,857.2433;Float;False;Property;_VertexDisplacement;Vertex Displacement;20;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;126;-804.3386,520.3587;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;118;-756.4468,-100.8327;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;144;778.126,1294.749;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;146;443.0621,1027.12;Float;False;Constant;_Vector0;Vector 0;18;0;Create;True;0;0;False;0;0,1,0;-1,1,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;145;809.7358,1119.842;Float;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;127;-300.4722,260.6869;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;563.1171,150.7918;Float;False;True;6;Float;ASEMaterialInspector;0;0;Unlit;Midget/Fire Distort;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;Back;0;False;-1;0;False;-1;False;-1.93;0.31;False;0;Custom;0.55;True;True;0;True;TransparentCutout;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;2;False;-1;255;False;-1;255;False;-1;6;False;-1;1;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;One;One;0;One;One;OFF;OFF;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;8;-1;-1;-1;0;0;0;False;0;0;0;False;-1;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;130;0;128;0
WireConnection;130;1;90;0
WireConnection;89;0;88;0
WireConnection;89;1;90;0
WireConnection;99;0;97;0
WireConnection;95;0;96;0
WireConnection;129;0;89;0
WireConnection;131;0;130;0
WireConnection;137;0;87;0
WireConnection;100;0;92;2
WireConnection;100;1;99;0
WireConnection;100;2;131;0
WireConnection;93;0;92;1
WireConnection;93;1;95;0
WireConnection;93;2;129;0
WireConnection;143;0;142;0
WireConnection;143;1;142;0
WireConnection;143;2;142;0
WireConnection;143;3;142;0
WireConnection;85;0;78;2
WireConnection;85;1;137;0
WireConnection;82;0;143;0
WireConnection;82;1;84;0
WireConnection;82;2;85;0
WireConnection;105;0;93;0
WireConnection;105;1;100;0
WireConnection;109;0;101;0
WireConnection;109;1;110;0
WireConnection;106;0;109;0
WireConnection;91;1;105;0
WireConnection;138;0;82;0
WireConnection;107;0;91;0
WireConnection;107;1;149;0
WireConnection;148;1;138;0
WireConnection;148;0;106;0
WireConnection;111;0;107;0
WireConnection;111;1;148;0
WireConnection;112;0;111;0
WireConnection;114;0;112;0
WireConnection;119;0;114;0
WireConnection;119;1;120;0
WireConnection;115;0;110;0
WireConnection;115;1;114;0
WireConnection;121;0;119;0
WireConnection;121;1;110;0
WireConnection;113;0;115;0
WireConnection;122;0;121;0
WireConnection;117;0;113;0
WireConnection;140;0;78;2
WireConnection;140;2;141;0
WireConnection;123;0;122;0
WireConnection;123;1;117;0
WireConnection;124;0;123;0
WireConnection;79;0;140;0
WireConnection;79;1;80;0
WireConnection;133;0;117;0
WireConnection;133;1;124;0
WireConnection;77;0;74;0
WireConnection;77;1;73;0
WireConnection;77;2;79;0
WireConnection;81;0;76;0
WireConnection;81;1;75;0
WireConnection;81;2;79;0
WireConnection;126;0;125;0
WireConnection;126;1;81;0
WireConnection;118;0;116;0
WireConnection;118;1;77;0
WireConnection;144;0;133;0
WireConnection;145;0;146;0
WireConnection;145;1;144;0
WireConnection;145;2;147;0
WireConnection;127;0;118;0
WireConnection;127;1;126;0
WireConnection;0;2;127;0
WireConnection;0;10;133;0
WireConnection;0;11;145;0
ASEEND*/
//CHKSM=78F61D7FEB48299B70B4BD2A0C9D1151EA430AD6