public abstract class Light {

  public PVector emissor;

  public Light() {
    emissor = null;
  }

  public Light(PVector emissor) {
    this.emissor = emissor;
  }

  abstract PVector evaluate(ShaderGlobals shaderGlobals);

  abstract float pdf(ShaderGlobals shaderGlobals);

  abstract PVector sample(ShaderGlobals shaderGlobals, PVector sample);
}
