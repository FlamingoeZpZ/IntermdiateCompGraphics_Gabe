Shader "Custom/Stencil"
{
    Properties
    {
        _MainTex ("Diffuse", 2D) = "white"{}
    }
    SubShader
    {
        Tags { "Queue"="Geometry" }
        Stencil {
        Ref 1               // use 1 as the value to check against
        Comp notequal       // If this stencil Ref 1 is not equal to what's in the stencil buffer, then we will keep this pixel that belongs to the Wall
        Pass keep           // If you do find a 1, don't draw it.
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
