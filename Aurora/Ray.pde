class Ray {
  public PVector origin;
  public PVector direction;
  
  public Ray(){};
  public Ray(PVector origin, PVector direction){
      this.origin = origin;
      this.direction = direction;
  }
  
  public PVector intersectionPoint(float distance){    // esse nome ta melhor
      return PVector.add(origin, PVector.mult(direction, distance));
  }
}
