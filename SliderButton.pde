class SliderButton {
  float xpos, ypos;
  float boxXpos = xpos+875;
  String text;
  
  SliderButton(float xpos, float ypos, String text) {
    this.xpos = xpos;
    this.ypos = ypos;
    this.text = text;
  }
  
  void display() {
    fill(0,0,0);
    stroke(0,0,0);
    rect(xpos, ypos, 750, 10);
    fill(0, 100, 100);
    rect(boxXpos, ypos, 20, 9);
    fill(0,0,0);
    textSize(15);
    textAlign(LEFT);
    text(text+": "+100*getValue(), xpos-375, ypos-15);
    if(mouseX < boxXpos+10
        && mouseX > boxXpos-10
        && mouseY < ypos+5
        && mouseY > ypos-5
        && mousePressed) {
          boxXpos = mouseX;
    }
    if(boxXpos < xpos-365) {
      boxXpos = xpos-365;
    }
    if(boxXpos > xpos+365) {
      boxXpos = xpos+365;
    }
  }
  
  float getValue() {
    return (boxXpos-(xpos-365))/(750-20);
  }
  
}
