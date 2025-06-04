Shader "PassesAndBlending/Blending"
{
    Properties
    {
        _MainTex("Texture", 2D) = "black" {}
    }
    SubShader
    {
        Tags { "Queue" = "Transparent" }

        //Blend One One   //adds the source and destination colors together. FinalColor = (SourceColor * 1) + (DestinationColor * 1). Since it's additive, black pixels don’t contribute to the result
        Blend SrcAlpha OneMinusSrcAlpha //anything which is not set as transparent, will not let any color pass through. This is the blend which is used for transparency.
        //Blend DstColor Zero     //texture's colors get multiplied by whatever is already in the frame buffer (the destination color). FinalColor = (SourceColor * DestinationColor) + (DestinationColor * 0).

        Pass{
            SetTexture[_MainTex] {combine Texture}  //this is replacing the pixels in the frame buffer with whatever is in our texture. This is same as what we have done up until now.
        }
    }
    FallBack "Diffuse"
}
