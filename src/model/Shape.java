package model;

public interface Shape extends Light {

    boolean explicitLight = false;

    Scene scene = null;

    BSDF bSDF = null;

    Intersection intersects(Ray ray);

    ShaderGlobals calculateShaderGlobals(Ray ray, Intersection intersection);

    float surfaceArea();

}
