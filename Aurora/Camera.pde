public class Camera {

  public float fieldOfView;

  public PMatrix3D worldMatrix;

  private Film film;

  public Camera() {

  }

  public Camera(float fieldOfView, Film film, PMatrix3D worldMatrix) {
    this.fieldOfView = fieldOfView;
    this.worldMatrix = worldMatrix;

  }

  public void lookAt(PVector position, PVector target, PVector up) {
    PVector distance_of_pf_points = position.sub(target);
    PVector w = distance_of_pf_points.div(distance_of_pf_points.mag());
    PVector vetor_w = up.cross(w);
    PVector u = vetor_w.div(vetor_w.mag());
    PVector v = w.cross(u);

    worldMatrix = new PMatrix3D(u.x, v.x, w.x, position.x,
                                u.y, v.y, w.y, position.y,
                                u.z, v.z, w.z, position.z,
                                0,     0,   0,         1);

  }

  public void transform(PMatrix3D transformation) {

  }

  public Ray generateRay(float x, float y, PVector sample) {
    return null;
  }

}
