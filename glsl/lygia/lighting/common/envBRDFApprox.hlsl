#ifndef FNC_ENVBRDFAPPROX
#define FNC_ENVBRDFAPPROX

float2 envBRDFApprox(const in float _NoV, in float _roughness)
{
    const float4 c0 = float4(-1.0, -0.0275, -0.572, 0.022);
    const float4 c1 = float4(1.0, 0.0425, 1.04, -0.04);
    float4 r = _roughness * c0 + c1;
    float a004 = min(r.x * r.x, exp2(-9.28 * _NoV)) * r.x + r.y;
    float2 AB = float2(-1.04, 1.04) * a004 + r.zw;
    return float2(AB.x, AB.y);
}

//https://www.unrealengine.com/en-US/blog/physically-based-shading-on-mobile
float3 envBRDFApprox(const in float3 _specularColor, const in float _NoV, const in float _roughness)
{
    float2 AB = envBRDFApprox(_NoV, _roughness);
    return _specularColor * AB.x + AB.y;
}


#ifdef STR_MATERIAL
float2 envBRDFApprox(const in Material _M) {
    return envBRDFApprox(_M.NoV, _M.roughness );
}

float3 envBRDFApprox(const in float3 _specularColor, const in Material _M) {
    return envBRDFApprox(_specularColor, _M.NoV, _M.roughness);
}

#endif

#endif