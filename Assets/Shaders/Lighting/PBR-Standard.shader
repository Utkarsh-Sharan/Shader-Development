Shader "Lighting/PBR-Standard"
{
    Properties
    {
        _Color("Color", Color) = (1,1,1,1)
        _MetallicTex("Metallic Texture (R)", 2D) = "white" {}
        _Metallic("Metallic", Range(0, 5)) = 0.5
        _Emission("Emission", Range(0, 5)) = 1  //challenge 1
    }
    SubShader
    {
        Tags{ "Queue" = "Geometry"}

        CGPROGRAM
        #pragma surface surf Standard

        float4 _Color;
        sampler2D _MetallicTex;
        half _Metallic;
        half _Emission;

        struct Input
        {
            float2 uv_MetallicTex;
        };

        void surf(Input IN, inout SurfaceOutputStandard o)  //SurfaceOutputStandard lets us access smoothness and metallic properties.
        {
            o.Albedo = _Color.rgb;
            o.Smoothness = tex2D(_MetallicTex, IN.uv_MetallicTex).r;
            o.Metallic = _Metallic; //attached a black n white texture to the object. More the area is dark, less it will be looking metallic.
            o.Emission = tex2D(_MetallicTex, IN.uv_MetallicTex).r * _Emission;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
