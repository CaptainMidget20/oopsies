// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Midget/Toon Lighting PMD"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_Shadow("Shadow", Range( 0 , 1)) = 0
		_Shiniess("Shiniess", Range( 1 , 200)) = 1
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
		_Vector0("Vector 0", Vector) = (0.7,-1,-1,0)
		_SphereAdd("Sphere Add", 2D) = "black" {}
		_Float6("Float 6", Float) = 1
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
			float3 worldNormal;
			INTERNAL_DATA
			float3 worldPos;
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
		uniform float _Float6;
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
			float2 uv_EmissionMap = i.uv_texcoord * _EmissionMap_ST.xy + _EmissionMap_ST.zw;
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 normalizeResult347 = normalize( mul( UNITY_MATRIX_MV, float4( ase_worldNormal , 0.0 ) ).xyz );
			float2 appendResult352 = (float2(normalizeResult347.xy));
			float2 temp_output_351_0 = ( ( appendResult352 * 0.5 ) + 0.5 );
			float4 In082 = float4(0,-1,0,1);
			float localMyCustomExpression82 = MyCustomExpression82( In082 );
			float3 ase_worldPos = i.worldPos;
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
			float3 lerpResult106 = lerp( saturate( ( localMyCustomExpression82 + localMyCustomExpression124 + 0.0 ) ) , saturate( ( localMyCustomExpression85 + localMyCustomExpression124 + _LightColor0.rgb ) ) , ( tex2D( _ShadowRamp, appendResult305 ) + ( 1.0 - _Shadow ) + ( pow( max( (float)0 , dotResult215 ) , _Shiniess ) * _SpecularColor * float4( _LightColor0.rgb , 0.0 ) * _Float6 ) ).rgb);
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
			c.rgb = ( ( tex2D( _EmissionMap, uv_EmissionMap ) * _EmissionColor ) + ( ( ( ( float4( (lerpResult119).rgb , 0.0 ) + tex2D( _SphereAdd, temp_output_351_0 ) ) * tex2D( _SphereMult, temp_output_351_0 ) ) * _Color ) * float4( lerpResult106 , 0.0 ) * localMyCustomExpression112 * localMyCustomExpression194 ) ).rgb;
			c.a = 1;
			clip( ( (lerpResult119).a - _CutoutValue ) - _Cutoff );
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
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows exclude_path:deferred 

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
71;246;1352;787;1475.09;477.4591;2.750601;True;True
Node;AmplifyShaderEditor.SamplerNode;136;-2001.36,-653.4565;Float;True;Property;_BumpMap;Bump Map;11;0;Create;True;0;0;False;0;None;76d06f04800da6046a2562de2611aa7f;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexTangentNode;141;-2238.863,-895.3572;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldNormalVector;144;-2232.839,-605.7565;Float;False;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.VertexBinormalNode;143;-2243.835,-757.5222;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.MatrixFromVectors;140;-1978.061,-792.9575;Float;False;FLOAT3x3;4;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3x3;0
Node;AmplifyShaderEditor.DynamicAppendNode;146;-1716.864,-630.5366;Float;True;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.WorldNormalVector;359;-427.5302,-876.2585;Float;False;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;145;-1495.213,-715.6403;Float;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3x3;0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.MVMatrixNode;345;-441.5035,-988.2793;Float;False;0;1;FLOAT4x4;0
Node;AmplifyShaderEditor.Vector3Node;361;-2096.186,483.9487;Float;False;Property;_Vector0;Vector 0;16;0;Create;True;0;0;False;0;0.7,-1,-1;0.7,-1,-1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.LightColorNode;362;-2058.893,122.0252;Float;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;363;-2330.85,256.3401;Float;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;364;-2048.726,339.0092;Float;False;Constant;_Float7;Float 7;26;0;Create;True;0;0;False;0;0.001;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;147;-1354.812,-717.0043;Float;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;309;-1511.889,-338.8142;Float;False;Property;_NormalMULT;Normal MULT;13;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;346;-93.80359,-1125.079;Float;False;2;2;0;FLOAT4x4;0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ConditionalIfNode;365;-1770.784,156.691;Float;False;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;212;-2272.734,806.2135;Float;False;World;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode;223;-1972.119,827.4106;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;347;120.8966,-1033.88;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;308;-1247.878,-446.1584;Float;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SamplerNode;103;-20.22932,-711.3135;Float;True;Property;_MainTex;Main Tex;6;0;Create;True;0;0;False;0;None;74cf9e9d62cfb9e4e9693d6a93821136;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;105;25.91689,-464.2958;Float;False;Property;_MaskColor;Mask Color;7;1;[HDR];Create;True;0;0;False;0;0,0,0,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;332;-1096.269,74.23193;Float;False;Constant;_Float3;Float 3;16;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;352;275.3375,-1014.351;Float;False;FLOAT2;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;350;219.3375,-909.351;Float;False;Constant;_Float5;Float 5;17;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;216;-1787.559,626.0222;Float;False;217;0;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;217;-1183.31,-792.4024;Float;False;Normals;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.NormalizeNode;222;-1796.153,828.1082;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DotProductOpNode;70;-1083.201,-53.38729;Float;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;330;-1466.1,687.9857;Float;False;Constant;_Int0;Int 0;17;0;Create;True;0;0;False;0;0;0;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;334;-871.1139,250.9663;Float;False;Constant;_Float4;Float 4;16;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;331;-905.0081,-51.661;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;215;-1449.227,789.5828;Float;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;120;47.37946,-269.7344;Float;True;Property;_ColorMask;Color Mask;8;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;104;350.1074,-397.0805;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;349;401.3375,-992.351;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;333;-730.6948,-58.92401;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;306;-1139.558,155.4998;Float;False;Constant;_Float1;Float 1;15;0;Create;True;0;0;False;0;0;0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;329;-1275.603,778.3309;Float;False;2;0;INT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;351;548.3375,-967.351;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WorldPosInputsNode;125;-350.6173,1562.6;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;219;-1570.138,1020.276;Float;False;Property;_Shiniess;Shiniess;2;0;Create;True;0;0;False;0;1;200;1;200;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;119;520.0099,-529.9872;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector4Node;86;-347.2934,1717.837;Float;False;Constant;_Vector2;Vector 2;0;0;Create;True;0;0;False;0;0,1,0,1;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;83;-364.0522,1393.976;Float;False;Constant;_Vector1;Vector 1;0;0;Create;True;0;0;False;0;0,-1,0,1;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;218;-1122.906,782.9039;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;360;-781.8545,1647.488;Float;False;Property;_Float6;Float 6;20;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;305;-792.224,98.39151;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;354;693.4746,-1110.229;Float;True;Property;_SphereAdd;Sphere Add;17;0;Create;True;0;0;False;0;None;4aa08ffc79525274db07013c5f39dc4c;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LightColorNode;182;-98.66399,1838.578;Float;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;290;-109.2673,1476.815;Float;False;Constant;_Float2;Float 2;20;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;231;-1020.171,1431.226;Float;False;Property;_SpecularColor;Specular Color;3;0;Create;True;0;0;False;0;1,1,1,0;1,1,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CustomExpressionNode;85;-144.4622,1724.576;Float;False;return ShadeSH9(half4(In0))@;1;False;1;True;In0;FLOAT4;0,0,0,0;In;My Custom Expression;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;91;-620.5579,471.4018;Float;False;Property;_Shadow;Shadow;1;0;Create;True;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;82;-134.7196,1385.008;Float;False;return ShadeSH9(half4(In0))@;1;False;1;True;In0;FLOAT4;0,0,0,0;In;My Custom Expression;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;124;-138.7854,1565.084;Float;False;return DecodeHDR(UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, normalize((_WorldSpaceCameraPos -objPos)), 7), unity_SpecCube0_HDR)* 0.02@;3;False;1;True;objPos;FLOAT3;0,0,0;In;My Custom Expression;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;253;432.2901,-231.8779;Float;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LightColorNode;286;-766.8499,1746.723;Float;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;92;-524.1679,310.3037;Float;False;Constant;_Float0;Float 0;1;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;355;664.6013,-241.099;Float;False;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;93;-336.2435,304.9466;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;121;106.709,1375.443;Float;False;3;3;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;89;122.0893,1525.432;Float;False;3;3;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;353;688.3375,-921.351;Float;True;Property;_SphereMult;Sphere Mult;15;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;237;-563.7154,1435.416;Float;False;4;4;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;307;-641.3577,31.21159;Float;True;Property;_ShadowRamp;Shadow Ramp;5;0;Create;True;0;0;False;0;None;4fa0d60b454b55b4d9c8bc8a781f7b74;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LightAttenuation;366;-1508.241,359.6981;Float;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.LightColorNode;367;-1519,172.7789;Float;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;368;-1728.785,424.2996;Float;False;Constant;_Float8;Float 8;17;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;199;-374.0522,1039.822;Float;False;Property;_Color;Color;4;0;Create;True;0;0;False;0;0,0,0,0;1,1,1,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;95;-132.6486,242.5518;Float;False;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;81;127.7477,1191.034;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DecodeLightmapHlpNode;110;340.3415,684.6046;Float;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;356;644.5586,-94.78829;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ConditionalIfNode;369;-1591.419,447.1938;Float;False;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;87;126.7546,1279.636;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;341;438.2247,441.1999;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CustomExpressionNode;112;694.3001,905.8863;Float;False;#ifdef LIGHTMAP_OFF$In0 = 1@$#endif$return In0@;4;False;1;True;In0;FLOAT4;0,0,0,0;In;My Custom Expression;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SamplerNode;127;821.4296,-197.6956;Float;True;Property;_EmissionMap;Emission Map;10;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;130;856.9706,11.02572;Float;False;Property;_EmissionColor;Emission Color;9;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;106;262.7835,1008.085;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CustomExpressionNode;194;580.6287,827.7976;Float;False;#if DIRECTIONAL$atten = 1@$#endif$return atten@;1;False;1;True;atten;FLOAT;0;In;My Custom Expression;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;255;958.0803,-299.4698;Float;False;Property;_CutoutValue;Cutout Value;12;0;Create;True;0;0;False;0;0.5;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;107;853.0204,740.8398;Float;False;4;4;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ComponentMaskNode;252;833.022,-451.1694;Float;False;False;False;False;True;1;0;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;128;1127.392,21.79374;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;254;1234.972,-427.3903;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;126;1218.224,595.478;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;325;-496.608,-456.6754;Float;True;Property;_CubeMap;CubeMap;18;0;Create;True;0;0;False;0;None;None;True;0;False;white;LockedToCube;False;Object;-1;Auto;Cube;6;0;SAMPLER2D;;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;335;-370.2743,688.0016;Float;False;Property;_Ambient;Ambient;14;0;Create;True;0;0;False;0;1,1,1,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;340;-100.8902,849.7739;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LightColorNode;337;-346.5188,892.5692;Float;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleAddOpNode;336;2.861138,729.0228;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;343;-455.5048,-1135.097;Float;False;217;0;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;327;-487.7581,-153.6873;Float;False;Property;_CubeMapIntensity;CubeMap Intensity;19;0;Create;True;0;0;False;0;0;0;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;339;75.27415,621.7269;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LightAttenuation;189;321.6678,830.8065;Float;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;348;-270.6625,-1072.351;Float;False;FLOAT3;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;265;504.3144,-705.7161;Float;False;myVarName1;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;326;-183.5197,-378.0369;Float;False;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WorldReflectionVector;324;-730.7747,-432.7618;Float;False;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1629.251,977.9595;Float;False;True;2;Float;ASEMaterialInspector;0;0;CustomLighting;Midget/Toon Lighting PMD;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;1;0;False;0;Custom;0.5;True;True;0;True;TransparentCutout;;Geometry;ForwardOnly;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;SrcAlpha;OneMinusSrcAlpha;0;SrcAlpha;OneMinusSrcAlpha;OFF;OFF;0;False;0.1;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;0;0;False;0;0;0;False;-1;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;140;0;141;0
WireConnection;140;1;143;0
WireConnection;140;2;144;0
WireConnection;146;0;136;1
WireConnection;146;1;136;2
WireConnection;146;2;136;3
WireConnection;145;0;146;0
WireConnection;145;1;140;0
WireConnection;147;0;145;0
WireConnection;346;0;345;0
WireConnection;346;1;359;0
WireConnection;365;0;362;2
WireConnection;365;1;364;0
WireConnection;365;2;363;0
WireConnection;365;3;363;0
WireConnection;365;4;361;0
WireConnection;223;0;212;0
WireConnection;223;1;365;0
WireConnection;347;0;346;0
WireConnection;308;0;147;0
WireConnection;308;1;309;0
WireConnection;352;0;347;0
WireConnection;217;0;308;0
WireConnection;222;0;223;0
WireConnection;70;0;308;0
WireConnection;70;1;365;0
WireConnection;331;0;70;0
WireConnection;331;1;332;0
WireConnection;215;0;216;0
WireConnection;215;1;222;0
WireConnection;104;0;103;0
WireConnection;104;1;105;0
WireConnection;349;0;352;0
WireConnection;349;1;350;0
WireConnection;333;0;331;0
WireConnection;333;1;334;0
WireConnection;329;0;330;0
WireConnection;329;1;215;0
WireConnection;351;0;349;0
WireConnection;351;1;350;0
WireConnection;119;0;104;0
WireConnection;119;1;103;0
WireConnection;119;2;120;1
WireConnection;218;0;329;0
WireConnection;218;1;219;0
WireConnection;305;0;306;0
WireConnection;305;1;333;0
WireConnection;354;1;351;0
WireConnection;85;0;86;0
WireConnection;82;0;83;0
WireConnection;124;0;125;0
WireConnection;253;0;119;0
WireConnection;355;0;253;0
WireConnection;355;1;354;0
WireConnection;93;0;92;0
WireConnection;93;1;91;0
WireConnection;121;0;82;0
WireConnection;121;1;124;0
WireConnection;121;2;290;0
WireConnection;89;0;85;0
WireConnection;89;1;124;0
WireConnection;89;2;182;1
WireConnection;353;1;351;0
WireConnection;237;0;218;0
WireConnection;237;1;231;0
WireConnection;237;2;286;1
WireConnection;237;3;360;0
WireConnection;307;1;305;0
WireConnection;95;0;307;0
WireConnection;95;1;93;0
WireConnection;95;2;237;0
WireConnection;81;0;121;0
WireConnection;356;0;355;0
WireConnection;356;1;353;0
WireConnection;369;0;367;2
WireConnection;369;1;364;0
WireConnection;369;2;366;0
WireConnection;369;3;366;0
WireConnection;369;4;368;0
WireConnection;87;0;89;0
WireConnection;341;0;356;0
WireConnection;341;1;199;0
WireConnection;112;0;110;0
WireConnection;106;0;81;0
WireConnection;106;1;87;0
WireConnection;106;2;95;0
WireConnection;194;0;369;0
WireConnection;107;0;341;0
WireConnection;107;1;106;0
WireConnection;107;2;112;0
WireConnection;107;3;194;0
WireConnection;252;0;119;0
WireConnection;128;0;127;0
WireConnection;128;1;130;0
WireConnection;254;0;252;0
WireConnection;254;1;255;0
WireConnection;126;0;128;0
WireConnection;126;1;107;0
WireConnection;325;1;324;0
WireConnection;340;0;337;0
WireConnection;336;0;335;0
WireConnection;336;1;340;0
WireConnection;339;0;336;0
WireConnection;348;0;343;0
WireConnection;265;0;103;4
WireConnection;326;0;325;0
WireConnection;326;1;327;0
WireConnection;326;2;106;0
WireConnection;324;0;136;0
WireConnection;0;10;254;0
WireConnection;0;13;126;0
ASEEND*/
//CHKSM=FED092127F90DB018A6E17C8823D355C669EF887