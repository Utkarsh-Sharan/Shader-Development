Shader "Introduction/PropertiesChallenge4"
{
    Properties
    {
        _myDiffuseTex("Diffuse Texture", 2D) = "white" {}
        _myEmissiveTex("Emissive Texture", 2D) = "white" {}
    }
        SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _myDiffuseTex;
        sampler2D _myEmissiveTex;

        struct Input
        {
            float2 uv_myDiffuseTex;
            float2 uv_myEmissiveTex;
        };

        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D(_myDiffuseTex, IN.uv_myDiffuseTex).rgb;
            o.Emission = tex2D(_myEmissiveTex, IN.uv_myEmissiveTex).rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
