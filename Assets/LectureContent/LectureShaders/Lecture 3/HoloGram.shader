Shader "Custom/Hologram"
{
    Properties
    {
        _RimColor ("Rim Color", Color) = (1,1,1,1)
        _RimPower ("Rim Power", Range(0.5, 8)) = 3
    }
    SubShader
    {
        Tags{"Queue" = "Transparent"}
        
        pass
        {
            ZWrite on //Write on Z Buffer
            ColorMask 0   // Disable color mask
        }
        
        CGPROGRAM
        #pragma surface surf Lambert alpha:fade
        
        struct Input
        {
            float3 viewDir;
        };

        float4 _RimColor;
        float _RimPower;

        void surf(Input IN, inout SurfaceOutput o)
        {
            const half rim = 1- saturate(dot(normalize(IN.viewDir), o.Normal));
            const float p = pow( rim, _RimPower);
            o.Emission = _RimColor.rgb * p * 10;
            o.Alpha = p;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
