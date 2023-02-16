Shader "Custom/Stencil 1"
{
    Properties
    {
        _MainTex ("Diffuse", 2D) = "white"{}
    }
    SubShader
    {
        

        Tags { "Queue"="Geometry-1" }
        
        
        ColorMask 0
        ZWrite off
        
        Stencil
        {
            Ref 1
            Comp always
            Pass replace
            
        }

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Lambert

        // Use shader model 3.0 target, to get nicer looking lighting

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
