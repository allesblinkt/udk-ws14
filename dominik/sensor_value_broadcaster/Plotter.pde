class SignalPlotter {
  float storage[];
  int pointer = 0;

  color strokeColor = color(255);
  color guideColor = color(50);

  /** Constructor. Accepts the capacity of the plotter */
  SignalPlotter(int theCapacity) {
    storage = new float[theCapacity];   // make room
  }

  /** Puts a new value in storage */
  void put(float theValue) {
    pointer = (pointer + 1) % storage.length;  // what's the next slot?
    storage[pointer] = theValue;  // store
  }

  /** Draws the plotter */
  void draw(float theX, float theY, float theWidth, float theHeight) {
    noFill();

    stroke(guideColor);
    line(theX, theY, theX + theWidth, theY);
    line(theX, theY + theHeight, theX + theWidth, theY + theHeight);
    line(theX, theY + theHeight * 0.5, theX + theWidth, theY + theHeight * 0.5);

    stroke(strokeColor);
    beginShape();
    for (int i = 0; i < storage.length; i++) {
      int index = (i + pointer + 1) % storage.length;  // start at the current and wrap around...
      float value = storage[index];
      float x = theX + map(i, 0, storage.length - 1, 0, theWidth);
      float y = theY + map(value, -1, 1, theHeight, 0);

      vertex(x, y);
    }
    endShape();
  }
}

