Shader "Lighting/BasicLambert"
{
    Properties
    {
        _Color("Color", Color) = (1,1,1,1)
    }
    SubShader
    {
        Tags{ "Queue" = "Geometry"}

        CGPROGRAM
        #pragma surface surf BasicLambert

        half4 LightingBasicLambert(SurfaceOutput s, half3 lightDir, half atten) //re-created lambert lighting model
        {
            half NdotL = dot(s.Normal, lightDir);
            half4 c;
            c.rgb = s.Albedo * _LightColor0.rgb * (NdotL * atten);  //_LightColor0 is for the interaction of object with the light color. 
            c.a = s.Alpha;                                          //If we don't multiply it, object will not interact with light.
          
            return c;   //unity uses this color to put on the pixel.
        }

        float4 _Color;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = _Color.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
