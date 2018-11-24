public class Diffuse extends BSDF {
    public PVector albedo;
    private Utils utils;

    public Diffuse() {}
    public Diffuse(PVector albedo) {
        this.albedo = albedo;
        utils = new Utils();
    }

    @Override
    public PVector evaluate(ShaderGlobals shaderGlobals) {
        return PVector.mult(albedo, utils.INVERSE_PI);
    }

    @Override
    public float pdf(ShaderGlobals shaderGlobals) {
        return 0;
    }

    @Override
    public PVector sample(ShaderGlobals shaderGlobals, PVector sample) {
        return null;
    }

}