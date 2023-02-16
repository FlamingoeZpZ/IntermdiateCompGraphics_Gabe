Shader "Custom/CustomDecal"
{
    Properties
    {
        _MainTex ("Main Texture", 2D) = "white" {}
        _DecalTex ("Decal Texture", 2D) = "white" {}
        [Toggle] _ShowDecal("Show Decal?", float) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Geometry" }
       

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Lambert

        sampler2D _MainTex;
        sampler2D _DecalTex;
        float _ShowDecal;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_DecalTex;
        };

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutput o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 a = tex2D (_MainTex, IN.uv_MainTex);
            fixed4 b = tex2D (_DecalTex, IN.uv_DecalTex) * _ShowDecal;
            //o.Albedo = b.r > 0.9? b.rgb :a.rgb;
            o.Albedo = b.rgb + a.rgb;
            //o.Albedo = b.rgb * a.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
