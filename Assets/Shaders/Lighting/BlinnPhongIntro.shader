Shader "Lighting/BlinnPhongIntro"
{
    Properties
    {
        _Color("Color", Color) = (1,1,1,1)
        _SpecColor("Specular Color", Color) = (1,1,1,1)    //no need to declare this inside CGPROGRAM (already declared). Gives error if declared again.
        _Spec("Specular", Range(0, 1)) = 0.5
        _Gloss("Glossiness", Range(0, 1)) = 0.5
    }
        SubShader
    {
        CGPROGRAM
        #pragma surface surf BlinnPhong

        float4 _Color;
        half _Spec;
        fixed _Gloss;

        struct Input
        {
            float2 uv_myTex;
        };

        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = _Color.rgb;
            o.Specular = _Spec;
            o.Gloss = _Gloss;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
