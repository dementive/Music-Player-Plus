# pdxgui_pushbutton.shader with a bunch of different effects
# Use effectname = "x" in the gui to use a different pixel shader for different gui buttons

Includes = {
	"cw/pdxgui.fxh"
	"cw/pdxgui_sprite.fxh"
}

ConstantBuffer( PdxConstantBuffer2 )
{
	float3 HighlightColor;
};

VertexShader =
{
	MainCode VS_Default
	{
		Input = "VS_INPUT_PDX_GUI"
		Output = "VS_OUTPUT_PDX_GUI"
		Code
		[[
			PDX_MAIN
			{
				return PdxGuiDefaultVertexShader( Input );
			}
		]]
	}
}

PixelShader =
{
	TextureSampler Texture
	{
		Ref = PdxTexture0
		MagFilter = "Point"
		MinFilter = "Point"
		MipFilter = "Point"
		SampleModeU = "Clamp"
		SampleModeV = "Clamp"
	}
	MainCode PixelShader
	{
		Input = "VS_OUTPUT_PDX_GUI"
		Output = "PDX_COLOR"
		Code
		[[
			PDX_MAIN
			{			
				float4 OutColor = SampleImageSprite( Texture, Input.UV0 );

				OutColor *= Input.Color;
				#ifndef NO_HIGHLIGHT
					OutColor.rgb += HighlightColor;
				#endif
				
				#ifdef DISABLED
					OutColor.rgb = DisableColor( OutColor.rgb );
				#endif
			    return OutColor;
			}
		]]
	}
	MainCode PS_GuiSaturate
	{	
		Input = "VS_OUTPUT_PDX_GUI"
		Output = "PDX_COLOR"
		Code
		[[
			PDX_MAIN
			{
				// https://github.com/dinfinity/mpc-pixel-shaders/blob/master/PS_Saturation.hlsl
				float4 OutColor = SampleImageSprite( Texture, Input.UV0 );
				OutColor *= Input.Color;

				// Ignore color of text (MUSIC PLAYER TEXTURES ONLY)
				if ( OutColor.r == 1.0 && OutColor.g == 1.0 && OutColor.b == 1.0 )
				{
					return OutColor;
				}

				float sat_factor = 1.6;
				float correction = 0.9;
				#ifdef SOFT_SATURATION
					sat_factor = 1.4;
				#endif

				float luminance = (OutColor.r+OutColor.g+OutColor.b)/3.;
				//Saturate
				float4 result = OutColor * sat_factor + (1-sat_factor)*luminance;
				OutColor = float4(result.rgb, OutColor.a);
				OutColor.rgb *= correction;

				#ifdef DISABLED
					OutColor.rgb = DisableColor( OutColor.rgb );
				#endif

				OutColor.rgb += HighlightColor;

			    return OutColor;
			}
		]]
	}
}


BlendState BlendState
{
	BlendEnable = yes
	SourceBlend = "SRC_ALPHA"
	DestBlend = "INV_SRC_ALPHA"
}

BlendState BlendStateNoAlpha
{
	BlendEnable = no
}

DepthStencilState DepthStencilState
{
	DepthEnable = no
}


Effect Up
{
	VertexShader = "VS_Default"
	PixelShader = "PixelShader"
}

Effect Over
{
	VertexShader = "VS_Default"
	PixelShader = "PixelShader"
}

Effect Down
{
	VertexShader = "VS_Default"
	PixelShader = "PixelShader"
}

Effect Disabled
{
	VertexShader = "VS_Default"
	PixelShader = "PixelShader"
	
	Defines = { "DISABLED" }
}

Effect NoAlphaNoHighlightUp
{
	VertexShader = "VS_Default"
	PixelShader = "PixelShader"
	BlendState = BlendStateNoAlpha

	Defines = { "NO_HIGHLIGHT" }
}

Effect NoAlphaNoHighlightOver
{
	VertexShader = "VS_Default"
	PixelShader = "PixelShader"
	BlendState = BlendStateNoAlpha
	
	Defines = { "NO_HIGHLIGHT" }
}

Effect NoAlphaNoHighlightDown
{
	VertexShader = "VS_Default"
	PixelShader = "PixelShader"
	BlendState = BlendStateNoAlpha
	
	Defines = { "NO_HIGHLIGHT" }
}

Effect NoAlphaNoHighlightDisabled
{
	VertexShader = "VS_Default"
	PixelShader = "PixelShader"
	BlendState = BlendStateNoAlpha
	
	Defines = { "DISABLED" "NO_HIGHLIGHT" }
}

Effect NoHighlightUp
{
	VertexShader = "VS_Default"
	PixelShader = "PixelShader"
	
	Defines = { "NO_HIGHLIGHT" }
}

Effect NoHighlightOver
{
	VertexShader = "VS_Default"
	PixelShader = "PixelShader"
	
	Defines = { "NO_HIGHLIGHT" }
}

Effect NoHighlightDown
{
	VertexShader = "VS_Default"
	PixelShader = "PixelShader"
	
	Defines = { "NO_HIGHLIGHT" }
}

Effect NoHighlightDisabled
{
	VertexShader = "VS_Default"
	PixelShader = "PixelShader"
	
	Defines = { "DISABLED" "NO_HIGHLIGHT" }
}

Effect GreyedOutUp
{
	VertexShader = "VS_Default"
	PixelShader = "PixelShader"
	Defines = { "DISABLED" }
}

Effect GreyedOutOver
{
	VertexShader = "VS_Default"
	PixelShader = "PixelShader"
	Defines = { "DISABLED" }
}

Effect GreyedOutDown
{
	VertexShader = "VS_Default"
	PixelShader = "PixelShader"
	Defines = { "DISABLED" }
}

Effect GreyedOutDisabled
{
	VertexShader = "VS_Default"
	PixelShader = "PixelShader"
	
	Defines = { "DISABLED" "NO_HIGHLIGHT" }
}

Effect SaturateUp
{
	VertexShader = "VS_Default"
	PixelShader = "PS_GuiSaturate"
}
Effect SaturateOver
{
	VertexShader = "VS_Default"
	PixelShader = "PS_GuiSaturate"
}
Effect SaturateDown
{
	VertexShader = "VS_Default"
	PixelShader = "PS_GuiSaturate"
}
Effect SaturateDisabled
{
	VertexShader = "VS_Default"
	PixelShader = "PS_GuiSaturate"
	
	Defines = { "DISABLED" }
}

Effect SoftSaturateUp
{
	VertexShader = "VS_Default"
	PixelShader = "PS_GuiSaturate"
	Defines = { "SOFT_SATURATION" }
}
Effect SoftSaturateOver
{
	VertexShader = "VS_Default"
	PixelShader = "PS_GuiSaturate"
	Defines = { "SOFT_SATURATION" }
}
Effect SoftSaturateDown
{
	VertexShader = "VS_Default"
	PixelShader = "PS_GuiSaturate"
	Defines = { "SOFT_SATURATION" }
}
Effect SoftSaturateDisabled
{
	VertexShader = "VS_Default"
	PixelShader = "PS_GuiSaturate"
	
	Defines = { "DISABLED" "SOFT_SATURATION" }
}