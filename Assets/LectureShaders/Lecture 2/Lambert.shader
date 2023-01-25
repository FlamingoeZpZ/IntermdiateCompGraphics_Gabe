Shader "Custom/Lambert"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _attention ("Attenuation", float) = 1.
    }
    SubShader
    {
        Tags { "LightMode"="ForwardBase" } // Directional Light sources
        Pass
        {
            CGPROGRAM
            #pragma  vertex vert;
            #pragma  vertex frag;

            uniform float4 _Color;
            uniform float4 _lightColor0;
            uniform float _attention;

            struct vertexInput
            {
                float4 vertex: POSITION;
                float3 normal: NORMAL;

                
            };
            
            struct vertexOutput
            {
                float4 pos: SV_POSITION;
                float4 col: COLOR;
                vertexOutput(float4 p, float4 c)
                {
                    pos = p;
                    col = c;
                }
            };

            vertexOutput vert(vertexInput v)
            {
                const float normalDirection = normalize(mul(float4(v.normal, 0.f), unity_WorldToObject).xyz);
                const float lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 diffuseReflection =  _attention * _lightColor0.xyz * _Color.rgb * max(0.f, dot(normalDirection, lightDirection)); // Lambert specific vs ADS

                return vertexOutput(UnityObjectToClipPos(v.vertex),float4(diffuseReflection, 1.f));
                
            }

            float4 frag(vertexOutput i) :COLOR
            {
                return i.col;
            }
            
            ENDCG
        }
        /*
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        half _Glossiness;
        half _Metallic;
        fixed4 _Color;

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = c.rgb;
            // Metallic and smoothness come from slider variables
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = c.a;
        }
        ENDCG*/
    }
    FallBack "Diffuse"
}
