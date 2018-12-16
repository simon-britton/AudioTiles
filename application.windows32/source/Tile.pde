class Tile {
  float xpos, ypos, horizontal, vertical;
  color stroke, fill, textFill;
  String text;
  int textSize;
  boolean enabled;
  SoundFile file;

  Tile(float xpos, float ypos, float horizontal, float vertical, color stroke, color fill, String text, color textFill, int textSize, SoundFile file) {
    this.xpos = xpos;
    this.ypos = ypos;
    this.horizontal = horizontal;
    this.vertical = vertical;
    this.stroke = stroke;
    this.fill = fill;
    this.textFill = textFill;
    this.text = text;
    this.textSize = textSize;
    this.file = file;
    enabled = false;
  }

  void display() {
    if (enabled) {
      fill(GREEN);
    } else {
      fill(fill);
    }
    stroke(stroke);
    rect(xpos, ypos, horizontal, vertical, 5);
    fill(textFill);
    textSize(textSize);
    text(text, xpos, ypos+10);
    if (mouseX > xpos-horizontal/2 
      && mouseX < xpos+horizontal/2
      && mouseY > ypos-vertical/2
      && mouseY < ypos+vertical/2
      && mousePressed) {
      enabled = !enabled;
      mousePressed = false;
    }
  }
  
  void play(){
    file.play();
  }
  void stop(){
    file.stop();
  }
  
  boolean isEnabled(){
    return enabled;
  }
}
