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
WireConnection;319;3;168;0
WireConnection;319;4;320;0
WireConnection;365;24;364;0
WireConnection;365;23;362;0
WireConnection;366;0;363;0
WireConnection;366;1;361;0
WireConnection;366;2;360;0
WireConnection;70;0;308;0
WireConnection;70;1;317;0
WireConnection;368;0;366;0
WireConnection;73;0;70;0
WireConnection;73;1;319;0
WireConnection;367;0;365;0
WireConnection;220;0;218;0
WireConnection;220;1;221;0
WireConnection;305;0;73;0
WireConnection;305;1;306;0
WireConnection;369;0;367;0
WireConnection;370;0;368;0
WireConnection;245;0;220;0
WireConnection;239;1;245;0
WireConnection;239;0;236;0
WireConnection;85;0;86;0
WireConnection;93;0;92;0
WireConnection;93;1;91;0
WireConnection;104;0;103;0
WireConnection;104;1;105;0
WireConnection;372;0;370;0
WireConnection;371;0;369;0
WireConnection;307;1;305;0
WireConnection;82;0;83;0
WireConnection;124;0;125;0
WireConnection;121;0;82;0
WireConnection;121;1;124;0
WireConnection;121;2;290;0
WireConnection;89;0;85;0
WireConnection;89;1;124;0
WireConnection;89;2;182;1
WireConnection;237;0;239;0
WireConnection;237;1;231;0
WireConnection;237;2;286;1
WireConnection;373;0;372;0
WireConnection;373;1;371;0
WireConnection;119;0;104;0
WireConnection;119;1;103;0
WireConnection;119;2;120;1
WireConnection;95;0;307;0
WireConnection;95;1;93;0
WireConnection;81;0;121;0
WireConnection;232;0;237;0
WireConnection;232;1;95;0
WireConnection;253;0;119;0
WireConnection;375;0;373;0
WireConnection;376;0;368;0
WireConnection;87;0;89;0
WireConnection;112;0;110;0
WireConnection;379;0;375;0
WireConnection;252;0;119;0
WireConnection;106;0;81;0
WireConnection;106;1;87;0
WireConnection;106;2;232;0
WireConnection;198;0;253;0
WireConnection;198;1;199;0
WireConnection;378;0;377;0
WireConnection;378;1;376;0
WireConnection;194;0;189;0
WireConnection;128;0;127;0
WireConnection;128;1;130;0
WireConnection;384;0;252;0
WireConnection;384;1;379;0
WireConnection;381;0;378;0
WireConnection;381;1;371;0
WireConnection;107;0;198;0
WireConnection;107;1;106;0
WireConnection;107;2;112;0
WireConnection;107;3;194;0
WireConnection;107;4;379;0
WireConnection;325;1;324;0
WireConnection;254;0;384;0
WireConnection;254;1;255;0
WireConnection;324;0;136;0
WireConnection;265;0;103;4
WireConnection;382;0;381;0
WireConnection;382;1;380;0
WireConnection;383;0;334;0
WireConnection;126;0;128;0
WireConnection;126;1;107;0
WireConnection;0;10;254;0
WireConnection;0;13;126;0
WireConnection;0;11;382;0
ASEEND*/
//CHKSM=0326EA323B5EFD32880C090CD7B5058004A9EB31