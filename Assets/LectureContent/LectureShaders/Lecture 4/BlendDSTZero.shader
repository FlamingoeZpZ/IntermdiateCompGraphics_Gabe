Shader "Custom/BlendDSTZero"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "black" {}
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" }
        Blend DstColor Zero //SrcAlpha, OneMinusSrcAlpha (Pixels containing transparency are not used) // One One (Black is gone
        pass
        {
            SetTexture[_MainTex] {combine texture}
        }
        
    }
    FallBack "Diffuse"
}
