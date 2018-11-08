public class Renderer {

  public RenderOptions options;
  public Camera camera;
  public Scene scene;

  public Renderer() {
  }

  public Renderer(RenderOptions options, Camera camera, Scene scene) {
    this.options = options;
    this.camera = camera;
    this.scene = scene;
  }

  public PVector computeDirectIlumination(BSDF bsdf, ShaderGlobals shaderGlobals) {
    return null;
  }

  public PVector computeIndirectIlumination(BSDF bsdf, ShaderGlobals shaderGlobals, int depth) {
    return null;
  }

  public PVector trace(Ray ray, int depth) {
    Intersection intersection = scene.intersects(ray);

    if (intersection.hit) {
      return new PVector(1.0, 1.0, 1.0);
    }
    return new PVector(0, 0, 0);
  }

  public PImage render() {
    PImage image = createImage(options.width, options.height, RGB);
    
    for (int i = 0; i < options.width - 1; i++) {
      for (int j = 0; j < options.height - 1; i++) {
        PVector[] cameraSamples = stratifiedSample(options.cameraSamples);

        PVector colorP = new PVector(0, 0, 0);
        float totalWeight = 0;

        PVector point = new PVector(0.5, 0.5);

        for (int k = 0; k < options.cameraSamples -1; k++) {
          PVector sample = PVector.mult((PVector.sub(cameraSamples[k], point)), options.filterWidth);
          Ray ray = camera.generateRay(i, j, sample);
          float weight = gaussian2D(sample, options.filterWidth);

          colorP = PVector.add(colorP, PVector.mult(trace(ray, 0), weight));

          totalWeight += weight;
        }
        
        colorP = PVector.div(colorP, totalWeight); 
       
        image.set(saturate(exposure(gamma(colorP,options.gammaValue));
      }
    }


    return null;
  }
  

  
}
