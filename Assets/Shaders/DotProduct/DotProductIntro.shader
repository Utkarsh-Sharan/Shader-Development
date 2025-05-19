Shader "DotProduct/DotProductIntro"
{
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert

        struct Input
        {
            float3 viewDir;
        };

        void surf(Input IN, inout SurfaceOutput o)
        {
            /*half dotPInv = 1-dot(IN.viewDir, o.Normal);
            half dotP = dot(IN.viewDir, o.Normal);
            o.Albedo = float3(dotP, 1, dotPInv);*/
            o.Albedo.r = 1-dot(IN.viewDir, o.Normal);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
