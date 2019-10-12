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
	// Sample: [0.0, +1.0]
	// Time: [-1.0, +1.0]
	float Sampled = CurrentTexture2D.Sample(CurrentSampler, input.UV);
	float Timed = Sampled + Time;
	if (Timed < 0.0f) Timed = -Timed;
	if (Timed > 1.0f) Timed = 2.0f - Timed;

	float Color = 1.0f;
	float4 Result = float4(Color, Color, Color, abs(sin((Sampled + Time + 1.0f) / 3.0f * 6.28f)) + 0.1f);
	Result.a = pow(Result.a, 6.0f);

	return Result;
}