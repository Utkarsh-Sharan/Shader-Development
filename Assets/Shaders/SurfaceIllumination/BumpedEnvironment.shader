Shader "Lighting/BumpedEnvironment"
{
    Properties
    {
        //_myDiffuseTex("Diffuse Texture", 2D) = "white" {}
        _myNormalTex("Bump Texture", 2D) = "bump" {}    //Bump and Normal are used interchangably
        _myDepthSlider("Depth", Range(0, 10)) = 1
        _myBrightnessSlider("Brightness", Range(0, 10)) = 1
        _myCubeMap("Cube Map", CUBE) = "white" {}
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert

        //sampler2D _myDiffuseTex;
        sampler2D _myNormalTex;
        half _myDepthSlider;
        half _myBrightnessSlider;
        samplerCUBE _myCubeMap;

        struct Input
        {
            //float2 uv_myDiffuseTex;
            float2 uv_myNormalTex;
            float3 worldRefl; INTERNAL_DATA
        };

        void surf(Input IN, inout SurfaceOutput o)
        {
            //o.Albedo = tex2D(_myDiffuseTex, IN.uv_myDiffuseTex).rgb;
            o.Normal = UnpackNormal(tex2D(_myNormalTex, IN.uv_myNormalTex)) * _myBrightnessSlider;
            o.Normal *= float3(_myDepthSlider, _myDepthSlider, 1);
            o.Albedo = texCUBE(_myCubeMap, WorldReflectionVector(IN, o.Normal)).rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
