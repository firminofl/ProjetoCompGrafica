class Sphere extends Shape {
    public PVector position;
    public float radius;

    public Sphere() {}
    
    public Sphere(PVector position, float radius, BSDF bsdf, boolean explicitLight, PVector emission){
        this.position = position;
        this.radius = radius;
        this.bsdf = bsdf;
        this.explicitLight = explicitLight;
        this.emission = emission;
    }
    
    @Override
    public Intersection intersects(Ray ray) {
        PVector d = PVector.sub(position, ray.origin);
        float t = d.dot(ray.direction);
        
        if (t < 0) return new Intersection();
        
        float d2 = d.dot(d) - t * t;
        float r2 = radius * radius;
        
        if (d2 > r2) return new Intersection();
        return new Intersection(true, t - sqrt(r2 - d2), -1);
    }
    
    @Override
    public ShaderGlobals calculateShaderGlobals(Ray ray, Intersection intersection) {
        PVector point = ray.intersectionPoint(intersection.distance);
        PVector normal = PVector.sub(point, position).normalize();
        
        float theta = atan2(normal.x, normal.z);
        float phi = acos(normal.y);
        
        Utils utils = new Utils();
        
        PVector uv = new PVector((theta * utils.INVERSE_PI + 1.0) * 0.5, phi * utils.INVERSE_PI);
        
        float st = sin(theta);
        float sp = sin(phi);
        float ct = cos(theta);
        float cp = cos(phi);
        
        PVector tangentU = new PVector(ct, 0, -st);
        PVector tangentV = new PVector(st * cp, -sp, ct * cp);
        
        PVector viewDirection = PVector.mult(ray.direction, -1.0);
        
        return new ShaderGlobals(point, normal, uv, tangentU, tangentV, viewDirection, null, null, null);
    }
    
    @Override
    public float surfaceArea() {
        return 4.0 * PI * radius * radius;
    }

    @Override
    public PVector evaluate(ShaderGlobals sg) {
        return emission;
    }
    
    @Override
    public float pdf(ShaderGlobals shaderglobals) {
        return 0;
    }
    
    @Override
    public PVector sample(ShaderGlobals shaderglobals, PVector sample) {
        return new PVector();
    }

}
