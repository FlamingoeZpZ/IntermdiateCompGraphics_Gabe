Shader "Custom/SurfaceShader"
{
    Properties
    {
        _myColor ("Example Color", Color) = (1,1,1,1)
        _myRange ("Example Range", Range(0,5)) = 1
        _myTexture ("Example Texture", 2D) = "" 
        _myCube ("Example CubeMap", CUBE) = "" 
        _myFloat ("Example Float", Float) = 0.5
        _myVector ("Example Vector", Vector) = (0.5,1,1,1)
        //[HDR] _myEmission ("Emissive Color", Color) = (1,1,1,1)
        //_myNormals ("Normals", Color) = (1,1,1,1)
    }
    SubShader
    {
        CGPROGRAM // START
        #pragma surface surf Lambert // Declare functions?

       

        fixed4 _myColor; //Direct reference to properties
        half _myRange;
        sampler2D _myTexture;
        samplerCUBE _myCube;
        float _myFloat;
        float4 _myVector;
       // fixed4 _myEmission; //Direct reference to properties
        //fixed4 _myNormals;

        struct Input
        {
            float2 uv_myTexture;
            float3 worldRefl;
        };
        
        //Surface
        void surf(Input IN, inout SurfaceOutput o) //RW?
        {
            //o.Alpha = tex2D(_myTexture, IN.uv_myTexture).a;
            o.Albedo = (tex2D(_myTexture, IN.uv_myTexture) * _myRange).rgb;
            o.Emission = texCUBE(_myCube, IN.worldRefl).rgb;
            //o.Normal = _myNormals;
        }
        
        ENDCG // END
    }
    FallBack "Diffuse"
}
