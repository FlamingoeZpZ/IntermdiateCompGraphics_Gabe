Shader "Custom/BasicToon"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex("Main Texture", 2D) = "" {}
        _ToonRamp("ToonRamp", 2D) = "" {}
        _SpecPow("Specular Power", range(0,100)) = 50
    }
    SubShader
    {
        Tags { "Queue"="Geometry" }
        

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf ToonRamp
        half _SpecPow;
        fixed4 _Color;
        sampler2D _MainTex;
        sampler2D _ToonRamp;

        
        //NOTE: BasicLambert, Basic Blinn too must be in both function and name

        //For flowCharting --> Inputs --> Process --> Output
        
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
