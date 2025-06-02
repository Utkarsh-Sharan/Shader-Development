Shader "PassesAndBlending/Hologram"
{
    Properties
    {
        _RimColor("Rim Color", Color) = (0, 0.5, 0.5, 0)
        _RimPower("Rim Power", Range(0.5, 8)) = 3
    }
    SubShader
    {
        Tags { "Queue" = "Transparent" }

        Pass{   //we are using a pass here. 1 pass = 1 draw call.
            ZWrite On   //this is writing a depth data into the z-buffer (used for depth)
            ColorMask 0 //we are not writing any colored pixels into the frame buffer.
        }

        CGPROGRAM   //This is another pass
        #pragma surface surf Lambert alpha:fade

        float4 _RimColor;
        float _RimPower;

        struct Input
        {
            float3 viewDir;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            half rim = 1-saturate(dot(normalize(IN.viewDir), o.Normal));
            o.Emission = _RimColor.rgb * pow(rim, _RimPower) * 10;
            o.Alpha = pow(rim, _RimPower);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
