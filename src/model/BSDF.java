package model;

public interface BSDF {
    PVector evaluate(ShaderGlobals shaderGlobals);

    float pdf(ShaderGlobals shaderGlobals);

    PVector sample(ShaderGlobals shaderGlobals, PVector sample);

}
