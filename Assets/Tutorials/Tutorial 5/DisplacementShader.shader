Shader "Custom/DisplacementShader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _DisplacementMap ("Displacement", 2D) = "black" {}
        _NormalMap ("Normal", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.5
        _DisplacementStrength("Displacement", Range(0,10)) = 1
    }
    SubShader
    {
        Pass{
        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma vertex vert
        #pragma fragment frag
        #pragma multi_compile_fog
        #include "UnityCG.cginc"


        sampler2D _MainTex;
        sampler2D _DisplacementMap;
        sampler2D _NormalMap;
        float4 _DisplacementMap_ST;
        float4 _MainTex_ST;
        float4 _NormalMap_ST;

        struct Input
        {
            float2 uv_MainTex;
        };
        struct appdata
        {
            float4 vertex : POSITION;
            float2 uv : TEXCOORD0;
            float3 normal : NORMAL; 
        };
        struct v2f
        {
            float2 uv : TEXCOORD0;
            UNITY_FOG_COORDS(1)
            float4 vertex: SV_POSITION;
        };
        half _Glossiness;
        half _Metallic;
        fixed4 _Color;
        half _DisplacementStrength;

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        v2f vert(appdata v){
            v2f o;
            o.uv = TRANSFORM_TEX(v.uv, _MainTex);

            float displacement = tex2Dlod(_DisplacementMap, float4(o.uv,0,0)).r;
            //float displacement = 0;
 float4 temp = float4(v.vertex.x, v.vertex.y, v.vertex.z, 1.0);
temp.xyz += displacement * tex2Dlod(_NormalMap, float4(o.uv,0,0)) * v.normal*  _DisplacementStrength;
            o.vertex = UnityObjectToClipPos(temp);

            UNITY_TRANSFER_FOG(o, o.vertex);

            
            
            return o;
        }

        fixed4 frag(v2f i ) : SV_Target{
            fixed4 col = tex2D(_MainTex, i.uv);
            UNITY_APPLY_FOG(i.fogCoord, col);
            return col;
           
        }
        ENDCG
    }
    }
}
