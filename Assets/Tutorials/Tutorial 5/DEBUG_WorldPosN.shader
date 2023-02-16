// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/DEBUG_WorldPosN" {
      Properties{
      }
  
      SubShader {
          Pass{
              CGPROGRAM
  
              #pragma target 3.0
              #pragma vertex vert
              #pragma fragment frag
  
              #include "UnityCG.cginc"
  
              struct appdata {
                  float4 vertex : POSITION;
                  
              };
  
              struct v2f {
                  float4 vertex : SV_POSITION;
                  float3 worldPos : TEXCOORD0;
              };
  
  
              v2f vert(appdata v) {
                  v2f o;
  
                  o.worldPos = mul (unity_ObjectToWorld, v.vertex);
                  o.vertex = UnityObjectToClipPos(v.vertex);
  
                  return o;
              }
  
              fixed4 frag(v2f i) : SV_Target {
                  return  float4(normalize(i.worldPos),0);
              }
  
              ENDCG
          }
  
      
      }
      FallBack "Diffuse"
  }