Shader "Custom/Specular"
{
    Properties{
       _Color("Color", Color) = (1.0,1.0,1.0)
       _SpecColor("Color", Color) = (1.0,1.0,1.0)
       _Shininess("Shininess", Float) = 10
   }
   SubShader{
       Pass
       {
           Tags {"LightMode" = "ForwardBase"}
           CGPROGRAM
           #pragma vertex vert
           #pragma fragment frag
           // user defined variables
           float4 _Color;
           float4 _SpecColor;
           float _Shininess;
           // unity defined variables
           uniform float4 _LightColor0;
           // structs
           struct vertexInput {
               float4 vertex : POSITION;
               float3 normal : NORMAL;
           };
           struct vertexOutput {
               float4 pos : SV_POSITION;
               float4 posWorld : TEXCOORD0;
               float4 normalDir : TEXCOORD1;
           };
           //vertex function
           vertexOutput vert(vertexInput v) {
               vertexOutput o;
               o.posWorld = mul(unity_ObjectToWorld, v.vertex);
               o.normalDir = normalize(mul(float4(v.normal, 0.0), unity_WorldToObject));
               o.pos = UnityObjectToClipPos(v.vertex);
               return o;
           }
           // fragment function
           float4 frag(vertexOutput i) : COLOR
           {
               // vectors
               const float3 normalDirection = i.normalDir;
               const float atten = 1.0;
               // lighting
               const float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
               const float3 diffuseReflection = atten * _LightColor0.xyz * max(0.0, dot(normalDirection, 
lightDirection));
               // specular direction
               const float3 lightReflectDirection = reflect(-lightDirection, normalDirection);
               const float3 viewDirection = normalize(float3(float4(_WorldSpaceCameraPos.xyz, 1.0) - 
i.posWorld.xyz));
               const float3 lightSeeDirection = max(0.0,dot(lightReflectDirection, viewDirection));
               const float3 shininessPower = pow(lightSeeDirection, _Shininess);
               const float3 specularReflection = atten * _SpecColor.rgb  * shininessPower;
               const float3 lightFinal = diffuseReflection + specularReflection + UNITY_LIGHTMODEL_AMBIENT;
               return float4(lightFinal * _Color.rgb, 1.0);
           }
           ENDCG
       }
    }
    Fallback  "Diffuse"

}