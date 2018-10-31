public class Camera {

  public float fieldOfView;

  public PMatrix3D worldMatrix;

  private Film film;

  public Camera() {

  }

  public Camera(float fieldOfView, Film film, PMatrix3D worldMatrix) {

  }

  public void lookAt(PVector position, PVector target, PVector up) {

  }

  public void transform(PMatrix3D transformation) {

  }

  public Ray generateRay(float x, float y, PVector sample) {
    return null;
  }

}
