class Renderer {
    public Utils utils;
    public RenderOptions options;
    public Camera camera;
    public Scene scene;
    
    public Renderer() {}

    public Renderer(RenderOptions options, Camera camera, Scene scene) {
        this.options = options;
        this.camera = camera;
        this.scene = scene;
        this.utils = new Utils();
    }

    public PVector computeDirectIllumination(BSDF bsdf, ShaderGlobals shaderGlobals) {
        PVector directIllumination = new PVector(0, 0, 0);

        for (int i = 0; i < scene.shapes.size(); i++) {
            Shape light = scene.shapes.get(i);

            if (light.explicitLight) {
                shaderGlobals.lightDirection = PVector.sub(((Sphere)light).position, shaderGlobals.point).normalize();
                Ray ray = new Ray(shaderGlobals.point, shaderGlobals.lightDirection);

                Intersection intersection = scene.intersects(ray);
                if (intersection.hit && intersection.index == i) {
                    float cosine = shaderGlobals.normal.dot(shaderGlobals.lightDirection);
                    PVector bsdfValue = bsdf.evaluate(shaderGlobals);
                    PVector lightIntensity = PVector.mult(light.evaluate(shaderGlobals), 1);
                    
                    directIllumination.add(utils.multiplyColor(bsdfValue.mult(cosine), lightIntensity));
                }
            }
        }

        return directIllumination;
    }

    public PVector computeIndirectIllumination(BSDF bsdf, ShaderGlobals shaderGlobals) {
        // TODO
        return new PVector();
    }

    public PVector trace(Ray ray, int depth) {
        Intersection intersection = scene.intersects(ray);

        if (intersection.hit) {
            Shape shape = scene.shapes.get(intersection.index);
            ShaderGlobals shaderGlobals = shape.calculateShaderGlobals(ray, intersection);

            // se interceptou uma luz, retorna a luz
            if (shape.explicitLight) return shape.evaluate(shaderGlobals);
            // senão, calcula a iluminação direta no objeto
            return computeDirectIllumination(shape.bsdf, shaderGlobals);
        }

        return new PVector(0, 0, 0);
    }

    public PImage render() {
        PImage image = createImage(width, height, RGB);
        
        for (int i = 0; i < width; i++) {
            for (int j = 0; j < height; j++) {
                PVector[] samples = utils.stratifiedSample(options.cameraSamples);
                
                PVector pColor = new PVector(0, 0, 0);
                float totalWeight = 0;
                
                for (int k = 0; k < options.cameraSamples; k++) {
                    PVector sample = PVector.sub(samples[k], new PVector(0.5, 0.5)).mult(options.filterWidth);
                    Ray ray = camera.generateRay(i, j, sample);
                    float weight = utils.gaussian2D(sample, options.filterWidth);
                    
                    pColor.add(PVector.mult(trace(ray, 0), weight));
                    totalWeight += weight;
                }
                
                pColor.div(totalWeight);
                pColor = utils.saturate(utils.gamma(utils.exposure(pColor, options.exposure), options.gamma)).mult(255.0);

                image.set(i, j, color(pColor.x, pColor.y, pColor.z));
            }
        }
        
        return image;
    }

}
