#include "Header2D.hlsli"

cbuffer cbTimeFlow
{
	float Time;
	float3 Pad;
};

SamplerState CurrentSampler : register(s0);
Texture2D<float> CurrentTexture2D : register(t0);

float4 main(VS_OUTPUT input) : SV_TARGET
{
	// Time: [-1.0, +1.0]
	float Sampled = CurrentTexture2D.Sample(CurrentSampler, input.UV) + Time / 2.0f;
	float Normalized = (Sampled + 0.5f) / 2.0f;
	float Color = (Normalized / 2.0f) + 0.5f; // [0.5 ~ 1.0]
	float Alpha = Normalized;
	
	float4 Result = float4(Color, Color, Color, Alpha);
	Result.a = pow(Result.a, 6.0f);

	return Result;
}