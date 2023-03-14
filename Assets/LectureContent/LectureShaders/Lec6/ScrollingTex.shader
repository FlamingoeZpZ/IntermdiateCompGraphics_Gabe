Shader "Custom/ScrollingTex"
{
    Properties
    {
        _MainTex ("Tex", 2D) = "White" {}
        _SpeedX("SpeedX", Range(-100,100)) = 1
        _SpeedY("SpeedY", Range(-100,100)) = 1
    }
    SubShader
    {
        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Lambert

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        fixed _SpeedX;
        fixed _SpeedY;

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutput o)
        {
            // Albedo comes from a texture tinted by color
            float2 newUV = IN.uv_MainTex + float2(_SpeedY, _SpeedX) * _Time;
            o.Albedo = tex2D (_MainTex, newUV);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
