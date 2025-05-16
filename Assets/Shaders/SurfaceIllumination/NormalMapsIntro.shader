Shader "Lighting/NormalMapsIntro"
{
    Properties
    {
        _myDiffuseTex("Diffuse Texture", 2D) = "white" {}
        _myNormalTex("Bump Texture", 2D) = "bump" {}    //Bump and Normal are used interchangably
        _mySlider("Depth Slider", Range(0, 10)) = 1
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _myDiffuseTex;
        sampler2D _myNormalTex;
        half _mySlider;

        struct Input
        {
            float2 uv_myDiffuseTex;
            float2 uv_myNormalTex;
        };

        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D(_myDiffuseTex, IN.uv_myDiffuseTex).rgb;
            o.Normal = UnpackNormal(tex2D(_myNormalTex, IN.uv_myNormalTex));
            o.Normal *= float3(_mySlider, _mySlider, 1);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
