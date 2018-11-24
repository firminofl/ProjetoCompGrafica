abstract class Shape extends Light {
    public boolean explicitLight;
    public BSDF bsdf;
    
    public abstract Intersection intersects(Ray ray);
    public abstract ShaderGlobals calculateShaderGlobals(Ray ray, Intersection intersection);
    public abstract float surfaceArea();
}
