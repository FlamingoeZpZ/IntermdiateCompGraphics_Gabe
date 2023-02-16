Shader "Custom/CoolBricks"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        [HDR] _EmissiveColor ("Emissive Color", Color) = (1,1,1,1)
        _MainTex ("Main Texture", 2D) = "white" {}
        _ToonRamp ("Toon Ramp", 2D) = "white" {}
        _NormalTex ("Normal Texture", 2D) = "white" {}
        _NormalScale ("Normal Scale", Range(0,10)) = 1.0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf ToonRamp

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _NormalTex;
        sampler2D _ToonRamp;

        struct Input
        {
            float2 uv_MainTex;
        };

        half _Glossiness;
        half _Metallic;
        half _NormalScale;
        fixed4 _Color;
        fixed4 _EmissiveColor;

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        half4 LightingToonRamp(SurfaceOutput s, half3 lightDir, half atten)
        {
            const half diff = max(0, dot(s.Normal, lightDir));
            const float h = diff*0.5f+0.5f; //Make difference noticable
            const float2 rh = h;
            const float3 ramp = tex2D(_ToonRamp, rh).rgb;

            float4 c; // Why not a fixed 4?
            c.rgb = s.Albedo * _LightColor0.rgb  * ramp;
            
            c.a = s.Alpha;
            return c;
        }

        void surf (Input IN, inout SurfaceOutput o)
        {
            // Albedo comes from a texture tinted by color
            const fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            const fixed3 n = tex2D(_NormalTex, IN.uv_MainTex).rgb;
            o.Albedo = c.rgb;
            o.Emission = n.g > 0.4 || n.r > 0.4?_EmissiveColor*_NormalScale:0;
            o.Normal =  n * _NormalScale;
            // Metallic and smoothness come from slider variables
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
