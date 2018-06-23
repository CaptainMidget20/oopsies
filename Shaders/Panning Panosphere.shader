// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:0,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:0,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:5789,x:32733,y:32804,varname:node_5789,prsc:2|emission-9594-OUT;n:type:ShaderForge.SFN_Tex2d,id:2316,x:32387,y:32940,ptovrint:False,ptlb:Tile Overlay,ptin:_TileOverlay,varname:node_1689,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:21fe2a71447c53a4d826247740b7609d,ntxv:0,isnm:False|UVIN-4710-OUT;n:type:ShaderForge.SFN_Append,id:2506,x:31891,y:32734,varname:node_2506,prsc:2|A-1832-OUT,B-65-OUT;n:type:ShaderForge.SFN_Time,id:2050,x:31869,y:32858,varname:node_2050,prsc:2;n:type:ShaderForge.SFN_Multiply,id:3042,x:32072,y:32744,varname:node_3042,prsc:2|A-2506-OUT,B-2050-T;n:type:ShaderForge.SFN_Add,id:4710,x:32090,y:32931,varname:node_4710,prsc:2|A-3042-OUT,B-8023-OUT;n:type:ShaderForge.SFN_Slider,id:8840,x:31734,y:32518,ptovrint:False,ptlb:Tile Speed X,ptin:_TileSpeedX,varname:node_2514,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:-1,cur:0,max:1;n:type:ShaderForge.SFN_Multiply,id:1832,x:32072,y:32454,varname:node_1832,prsc:2|A-2814-OUT,B-8840-OUT;n:type:ShaderForge.SFN_Vector1,id:2814,x:31891,y:32454,varname:node_2814,prsc:2,v1:0.1;n:type:ShaderForge.SFN_Multiply,id:65,x:32072,y:32594,varname:node_65,prsc:2|A-2814-OUT,B-3472-OUT;n:type:ShaderForge.SFN_Slider,id:3472,x:31734,y:32599,ptovrint:False,ptlb:Tile Speed Y,ptin:_TileSpeedY,varname:node_5322,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:-1,cur:0,max:1;n:type:ShaderForge.SFN_Multiply,id:9594,x:32560,y:33035,varname:node_9594,prsc:2|A-2316-RGB,B-7727-OUT;n:type:ShaderForge.SFN_ValueProperty,id:7727,x:32282,y:33185,ptovrint:False,ptlb:node_7727,ptin:_node_7727,varname:node_7727,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ViewVector,id:743,x:30290,y:32958,varname:node_743,prsc:2;n:type:ShaderForge.SFN_Multiply,id:1052,x:30464,y:32958,varname:node_1052,prsc:2|A-743-OUT,B-3884-OUT;n:type:ShaderForge.SFN_Vector1,id:3884,x:30290,y:33089,varname:node_3884,prsc:2,v1:-1;n:type:ShaderForge.SFN_Code,id:2984,x:30669,y:33152,varname:node_2984,prsc:2,code:ZgBsAG8AYQB0ADMAIABuAG8AcgBtAGEAbABpAHoAZQBkAEMAbwBvAHIAZABzACAAPQAgAG4AbwByAG0AYQBsAGkAegBlACgAYwBvAG8AcgBkAHMAKQA7AA0ACgBmAGwAbwBhAHQAIABsAGEAdABpAHQAdQBkAGUAIAA9ACAAYQBjAG8AcwAoAG4AbwByAG0AYQBsAGkAegBlAGQAQwBvAG8AcgBkAHMALgB5ACkAOwANAAoAZgBsAG8AYQB0ACAAbABvAG4AZwBpAHQAdQBkAGUAIAA9ACAAYQB0AGEAbgAyACgAbgBvAHIAbQBhAGwAaQB6AGUAZABDAG8AbwByAGQAcwAuAHoALAAgAG4AbwByAG0AYQBsAGkAegBlAGQAQwBvAG8AcgBkAHMALgB4ACkAOwANAAoAZgBsAG8AYQB0ADIAIABzAHAAaABlAHIAZQBDAG8AbwByAGQAcwAgAD0AIABmAGwAbwBhAHQAMgAoAGwAbwBuAGcAaQB0AHUAZABlACwAIABsAGEAdABpAHQAdQBkAGUAKQAgACoAIABmAGwAbwBhAHQAMgAoADAALgA1AC8AVQBOAEkAVABZAF8AUABJACwAIAAxAC4AMAAvAFUATgBJAFQAWQBfAFAASQApADsADQAKAHMAcABoAGUAcgBlAEMAbwBvAHIAZABzACAAPQAgAGYAbABvAGEAdAAyACgAMAAuADUALAAxAC4AMAApACAALQAgAHMAcABoAGUAcgBlAEMAbwBvAHIAZABzADsACgByAGUAdAB1AHIAbgAgACgAcwBwAGgAZQByAGUAQwBvAG8AcgBkAHMAIAArACAAZgBsAG8AYQB0ADQAKAAwACwAIAAxAC0AdQBuAGkAdAB5AF8AUwB0AGUAcgBlAG8ARQB5AGUASQBuAGQAZQB4ACwAMQAsADAALgA1ACkALgB4AHkAKQAgACoAIABmAGwAbwBhAHQANAAoADAALAAgADEALQB1AG4AaQB0AHkAXwBTAHQAZQByAGUAbwBFAHkAZQBJAG4AZABlAHgALAAxACwAMAAuADUAKQAuAHoAdwA7AA==,output:1,fname:StereoPanoProjection,width:891,height:132,input:2,input_1_label:coords|A-1052-OUT;n:type:ShaderForge.SFN_Code,id:4693,x:30668,y:32958,varname:node_4693,prsc:2,code:ZgBsAG8AYQB0ADMAIABuAG8AcgBtAGEAbABpAHoAZQBkAEMAbwBvAHIAZABzACAAPQAgAG4AbwByAG0AYQBsAGkAegBlACgAYwBvAG8AcgBkAHMAKQA7AA0ACgBmAGwAbwBhAHQAIABsAGEAdABpAHQAdQBkAGUAIAA9ACAAYQBjAG8AcwAoAG4AbwByAG0AYQBsAGkAegBlAGQAQwBvAG8AcgBkAHMALgB5ACkAOwANAAoAZgBsAG8AYQB0ACAAbABvAG4AZwBpAHQAdQBkAGUAIAA9ACAAYQB0AGEAbgAyACgAbgBvAHIAbQBhAGwAaQB6AGUAZABDAG8AbwByAGQAcwAuAHoALAAgAG4AbwByAG0AYQBsAGkAegBlAGQAQwBvAG8AcgBkAHMALgB4ACkAOwANAAoAZgBsAG8AYQB0ADIAIABzAHAAaABlAHIAZQBDAG8AbwByAGQAcwAgAD0AIABmAGwAbwBhAHQAMgAoAGwAbwBuAGcAaQB0AHUAZABlACwAIABsAGEAdABpAHQAdQBkAGUAKQAgACoAIABmAGwAbwBhAHQAMgAoADEALgAwAC8AVQBOAEkAVABZAF8AUABJACwAIAAxAC4AMAAvAFUATgBJAFQAWQBfAFAASQApADsADQAKAHMAcABoAGUAcgBlAEMAbwBvAHIAZABzACAAPQAgAGYAbABvAGEAdAAyACgAMQAuADAALAAxAC4AMAApACAALQAgAHMAcABoAGUAcgBlAEMAbwBvAHIAZABzADsACgByAGUAdAB1AHIAbgAgACgAcwBwAGgAZQByAGUAQwBvAG8AcgBkAHMAIAArACAAZgBsAG8AYQB0ADQAKAAwACwAIAAxAC0AdQBuAGkAdAB5AF8AUwB0AGUAcgBlAG8ARQB5AGUASQBuAGQAZQB4ACwAMQAsADEALgAwACkALgB4AHkAKQAgACoAIABmAGwAbwBhAHQANAAoADAALAAgADEALQB1AG4AaQB0AHkAXwBTAHQAZQByAGUAbwBFAHkAZQBJAG4AZABlAHgALAAxACwAMQAuADAAKQAuAHoAdwA7AA==,output:1,fname:MonoPanoProjection,width:892,height:132,input:2,input_1_label:coords|A-1052-OUT;n:type:ShaderForge.SFN_SwitchProperty,id:8023,x:31640,y:32958,ptovrint:False,ptlb:Stereo Enabled,ptin:_StereoEnabled,varname:node_803,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:True|A-4693-OUT,B-2984-OUT;proporder:2316-8840-3472-7727-8023;pass:END;sub:END;*/

Shader "Midget/Panning Panosphere" {
    Properties {
        _TileOverlay ("Tile Overlay", 2D) = "white" {}
        _TileSpeedX ("Tile Speed X", Range(-1, 1)) = 0
        _TileSpeedY ("Tile Speed Y", Range(-1, 1)) = 0
        _node_7727 ("node_7727", Float ) = 0
        [MaterialToggle] _StereoEnabled ("Stereo Enabled", Float ) = 0
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        LOD 100
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Cull Off
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform sampler2D _TileOverlay; uniform float4 _TileOverlay_ST;
            uniform float _TileSpeedX;
            uniform float _TileSpeedY;
            uniform float _node_7727;
            float2 StereoPanoProjection( float3 coords ){
            float3 normalizedCoords = normalize(coords);
            float latitude = acos(normalizedCoords.y);
            float longitude = atan2(normalizedCoords.z, normalizedCoords.x);
            float2 sphereCoords = float2(longitude, latitude) * float2(0.5/UNITY_PI, 1.0/UNITY_PI);
            sphereCoords = float2(0.5,1.0) - sphereCoords;
            return (sphereCoords + float4(0, 1-unity_StereoEyeIndex,1,0.5).xy) * float4(0, 1-unity_StereoEyeIndex,1,0.5).zw;
            }
            
            float2 MonoPanoProjection( float3 coords ){
            float3 normalizedCoords = normalize(coords);
            float latitude = acos(normalizedCoords.y);
            float longitude = atan2(normalizedCoords.z, normalizedCoords.x);
            float2 sphereCoords = float2(longitude, latitude) * float2(1.0/UNITY_PI, 1.0/UNITY_PI);
            sphereCoords = float2(1.0,1.0) - sphereCoords;
            return (sphereCoords + float4(0, 1-unity_StereoEyeIndex,1,1.0).xy) * float4(0, 1-unity_StereoEyeIndex,1,1.0).zw;
            }
            
            uniform fixed _StereoEnabled;
            struct VertexInput {
                float4 vertex : POSITION;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 posWorld : TEXCOORD0;
                UNITY_FOG_COORDS(1)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
////// Lighting:
////// Emissive:
                float node_2814 = 0.1;
                float4 node_2050 = _Time;
                float3 node_1052 = (viewDirection*(-1.0));
                float2 node_4710 = ((float2((node_2814*_TileSpeedX),(node_2814*_TileSpeedY))*node_2050.g)+lerp( MonoPanoProjection( node_1052 ), StereoPanoProjection( node_1052 ), _StereoEnabled ));
                float4 _TileOverlay_var = tex2D(_TileOverlay,TRANSFORM_TEX(node_4710, _TileOverlay));
                float3 emissive = (_TileOverlay_var.rgb*_node_7727);
                float3 finalColor = emissive;
                fixed4 finalRGBA = fixed4(finalColor,1);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "ShadowCaster"
            Tags {
                "LightMode"="ShadowCaster"
            }
            Offset 1, 1
            Cull Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_SHADOWCASTER
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            struct VertexInput {
                float4 vertex : POSITION;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
