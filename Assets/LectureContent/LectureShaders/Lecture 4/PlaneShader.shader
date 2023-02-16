Shader "Unlit/PlaneShader"
{
    Properties
    {
    }
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float4 color : COLOR;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.color.r = (v.vertex.x + 5)  / 5;
                o.color.g = (v.vertex.z + 5)  / 5;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = i.color;
                //Does not work in fragment
                //col.r = (i.vertex.x + 5)  / 5;
                //col.g = (i.vertex.z + 5)  / 5;
                return col;
            }
            ENDCG
        }
    }
}
