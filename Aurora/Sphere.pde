public class Sphere extends Shape {

  public PVector position;
  public float radius;

  public Sphere() {
    super();
    position = null;
    radius = -1;
  }

  public Sphere(PVector position, float radius, boolean explicitLight, PVector emissor) {
    this.position = position;
    this.radius = radius;
    this.explicitLight = explicitLight;
    this.emissor = emissor;
  }

  @Override
    public PVector evaluate(ShaderGlobals shaderGlobals) {
    return null;
  }

  @Override
    public float pdf(ShaderGlobals shaderGlobals) {
    return -1;
  }

  @Override
    public PVector sample(ShaderGlobals shaderGlobals, PVector sample) {
    return null;
  }

  @Override
    public Intersection intersects(Ray ray) {
    Intersection intersection = null;

    PVector L = position.cross(position, ray.origin);
    float tm = PVector.dot(L, ray.direction);

    if (tm >= 0) {
      intersection = new Intersection();
      intersection.hit = true;

      double d = Math.sqrt(PVector.dot(L, L) - Math.pow(tm, 2));
      double deltaT = Math.sqrt(Math.pow(radius, 2) - Math.pow(d, 2));
      double t0 = tm - deltaT;
      //double t1 = tm + deltaT;

      intersection.distance = (float)t0;
    }

    return intersection;
  }

  @Override
    public ShaderGlobals calculateShaderGlobals(Ray ray, Intersection intersection) {

    ShaderGlobals shaderGlobals = new ShaderGlobals();

    PVector P = PVector.add(ray.origin, PVector.mult(position, intersection.distance)); 
    shaderGlobals.normal = PVector.div(PVector.sub(P, position), PVector.dist(P, position)); 

    float teta = atan2(shaderGlobals.normal.x, shaderGlobals.normal.y);
    float fi = acos(shaderGlobals.normal.y);

    float Tx = cos(teta);
    float Ty = 0;
    float Tz = -sin(teta);
    shaderGlobals.tangentU = new PVector(Tx, Ty, Tz);

    float Bx = sin(teta)*cos(fi);
    float By = -sin(fi);
    float Bz = cos(teta)*cos(fi);
    shaderGlobals.tangentV = new PVector(Bx, By, Bz);

    float u = (float)(((teta/2*Math.PI) / Math.PI) + 1)/2;
    float v = (float)(((fi/Math.PI) /Math.PI) + 1)/2;

    shaderGlobals.uv = new PVector(u, v);
    shaderGlobals.viewDirection = PVector.mult(ray.direction, -1);

    return shaderGlobals;
  }

  @Override
    public float surfaceArea() {
    return (float) (4 * Math.PI * Math.pow(radius, 2));
  }

  @Override
    public void transform(PMatrix3D transformation) {
  }
}
