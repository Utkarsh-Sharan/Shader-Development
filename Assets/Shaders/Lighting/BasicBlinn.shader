Shader "Lighting/BasicBlinn"
{
    Properties
    {
        _Color("Color", Color) = (1,1,1,1)
    }
    SubShader
    {
        Tags{ "Queue" = "Geometry"}

        CGPROGRAM
        #pragma surface surf BasicBlinn

        half4 LightingBasicBlinn(SurfaceOutput s, half3 lightDir, half3 viewDir, half atten) //re-created Blinn-Phong lighting model
        {
            half3 h = normalize(lightDir + viewDir);    //getting half way between light and viewer directions.
            half diff = max(0, dot(s.Normal, lightDir));
            float nh = max(0, dot(s.Normal, h));
            float spec = pow(nh, 48.0);
            
            half4 c;
            c.rgb = (s.Albedo * _LightColor0.rgb * diff + _LightColor0.rgb * spec) * atten * _SinTime; //the _SinTime returns 4	values that change overtime	based on the time since	level load
            c.a = s.Alpha;
          
            return c;
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
