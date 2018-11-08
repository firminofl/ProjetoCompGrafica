public abstract class BSDF {

  public BSDF() {}

  abstract PVector evaluate(ShaderGlobals shaderGlobals);

  abstract float pdf(ShaderGlobals shaderGlobals);

  abstract PVector sample(ShaderGlobals shaderGlobals, PVector sample);
}
