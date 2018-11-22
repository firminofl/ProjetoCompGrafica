class Camera {
    public float fieldOfView;
    public Film film;
    public PMatrix3D worldMatrix;

    public Camera() {}

    public Camera(float fieldOfView, Film film, PMatrix3D worldMatrix) {
        this.fieldOfView = fieldOfView;
        this.film = film;
        this.worldMatrix = worldMatrix;
    }

    public void lookAt(PVector position, PVector target, PVector up) {
        PVector w = PVector.sub(position, target).normalize();
        PVector u = up.cross(w).normalize();
        PVector v = w.cross(u);

        worldMatrix = new PMatrix3D(u.x, v.x, w.x, position.x,
                                    u.y, v.y, w.y, position.y,
                                    u.z, v.z, w.z, position.z,
                                    0, 0, 0, 1);
    }

    public void transform(PMatrix3D transformation) {
        worldMatrix.apply(transformation);
    }

    public Ray generateRay(float x, float y, PVector sample) {
        float scale = tan(fieldOfView * 0.5);
        
        PVector pixel = new PVector(
            (2.0 * (x + 0.5 + sample.x) / film.width - 1.0) * scale * film.aspectRatio(),
            (1.0 - 2.0 * (y + 0.5 + sample.y) / film.height) * scale,
            -1.0
        );
        
        worldMatrix.mult(pixel, pixel);
        
        PVector origin = new PVector(worldMatrix.m03, worldMatrix.m13, worldMatrix.m23);
        
        return new Ray(origin, PVector.sub(pixel, origin).normalize());
    }

}
