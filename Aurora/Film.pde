public class Film {

  float width;
  float height;

  public Film() {
    width = 0;
    height = 0;
  }

  public Film(float width, float height) {
    this.width = width;
    this.height = height;
  }

  public float aspectRatio() {
    return width / height;
  }
}
