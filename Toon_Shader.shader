Shader "Custom/Toon_Shader"
{
    Properties {
        _FrontColor("FrontColor" , color) = (0,0,0,0)
        _MColor("MColor",color) = (0,0,0,0)
        _BackColor("BackColor",color) = (0,0,0,0)
        _cross("cross",Range(-1.0,1.0)) = 0.0
    }
 
    SubShader 
    {
        Tags { "RenderType"="Qpaque" }
        LOD 200
        pass{
            CGPROGRAM
        
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            #include "UnityLightingCommon.cginc"
            
           

            struct appdata {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct v2f {
                float4 vertex : SV_POSITION;
                float3 normal : NORMAL;
            };

            float4 _FrontColor;
            float4 _BackColor;
            float4 _MColor;
            float _cross;

            v2f vert(appdata a){
                v2f o;
                o.vertex = UnityObjectToClipPos(a.vertex);
                o.normal = UnityObjectToWorldNormal(a.normal);
                return o;
            }

            float4 frag(v2f v): SV_Target {
                
                
                float3 lightSrc = normalize(_WorldSpaceLightPos0.xyz);
                float diff = dot(lightSrc,v.normal);
                //return diff>_cross?_FrontColor:_BackColor;
                return diff > _cross ? (diff > (_cross + 0.4) ? _FrontColor : _MColor) : _BackColor;
            }

            ENDCG
        }
    }
}
