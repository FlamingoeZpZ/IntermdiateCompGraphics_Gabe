Shader "Custom/BasicBlinn"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex("Main Texture", 2D) = "" {}
        _SpecPow("Specular Power", range(0,100)) = 50
    }
    SubShader
    {
        Tags { "Queue"="Geometry" }
        

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf BasicBlinn
        half _SpecPow;
        fixed4 _Color;
        sampler2D _MainTex;

        
        //NOTE: BasicLambert, Basic Blinn too must be in both function and name

        //For flowCharting --> Inputs --> Process --> Output
        
       half4 LightingBasicBlinn(SurfaceOutput s, half3 lightDir, half3 viewDir, half atten)
        {
            const half3 h = normalize(lightDir  + viewDir);
            const half diff = max(0, dot(s.Normal, lightDir));
            const float nh = max(0, dot(s.Normal, h)); // Uses halfway vector
            const float spec = pow(nh, _SpecPow);

           
            half4 c;
            c.rgb = (s.Albedo * _LightColor0.rgb  * diff + _LightColor0.rgb * spec) * atten;
            c.a = s.Alpha;
            return c;
        }

       
        
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
