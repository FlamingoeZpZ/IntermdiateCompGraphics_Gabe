Shader "Custom/BasicLambert"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex("Main Texture", 2D) = "" {}
    }
    SubShader
    {
        Tags { "Queue"="Geometry" }
        

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf BasicLambert

        //NOTE: BasicLambert must be in both function and name
       half4 LightingBasicLambert(SurfaceOutput s, half3 lightDir, half atten)
        {
            const half NDotL = dot(s.Normal, lightDir); //Sourse hits surface
            half4 c;
            c.rgb = s.Albedo * _LightColor0.rgb * (NDotL * atten);
            c.a = s.Alpha;
            return c;
        }

        fixed4 _Color;
        sampler2D _MainTex;
        
        struct Input
        {
            float2 uv_MainTex;
        };

        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D(_MainTex,  IN.uv_MainTex).rgb * _Color.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
