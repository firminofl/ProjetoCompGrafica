package model;

public interface Light {

    PVector emission = null;
    PVector evaluate(ShaderGlobals shaderGlobals);

    float pdf(ShaderGlobals shaderGlobals);

    PVector sample(ShaderGlobals shaderGlobals, PVector sample);

}
