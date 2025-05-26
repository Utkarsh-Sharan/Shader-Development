Shader "Lighting/PBR-Speculative"
{
    Properties
    {
        _Color("Color", Color) = (1,1,1,1)
        _MetallicTex("Metallic Texture (R)", 2D) = "white" {}
        _SpecColor("Specular", Color) = (1,1,1,1)
    }
    SubShader
    {
        Tags{ "Queue" = "Geometry"}

        CGPROGRAM
        #pragma surface surf StandardSpecular

        float4 _Color;
        sampler2D _MetallicTex;

        struct Input
        {
            float2 uv_MetallicTex;
        };

        void surf(Input IN, inout SurfaceOutputStandardSpecular o)  //SurfaceOutputStandardSpecular lets us access smoothness and Specular properties.
        {
            o.Albedo = _Color.rgb;
            //o.Smoothness = tex2D(_MetallicTex, IN.uv_MetallicTex).r;
            o.Smoothness = 1-tex2D(_MetallicTex, IN.uv_MetallicTex).r; //challenge 2- reverse glossiness effect
            o.Specular = _SpecColor.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
