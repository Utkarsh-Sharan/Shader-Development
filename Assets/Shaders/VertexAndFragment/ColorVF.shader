Shader "VertexAndFragment/ColorVF"
{
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;       //these vertices are in world space.
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;    //these vertices are processed from world space to clip space.
                float4 color : COLOR;
            };

            v2f vert (appdata v)        //Runs on every VERTEX. Use this if we DON'T want to change color of mesh when camera moves.
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);  //reduces the data down to 2D. Changes vertex position from world to clip space.
                //o.color.r = v.vertex.x;
                //o.color.g = v.vertex.z;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target     //Runs on every PIXEL. So this does a lot of work compared to v2f vert(). Use this if we want to change color of mesh when camera moves.
            {
                fixed4 col;
                col.r = i.vertex.x/10000;
                col.g = (i.vertex.y)/10000;
                return col;
            }
            ENDCG
        }
    }
}
