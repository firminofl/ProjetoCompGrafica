public abstract class Shape extends Light {

  PMatrix3D worldMatrix;
  BSDF bsdf;
  boolean explicitLight;

  public Shape() {
    super();
    worldMatrix = null;
    bsdf = null;
    explicitLight = false;
  }

  public Shape(PMatrix3D worldMatrix, BSDF bsdf, boolean explicitLight) {
    this.worldMatrix = worldMatrix;
    this.bsdf = bsdf;
    this.explicitLight = explicitLight;
  }

  abstract Intersection intersects(Ray ray);

  abstract ShaderGlobals calculateShaderGlobals(Ray ray, Intersection intersection);

  abstract float surfaceArea();

  abstract void transform(PMatrix3D transformation);
}
