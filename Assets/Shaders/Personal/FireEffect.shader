Shader "Personal/FireEffect"
{
    Properties
    {
        _MainTex("Noise Texture", 2D) = "white" {}
        _RampTex("Color Ramp", 2D) = "white" {}
        _ScrollSpeed("Scroll Speed", Float) = 1.0
        _Tiling("Tiling", Float) = 3.0
        _EmissionStrength("Emission Strength", Float) = 3.0
    }

    SubShader
    {
        Tags { "RenderType" = "Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            sampler2D _MainTex;
            sampler2D _RampTex;
            float _ScrollSpeed;
            float _Tiling;
            float _EmissionStrength;

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                // Animate the UVs
                float2 uv = i.uv;
                uv.y += _Time.y * _ScrollSpeed;
                uv *= _Tiling;

                // Sample noise
                float noise = tex2D(_MainTex, uv).r;

                // Sample color from ramp using noise
                float3 fireColor = tex2D(_RampTex, float2(noise, 0)).rgb;

                // Apply emission strength
                return fixed4(fireColor * _EmissionStrength, 1.0);
            }
            ENDCG
        }
    }
    FallBack "Unlit/Texture"
}
