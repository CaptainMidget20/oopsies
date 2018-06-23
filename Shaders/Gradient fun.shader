// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:2,rntp:3,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:32719,y:32712,varname:node_3138,prsc:2|emission-2236-OUT,clip-6036-OUT;n:type:ShaderForge.SFN_TexCoord,id:141,x:31078,y:32852,varname:node_141,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Time,id:7015,x:31191,y:33034,varname:node_7015,prsc:2;n:type:ShaderForge.SFN_Add,id:963,x:31951,y:33118,varname:node_963,prsc:2|A-9172-OUT,B-5534-OUT;n:type:ShaderForge.SFN_Multiply,id:5534,x:31485,y:33145,varname:node_5534,prsc:2|A-7015-TSL,B-2372-OUT;n:type:ShaderForge.SFN_ValueProperty,id:2372,x:31308,y:33209,ptovrint:False,ptlb:Speed,ptin:_Speed,varname:node_2372,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_RemapRange,id:3774,x:31283,y:32852,varname:node_3774,prsc:2,frmn:0,frmx:1,tomn:-1,tomx:1|IN-141-UVOUT;n:type:ShaderForge.SFN_Multiply,id:6002,x:31462,y:32852,varname:node_6002,prsc:2|A-3774-OUT,B-3774-OUT;n:type:ShaderForge.SFN_ComponentMask,id:8960,x:31625,y:32852,varname:node_8960,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-6002-OUT;n:type:ShaderForge.SFN_Add,id:9917,x:31804,y:32862,varname:node_9917,prsc:2|A-8960-R,B-8960-G;n:type:ShaderForge.SFN_Tex2d,id:9648,x:32224,y:32519,ptovrint:False,ptlb:Gradient,ptin:_Gradient,varname:node_9648,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:45fad1255fe12d44da0cc0415a78cfb6,ntxv:0,isnm:False|UVIN-868-OUT;n:type:ShaderForge.SFN_Append,id:9172,x:31735,y:33005,varname:node_9172,prsc:2|A-9917-OUT,B-9917-OUT;n:type:ShaderForge.SFN_Multiply,id:4888,x:31103,y:32657,varname:node_4888,prsc:2|A-7813-OUT,B-6153-OUT;n:type:ShaderForge.SFN_Pi,id:7813,x:30904,y:32599,varname:node_7813,prsc:2;n:type:ShaderForge.SFN_Sin,id:964,x:31312,y:32627,varname:node_964,prsc:2|IN-4888-OUT;n:type:ShaderForge.SFN_Vector1,id:4595,x:31312,y:32764,varname:node_4595,prsc:2,v1:2;n:type:ShaderForge.SFN_Power,id:6023,x:31433,y:32643,varname:node_6023,prsc:2|VAL-964-OUT,EXP-4595-OUT;n:type:ShaderForge.SFN_ComponentMask,id:6213,x:31591,y:32643,varname:node_6213,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-6023-OUT;n:type:ShaderForge.SFN_Min,id:8064,x:31826,y:32616,varname:node_8064,prsc:2|A-6213-R,B-6213-G;n:type:ShaderForge.SFN_Slider,id:6180,x:31144,y:32414,ptovrint:False,ptlb:Box,ptin:_Box,varname:node_6180,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:-1,cur:-1,max:1;n:type:ShaderForge.SFN_Multiply,id:6153,x:30888,y:32716,varname:node_6153,prsc:2|A-6180-OUT,B-8543-OUT;n:type:ShaderForge.SFN_TexCoord,id:2753,x:30554,y:32962,varname:node_2753,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Add,id:868,x:32208,y:33044,varname:node_868,prsc:2|A-8064-OUT,B-963-OUT;n:type:ShaderForge.SFN_Tex2d,id:8142,x:32360,y:32787,ptovrint:False,ptlb:Noise (For Opacity),ptin:_NoiseForOpacity,varname:node_8142,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:28c7aad1372ff114b90d330f8a2dd938,ntxv:0,isnm:False|UVIN-868-OUT;n:type:ShaderForge.SFN_Multiply,id:6036,x:32528,y:33019,varname:node_6036,prsc:2|A-8142-RGB,B-8752-OUT;n:type:ShaderForge.SFN_Multiply,id:2236,x:32525,y:32656,varname:node_2236,prsc:2|A-9648-RGB,B-6383-OUT;n:type:ShaderForge.SFN_ValueProperty,id:6383,x:32513,y:32530,ptovrint:False,ptlb:Emission Value,ptin:_EmissionValue,varname:node_6383,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_ValueProperty,id:8752,x:32397,y:33175,ptovrint:False,ptlb:Opacity Value,ptin:_OpacityValue,varname:node_8752,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:3;n:type:ShaderForge.SFN_Add,id:8543,x:30795,y:32924,varname:node_8543,prsc:2|A-2753-UVOUT,B-5534-OUT;proporder:2372-9648-6180-8142-6383-8752;pass:END;sub:END;*/

Shader "Midget/Gradient fun" {
    Properties {
        _Speed ("Speed", Float ) = 1
        _Gradient ("Gradient", 2D) = "white" {}
        _Box ("Box", Range(-1, 1)) = -1
        _NoiseForOpacity ("Noise (For Opacity)", 2D) = "white" {}
        _EmissionValue ("Emission Value", Float ) = 1
        _OpacityValue ("Opacity Value", Float ) = 3
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "Queue"="AlphaTest"
            "RenderType"="TransparentCutout"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform float _Speed;
            uniform sampler2D _Gradient; uniform float4 _Gradient_ST;
            uniform float _Box;
            uniform sampler2D _NoiseForOpacity; uniform float4 _NoiseForOpacity_ST;
            uniform float _EmissionValue;
            uniform float _OpacityValue;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                float4 node_7015 = _Time;
                float node_5534 = (node_7015.r*_Speed);
                float2 node_6213 = pow(sin((3.141592654*(_Box*(i.uv0+node_5534)))),2.0).rg;
                float node_8064 = min(node_6213.r,node_6213.g);
                float2 node_3774 = (i.uv0*2.0+-1.0);
                float2 node_8960 = (node_3774*node_3774).rg;
                float node_9917 = (node_8960.r+node_8960.g);
                float2 node_868 = (node_8064+(float2(node_9917,node_9917)+node_5534));
                float4 _NoiseForOpacity_var = tex2D(_NoiseForOpacity,TRANSFORM_TEX(node_868, _NoiseForOpacity));
                clip((_NoiseForOpacity_var.rgb*_OpacityValue) - 0.5);
////// Lighting:
////// Emissive:
                float4 _Gradient_var = tex2D(_Gradient,TRANSFORM_TEX(node_868, _Gradient));
                float3 emissive = (_Gradient_var.rgb*_EmissionValue);
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
        Pass {
            Name "ShadowCaster"
            Tags {
                "LightMode"="ShadowCaster"
            }
            Offset 1, 1
            Cull Back
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_SHADOWCASTER
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform float _Speed;
            uniform float _Box;
            uniform sampler2D _NoiseForOpacity; uniform float4 _NoiseForOpacity_ST;
            uniform float _OpacityValue;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
                float2 uv0 : TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                float4 node_7015 = _Time;
                float node_5534 = (node_7015.r*_Speed);
                float2 node_6213 = pow(sin((3.141592654*(_Box*(i.uv0+node_5534)))),2.0).rg;
                float node_8064 = min(node_6213.r,node_6213.g);
                float2 node_3774 = (i.uv0*2.0+-1.0);
                float2 node_8960 = (node_3774*node_3774).rg;
                float node_9917 = (node_8960.r+node_8960.g);
                float2 node_868 = (node_8064+(float2(node_9917,node_9917)+node_5534));
                float4 _NoiseForOpacity_var = tex2D(_NoiseForOpacity,TRANSFORM_TEX(node_868, _NoiseForOpacity));
                clip((_NoiseForOpacity_var.rgb*_OpacityValue) - 0.5);
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
