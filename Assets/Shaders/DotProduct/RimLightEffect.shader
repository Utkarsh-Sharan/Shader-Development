Shader "DotProduct/RimLight"
{
    Properties
    {
        _rimColor("Rim Color", Color) = (0, 0.5, 0.5, 0)
        _rimPower("Power", Range(0.5, 10)) = 3
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert

        float4 _rimColor;
        half _rimPower;

        struct Input
        {
            float3 viewDir;
        };

        void surf(Input IN, inout SurfaceOutput o)
        {
            half rim = 1-saturate(dot(normalize(IN.viewDir), o.Normal));
            o.Emission = _rimColor.rgb * pow(rim, _rimPower);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
