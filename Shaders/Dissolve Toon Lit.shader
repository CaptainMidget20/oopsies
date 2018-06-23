// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Midget/Toon Light Dissolve"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
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
		_StaticLightDirection("Static Light Direction", Vector) = (0.7,-1,-1,0)
		_BurnRamp("Burn Ramp", 2D) = "white" {}
		_DissolveGuide("Dissolve Guide", 2D) = "white" {}
		_DissolveAmount("Dissolve Amount", Range( 0 , 2)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
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
		uniform float _DissolveAmount;
		uniform sampler2D _DissolveGuide;
		uniform float4 _DissolveGuide_ST;
		uniform float _CutoutValue;
		uniform sampler2D _BurnRamp;
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
			float2 uv_DissolveGuide = i.uv_texcoord * _DissolveGuide_ST.xy + _DissolveGuide_ST.zw;
			float temp_output_254_0 = ( ( (lerpResult119).a + ( (-0.6 + (( 1.0 - _DissolveAmount ) - 0) * (0.6 - -0.6) / (1 - 0)) + tex2D( _DissolveGuide, uv_DissolveGuide ).r ) ) - _CutoutValue );
			float2 uv_EmissionMap = i.uv_texcoord * _EmissionMap_ST.xy + _EmissionMap_ST.zw;
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
			float4 temp_cast_6 = (clampResult245).xxxx;
			float div239=256.0/float((int)_GlossPos);
			float4 posterize239 = ( floor( temp_cast_6 * div239 ) / div239 );
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
			c.rgb = ( ( tex2D( _EmissionMap, uv_EmissionMap ) * _EmissionColor ) + ( ( float4( (lerpResult119).rgb , 0.0 ) * _Color ) * float4( lerpResult106 , 0.0 ) * localMyCustomExpression112 * localMyCustomExpression194 ) ).rgb;
			c.a = 1;
			clip( temp_output_254_0 - _Cutoff );
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
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 tex2DNode103 = tex2D( _MainTex, uv_MainTex );
			float2 uv_ColorMask = i.uv_texcoord * _ColorMask_ST.xy + _ColorMask_ST.zw;
			float4 lerpResult119 = lerp( ( tex2DNode103 * _MaskColor ) , tex2DNode103 , tex2D( _ColorMask, uv_ColorMask ).r);
			float2 uv_DissolveGuide = i.uv_texcoord * _DissolveGuide_ST.xy + _DissolveGuide_ST.zw;
			float temp_output_254_0 = ( ( (lerpResult119).a + ( (-0.6 + (( 1.0 - _DissolveAmount ) - 0) * (0.6 - -0.6) / (1 - 0)) + tex2D( _DissolveGuide, uv_DissolveGuide ).r ) ) - _CutoutValue );
			float clampResult334 = clamp( (-4 + (temp_output_254_0 - 0) * (4 - -4) / (1 - 0)) , 0 , 1 );
			float temp_output_335_0 = ( 1.0 - clampResult334 );
			float2 appendResult336 = (float2(temp_output_335_0 , 0.5));
			o.Emission = ( temp_output_335_0 * tex2D( _BurnRamp, appendResult336 ) ).rgb;
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
144;250;1906;741;2573.122;-1228.534;2.548647;True;True
Node;AmplifyShaderEditor.VertexTangentNode;141;-2238.863,-895.3572;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SamplerNode;136;-2001.36,-653.4565;Float;True;Property;_BumpMap;Bump Map;13;0;Create;True;0;0;False;0;None;bbab0a6f7bae9cf42bf057d8ee2755f6;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldNormalVector;144;-2232.839,-605.7565;Float;False;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.VertexBinormalNode;143;-2243.835,-757.5222;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.MatrixFromVectors;140;-1978.061,-792.9575;Float;False;FLOAT3x3;4;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3x3;0
Node;AmplifyShaderEditor.DynamicAppendNode;146;-1716.864,-630.5366;Float;True;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;71;-2364.026,257.6643;Float;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;313;-2081.902,340.3332;Float;False;Constant;_Float3;Float 3;26;0;Create;True;0;0;False;0;0.001;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LightColorNode;318;-2092.069,123.3494;Float;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;145;-1495.213,-715.6403;Float;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3x3;0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.Vector3Node;316;-2129.362,485.2726;Float;False;Property;_StaticLightDirection;Static Light Direction;16;0;Create;True;0;0;False;0;0.7,-1,-1;0.7,-1,-1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;212;-2272.734,821.954;Float;False;World;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CommentaryNode;326;-624,2624;Float;False;908.2314;498.3652;Dissolve - Opacity Mask;5;331;330;329;328;327;;1,1,1,1;0;0
Node;AmplifyShaderEditor.NormalizeNode;147;-1354.812,-717.0043;Float;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ConditionalIfNode;317;-1803.959,158.0152;Float;False;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;309;-1511.889,-338.8142;Float;False;Property;_NormalMULT;Normal MULT;15;0;Create;True;0;0;False;0;2;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;105;11.22445,-107.3214;Float;False;Property;_MaskColor;Mask Color;9;1;[HDR];Create;True;0;0;False;0;0,0,0,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;327;-866.2281,2686.175;Float;False;Property;_DissolveAmount;Dissolve Amount;19;0;Create;True;0;0;False;0;0;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;308;-1247.878,-446.1584;Float;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleAddOpNode;223;-1972.119,827.4106;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;103;-62.80528,-340.3971;Float;True;Property;_MainTex;Main Tex;8;0;Create;True;0;0;False;0;None;b66bceaf0cc0ace4e9bdc92f14bba709;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;217;-1183.31,-792.4024;Float;False;myVarName0;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.OneMinusNode;328;-437.2377,2695.646;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;120;199.9882,57.61399;Float;True;Property;_ColorMask;Color Mask;10;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;216;-1787.559,626.0222;Float;False;217;0;1;FLOAT4;0
Node;AmplifyShaderEditor.NormalizeNode;222;-1796.153,828.1082;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;104;344.1286,-59.27595;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;119;571.5412,-61.47873;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LightColorNode;64;-1552.175,174.1031;Float;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.TFHCRemapNode;330;-192,2688;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-0.6;False;4;FLOAT;0.6;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;320;-1761.96,425.6235;Float;False;Constant;_Float4;Float 4;17;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LightAttenuation;168;-1541.416,361.022;Float;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;215;-1449.227,789.5828;Float;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;329;-224,2912;Float;True;Property;_DissolveGuide;Dissolve Guide;18;0;Create;True;0;0;False;0;None;8f583144143510949871a5a6e10bdf09;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;219;-1570.138,1020.276;Float;False;Property;_Gloss;Gloss;2;0;Create;True;0;0;False;0;1;1;1;30;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;218;-1291.421,808.1673;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;70;-1238.146,-82.43951;Float;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ConditionalIfNode;319;-1624.594,448.5177;Float;False;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;221;-1267.443,1011.597;Float;False;Property;_Specular;Specular;3;0;Create;True;0;0;False;0;1;0;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;252;778.4542,-264.0804;Float;False;False;False;False;True;1;0;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;331;16,2672;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;73;-1022.074,-38.86852;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;306;-1004.94,319.1523;Float;False;Constant;_Float1;Float 1;15;0;Create;True;0;0;False;0;0.2;0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;342;1069.983,-235.416;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;255;965.8755,-75.35318;Float;False;Property;_CutoutValue;Cutout Value;14;0;Create;True;0;0;False;0;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;220;-1092.727,802.4246;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;86;-490.6377,1061.639;Float;False;Constant;_Vector2;Vector 2;0;0;Create;True;0;0;False;0;0,1,0,1;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;92;-524.1679,310.3037;Float;False;Constant;_Float0;Float 0;1;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;83;-507.3965,737.7778;Float;False;Constant;_Vector1;Vector 1;0;0;Create;True;0;0;False;0;0,-1,0,1;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;245;-953.5909,797.2953;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;91;-620.5579,471.4018;Float;False;Property;_Shadow;Shadow;1;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;236;-991.835,1020.967;Float;False;Property;_GlossPos;Gloss Pos;5;0;Create;True;0;0;False;0;1;1;1;256;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;332;-560,2160;Float;False;814.5701;432.0292;Burn Effect - Emission;6;338;337;336;335;333;334;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;254;1252.512,-177.9385;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;305;-792.224,98.39151;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WorldPosInputsNode;125;-493.9616,906.402;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CustomExpressionNode;82;-278.0639,728.8098;Float;False;return ShadeSH9(half4(In0))@;1;False;1;True;In0;FLOAT4;0,0,0,0;In;My Custom Expression;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;231;-1020.171,1431.226;Float;False;Property;_GlossColor;Gloss Color;4;0;Create;True;0;0;False;0;1,1,1,0;1,1,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;333;-685.2156,2294.253;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-4;False;4;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;93;-349.4334,302.0155;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosterizeNode;239;-770.1539,822.0636;Float;False;1;2;1;COLOR;0,0,0,0;False;0;INT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;307;-641.3577,31.21159;Float;True;Property;_ShadowRamp;Shadow Ramp;7;0;Create;True;0;0;False;0;None;44b0e9ef225ce6b48960e6a3999ffd5c;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CustomExpressionNode;85;-287.8065,1068.378;Float;False;return ShadeSH9(half4(In0))@;1;False;1;True;In0;FLOAT4;0,0,0,0;In;My Custom Expression;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;124;-282.1297,908.8864;Float;False;return DecodeHDR(UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, normalize((_WorldSpaceCameraPos -objPos)), 7), unity_SpecCube0_HDR)* 0.02@;3;False;1;True;objPos;FLOAT3;0,0,0;In;My Custom Expression;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LightColorNode;182;-242.0083,1182.38;Float;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;290;-218.8302,660.1541;Float;False;Constant;_Float2;Float 2;20;0;Create;True;0;0;False;0;-1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LightColorNode;286;-766.8499,1746.723;Float;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.ClampOpNode;334;-427.6146,2310.684;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;237;-563.7154,1435.416;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;89;-21.25515,869.2344;Float;False;3;3;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;95;-45.14767,289.8023;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;121;-36.63543,719.2446;Float;False;3;3;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;81;-28.33839,499.7956;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;199;382.0619,289.064;Float;False;Property;_Color;Color;6;0;Create;True;0;0;False;0;0,0,0,0;1,1,1,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;335;-288,2192;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DecodeLightmapHlpNode;110;340.3415,690.7327;Float;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LightAttenuation;189;321.6678,830.8065;Float;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;87;-16.58986,623.4379;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;232;-18.17629,389.1621;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ComponentMaskNode;253;790.8775,-173.4126;Float;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;198;604.7799,124.0774;Float;False;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CustomExpressionNode;194;580.6287,827.7976;Float;False;#if DIRECTIONAL$atten = 1@$#endif$return atten@;1;False;1;True;atten;FLOAT;0;In;My Custom Expression;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;112;558.4617,683.3754;Float;False;#ifdef LIGHTMAP_OFF$In0 = 1@$#endif$return In0@;4;False;1;True;In0;FLOAT4;0,0,0,0;In;My Custom Expression;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.LerpOp;106;185.0852,450.357;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;127;751.2711,30.31899;Float;True;Property;_EmissionMap;Emission Map;12;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;336;-230.1001,2425.1;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0.5;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;130;786.8121,239.0403;Float;False;Property;_EmissionColor;Emission Color;11;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;128;1057.234,249.8083;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;107;748.7986,422.1623;Float;False;4;4;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;337;-82.60001,2389.482;Float;True;Property;_BurnRamp;Burn Ramp;17;0;Create;True;0;0;False;0;None;52e66a9243cdfed44b5e906f5910d35b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;265;498.3356,-367.9112;Float;False;myVarName1;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;126;1218.224,595.478;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;323;1242.348,1008.258;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;338;128,2240;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1629.251,977.9595;Float;False;True;2;Float;ASEMaterialInspector;0;0;CustomLighting;Midget/Toon Light Dissolve;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;1;0;False;0;Custom;0.5;True;True;0;True;TransparentCutout;;Geometry;ForwardOnly;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;SrcAlpha;OneMinusSrcAlpha;0;SrcAlpha;OneMinusSrcAlpha;OFF;OFF;0;False;0.1;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;0;0;False;0;0;0;False;-1;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;339;480,2144;Float;False;765.1592;493.9802;Created by The Four Headed Cat @fourheadedcat - www.twitter.com/fourheadedcat;0;;1,1,1,1;0;0
WireConnection;140;0;141;0
WireConnection;140;1;143;0
WireConnection;140;2;144;0
WireConnection;146;0;136;1
WireConnection;146;1;136;2
WireConnection;146;2;136;3
WireConnection;145;0;146;0
WireConnection;145;1;140;0
WireConnection;147;0;145;0
WireConnection;317;0;318;2
WireConnection;317;1;313;0
WireConnection;317;2;71;0
WireConnection;317;3;71;0
WireConnection;317;4;316;0
WireConnection;308;0;147;0
WireConnection;308;1;309;0
WireConnection;223;0;212;0
WireConnection;223;1;317;0
WireConnection;217;0;308;0
WireConnection;328;0;327;0
WireConnection;222;0;223;0
WireConnection;104;0;103;0
WireConnection;104;1;105;0
WireConnection;119;0;104;0
WireConnection;119;1;103;0
WireConnection;119;2;120;1
WireConnection;330;0;328;0
WireConnection;215;0;216;0
WireConnection;215;1;222;0
WireConnection;218;0;215;0
WireConnection;218;1;219;0
WireConnection;70;0;308;0
WireConnection;70;1;317;0
WireConnection;319;0;64;2
WireConnection;319;1;313;0
WireConnection;319;2;168;0
WireConnection;319;3;168;0
WireConnection;319;4;320;0
WireConnection;252;0;119;0
WireConnection;331;0;330;0
WireConnection;331;1;329;1
WireConnection;73;0;70;0
WireConnection;73;1;319;0
WireConnection;342;0;252;0
WireConnection;342;1;331;0
WireConnection;220;0;218;0
WireConnection;220;1;221;0
WireConnection;245;0;220;0
WireConnection;254;0;342;0
WireConnection;254;1;255;0
WireConnection;305;0;73;0
WireConnection;305;1;306;0
WireConnection;82;0;83;0
WireConnection;333;0;254;0
WireConnection;93;0;92;0
WireConnection;93;1;91;0
WireConnection;239;1;245;0
WireConnection;239;0;236;0
WireConnection;307;1;305;0
WireConnection;85;0;86;0
WireConnection;124;0;125;0
WireConnection;334;0;333;0
WireConnection;237;0;239;0
WireConnection;237;1;231;0
WireConnection;237;2;286;1
WireConnection;89;0;85;0
WireConnection;89;1;124;0
WireConnection;89;2;182;1
WireConnection;95;0;307;0
WireConnection;95;1;93;0
WireConnection;121;0;82;0
WireConnection;121;1;124;0
WireConnection;121;2;290;0
WireConnection;81;0;121;0
WireConnection;335;0;334;0
WireConnection;87;0;89;0
WireConnection;232;0;237;0
WireConnection;232;1;95;0
WireConnection;253;0;119;0
WireConnection;198;0;253;0
WireConnection;198;1;199;0
WireConnection;194;0;189;0
WireConnection;112;0;110;0
WireConnection;106;0;81;0
WireConnection;106;1;87;0
WireConnection;106;2;232;0
WireConnection;336;0;335;0
WireConnection;128;0;127;0
WireConnection;128;1;130;0
WireConnection;107;0;198;0
WireConnection;107;1;106;0
WireConnection;107;2;112;0
WireConnection;107;3;194;0
WireConnection;337;1;336;0
WireConnection;265;0;103;4
WireConnection;126;0;128;0
WireConnection;126;1;107;0
WireConnection;338;0;335;0
WireConnection;338;1;337;0
WireConnection;0;2;338;0
WireConnection;0;10;254;0
WireConnection;0;13;126;0
ASEEND*/
//CHKSM=D00A276A2F9EB2DCE9DFF30BC561078F91377A49