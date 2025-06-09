Shader "VertexAndFragment/MaterialUse"
{
    Properties
    {
        _MainTex("Texture", 2D) = "white" {}
        _ScaleUVX("Scale UV X", Range(1, 10)) = 1
        _ScaleUVY("Scale UV Y", Range(1, 10)) = 1
    }
    SubShader
    {
        Tags {"Queue" = "Transparent"}

        GrabPass{}    //grabs all pixels that are about to appear on the screen.
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;       //these vertices are in world space.
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;    //these vertices are processed from world space to clip space.
            };

            sampler2D _GrabTexture;
            sampler2D _MainTex;
            float4 _MainTex_ST;
            float _ScaleUVX;
            float _ScaleUVY;

            v2f vert (appdata v)        //Runs on every VERTEX. Use this if we DON'T want to change color of mesh when camera moves.
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);  //reduces the data down to 2D. Changes vertex position from world to clip space.
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);       //creating a set of uv values that can be used by the fragment shader function at down.
                o.uv.x = sin(o.uv.x * _ScaleUVX);
                o.uv.y = sin(o.uv.y * _ScaleUVY);
                
                return o;
            }

            fixed4 frag(v2f i) : SV_Target     //Runs on every PIXEL. So this does a lot of work compared to v2f vert(). Use this if we want to change color of mesh when camera moves.
            {
                fixed4 col = tex2D(_GrabTexture, i.uv);
                return col;
            }
            ENDCG
        }
    }
}
