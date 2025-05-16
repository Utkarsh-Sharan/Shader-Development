Shader "Introduction/PropertiesChallenge3"
{
    Properties
    {
        _myTex("Texture", 2D) = "white" {}
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _myTex;

        struct Input
        {
            float2 uv_myTex;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            float4 greenColor = float4(0, 1, 0, 1);
            o.Albedo = (tex2D(_myTex, IN.uv_myTex) * greenColor).rgb;
        }
        ENDCG
    }
        FallBack "Diffuse"
}
