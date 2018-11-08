public class Camera {
  public float fieldOfView;
  public Film film;
  public PMatrix3D worldMatrix;

  public Camera() {
    fieldOfView = -1;
    worldMatrix = null; 
  }

  public Camera(float fieldOfView, Film film, PMatrix3D worldMatrix) {
    this.fieldOfView = fieldOfView;
    this.film = film;
    this.worldMatrix = worldMatrix;
  }

  public void lookAt(PVector position, PVector target, PVector up) {
    PVector W = PVector.sub(position, target).normalize();
    PVector U = W.cross(up, W).normalize();
    PVector V = W.cross(W, U);

    worldMatrix = new PMatrix3D(U.x, V.x, W.x, position.x, 
      U.y, V.y, W.y, position.y, 
      U.z, V.z, W.z, position.z, 
      0, 0, 0, 1);
  }

  public void transform(PMatrix3D transformation) {
    worldMatrix.apply(transformation);
  }

  public Ray generateRay(float x, float y, PVector sample) {
    float Xndc = (x + 0.5) / film.width;
    float Yndc = (y + 0.5) / film.height;
    
    float Xscreen = 2 * Xndc - 1;
    float Yscreen = 1 - 2 * Yndc;
    
    float a = film.aspectRatio();    
    
    float d = tan(a / 2);

    float xc = film.aspectRatio() * (fieldOfView/2) * x;
    float yc = (fieldOfView/2) * y;

    PVector P = new PVector(xc, yc, -1);    
    PVector PL = new PVector(1, 1, 1);
    PL = worldMatrix.mult(P, PL); 

    PVector D = PVector.sub(PL, sample).normalize();

    return new Ray(P, D);
  }
}
