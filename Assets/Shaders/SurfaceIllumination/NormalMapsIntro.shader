Shader "SurfIllumination/NormalMapsIntro"
{
    Properties
    {
        _myDiffuseTex("Diffuse Texture", 2D) = "white" {}
        _myNormalTex("Bump Texture", 2D) = "bump" {}    //Bump and Normal are used interchangably
        _myDepthSlider("Depth Slider", Range(0, 10)) = 1
        _myScaleSlider("Scale Slider", Range(0.5, 2)) = 1
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _myDiffuseTex;
        sampler2D _myNormalTex;
        half _myDepthSlider;
        half _myScaleSlider;

        struct Input
        {
            float2 uv_myDiffuseTex;
            float2 uv_myNormalTex;
        };

        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D(_myDiffuseTex, IN.uv_myDiffuseTex * _myScaleSlider).rgb;
            o.Normal = UnpackNormal(tex2D(_myNormalTex, IN.uv_myNormalTex * _myScaleSlider));
            o.Normal *= float3(_myDepthSlider, _myDepthSlider, 1);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
