class Utils {
    public final float INVERSE_PI = 1.0/PI;
  
    public Utils() {}

    public PVector[] stratifiedSample(int samples) {
        int size = (int)sqrt(samples);
        PVector[] points = new PVector[samples];

        for (int i = 0; i < size; i++) {
            for (int j = 0; j < size; j++) {

                points[i*size + j] = PVector.add(uniformRandom2D(), 
                                                 new PVector(i, j)).div(size);
            }
        }

        return points;
    }

    public float uniformRandom1D() {
        return random(1.0);
    }

    public PVector uniformRandom2D() {
        return new PVector(uniformRandom1D(), uniformRandom1D());
    }

    public float gaussian1D(float sample, float width) {
        float radius = width * 0.5;
        return max(0, exp(-sample * sample) - exp(-radius * radius));
    }

    public float gaussian2D(PVector sample, float width) {
        return gaussian1D(sample.x, width) * gaussian1D(sample.y, width);
    }

    public PVector saturate(PVector colour) {
        return new PVector(constrain(colour.x, 0, 1.0), 
                           constrain(colour.y, 0, 1.0), 
                           constrain(colour.z, 0, 1.0));
    }

    public PVector gamma(PVector colour, float value) {
        float t = 1.0/value;
        return new PVector(pow(colour.x, t), pow(colour.y, t), pow(colour.z, t));
    }

    public PVector exposure(PVector colour, float value) {
        float t = pow(2.0, value);
        return new PVector(colour.x * t, colour.y * t, colour.z * t);
    }

    public PVector multiplyColor(PVector a, PVector b) {
        return new PVector(a.x * b.x, a.y * b.y, a.z * b.z);
    }

}
