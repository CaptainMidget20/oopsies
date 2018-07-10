// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Midget/idontfeelgood"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.46
		_Shadow("Shadow", Range( 0 , 1)) = 0
		_Gloss("Gloss", Range( 1 , 30)) = 1
		_Specular("Specular", Range( 0 , 4)) = 1
		_GlossColor("Gloss Color", Color) = (1,1,1,0)
		_GlossPos("Gloss Pos", Range( 1 , 256)) = 1
		_Color("Color", Color) = (0,0,0,0)
		_ShadowRamp("Shadow Ramp", 2D) = "white" {}
		_MainTex("Main Tex", 2D) = "white" {}
		[HDR]_MaskColor("Mask Color", Color) = (0,0,0,0)
		_ColorMask("Color Mask", 2D) = "white" {}
		_EmissionColor("Emission Color", Color) = (0,0,0,0)
		_EmissionMap("Emission Map", 2D) = "white" {}
		_BumpMap("Bump Map", 2D) = "bump" {}
		_CutoutValue("Cutout Value", Range( 0 , 1)) = 0.5
		_NormalMULT("Normal MULT", Float) = 2
		_GradientAngle("Gradient Angle", Float) = -45
		_StaticLightDirection("Static Light Direction", Vector) = (0.7,-1,-1,0)
		_Displacement("Displacement", Float) = 1
		_Tiling("Tiling", Float) = 0.08
		_GradientSmooth("Gradient Smooth", Float) = 1
		_OriginXPLAYWITHME("Origin X (PLAY WITH ME)", Float) = 0.5
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Geometry+0" }
		Cull Off
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) fixed3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
		};

		struct SurfaceOutputCustomLightingCustom
		{
			fixed3 Albedo;
			fixed3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			fixed Alpha;
			Input SurfInput;
			UnityGIInput GIData;
		};

		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform float4 _MaskColor;
		uniform sampler2D _ColorMask;
		uniform float4 _ColorMask_ST;
		uniform float _GradientSmooth;
		uniform float _GradientAngle;
		uniform float _OriginXPLAYWITHME;
		uniform float _Tiling;
		uniform float _CutoutValue;
		uniform sampler2D _EmissionMap;
		uniform float4 _EmissionMap_ST;
		uniform float4 _EmissionColor;
		uniform float4 _Color;
		uniform float _GlossPos;
		uniform sampler2D _BumpMap;
		uniform float4 _BumpMap_ST;
		uniform float _NormalMULT;
		uniform float3 _StaticLightDirection;
		uniform float _Gloss;
		uniform float _Specular;
		uniform float4 _GlossColor;
		uniform sampler2D _ShadowRamp;
		uniform float _Shadow;
		uniform float _Displacement;
		uniform float _Cutoff = 0.46;


		float MyCustomExpression82( float4 In0 )
		{
			return ShadeSH9(half4(In0));
		}


		float3 MyCustomExpression124( float3 objPos )
		{
			return DecodeHDR(UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, normalize((_WorldSpaceCameraPos -objPos)), 7), unity_SpecCube0_HDR)* 0.02;
		}


		float MyCustomExpression85( float4 In0 )
		{
			return ShadeSH9(half4(In0));
		}


		float4 MyCustomExpression112( float4 In0 )
		{
			#ifdef LIGHTMAP_OFF
			In0 = 1;
			#endif
			return In0;
		}


		float MyCustomExpression194( float atten )
		{
			#if DIRECTIONAL
			atten = 1;
			#endif
			return atten;
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float4 appendResult333 = (float4((( float4( ase_worldPos , 0.0 ) - mul( unity_ObjectToWorld, float4(0,0,0,1) ) )).xyz , 0.0));
			float4 temp_output_334_0 = mul( unity_ObjectToWorld, appendResult333 );
			float2 appendResult336 = (float2(temp_output_334_0.x , temp_output_334_0.y));
			float temp_output_345_0 = ( radians( 90.0 ) - ( radians( _GradientAngle ) + atan2( appendResult336.y , appendResult336.x ) ) );
			float2 appendResult353 = (float2(( cos( temp_output_345_0 ) * length( appendResult336 ) ) , ( length( appendResult336 ) * sin( temp_output_345_0 ) )));
			float2 appendResult354 = (float2(_OriginXPLAYWITHME , 0.5));
			float smoothstepResult360 = smoothstep( 0 , _GradientSmooth , ( appendResult353 + appendResult354 ).x);
			float4 lerpResult366 = lerp( float4(0,0,0,0) , float4(1,1,1,0) , smoothstepResult360);
			float clampResult376 = clamp( lerpResult366.r , 0 , 1 );
			float3 temp_output_23_0_g3 = ceil( ( temp_output_334_0 / _Tiling ) ).xyz;
			float dotResult6_g3 = dot( temp_output_23_0_g3 , float3(45149,25977,38434) );
			float dotResult7_g3 = dot( temp_output_23_0_g3 , float3(86320,6417,67925) );
			float2 appendResult8_g3 = (float2(dotResult6_g3 , dotResult7_g3));
			float dotResult9_g3 = dot( temp_output_23_0_g3 , float3(59471,16773,39403) );
			float3 appendResult13_g3 = (float3(appendResult8_g3 , dotResult9_g3));
			float mulTime364 = _Time.y * 1;
			float3 temp_output_16_0_g3 = ( sin( appendResult13_g3 ) * ( 28030.0 + mulTime364 ) );
			float3 temp_cast_2 = (1.0).xxx;
			float clampResult371 = clamp( (float3( 0,0,0 ) + (( ( ( temp_output_16_0_g3 - floor( temp_output_16_0_g3 ) ) * 2.0 ) - temp_cast_2 ) - float3( -1,-1,-1 )) * (float3( 1,1,1 ) - float3( 0,0,0 )) / (float3( 1,1,1 ) - float3( -1,-1,-1 ))).x , 0 , 1 );
			v.vertex.xyz += ( ( ( _Displacement * clampResult376 ) * clampResult371 ) * float3(-1,1,0) );
		}

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			#if DIRECTIONAL
			float ase_lightAtten = data.atten;
			if( _LightColor0.a == 0)
			ase_lightAtten = 0;
			#else
			float3 ase_lightAttenRGB = gi.light.color / ( ( _LightColor0.rgb ) + 0.000001 );
			float ase_lightAtten = max( max( ase_lightAttenRGB.r, ase_lightAttenRGB.g ), ase_lightAttenRGB.b );
			#endif
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 tex2DNode103 = tex2D( _MainTex, uv_MainTex );
			float2 uv_ColorMask = i.uv_texcoord * _ColorMask_ST.xy + _ColorMask_ST.zw;
			float4 lerpResult119 = lerp( ( tex2DNode103 * _MaskColor ) , tex2DNode103 , tex2D( _ColorMask, uv_ColorMask ).r);
			float3 ase_worldPos = i.worldPos;
			float4 appendResult333 = (float4((( float4( ase_worldPos , 0.0 ) - mul( unity_ObjectToWorld, float4(0,0,0,1) ) )).xyz , 0.0));
			float4 temp_output_334_0 = mul( unity_ObjectToWorld, appendResult333 );
			float2 appendResult336 = (float2(temp_output_334_0.x , temp_output_334_0.y));
			float temp_output_345_0 = ( radians( 90.0 ) - ( radians( _GradientAngle ) + atan2( appendResult336.y , appendResult336.x ) ) );
			float2 appendResult353 = (float2(( cos( temp_output_345_0 ) * length( appendResult336 ) ) , ( length( appendResult336 ) * sin( temp_output_345_0 ) )));
			float2 appendResult354 = (float2(_OriginXPLAYWITHME , 0.5));
			float smoothstepResult360 = smoothstep( 0 , _GradientSmooth , ( appendResult353 + appendResult354 ).x);
			float4 lerpResult366 = lerp( float4(0,0,0,0) , float4(1,1,1,0) , smoothstepResult360);
			float clampResult372 = clamp( ( 1.0 - lerpResult366.r ) , 0 , 1 );
			float3 temp_output_23_0_g3 = ceil( ( temp_output_334_0 / _Tiling ) ).xyz;
			float dotResult6_g3 = dot( temp_output_23_0_g3 , float3(45149,25977,38434) );
			float dotResult7_g3 = dot( temp_output_23_0_g3 , float3(86320,6417,67925) );
			float2 appendResult8_g3 = (float2(dotResult6_g3 , dotResult7_g3));
			float dotResult9_g3 = dot( temp_output_23_0_g3 , float3(59471,16773,39403) );
			float3 appendResult13_g3 = (float3(appendResult8_g3 , dotResult9_g3));
			float mulTime364 = _Time.y * 1;
			float3 temp_output_16_0_g3 = ( sin( appendResult13_g3 ) * ( 28030.0 + mulTime364 ) );
			float3 temp_cast_2 = (1.0).xxx;
			float clampResult371 = clamp( (float3( 0,0,0 ) + (( ( ( temp_output_16_0_g3 - floor( temp_output_16_0_g3 ) ) * 2.0 ) - temp_cast_2 ) - float3( -1,-1,-1 )) * (float3( 1,1,1 ) - float3( 0,0,0 )) / (float3( 1,1,1 ) - float3( -1,-1,-1 ))).x , 0 , 1 );
			float clampResult379 = clamp( ceil( ( clampResult372 - clampResult371 ) ) , 0 , 1 );
			float2 uv_EmissionMap = i.uv_texcoord * _EmissionMap_ST.xy + _EmissionMap_ST.zw;
			float4 In082 = float4(0,-1,0,1);
			float localMyCustomExpression82 = MyCustomExpression82( In082 );
			float3 objPos124 = ase_worldPos;
			float3 localMyCustomExpression124 = MyCustomExpression124( objPos124 );
			float4 In085 = float4(0,1,0,1);
			float localMyCustomExpression85 = MyCustomExpression85( In085 );
			float2 uv_BumpMap = i.uv_texcoord * _BumpMap_ST.xy + _BumpMap_ST.zw;
			float3 tex2DNode136 = UnpackNormal( tex2D( _BumpMap, uv_BumpMap ) );
			float4 appendResult146 = (float4(tex2DNode136.r , tex2DNode136.g , tex2DNode136.b , 0));
			float3 ase_worldTangent = WorldNormalVector( i, float3( 1, 0, 0 ) );
			float3 ase_worldBitangent = WorldNormalVector( i, float3( 0, 1, 0 ) );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float4 normalizeResult147 = normalize( float4( mul( appendResult146.xyz, float3x3(ase_worldTangent, ase_worldBitangent, ase_worldNormal) ) , 0.0 ) );
			float4 temp_output_308_0 = ( normalizeResult147 * _NormalMULT );
			float4 myVarName0217 = temp_output_308_0;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			float3 ifLocalVar317 = 0;
			if( _LightColor0.a >= 0.001 )
				ifLocalVar317 = ase_worldlightDir;
			else
				ifLocalVar317 = _StaticLightDirection;
			float3 normalizeResult222 = normalize( ( ase_worldViewDir + ifLocalVar317 ) );
			float dotResult215 = dot( myVarName0217 , float4( normalizeResult222 , 0.0 ) );
			float clampResult245 = clamp( ( pow( dotResult215 , _Gloss ) * _Specular ) , 0 , 1 );
			float4 temp_cast_8 = (clampResult245).xxxx;
			float div239=256.0/float((int)_GlossPos);
			float4 posterize239 = ( floor( temp_cast_8 * div239 ) / div239 );
			float dotResult70 = dot( temp_output_308_0 , float4( ifLocalVar317 , 0.0 ) );
			float ifLocalVar319 = 0;
			if( _LightColor0.a >= 0.001 )
				ifLocalVar319 = ase_lightAtten;
			else
				ifLocalVar319 = 1.0;
			float2 appendResult305 = (float2(( dotResult70 * ifLocalVar319 ) , 0.2));
			float3 lerpResult106 = lerp( saturate( ( localMyCustomExpression82 + localMyCustomExpression124 + -1.0 ) ) , saturate( ( localMyCustomExpression85 + localMyCustomExpression124 + _LightColor0.rgb ) ) , ( ( posterize239 * _GlossColor * float4( _LightColor0.rgb , 0.0 ) ) + ( tex2D( _ShadowRamp, appendResult305 ) + ( 1.0 - _Shadow ) ) ).r);
			float3 decodeLightMap110 = DecodeLightmap( float4( 0,0,0,0 ) );
			float4 In0112 = float4( decodeLightMap110 , 0.0 );
			float4 localMyCustomExpression112 = MyCustomExpression112( In0112 );
			float atten194 = ase_lightAtten;
			float localMyCustomExpression194 = MyCustomExpression194( atten194 );
			c.rgb = ( ( tex2D( _EmissionMap, uv_EmissionMap ) * _EmissionColor ) + ( ( float4( (lerpResult119).rgb , 0.0 ) * _Color ) * float4( lerpResult106 , 0.0 ) * localMyCustomExpression112 * localMyCustomExpression194 * clampResult379 ) ).rgb;
			c.a = 1;
			clip( ( ( (lerpResult119).a + clampResult379 ) - _CutoutValue ) - _Cutoff );
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
			o.Normal = float3(0,0,1);
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows exclude_path:deferred vertex:vertexDataFunc 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float4 tSpace0 : TEXCOORD2;
				float4 tSpace1 : TEXCOORD3;
				float4 tSpace2 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				vertexDataFunc( v, customInputData );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				fixed3 worldNormal = UnityObjectToWorldNormal( v.normal );
				fixed3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				fixed3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			fixed4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				fixed3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputCustomLightingCustom o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputCustomLightingCustom, o )
				surf( surfIN, o );
				UnityGI gi;
				UNITY_INITIALIZE_OUTPUT( UnityGI, gi );
				LightingStandardCustomLighting( o, worldViewDir, gi );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15001
11;302;1906;1004;1520.44;-1694.454;1;True;True
Node;AmplifyShaderEditor.ObjectToWorldMatrixNode;327;-1907.25,3159.324;Float;False;0;1;FLOAT4x4;0
Node;AmplifyShaderEditor.Vector4Node;326;-1915.645,3285.254;Float;False;Constant;_Vector0;Vector 0;0;0;Create;True;0;0;False;0;0,0,0,1;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldPosInputsNode;329;-1709.359,3039.112;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;328;-1633.562,3181.153;Float;False;2;2;0;FLOAT4x4;0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;330;-1385.061,3154.287;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;332;-1357.12,3474.427;Float;False;Constant;_Float5;Float 5;7;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;331;-1389.438,3318.729;Float;False;True;True;True;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;333;-1194.111,3226.723;Float;False;FLOAT4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;334;-1147.348,3104.494;Float;False;2;2;0;FLOAT4x4;0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.BreakToComponentsNode;335;-1013.358,2694.362;Float;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DynamicAppendNode;336;-1110.027,2518.416;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;337;-1378.347,2348.639;Float;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;338;-1303.64,2180.44;Float;False;Property;_GradientAngle;Gradient Angle;16;0;Create;True;0;0;False;0;-45;-45;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ATan2OpNode;341;-1095.715,2267.29;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RadiansOpNode;340;-1112.215,2178.09;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;339;-1072.969,2058.086;Float;False;Constant;_Float7;Float 7;7;0;Create;True;0;0;False;0;90;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RadiansOpNode;343;-890.1974,2088.457;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;342;-952.2135,2186.09;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;345;-711.2133,2133.09;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LengthOpNode;344;-779.6462,2476.022;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexTangentNode;141;-2238.863,-895.3572;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SamplerNode;136;-2001.36,-653.4565;Float;True;Property;_BumpMap;Bump Map;13;0;Create;True;0;0;False;0;None;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldNormalVector;144;-2232.839,-605.7565;Float;False;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.VertexBinormalNode;143;-2243.835,-757.5222;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.BreakToComponentsNode;346;-578.6204,2470.535;Float;False;FLOAT;1;0;FLOAT;0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.CosOpNode;348;-554.6464,2138.823;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;347;-574.8754,2315.074;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;146;-1716.864,-630.5366;Float;True;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.MatrixFromVectors;140;-1978.061,-792.9575;Float;False;FLOAT3x3;4;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3x3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;350;-423.4463,2196.422;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;349;-338.2563,2389.199;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;352;-762.8202,1869.145;Float;False;Property;_OriginXPLAYWITHME;Origin X (PLAY WITH ME);22;0;Create;True;0;0;False;0;0.5;-0.09;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;71;-2364.026,257.6643;Float;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;313;-2081.902,340.3332;Float;False;Constant;_Float3;Float 3;26;0;Create;True;0;0;False;0;0.001;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;351;-763.0233,1956.469;Float;False;Constant;_OriginY;Origin Y;3;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;145;-1495.213,-715.6403;Float;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3x3;0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.Vector3Node;316;-2129.362,485.2726;Float;False;Property;_StaticLightDirection;Static Light Direction;17;0;Create;True;0;0;False;0;0.7,-1,-1;0.7,-1,-1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.LightColorNode;318;-2092.069,123.3494;Float;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;212;-2272.734,821.954;Float;False;World;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.NormalizeNode;147;-1354.812,-717.0043;Float;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;309;-1511.889,-338.8142;Float;False;Property;_NormalMULT;Normal MULT;15;0;Create;True;0;0;False;0;2;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;353;-225.0462,2310.023;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;354;-483.4022,1931.535;Float;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ConditionalIfNode;317;-1803.959,158.0152;Float;False;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;356;-114.6462,2202.708;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;355;-987.9746,3207.032;Float;False;Property;_Tiling;Tiling;20;0;Create;True;0;0;False;0;0.08;0.005;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;308;-1247.878,-446.1584;Float;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleAddOpNode;223;-1972.119,827.4106;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;216;-1787.559,626.0222;Float;False;217;0;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;358;-75.34617,2463.869;Float;False;Property;_GradientSmooth;Gradient Smooth;21;0;Create;True;0;0;False;0;1;0.22;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;357;-796.2284,3132.912;Float;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.BreakToComponentsNode;359;-103.8919,2320.322;Float;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RegisterLocalVarNode;217;-1183.31,-792.4024;Float;False;myVarName0;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.NormalizeNode;222;-1796.153,828.1082;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;361;-211.4873,2002.212;Float;False;Constant;_Color0;Color 0;7;0;Create;True;0;0;False;0;1,1,1,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CeilOpNode;362;-618.9843,3139.356;Float;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;320;-1761.96,425.6235;Float;False;Constant;_Float4;Float 4;17;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;219;-1570.138,1020.276;Float;False;Property;_Gloss;Gloss;2;0;Create;True;0;0;False;0;1;1;1;30;0;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;360;108.63,2271.52;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;215;-1449.227,789.5828;Float;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightAttenuation;168;-1541.416,361.022;Float;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.LightColorNode;64;-1552.175,174.1031;Float;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.ColorNode;363;-210.4173,1810.487;Float;False;Constant;_Color1;Color 1;7;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;364;-80.34336,3094.255;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;218;-1291.421,808.1673;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;221;-1267.443,1011.597;Float;False;Property;_Specular;Specular;3;0;Create;True;0;0;False;0;1;0;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.ConditionalIfNode;319;-1624.594,448.5177;Float;False;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;365;109.2401,3117.379;Float;False;3drandvec;-1;;3;d94cb30cff2e2ee47907572510d84196;0;2;24;FLOAT;0;False;23;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;366;212.9327,2001.605;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.DotProductOpNode;70;-1238.146,-82.43951;Float;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;368;433.5165,2652.101;Float;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;306;-1004.94,319.1523;Float;False;Constant;_Float1;Float 1;15;0;Create;True;0;0;False;0;0.2;0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;73;-1022.074,-38.86852;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;367;722.6049,3094.064;Float;False;5;0;FLOAT3;0,0,0;False;1;FLOAT3;-1,-1,-1;False;2;FLOAT3;1,1,1;False;3;FLOAT3;0,0,0;False;4;FLOAT3;1,1,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;220;-1092.727,802.4246;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;305;-792.224,98.39151;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WorldPosInputsNode;125;-493.9616,906.402;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.BreakToComponentsNode;369;930.6569,3124.463;Float;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.Vector4Node;83;-507.3965,737.7778;Float;False;Constant;_Vector1;Vector 1;0;0;Create;True;0;0;False;0;0,-1,0,1;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;103;-62.80528,-340.3971;Float;True;Property;_MainTex;Main Tex;8;0;Create;True;0;0;False;0;None;2008bc5da4b54ec4794ec5f81a9d5679;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;92;-524.1679,310.3037;Float;False;Constant;_Float0;Float 0;1;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;91;-620.5579,471.4018;Float;False;Property;_Shadow;Shadow;1;0;Create;True;0;0;False;0;0;0.595;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;105;11.22445,-107.3214;Float;False;Property;_MaskColor;Mask Color;9;1;[HDR];Create;True;0;0;False;0;0,0,0,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;86;-490.6377,1061.639;Float;False;Constant;_Vector2;Vector 2;0;0;Create;True;0;0;False;0;0,1,0,1;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;370;760.9329,2578.907;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;236;-991.835,1020.967;Float;False;Property;_GlossPos;Gloss Pos;5;0;Create;True;0;0;False;0;1;1;1;256;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;245;-953.5909,797.2953;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;231;-1020.171,1431.226;Float;False;Property;_GlossColor;Gloss Color;4;0;Create;True;0;0;False;0;1,1,1,0;1,1,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;290;-218.8302,660.1541;Float;False;Constant;_Float2;Float 2;20;0;Create;True;0;0;False;0;-1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PosterizeNode;239;-770.1539,822.0636;Float;False;1;2;1;COLOR;0,0,0,0;False;0;INT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LightColorNode;182;-242.0083,1182.38;Float;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.CustomExpressionNode;85;-287.8065,1068.378;Float;False;return ShadeSH9(half4(In0))@;1;False;1;True;In0;FLOAT4;0,0,0,0;In;My Custom Expression;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;93;-349.4334,302.0155;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;104;344.1286,-59.27595;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LightColorNode;286;-875.1208,1588.051;Float;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.ClampOpNode;372;967.3269,2560.974;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;371;1199.359,3124.412;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;307;-641.3577,31.21159;Float;True;Property;_ShadowRamp;Shadow Ramp;7;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CustomExpressionNode;82;-278.0639,728.8098;Float;False;return ShadeSH9(half4(In0))@;1;False;1;True;In0;FLOAT4;0,0,0,0;In;My Custom Expression;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;120;199.9882,57.61399;Float;True;Property;_ColorMask;Color Mask;10;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CustomExpressionNode;124;-282.1297,908.8864;Float;False;return DecodeHDR(UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, normalize((_WorldSpaceCameraPos -objPos)), 7), unity_SpecCube0_HDR)* 0.02@;3;False;1;True;objPos;FLOAT3;0,0,0;In;My Custom Expression;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;121;-36.63543,719.2446;Float;False;3;3;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;89;-21.25515,869.2344;Float;False;3;3;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;237;-563.7154,1435.416;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;373;1182.575,2560.192;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;119;571.5412,-61.47873;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;95;-45.14767,289.8023;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;81;-28.33839,499.7956;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;232;-18.17629,389.1621;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;199;382.0619,289.064;Float;False;Property;_Color;Color;6;0;Create;True;0;0;False;0;0,0,0,0;1,1,1,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LightAttenuation;189;321.6678,830.8065;Float;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.DecodeLightmapHlpNode;110;340.3415,690.7327;Float;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;253;790.8775,-173.4126;Float;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CeilOpNode;375;1343.017,2573.286;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;376;957.5028,2767.804;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;87;-16.58986,623.4379;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;377;833.9539,2910.625;Float;False;Property;_Displacement;Displacement;18;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;112;558.4617,683.3754;Float;False;#ifdef LIGHTMAP_OFF$In0 = 1@$#endif$return In0@;4;False;1;True;In0;FLOAT4;0,0,0,0;In;My Custom Expression;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ClampOpNode;379;1496.813,2573.286;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;252;778.4542,-264.0804;Float;False;False;False;False;True;1;0;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;127;751.2711,30.31899;Float;True;Property;_EmissionMap;Emission Map;12;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;106;185.0852,450.357;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;198;604.7799,124.0774;Float;False;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;130;786.8121,239.0403;Float;False;Property;_EmissionColor;Emission Color;11;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;378;1144.617,2919.92;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;194;580.6287,827.7976;Float;False;#if DIRECTIONAL$atten = 1@$#endif$return atten@;1;False;1;True;atten;FLOAT;0;In;My Custom Expression;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;128;1057.234,249.8083;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;384;1134.264,-292.7494;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;381;1335.156,2931.538;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;107;748.7986,422.1623;Float;False;5;5;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector3Node;380;1285.595,2743.999;Float;False;Constant;_Vector3;Vector 3;4;0;Create;True;0;0;False;0;-1,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;255;827.4104,431.6897;Float;False;Property;_CutoutValue;Cutout Value;14;0;Create;True;0;0;False;0;0.5;0.644;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;325;-496.608,-456.6754;Float;True;Property;_TextureSample0;Texture Sample 0;19;0;Create;True;0;0;False;0;None;56a68e301a0ff55469ae441c0112d256;True;0;False;white;LockedToCube;False;Object;-1;Auto;Cube;6;0;SAMPLER2D;;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;323;1242.348,1008.258;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;254;1252.512,-177.9385;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldReflectionVector;324;-730.7747,-432.7618;Float;False;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RegisterLocalVarNode;265;498.3356,-367.9112;Float;False;myVarName1;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;382;1541.14,2870.607;Float;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;383;-780.4113,3272.62;Float;False;myVarName2;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleAddOpNode;126;1218.224,595.478;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SinTimeNode;385;-1047.38,1779.422;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1629.251,977.9595;Float;False;True;2;Float;ASEMaterialInspector;0;0;CustomLighting;Midget/idontfeelgood;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;1;0;False;0;Custom;0.46;True;True;0;True;TransparentCutout;;Geometry;ForwardOnly;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;SrcAlpha;OneMinusSrcAlpha;0;SrcAlpha;OneMinusSrcAlpha;OFF;OFF;0;False;0.1;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;0;0;False;0;0;0;False;-1;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;328;0;327;0
WireConnection;328;1;326;0
WireConnection;330;0;329;0
WireConnection;330;1;328;0
WireConnection;331;0;330;0
WireConnection;333;0;331;0
WireConnection;333;3;332;0
WireConnection;334;0;327;0
WireConnection;334;1;333;0
WireConnection;335;0;334;0
WireConnection;336;0;335;0
WireConnection;336;1;335;1
WireConnection;337;0;336;0
WireConnection;341;0;337;1
WireConnection;341;1;337;0
WireConnection;340;0;338;0
WireConnection;343;0;339;0
WireConnection;342;0;340;0
WireConnection;342;1;341;0
WireConnection;345;0;343;0
WireConnection;345;1;342;0
WireConnection;344;0;336;0
WireConnection;346;0;344;0
WireConnection;348;0;345;0
WireConnection;347;0;345;0
WireConnection;146;0;136;1
WireConnection;146;1;136;2
WireConnection;146;2;136;3
WireConnection;140;0;141;0
WireConnection;140;1;143;0
WireConnection;140;2;144;0
WireConnection;350;0;348;0
WireConnection;350;1;346;0
WireConnection;349;0;346;0
WireConnection;349;1;347;0
WireConnection;145;0;146;0
WireConnection;145;1;140;0
WireConnection;147;0;145;0
WireConnection;353;0;350;0
WireConnection;353;1;349;0
WireConnection;354;0;352;0
WireConnection;354;1;351;0
WireConnection;317;0;318;2
WireConnection;317;1;313;0
WireConnection;317;2;71;0
WireConnection;317;3;71;0
WireConnection;317;4;316;0
WireConnection;356;0;353;0
WireConnection;356;1;354;0
WireConnection;308;0;147;0
WireConnection;308;1;309;0
WireConnection;223;0;212;0
WireConnection;223;1;317;0
WireConnection;357;0;334;0
WireConnection;357;1;355;0
WireConnection;359;0;356;0
WireConnection;217;0;308;0
WireConnection;222;0;223;0
WireConnection;362;0;357;0
WireConnection;360;0;359;0
WireConnection;360;2;358;0
WireConnection;215;0;216;0
WireConnection;215;1;222;0
WireConnection;218;0;215;0
WireConnection;218;1;219;0
WireConnection;319;0;64;2
WireConnection;319;1;313;0
WireConnection;319;2;168;0
// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Midget/Toon Lighting PMD NGF"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_Shadow("Shadow", Range( 0 , 1)) = 0
		_Shiniess("Shiniess", Range( 1 , 200)) = 1
		_SpecularContrib("Specular Contrib", Float) = 1
		_SpecularColor("Specular Color", Color) = (1,1,1,0)
		_Color("Color", Color) = (0,0,0,0)
		_ShadowRamp("Shadow Ramp", 2D) = "white" {}
		_MainTex("Main Tex", 2D) = "white" {}
		[HDR]_MaskColor("Mask Color", Color) = (0,0,0,0)
		_ColorMask("Color Mask", 2D) = "white" {}
		_EmissionColor("Emission Color", Color) = (0,0,0,0)
		_EmissionMap("Emission Map", 2D) = "white" {}
		_BumpMap("Bump Map", 2D) = "bump" {}
		_CutoutValue("Cutout Value", Range( 0 , 1)) = 0.5
		_NormalMULT("Normal MULT", Float) = 1
		_SphereMult("Sphere Mult", 2D) = "white" {}
		_GradientAngle("Gradient Angle", Float) = -45
		_Vector0("Vector 0", Vector) = (0.7,-1,-1,0)
		_SphereAdd("Sphere Add", 2D) = "black" {}
		_Displacement("Displacement", Float) = 1
		_Tiling("Tiling", Float) = 0.01
		_GradSmooth("Grad Smooth", Float) = 0.5
		_PLAYWITHME("(PLAY WITH ME!)", Float) = 0.15
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Geometry+0" }
		Cull Off
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) fixed3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
		};

		struct SurfaceOutputCustomLightingCustom
		{
			fixed3 Albedo;
			fixed3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			fixed Alpha;
			Input SurfInput;
			UnityGIInput GIData;
		};

		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform float4 _MaskColor;
		uniform sampler2D _ColorMask;
		uniform float4 _ColorMask_ST;
		uniform float _GradSmooth;
		uniform float _GradientAngle;
		uniform float _PLAYWITHME;
		uniform float _Tiling;
		uniform float _CutoutValue;
		uniform sampler2D _EmissionMap;
		uniform float4 _EmissionMap_ST;
		uniform float4 _EmissionColor;
		uniform sampler2D _SphereAdd;
		uniform sampler2D _SphereMult;
		uniform float4 _Color;
		uniform sampler2D _ShadowRamp;
		uniform sampler2D _BumpMap;
		uniform float4 _BumpMap_ST;
		uniform float _NormalMULT;
		uniform float3 _Vector0;
		uniform float _Shadow;
		uniform float _Shiniess;
		uniform float4 _SpecularColor;
		uniform float _SpecularContrib;
		uniform float _Displacement;
		uniform float _Cutoff = 0.5;


		float MyCustomExpression82( float4 In0 )
		{
			return ShadeSH9(half4(In0));
		}


		float3 MyCustomExpression124( float3 objPos )
		{
			return DecodeHDR(UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, normalize((_WorldSpaceCameraPos -objPos)), 7), unity_SpecCube0_HDR)* 0.02;
		}


		float MyCustomExpression85( float4 In0 )
		{
			return ShadeSH9(half4(In0));
		}


		float4 MyCustomExpression112( float4 In0 )
		{
			#ifdef LIGHTMAP_OFF
			In0 = 1;
			#endif
			return In0;
		}


		float MyCustomExpression194( float atten )
		{
			#if DIRECTIONAL
			atten = 1;
			#endif
			return atten;
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float4 appendResult377 = (float4((( float4( ase_worldPos , 0.0 ) - mul( unity_ObjectToWorld, float4(0,0,0,1) ) )).xyz , 0.0));
			float4 temp_output_378_0 = mul( unity_ObjectToWorld, appendResult377 );
			float2 appendResult380 = (float2(temp_output_378_0.x , temp_output_378_0.y));
			float temp_output_388_0 = ( radians( 90.0 ) - ( radians( _GradientAngle ) + atan2( appendResult380.y , appendResult380.x ) ) );
			float2 appendResult397 = (float2(( cos( temp_output_388_0 ) * 0 ) , ( length( appendResult380 ) * sin( temp_output_388_0 ) )));
			float2 appendResult398 = (float2(_PLAYWITHME , 0.5));
			float smoothstepResult406 = smoothstep( 0 , _GradSmooth , ( appendResult397 + appendResult398 ).x);
			float4 lerpResult410 = lerp( float4(0,0,0,0) , float4(1,1,1,0) , smoothstepResult406);
			float clampResult419 = clamp( lerpResult410.r , 0 , 1 );
			float3 temp_output_23_0_g3 = ceil( ( temp_output_378_0 / _Tiling ) ).xyz;
			float dotResult6_g3 = dot( temp_output_23_0_g3 , float3(48114,63886,67997) );
			float dotResult7_g3 = dot( temp_output_23_0_g3 , float3(11649,73362,35861) );
			float2 appendResult8_g3 = (float2(dotResult6_g3 , dotResult7_g3));
			float dotResult9_g3 = dot( temp_output_23_0_g3 , float3(91385,63399,80130) );
			float3 appendResult13_g3 = (float3(appendResult8_g3 , dotResult9_g3));
			float mulTime408 = _Time.y * 1;
			float3 temp_output_16_0_g3 = ( sin( appendResult13_g3 ) * ( 84591.0 + mulTime408 ) );
			float3 temp_cast_2 = (1.0).xxx;
			float clampResult416 = clamp( (float3( 0,0,0 ) + (( ( ( temp_output_16_0_g3 - floor( temp_output_16_0_g3 ) ) * 2.0 ) - temp_cast_2 ) - float3( -1,-1,-1 )) * (float3( 1,1,1 ) - float3( 0,0,0 )) / (float3( 1,1,1 ) - float3( -1,-1,-1 ))).x , 0 , 1 );
			v.vertex.xyz += ( ( ( _Displacement * clampResult419 ) * clampResult416 ) * float3(-1,1,0) );
		}

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			#if DIRECTIONAL
			float ase_lightAtten = data.atten;
			if( _LightColor0.a == 0)
			ase_lightAtten = 0;
			#else
			float3 ase_lightAttenRGB = gi.light.color / ( ( _LightColor0.rgb ) + 0.000001 );
			float ase_lightAtten = max( max( ase_lightAttenRGB.r, ase_lightAttenRGB.g ), ase_lightAttenRGB.b );
			#endif
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 tex2DNode103 = tex2D( _MainTex, uv_MainTex );
			float2 uv_ColorMask = i.uv_texcoord * _ColorMask_ST.xy + _ColorMask_ST.zw;
			float4 lerpResult119 = lerp( ( tex2DNode103 * _MaskColor ) , tex2DNode103 , tex2D( _ColorMask, uv_ColorMask ).r);
			float3 ase_worldPos = i.worldPos;
			float4 appendResult377 = (float4((( float4( ase_worldPos , 0.0 ) - mul( unity_ObjectToWorld, float4(0,0,0,1) ) )).xyz , 0.0));
			float4 temp_output_378_0 = mul( unity_ObjectToWorld, appendResult377 );
			float2 appendResult380 = (float2(temp_output_378_0.x , temp_output_378_0.y));
			float temp_output_388_0 = ( radians( 90.0 ) - ( radians( _GradientAngle ) + atan2( appendResult380.y , appendResult380.x ) ) );
			float2 appendResult397 = (float2(( cos( temp_output_388_0 ) * 0 ) , ( length( appendResult380 ) * sin( temp_output_388_0 ) )));
			float2 appendResult398 = (float2(_PLAYWITHME , 0.5));
			float smoothstepResult406 = smoothstep( 0 , _GradSmooth , ( appendResult397 + appendResult398 ).x);
			float4 lerpResult410 = lerp( float4(0,0,0,0) , float4(1,1,1,0) , smoothstepResult406);
			float clampResult415 = clamp( ( 1.0 - lerpResult410.r ) , 0 , 1 );
			float3 temp_output_23_0_g3 = ceil( ( temp_output_378_0 / _Tiling ) ).xyz;
			float dotResult6_g3 = dot( temp_output_23_0_g3 , float3(48114,63886,67997) );
			float dotResult7_g3 = dot( temp_output_23_0_g3 , float3(11649,73362,35861) );
			float2 appendResult8_g3 = (float2(dotResult6_g3 , dotResult7_g3));
			float dotResult9_g3 = dot( temp_output_23_0_g3 , float3(91385,63399,80130) );
			float3 appendResult13_g3 = (float3(appendResult8_g3 , dotResult9_g3));
			float mulTime408 = _Time.y * 1;
			float3 temp_output_16_0_g3 = ( sin( appendResult13_g3 ) * ( 84591.0 + mulTime408 ) );
			float3 temp_cast_2 = (1.0).xxx;
			float clampResult416 = clamp( (float3( 0,0,0 ) + (( ( ( temp_output_16_0_g3 - floor( temp_output_16_0_g3 ) ) * 2.0 ) - temp_cast_2 ) - float3( -1,-1,-1 )) * (float3( 1,1,1 ) - float3( 0,0,0 )) / (float3( 1,1,1 ) - float3( -1,-1,-1 ))).x , 0 , 1 );
			float clampResult421 = clamp( ceil( ( clampResult415 - clampResult416 ) ) , 0 , 1 );
			float2 uv_EmissionMap = i.uv_texcoord * _EmissionMap_ST.xy + _EmissionMap_ST.zw;
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 normalizeResult347 = normalize( mul( UNITY_MATRIX_MV, float4( ase_worldNormal , 0.0 ) ).xyz );
			float2 appendResult352 = (float2(normalizeResult347.xy));
			float2 temp_output_351_0 = ( ( appendResult352 * 0.5 ) + 0.5 );
			float4 In082 = float4(0,-1,0,1);
			float localMyCustomExpression82 = MyCustomExpression82( In082 );
			float3 objPos124 = ase_worldPos;
			float3 localMyCustomExpression124 = MyCustomExpression124( objPos124 );
			float4 In085 = float4(0,1,0,1);
			float localMyCustomExpression85 = MyCustomExpression85( In085 );
			float2 uv_BumpMap = i.uv_texcoord * _BumpMap_ST.xy + _BumpMap_ST.zw;
			float3 tex2DNode136 = UnpackNormal( tex2D( _BumpMap, uv_BumpMap ) );
			float4 appendResult146 = (float4(tex2DNode136.r , tex2DNode136.g , tex2DNode136.b , 0));
			float3 ase_worldTangent = WorldNormalVector( i, float3( 1, 0, 0 ) );
			float3 ase_worldBitangent = WorldNormalVector( i, float3( 0, 1, 0 ) );
			float4 normalizeResult147 = normalize( float4( mul( appendResult146.xyz, float3x3(ase_worldTangent, ase_worldBitangent, ase_worldNormal) ) , 0.0 ) );
			float4 temp_output_308_0 = ( normalizeResult147 * _NormalMULT );
			float3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			float3 ifLocalVar365 = 0;
			if( _LightColor0.a >= 0.001 )
				ifLocalVar365 = ase_worldlightDir;
			else
				ifLocalVar365 = _Vector0;
			float dotResult70 = dot( temp_output_308_0 , float4( ifLocalVar365 , 0.0 ) );
			float2 appendResult305 = (float2(0.0 , ( ( dotResult70 * 0.5 ) + 0.5 )));
			float4 Normals217 = temp_output_308_0;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 normalizeResult222 = normalize( ( ase_worldViewDir + ifLocalVar365 ) );
			float dotResult215 = dot( Normals217 , float4( normalizeResult222 , 0.0 ) );
			float3 lerpResult106 = lerp( saturate( ( localMyCustomExpression82 + localMyCustomExpression124 + 0.0 ) ) , saturate( ( localMyCustomExpression85 + localMyCustomExpression124 + _LightColor0.rgb ) ) , ( tex2D( _ShadowRamp, appendResult305 ) + ( 1.0 - _Shadow ) + ( pow( max( (float)0 , dotResult215 ) , _Shiniess ) * _SpecularColor * float4( _LightColor0.rgb , 0.0 ) * _SpecularContrib ) ).rgb);
			float3 decodeLightMap110 = DecodeLightmap( float4( 0,0,0,0 ) );
			float4 In0112 = float4( decodeLightMap110 , 0.0 );
			float4 localMyCustomExpression112 = MyCustomExpression112( In0112 );
			float ifLocalVar369 = 0;
			if( _LightColor0.a >= 0.001 )
				ifLocalVar369 = ase_lightAtten;
			else
				ifLocalVar369 = 1.0;
			float atten194 = ifLocalVar369;
			float localMyCustomExpression194 = MyCustomExpression194( atten194 );
			c.rgb = ( ( tex2D( _EmissionMap, uv_EmissionMap ) * _EmissionColor ) + ( ( ( ( float4( (lerpResult119).rgb , 0.0 ) + tex2D( _SphereAdd, temp_output_351_0 ) ) * tex2D( _SphereMult, temp_output_351_0 ) ) * _Color ) * float4( lerpResult106 , 0.0 ) * localMyCustomExpression112 * localMyCustomExpression194 * clampResult421 ) ).rgb;
			c.a = 1;
			clip( ( ( (lerpResult119).a + clampResult421 ) - _CutoutValue ) - _Cutoff );
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
			o.Normal = float3(0,0,1);
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows exclude_path:deferred vertex:vertexDataFunc 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float4 tSpace0 : TEXCOORD2;
				float4 tSpace1 : TEXCOORD3;
				float4 tSpace2 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				vertexDataFunc( v, customInputData );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				fixed3 worldNormal = UnityObjectToWorldNormal( v.normal );
				fixed3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				fixed3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			fixed4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				fixed3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputCustomLightingCustom o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputCustomLightingCustom, o )
				surf( surfIN, o );
				UnityGI gi;
				UNITY_INITIALIZE_OUTPUT( UnityGI, gi );
				LightingStandardCustomLighting( o, worldViewDir, gi );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15001
7;29;1586;824;2604.531;-538.5777;2.278626;True;True
Node;AmplifyShaderEditor.ObjectToWorldMatrixNode;370;-1889.27,3486.721;Float;False;0;1;FLOAT4x4;0
Node;AmplifyShaderEditor.Vector4Node;371;-1897.665,3612.651;Float;False;Constant;_Vector3;Vector 3;0;0;Create;True;0;0;False;0;0,0,0,1;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldPosInputsNode;372;-1691.379,3366.509;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;373;-1615.582,3508.55;Float;False;2;2;0;FLOAT4x4;0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;374;-1367.081,3481.684;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;375;-1339.14,3801.824;Float;False;Constant;_Float9;Float 9;7;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;376;-1371.458,3646.126;Float;False;True;True;True;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;377;-1176.131,3554.12;Float;False;FLOAT4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;378;-1129.368,3431.891;Float;False;2;2;0;FLOAT4x4;0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.BreakToComponentsNode;379;-995.3781,3021.759;Float;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DynamicAppendNode;380;-1092.047,2845.813;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;382;-1285.66,2506.237;Float;False;Property;_GradientAngle;Gradient Angle;17;0;Create;True;0;0;False;0;-45;-45;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;381;-1360.367,2676.035;Float;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;385;-1054.989,2385.483;Float;False;Constant;_Float11;Float 11;7;0;Create;True;0;0;False;0;90;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RadiansOpNode;384;-1094.235,2505.487;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ATan2OpNode;383;-1077.735,2594.687;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;387;-934.2336,2513.487;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RadiansOpNode;386;-872.2175,2415.854;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LengthOpNode;389;-761.6663,2803.419;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;388;-693.2334,2460.487;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;392;-556.8955,2642.47;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CosOpNode;391;-536.6665,2466.22;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;390;-560.6404,2797.931;Float;False;FLOAT;1;0;FLOAT;0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;394;-320.2765,2716.595;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;393;-405.4664,2523.819;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;396;-745.0433,2283.866;Float;False;Constant;_Float13;Float 13;3;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;144;-2232.839,-605.7565;Float;False;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.VertexTangentNode;141;-2238.863,-895.3572;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.VertexBinormalNode;143;-2243.835,-757.5222;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SamplerNode;136;-2001.36,-653.4565;Float;True;Property;_BumpMap;Bump Map;12;0;Create;True;0;0;False;0;None;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;395;-744.8402,2196.542;Float;False;Property;_PLAYWITHME;(PLAY WITH ME!);25;0;Create;True;0;0;False;0;0.15;-0.59;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.MatrixFromVectors;140;-1978.061,-792.9575;Float;False;FLOAT3x3;4;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3x3;0
Node;AmplifyShaderEditor.DynamicAppendNode;146;-1716.864,-630.5366;Float;True;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;397;-207.0662,2637.42;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;398;-465.4223,2258.932;Float;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WorldNormalVector;359;-427.5302,-876.2585;Float;False;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.LightColorNode;362;-2058.893,122.0252;Float;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.Vector3Node;361;-2096.186,483.9487;Float;False;Property;_Vector0;Vector 0;18;0;Create;True;0;0;False;0;0.7,-1,-1;0.7,-1,-1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.MVMatrixNode;345;-441.5035,-988.2793;Float;False;0;1;FLOAT4x4;0
Node;AmplifyShaderEditor.SimpleAddOpNode;399;-96.66628,2530.105;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;145;-1495.213,-715.6403;Float;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3x3;0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;364;-2048.726,339.0092;Float;False;Constant;_Float7;Float 7;26;0;Create;True;0;0;False;0;0.001;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;363;-2330.85,256.3401;Float;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;400;-969.9948,3534.429;Float;False;Property;_Tiling;Tiling;23;0;Create;True;0;0;False;0;0.01;0.01;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;309;-1511.889,-338.8142;Float;False;Property;_NormalMULT;Normal MULT;14;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;402;-778.2485,3460.309;Float;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.NormalizeNode;147;-1354.812,-717.0043;Float;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.BreakToComponentsNode;403;-85.912,2647.719;Float;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;212;-2272.734,806.2135;Float;False;World;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;346;-93.80359,-1125.079;Float;False;2;2;0;FLOAT4x4;0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ConditionalIfNode;365;-1770.784,156.691;Float;False;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;401;-55.76629,2791.265;Float;False;Property;_GradSmooth;Grad Smooth;24;0;Create;True;0;0;False;0;0.5;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;406;126.61,2598.917;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;408;-62.36348,3421.652;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;405;-601.0044,3466.753;Float;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.NormalizeNode;347;120.8966,-1033.88;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;223;-1972.119,827.4106;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;308;-1247.878,-446.1584;Float;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ColorNode;404;-193.5074,2329.609;Float;False;Constant;_Color0;Color 0;7;0;Create;True;0;0;False;0;1,1,1,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;407;-192.4374,2137.884;Float;False;Constant;_Color1;Color 1;7;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;216;-1787.559,626.0222;Float;False;217;0;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;350;219.3375,-909.351;Float;False;Constant;_Float5;Float 5;17;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;332;-1096.269,74.23193;Float;False;Constant;_Float3;Float 3;16;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;217;-1183.31,-792.4024;Float;False;Normals;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.FunctionNode;409;127.2201,3444.776;Float;False;3drandvec;-1;;3;d94cb30cff2e2ee47907572510d84196;0;2;24;FLOAT;0;False;23;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;103;-20.22932,-711.3135;Float;True;Property;_MainTex;Main Tex;7;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;410;230.9126,2329.002;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;352;275.3375,-1014.351;Float;False;FLOAT2;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DotProductOpNode;70;-1083.201,-53.38729;Float;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;105;25.91689,-464.2958;Float;False;Property;_MaskColor;Mask Color;8;1;[HDR];Create;True;0;0;False;0;0,0,0,0;1,1,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NormalizeNode;222;-1796.153,828.1082;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;120;47.37946,-269.7344;Float;True;Property;_ColorMask;Color Mask;9;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;331;-905.0081,-51.661;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;330;-1466.1,687.9857;Float;False;Constant;_Int0;Int 0;17;0;Create;True;0;0;False;0;0;0;0;1;INT;0
Node;AmplifyShaderEditor.DotProductOpNode;215;-1449.227,789.5828;Float;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;411;451.4964,2979.497;Float;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;334;-871.1139,250.9663;Float;False;Constant;_Float4;Float 4;16;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;412;740.5849,3421.461;Float;False;5;0;FLOAT3;0,0,0;False;1;FLOAT3;-1,-1,-1;False;2;FLOAT3;1,1,1;False;3;FLOAT3;0,0,0;False;4;FLOAT3;1,1,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;349;401.3375,-992.351;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;104;350.1074,-397.0805;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector4Node;86;-347.2934,1717.837;Float;False;Constant;_Vector2;Vector 2;0;0;Create;True;0;0;False;0;0,1,0,1;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;306;-1139.558,155.4998;Float;False;Constant;_Float1;Float 1;15;0;Create;True;0;0;False;0;0;0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;119;520.0099,-529.9872;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector4Node;83;-364.0522,1393.976;Float;False;Constant;_Vector1;Vector 1;0;0;Create;True;0;0;False;0;0,-1,0,1;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;219;-1570.138,1020.276;Float;False;Property;_Shiniess;Shiniess;2;0;Create;True;0;0;False;0;1;200;1;200;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;333;-730.6948,-58.92401;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;125;-350.6173,1562.6;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode;351;548.3375,-967.351;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;414;778.913,2906.303;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;329;-1275.603,778.3309;Float;False;2;0;INT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;413;948.637,3451.86;Float;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.ColorNode;231;-1020.171,1431.226;Float;False;Property;_SpecularColor;Specular Color;4;0;Create;True;0;0;False;0;1,1,1,0;1,1,1,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;305;-792.224,98.39151;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;354;693.4746,-1110.229;Float;True;Property;_SphereAdd;Sphere Add;19;0;Create;True;0;0;False;0;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;416;1217.339,3451.809;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;91;-620.5579,471.4018;Float;False;Property;_Shadow;Shadow;1;0;Create;True;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;360;-781.8545,1647.488;Float;False;Property;_SpecularContrib;Specular Contrib;3;0;Create;True;0;0;False;0;1;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LightColorNode;286;-766.8499,1746.723;Float;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.ComponentMaskNode;253;432.2901,-231.8779;Float;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CustomExpressionNode;82;-134.7196,1385.008;Float;False;return ShadeSH9(half4(In0))@;1;False;1;True;In0;FLOAT4;0,0,0,0;In;My Custom Expression;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;85;-144.4622,1724.576;Float;False;return ShadeSH9(half4(In0))@;1;False;1;True;In0;FLOAT4;0,0,0,0;In;My Custom Expression;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;415;985.3069,2888.37;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;290;-109.2673,1476.815;Float;False;Constant;_Float2;Float 2;20;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;92;-524.1679,310.3037;Float;False;Constant;_Float0;Float 0;1;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;218;-1122.906,782.9039;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;124;-138.7854,1565.084;Float;False;return DecodeHDR(UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, normalize((_WorldSpaceCameraPos -objPos)), 7), unity_SpecCube0_HDR)* 0.02@;3;False;1;True;objPos;FLOAT3;0,0,0;In;My Custom Expression;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LightColorNode;182;-98.66399,1838.578;Float;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleAddOpNode;89;122.0893,1525.432;Float;False;3;3;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;368;-1728.785,424.2996;Float;False;Constant;_Float8;Float 8;17;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;353;688.3375,-921.351;Float;True;Property;_SphereMult;Sphere Mult;16;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;121;106.709,1375.443;Float;False;3;3;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LightColorNode;367;-1519,172.7789;Float;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleAddOpNode;355;664.6013,-241.099;Float;False;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;93;-336.2435,304.9466;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;307;-641.3577,31.21159;Float;True;Property;_ShadowRamp;Shadow Ramp;6;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LightAttenuation;366;-1508.241,359.6981;Float;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;237;-563.7154,1435.416;Float;False;4;4;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;417;1200.555,2887.588;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;81;127.7477,1191.034;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CeilOpNode;418;1360.997,2900.682;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;419;975.4828,3095.201;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;356;644.5586,-94.78829;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;420;851.934,3238.022;Float;False;Property;_Displacement;Displacement;20;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;95;-132.6486,242.5518;Float;False;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;199;-374.0522,1039.822;Float;False;Property;_Color;Color;5;0;Create;True;0;0;False;0;0,0,0,0;1,1,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;87;126.7546,1279.636;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ConditionalIfNode;369;-1591.419,447.1938;Float;False;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DecodeLightmapHlpNode;110;340.3415,684.6046;Float;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;127;821.4296,-197.6956;Float;True;Property;_EmissionMap;Emission Map;11;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;130;856.9706,11.02572;Float;False;Property;_EmissionColor;Emission Color;10;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;422;1162.597,3247.317;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;194;580.6287,827.7976;Float;False;#if DIRECTIONAL$atten = 1@$#endif$return atten@;1;False;1;True;atten;FLOAT;0;In;My Custom Expression;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;106;262.7835,1008.085;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;252;833.022,-451.1694;Float;False;False;False;False;True;1;0;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;112;694.3001,905.8863;Float;False;#ifdef LIGHTMAP_OFF$In0 = 1@$#endif$return In0@;4;False;1;True;In0;FLOAT4;0,0,0,0;In;My Custom Expression;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;341;438.2247,441.1999;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;421;1514.793,2900.682;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;107;853.0204,740.8398;Float;False;5;5;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;128;1127.392,21.79374;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;427;1107.557,-440.0771;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;423;1353.136,3258.935;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;424;1303.575,3071.396;Float;False;Constant;_Vector4;Vector 4;4;0;Create;True;0;0;False;0;-1,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;255;958.0803,-299.4698;Float;False;Property;_CutoutValue;Cutout Value;13;0;Create;True;0;0;False;0;0.5;0.497;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;339;75.27415,621.7269;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;325;-496.608,-456.6754;Float;True;Property;_CubeMap;CubeMap;21;0;Create;True;0;0;False;0;None;None;True;0;False;white;LockedToCube;False;Object;-1;Auto;Cube;6;0;SAMPLER2D;;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;343;-455.5048,-1135.097;Float;False;217;0;1;FLOAT4;0
Node;AmplifyShaderEditor.WorldReflectionVector;324;-730.7747,-432.7618;Float;False;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleSubtractOpNode;254;1234.972,-427.3903;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;126;1218.224,595.478;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;425;1559.12,3198.004;Float;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;426;-762.4315,3600.017;Float;False;myVarName2;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.LightAttenuation;189;321.6678,830.8065;Float;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;348;-270.6625,-1072.351;Float;False;FLOAT3;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;336;2.861138,729.0228;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;335;-370.2743,688.0016;Float;False;Property;_Ambient;Ambient;15;0;Create;True;0;0;False;0;1,1,1,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LightColorNode;337;-346.5188,892.5692;Float;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;326;-183.5197,-378.0369;Float;False;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;265;504.3144,-705.7161;Float;False;myVarName1;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;340;-100.8902,849.7739;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;327;-487.7581,-153.6873;Float;False;Property;_CubeMapIntensity;CubeMap Intensity;22;0;Create;True;0;0;False;0;0;0;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1629.251,977.9595;Float;False;True;2;Float;ASEMaterialInspector;0;0;CustomLighting;Midget/Toon Lighting PMD NGF;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;1;0;False;0;Custom;0.5;True;True;0;True;TransparentCutout;;Geometry;ForwardOnly;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;SrcAlpha;OneMinusSrcAlpha;0;SrcAlpha;OneMinusSrcAlpha;OFF;OFF;0;False;0.1;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;0;0;False;0;0;0;False;-1;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;373;0;370;0
WireConnection;373;1;371;0
WireConnection;374;0;372;0
WireConnection;374;1;373;0
WireConnection;376;0;374;0
WireConnection;377;0;376;0
WireConnection;377;3;375;0
WireConnection;378;0;370;0
WireConnection;378;1;377;0
WireConnection;379;0;378;0
WireConnection;380;0;379;0
WireConnection;380;1;379;1
WireConnection;381;0;380;0
WireConnection;384;0;382;0
WireConnection;383;0;381;1
WireConnection;383;1;381;0
WireConnection;387;0;384;0
WireConnection;387;1;383;0
WireConnection;386;0;385;0
WireConnection;389;0;380;0
WireConnection;388;0;386;0
WireConnection;388;1;387;0
WireConnection;392;0;388;0
WireConnection;391;0;388;0
WireConnection;390;0;389;0
WireConnection;394;0;390;0
WireConnection;394;1;392;0
WireConnection;393;0;391;0
WireConnection;140;0;141;0
WireConnection;140;1;143;0
WireConnection;140;2;144;0
WireConnection;146;0;136;1
WireConnection;146;1;136;2
WireConnection;146;2;136;3
WireConnection;397;0;393;0
WireConnection;397;1;394;0
WireConnection;398;0;395;0
WireConnection;398;1;396;0
WireConnection;399;0;397;0
WireConnection;399;1;398;0
WireConnection;145;0;146;0
WireConnection;145;1;140;0
WireConnection;402;0;378;0
WireConnection;402;1;400;0
WireConnection;147;0;145;0
WireConnection;403;0;399;0
WireConnection;346;0;345;0
WireConnection;346;1;359;0
WireConnection;365;0;362;2
WireConnection;365;1;364;0
WireConnection;365;2;363;0
WireConnection;365;3;363;0
WireConnection;365;4;361;0
WireConnection;406;0;403;0
WireConnection;406;2;401;0
WireConnection;405;0;402;0
WireConnection;347;0;346;0
WireConnection;223;0;212;0
WireConnection;223;1;365;0
WireConnection;308;0;147;0
WireConnection;308;1;309;0
WireConnection;217;0;308;0
WireConnection;409;24;408;0
WireConnection;409;23;405;0
WireConnection;410;0;407;0
WireConnection;410;1;404;0
WireConnection;410;2;406;0
WireConnection;352;0;347;0
WireConnection;70;0;308;0
WireConnection;70;1;365;0
WireConnection;222;0;223;0
WireConnection;331;0;70;0
WireConnection;331;1;332;0
WireConnection;215;0;216;0
WireConnection;215;1;222;0
WireConnection;411;0;410;0
WireConnection;412;0;409;0
WireConnection;349;0;352;0
WireConnection;349;1;350;0
WireConnection;104;0;103;0
WireConnection;104;1;105;0
WireConnection;119;0;104;0
WireConnection;119;1;103;0
WireConnection;119;2;120;1
WireConnection;333;0;331;0
WireConnection;333;1;334;0
WireConnection;351;0;349;0
WireConnection;351;1;350;0
WireConnection;414;0;411;0
WireConnection;329;0;330;0
WireConnection;329;1;215;0
WireConnection;413;0;412;0
WireConnection;305;0;306;0
WireConnection;305;1;333;0
WireConnection;354;1;351;0
WireConnection;416;0;413;0
WireConnection;253;0;119;0
WireConnection;82;0;83;0
WireConnection;85;0;86;0
WireConnection;415;0;414;0
WireConnection;218;0;329;0
WireConnection;218;1;219;0
WireConnection;124;0;125;0
WireConnection;89;0;85;0
WireConnection;89;1;124;0
WireConnection;89;2;182;1
WireConnection;353;1;351;0
WireConnection;121;0;82;0
WireConnection;121;1;124;0
WireConnection;121;2;290;0
WireConnection;355;0;253;0
WireConnection;355;1;354;0
WireConnection;93;0;92;0
WireConnection;93;1;91;0
WireConnection;307;1;305;0
WireConnection;237;0;218;0
WireConnection;237;1;231;0
WireConnection;237;2;286;1
WireConnection;237;3;360;0
WireConnection;417;0;415;0
WireConnection;417;1;416;0
WireConnection;81;0;121;0
WireConnection;418;0;417;0
WireConnection;419;0;411;0
WireConnection;356;0;355;0
WireConnection;356;1;353;0
WireConnection;95;0;307;0
WireConnection;95;1;93;0
WireConnection;95;2;237;0
WireConnection;87;0;89;0
WireConnection;369;0;367;2
WireConnection;369;1;364;0
WireConnection;369;2;366;0
WireConnection;369;3;366;0
WireConnection;369;4;368;0
WireConnection;422;0;420;0
WireConnection;422;1;419;0
WireConnection;194;0;369;0
WireConnection;106;0;81;0
WireConnection;106;1;87;0
WireConnection;106;2;95;0
WireConnection;252;0;119;0
WireConnection;112;0;110;0
WireConnection;341;0;356;0
WireConnection;341;1;199;0
WireConnection;421;0;418;0
WireConnection;107;0;341;0
WireConnection;107;1;106;0
WireConnection;107;2;112;0
WireConnection;107;3;194;0
WireConnection;107;4;421;0
WireConnection;128;0;127;0
WireConnection;128;1;130;0
WireConnection;427;0;252;0
WireConnection;427;1;421;0
WireConnection;423;0;422;0
WireConnection;423;1;416;0
WireConnection;339;0;336;0
WireConnection;325;1;324;0
WireConnection;324;0;136;0
WireConnection;254;0;427;0
WireConnection;254;1;255;0
WireConnection;126;0;128;0
WireConnection;126;1;107;0
WireConnection;425;0;423;0
WireConnection;425;1;424;0
WireConnection;426;0;378;0
WireConnection;348;0;343;0
WireConnection;336;0;335;0
WireConnection;336;1;340;0
WireConnection;326;0;325;0
WireConnection;326;1;327;0
WireConnection;326;2;106;0
WireConnection;265;0;103;4
WireConnection;340;0;337;0
WireConnection;0;10;254;0
WireConnection;0;13;126;0
WireConnection;0;11;425;0
ASEEND*/
//CHKSM=7E38124EAC9CF1B0AAC4DF308801E50F5AEF703A
