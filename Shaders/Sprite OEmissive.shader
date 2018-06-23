// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:32719,y:32712,varname:node_3138,prsc:2|emission-1166-OUT;n:type:ShaderForge.SFN_Tex2d,id:5545,x:32153,y:32718,ptovrint:False,ptlb:node_1516,ptin:_node_1516,varname:node_1516,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:e70171ecc0f459f4b9ec14f0283cee15,ntxv:0,isnm:False|UVIN-9321-OUT;n:type:ShaderForge.SFN_Time,id:207,x:30653,y:33362,varname:node_207,prsc:2;n:type:ShaderForge.SFN_Multiply,id:7071,x:30844,y:33362,varname:node_7071,prsc:2|A-7577-OUT,B-207-T;n:type:ShaderForge.SFN_ValueProperty,id:2799,x:30647,y:32810,ptovrint:False,ptlb:Rows,ptin:_Rows,varname:node_9772,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_ValueProperty,id:566,x:30647,y:32917,ptovrint:False,ptlb:Columns,ptin:_Columns,varname:node_6599,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_ValueProperty,id:7577,x:30647,y:33024,ptovrint:False,ptlb:Time SPeed,ptin:_TimeSPeed,varname:node_2288,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Frac,id:8437,x:31029,y:33362,varname:node_8437,prsc:2|IN-7071-OUT;n:type:ShaderForge.SFN_Multiply,id:9104,x:31029,y:33226,varname:node_9104,prsc:2|A-566-OUT,B-2799-OUT;n:type:ShaderForge.SFN_Multiply,id:4397,x:31201,y:33295,varname:node_4397,prsc:2|A-9104-OUT,B-8437-OUT;n:type:ShaderForge.SFN_Round,id:4834,x:31372,y:33295,varname:node_4834,prsc:2|IN-4397-OUT;n:type:ShaderForge.SFN_Divide,id:2277,x:31549,y:33310,varname:node_2277,prsc:2|A-4834-OUT,B-5147-OUT;n:type:ShaderForge.SFN_Relay,id:5147,x:31333,y:32826,cmnt:Rows,varname:node_5147,prsc:2|IN-2799-OUT;n:type:ShaderForge.SFN_Relay,id:5113,x:31345,y:33023,cmnt:Colums,varname:node_5113,prsc:2|IN-566-OUT;n:type:ShaderForge.SFN_Floor,id:4358,x:31726,y:33310,varname:node_4358,prsc:2|IN-2277-OUT;n:type:ShaderForge.SFN_Divide,id:960,x:31741,y:33156,varname:node_960,prsc:2|A-4358-OUT,B-5113-OUT;n:type:ShaderForge.SFN_Divide,id:4658,x:31741,y:32873,varname:node_4658,prsc:2|A-1391-OUT,B-5147-OUT;n:type:ShaderForge.SFN_OneMinus,id:6888,x:31921,y:33156,varname:node_6888,prsc:2|IN-960-OUT;n:type:ShaderForge.SFN_Append,id:9547,x:32016,y:32997,varname:node_9547,prsc:2|A-4658-OUT,B-6888-OUT;n:type:ShaderForge.SFN_Fmod,id:1391,x:31741,y:33006,varname:node_1391,prsc:2|A-4834-OUT,B-5147-OUT;n:type:ShaderForge.SFN_Divide,id:3306,x:31789,y:32610,varname:node_3306,prsc:2|A-1564-UVOUT,B-4953-OUT;n:type:ShaderForge.SFN_Append,id:4953,x:31604,y:32600,varname:node_4953,prsc:2|A-5147-OUT,B-5113-OUT;n:type:ShaderForge.SFN_Add,id:9321,x:31965,y:32749,varname:node_9321,prsc:2|A-3306-OUT,B-9547-OUT;n:type:ShaderForge.SFN_Multiply,id:1166,x:32535,y:32831,varname:node_1166,prsc:2|A-5545-RGB,B-2701-OUT;n:type:ShaderForge.SFN_ValueProperty,id:2701,x:32199,y:32921,ptovrint:False,ptlb:Emission Value,ptin:_EmissionValue,varname:node_103,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:2;n:type:ShaderForge.SFN_TexCoord,id:1564,x:31789,y:32440,varname:node_1564,prsc:2,uv:0,uaff:False;proporder:5545-2701-2799-566-7577;pass:END;sub:END;*/

Shader "Midget/Sprite Animator Emissive" {
    Properties {
        _node_1516 ("node_1516", 2D) = "white" {}
        _EmissionValue ("Emission Value", Float ) = 2
        _Rows ("Rows", Float ) = 1
        _Columns ("Columns", Float ) = 1
        _TimeSPeed ("Time SPeed", Float ) = 1
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
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
            uniform sampler2D _node_1516; uniform float4 _node_1516_ST;
            uniform float _Rows;
            uniform float _Columns;
            uniform float _TimeSPeed;
            uniform float _EmissionValue;
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
////// Lighting:
////// Emissive:
                float node_5147 = _Rows; // Rows
                float node_5113 = _Columns; // Colums
                float4 node_207 = _Time;
                float node_4834 = round(((_Columns*_Rows)*frac((_TimeSPeed*node_207.g))));
                float2 node_9321 = ((i.uv0/float2(node_5147,node_5113))+float2((fmod(node_4834,node_5147)/node_5147),(1.0 - (floor((node_4834/node_5147))/node_5113))));
                float4 _node_1516_var = tex2D(_node_1516,TRANSFORM_TEX(node_9321, _node_1516));
                float3 emissive = (_node_1516_var.rgb*_EmissionValue);
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
