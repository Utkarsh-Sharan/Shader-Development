Shader "Introduction/AllProperties"
{
    Properties
    {
        _myColor("Color", Color) = (1,1,1,1)
        _myTex("Texture", 2D) = "white" {}
        _myCube("Cube", CUBE) = "" {}
        _myRange("Range", Range(0, 5)) = 1
        _myFloat("Float", Float) = 0.5
        _myVector("Vector", Vector) = (0.5, 1, 1, 1)
    }
    SubShader
    {
        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        fixed4 _myColor;
        sampler2D _myTex;
        samplerCUBE _myCube;
        half _myRange;
        float _myFloat;
        float4 _myVector;

        struct Input
        {
            float2 uv_myTex;
            float3 worldRefl;
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            //IN.uv_MainTex is grabbing all the uv values we got on the model, 
            //wrapping the  _myTex(texture) 
            //onto it using tex2D() (not built in unity, its built in HLSL) method.
            o.Albedo = (tex2D(_myTex, IN.uv_myTex) * _myRange + _myColor).rgb; //turns intensity of the color up/down when range is high/low. Multiplies the r, g and b values with same number.
            o.Emission = texCUBE(_myCube, IN.worldRefl).rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
