// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:32719,y:32712,varname:node_3138,prsc:2|emission-9367-OUT;n:type:ShaderForge.SFN_TexCoord,id:1136,x:30807,y:32911,varname:node_1136,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Time,id:1890,x:30920,y:33093,varname:node_1890,prsc:2;n:type:ShaderForge.SFN_Add,id:4489,x:31790,y:33192,varname:node_4489,prsc:2|A-7370-OUT,B-8500-OUT;n:type:ShaderForge.SFN_Multiply,id:8500,x:31227,y:33170,varname:node_8500,prsc:2|A-1890-TSL,B-3968-OUT;n:type:ShaderForge.SFN_ValueProperty,id:3968,x:31037,y:33268,ptovrint:False,ptlb:Speed,ptin:_Speed,varname:node_2372,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:3;n:type:ShaderForge.SFN_RemapRange,id:8031,x:31012,y:32911,varname:node_8031,prsc:2,frmn:0,frmx:1,tomn:-1,tomx:1|IN-1136-UVOUT;n:type:ShaderForge.SFN_Multiply,id:3093,x:31191,y:32911,varname:node_3093,prsc:2|A-8031-OUT,B-8031-OUT;n:type:ShaderForge.SFN_ComponentMask,id:567,x:31354,y:32911,varname:node_567,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-3093-OUT;n:type:ShaderForge.SFN_Add,id:9554,x:31533,y:32921,varname:node_9554,prsc:2|A-567-R,B-567-G;n:type:ShaderForge.SFN_Tex2d,id:8225,x:31953,y:32578,ptovrint:False,ptlb:Gradient,ptin:_Gradient,varname:node_9648,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:45fad1255fe12d44da0cc0415a78cfb6,ntxv:0,isnm:False|UVIN-8463-OUT;n:type:ShaderForge.SFN_Append,id:7370,x:31464,y:33064,varname:node_7370,prsc:2|A-9554-OUT,B-9554-OUT;n:type:ShaderForge.SFN_Multiply,id:2717,x:30836,y:32687,varname:node_2717,prsc:2|A-7645-OUT,B-1196-OUT;n:type:ShaderForge.SFN_Pi,id:7645,x:30633,y:32658,varname:node_7645,prsc:2;n:type:ShaderForge.SFN_Sin,id:3610,x:31002,y:32665,varname:node_3610,prsc:2|IN-2717-OUT;n:type:ShaderForge.SFN_Vector1,id:2805,x:31041,y:32823,varname:node_2805,prsc:2,v1:2;n:type:ShaderForge.SFN_Power,id:4060,x:31162,y:32702,varname:node_4060,prsc:2|VAL-3610-OUT,EXP-2805-OUT;n:type:ShaderForge.SFN_ComponentMask,id:425,x:31320,y:32702,varname:node_425,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-4060-OUT;n:type:ShaderForge.SFN_Min,id:8837,x:31522,y:32671,varname:node_8837,prsc:2|A-425-R,B-425-G;n:type:ShaderForge.SFN_Slider,id:1292,x:30180,y:32824,ptovrint:False,ptlb:Box,ptin:_Box,varname:node_6180,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:-1,cur:1,max:1;n:type:ShaderForge.SFN_Multiply,id:1196,x:30617,y:32775,varname:node_1196,prsc:2|A-1292-OUT,B-1391-UVOUT;n:type:ShaderForge.SFN_TexCoord,id:1391,x:30476,y:32923,varname:node_1391,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Add,id:4928,x:31816,y:32944,varname:node_4928,prsc:2|A-8837-OUT,B-8500-OUT;n:type:ShaderForge.SFN_Multiply,id:9367,x:32319,y:32733,varname:node_9367,prsc:2|A-8225-RGB,B-2512-OUT,C-4509-RGB;n:type:ShaderForge.SFN_ValueProperty,id:2512,x:32242,y:32589,ptovrint:False,ptlb:Emission Value,ptin:_EmissionValue,varname:node_6383,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:3;n:type:ShaderForge.SFN_Append,id:8463,x:32027,y:33114,varname:node_8463,prsc:2|A-4928-OUT,B-4489-OUT;n:type:ShaderForge.SFN_Color,id:4509,x:32156,y:32871,ptovrint:False,ptlb:node_4509,ptin:_node_4509,varname:node_4509,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;proporder:3968-8225-1292-2512-4509;pass:END;sub:END;*/

Shader "Midget/Gradient fun 2" {
    Properties {
        _Speed ("Speed", Float ) = 3
        _Gradient ("Gradient", 2D) = "white" {}
        _Box ("Box", Range(-1, 1)) = 1
        _EmissionValue ("Emission Value", Float ) = 3
        _node_4509 ("node_4509", Color) = (0.5,0.5,0.5,1)
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
            uniform float _Speed;
            uniform sampler2D _Gradient; uniform float4 _Gradient_ST;
            uniform float _Box;
            uniform float _EmissionValue;
            uniform float4 _node_4509;
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
                float2 node_425 = pow(sin((3.141592654*(_Box*i.uv0))),2.0).rg;
                float4 node_1890 = _Time;
                float node_8500 = (node_1890.r*_Speed);
                float2 node_8031 = (i.uv0*2.0+-1.0);
                float2 node_567 = (node_8031*node_8031).rg;
                float node_9554 = (node_567.r+node_567.g);
                float3 node_8463 = float3((min(node_425.r,node_425.g)+node_8500),(float2(node_9554,node_9554)+node_8500));
                float4 _Gradient_var = tex2D(_Gradient,TRANSFORM_TEX(node_8463, _Gradient));
                float3 emissive = (_Gradient_var.rgb*_EmissionValue*_node_4509.rgb);
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
