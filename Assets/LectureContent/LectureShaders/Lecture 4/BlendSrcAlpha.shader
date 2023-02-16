Shader "Custom/BlendSrcAlpha"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "black" {}
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" }
        Blend SrcAlpha OneMinusSrcAlpha //SrcAlpha, OneMinusSrcAlpha (Pixels containing transparency are not used) // One One (Black is gone
        pass
        {
            SetTexture[_MainTex] {combine texture}
        }
        
    }
    FallBack "Diffuse"
}
