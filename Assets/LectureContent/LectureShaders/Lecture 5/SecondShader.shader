Shader "Custom/What"
{
    Properties
    {
        _MainTex("Albedo (RGB)", 2D) = "white" {}
        _ScaleX("Scale X", Range(0,10)) = 1
        _ScaleY("Scale Y", Range(0,10)) = 1
    }
    SubShader
    {
        Pass{
            Tags{"LightMode" = "ForwardBase"}
        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma vertex vert
        #pragma fragment frag

        #include "UnityCG.cginc"
        #include "UnityLightingCommon.cginc"

        struct appdata
        {
            float4 vertex : POSITION;
            float3 normal : NORMAL;
            float2 uv: TEXCOORD0;
        };

        struct v2f
        {
            float2 uv : TEXCOORD0;
            fixed4 diff : COLOR;
            float4 vertex : SV_POSITION;
        };
        

        sampler2D _MainTex;
        float4 _MainTex_ST;
        
        half _ScaleX;
        half _ScaleY;

        v2f vert(appdata v)
        {
            v2f o;
            o.vertex = UnityObjectToClipPos(v.vertex);
            o.uv = v.uv;
            o.uv.x = sin(o.uv.x * _ScaleX);
            o.uv.y = sin(o.uv.y * _ScaleY);
            half3 worldNormal = UnityObjectToWorldNormal(v.normal);
            half nl = max(0, dot(worldNormal, _WorldSpaceLightPos0.xyz));
            o.diff = nl * _LightColor0;
            return o;
        }

        fixed4 frag(v2f i ) :SV_Target
        {
            fixed4 col = tex2D(_MainTex, i.uv).rgba;
            col *= i.diff;
            return col;
        }
        ENDCG
        }
    }
    FallBack "Diffuse"
}
