Shader "DotProduct/LogicalCutoff"
{
    Properties
    {
        _myDiffuseTex("Diffuse Texture", 2D) = "white" {}
        _myStripeWidthSlider("Stripe Width", Range(1, 20)) = 10
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert

        half _myStripeWidthSlider;
        sampler2D _myDiffuseTex;

        struct Input
        {
            float2 uv_myDiffuseTex;
            float3 viewDir;
            float3 worldPos;
        };

        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D(_myDiffuseTex, IN.uv_myDiffuseTex).rgb;

            half rim = 1-saturate(dot(normalize(IN.viewDir), o.Normal));
            //o.Emission = IN.worldPos.y > 0.3 ? float3(1, 0, 0) : float3(0.2, 0, 0.7);   //checking if object's world position at y coordinate is > 0.3. If true, set emission to red, else purple-blue.
            o.Emission = frac(IN.worldPos.y * _myStripeWidthSlider * 0.5) > 0.4 ? float3(1, 0, 0) * rim : float3(0.2, 0, 0.7) * rim;  //frac() cycles values between 0 and 1, so it creates bands or stripes along the Y-axis
        }
        ENDCG
    }
    FallBack "Diffuse"
}
