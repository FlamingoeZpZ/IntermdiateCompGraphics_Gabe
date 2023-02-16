Shader "Custom/WaterDisplacement"
{ // https://learn.unity.com/tutorial/creating-a-vertex-displacement-shader#6047d52cedbc2a001e4a92ea
    Properties
    {
        _MainTex (" Diffuse (RGB)", 2D) = "white" {}
        _NormalMap ("Normal Map", 2D) = "bump" {}
        _Tint("Tint", Color) = (1,1,1)
        _Glossiness("Gloss", Range(0,1)) = 0.5
        _Metallic("Metal", Range(0,1)) = 0.5
        
        _Direction("Direction", Vector) = (1.0,0.0,0.0,1.0)
        _Steepness ("Steepness", range(0,1)) = 0.5
        _Freq ("Frequency", float) = 1.0
    } 
SubShader
    {
        Tags { "RenderType"="Opaque" }
        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows vertex:vert addshadow
 
        sampler2D _MainTex;
        
        sampler2D _NormalMap;
 
        struct Input
        {
            float2 uv_MainTex;
            float2 uv_NormalMap;
        };
 
	 half _Glossiness;
 half _Metallic;
 fixed4 _Tint;
 float4 _Direction;
 float _Steepness;
 float _Freq;
        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
                       // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
                       // #pragma instancing_options assumeuniformscaling
                       UNITY_INSTANCING_BUFFER_START(Props)
                           // put more per-instance properties here
                       UNITY_INSTANCING_BUFFER_END(Props)
                
                       void vert(inout appdata_full v){
                           float3 pos = v.vertex.xyz;
                           const float4 dir = normalize(_Direction);
                           const float defaultWaveLength = 2 * UNITY_PI;
                           const float wL = defaultWaveLength / _Freq;
                           const float phase  = sqrt(9.8f / wL);
                           const float display = wL * dot(dir,pos) - phase * _Time.y; //wtf time?


                           const float peak = _Steepness /wL;
                           pos.x += dir.x * peak * cos(display);
                           pos.y = peak * sin(display);
                           pos.z += dir.y * peak * cos(display);

                           v.vertex.xyz = pos;
                           
                       }
                
                       void surf (Input In, inout SurfaceOutputStandard o)
                       {
                           fixed4 c = tex2D (_MainTex, In.uv_MainTex) * _Tint;
                           o.Albedo = c.rgb;
                           o.Normal = UnpackNormal (tex2D (_NormalMap, In.uv_NormalMap));
                    // Metallic and smoothness come from slider variables
                           o.Metallic = _Metallic;
                           o.Smoothness = _Glossiness;
                           o.Alpha = c.a;   
                       }
                
                       ENDCG
                   }
                   FallBack "Diffuse"
               }