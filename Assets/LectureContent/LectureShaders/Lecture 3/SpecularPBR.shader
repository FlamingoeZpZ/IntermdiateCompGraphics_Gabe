Shader "Custom/SpecularPBR"
{
    //Changing the metallic PBR to specular, causes the material to lose it's albedo property...
    //This is because we're no longer using metallic, we're using specular base highlights.
    
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MetallicTex("Metallic (R)", 2D) = "white" {}
        //_Metallic ("Metallic", Range(0,1)) = 0.0
        _SpecColor("Specular Color", Color) = (1,1,1,1)
    }
    SubShader
    {
        Tags { "Queue"="Geometry" }

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf StandardSpecular

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MetallicTex;
        //half _Metallic;
        fixed4 _Color;
        //fixed4 _SpecColor; How is this already declared?

        struct Input
        {
            float2 uv_MetallicTex;
        };

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandardSpecular o)
        {
            o.Albedo = _Color.rgb;
            // Metallic and smoothness come from slider variables
            //o.Specular = _Metallic;
            o.Specular = _SpecColor.rgb;
            o.Smoothness = tex2D(_MetallicTex, IN.uv_MetallicTex).r;
            //o.Alpha = _Color.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
