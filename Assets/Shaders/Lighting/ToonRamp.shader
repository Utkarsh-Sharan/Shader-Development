Shader "Lighting/ToonRamp"
{
    Properties
    {
        _Color("Color", Color) = (1,1,1,1)
        _RampTex("Ramp Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags{ "Queue" = "Geometry"}

        CGPROGRAM
        #pragma surface surf ToonRamp

        float4 _Color;
        sampler2D _RampTex;

        float4 LightingToonRamp(SurfaceOutput s, float3 lightDir, half atten) //created toon shader lighting model
        {
            half diff = dot(s.Normal, lightDir);
            float h = diff * 0.5 + 0.5;
            float2 rh = h;  //converting it to uv value.
            float3 ramp = tex2D(_RampTex, rh).rgb;

            float4 c;
            c.rgb = s.Albedo * _LightColor0.rgb * ramp;
            c.a = s.Alpha;
          
            return c;
        }

        struct Input
        {
            float2 uv_MainTex;
            float3 viewDir;
        };

        void surf(Input IN, inout SurfaceOutput o)
        {
            //o.Albedo = _Color.rgb;
            float diff = dot(o.Normal, IN.viewDir); //challenge 3 completed.s
            float h = diff * 0.5 + 0.5;
            float2 rh = h;

            o.Albedo = tex2D(_RampTex, rh).rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
