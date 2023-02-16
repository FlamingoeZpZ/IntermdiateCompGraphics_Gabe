// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/DEBUG_WorldPosY" {
      Properties{
          _A("A", Color) = (1,0,0)
          _B("B", Color) = (0,0,1)
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

              fixed4 _A;
              fixed4 _B;
  
              v2f vert(appdata v) {
                  v2f o;
  
                  o.worldPos = mul (unity_ObjectToWorld, v.vertex);
                  o.vertex = UnityObjectToClipPos(v.vertex);
  
                  return o;
              }
    
              fixed4 frag(v2f i) : SV_Target {
                  return  float4(i.worldPos.y>0?_A.rgb:_B.rgb,0);
              }
  
              ENDCG
          }
  
      
      }
      FallBack "Diffuse"
  }