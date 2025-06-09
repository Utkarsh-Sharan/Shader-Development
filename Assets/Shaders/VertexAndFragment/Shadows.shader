Shader "VertexAndFragment/Shadows"
{
    Properties
    {
        _MainTex("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Pass
        {
            Tags {"LightMode" = "ForwardBase"} // Sets the shader to use the ForwardBase lighting mode.

            CGPROGRAM
            #pragma vertex vert                     // Declares the vertex shader function.
            #pragma fragment frag                   // Declares the fragment shader function.
            #pragma multi_compile_fwdbase nolightmap nodirlightmap nodynlightmap novertexlight
            #include "UnityCG.cginc"                // Includes common Unity shader functions.
            #include "UnityLightingCommon.cginc"    // Includes common Unity lighting functions.
            #include "Lighting.cginc"
            #include "AutoLight.cginc"

            // Defines the structure for input vertex data.
            struct appdata {
                float4 vertex : POSITION;       // Vertex position.
                float3 normal : NORMAL;         // Vertex normal.
                float4 texcoord : TEXCOORD0;    // Texture coordinate.
            };

            // Defines the structure for passing data from vertex shader to fragment shader.
            struct v2f
            {
                float2 uv : TEXCOORD0;          // Texture coordinates.
                fixed4 diff : COLOR0;           // Diffuse lighting color.
                //float4 vertex : SV_POSITION;    // Transformed vertex position.
                float4 pos : SV_POSITION;       // Here its pos, bcz TRANSFER_SHADOW(o) line is looking for pos, not for vertex.
                SHADOW_COORDS(1)                // Calculates coords for the shadows on the object
            };

            // Vertex shader function
            v2f vert(appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);                      // Converts object-space vertex to clip-space.
                o.uv = v.texcoord;                                              // Passes texture coordinates to fragment shader.
                half3 worldNormal = UnityObjectToWorldNormal(v.normal);         // Converts object-space normal to world-space.
                half nl = max(0, dot(worldNormal, _WorldSpaceLightPos0.xyz));   // Computes light intensity based on normal direction.
                o.diff = nl * _LightColor0;                                     // Multiplies light intensity by the light color.
                TRANSFER_SHADOW(o)

                return o;                                                       // Returns processed data.
            }

            sampler2D _MainTex; // Declares the texture sampler.

            // Fragment shader function
            fixed4 frag(v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv);     // Samples the texture at the given coordinates.
                fixed shadow = SHADOW_ATTENUATION(i);
                col *= i.diff * shadow;                          // Applies lighting effect to the texture color.

                return col;                             // Returns the final color.
            }
            ENDCG
        }
        Pass
        {
            Tags {"LightMode" = "ShadowCaster"} // Sets the shader to act as a shadow caster.

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_shadowcaster  // Enables multi-compilation for shadow casting across different scenarios.
            #include "UnityCG.cginc"

            struct appdata {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 texcoord : TEXCOORD0;
            };

            struct v2f {
                V2F_SHADOW_CASTER;  // Defines a structure using Unity's built-in macro for shadow casting.
            };

            v2f vert(appdata v)
            {
                v2f o;
                TRANSFER_SHADOW_CASTER_NORMALOFFSET(o)  // Computes and transfers necessary shadow casting data with normal offset.
                return o;
            }

            float4 frag(v2f i) : SV_Target
            {
                SHADOW_CASTER_FRAGMENT(i)   // Executes the fragment function for shadow casting.
            }
            ENDCG
        }
    }
}
