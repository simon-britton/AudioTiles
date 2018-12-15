class Button {
  float xpos, ypos, horizontal, vertical;
  color stroke, fill, textFill;
  ActionEvent e;
  String text;
  int textSize;
  
  Button(float xpos,float ypos, float horizontal, float vertical, color stroke, color fill, ActionEvent e, String text, color textFill, int textSize){
    this.xpos = xpos;
    this.ypos = ypos;
    this.horizontal = horizontal;
    this.vertical = vertical;
    this.stroke = stroke;
    this.fill = fill;
    this.textFill = textFill;
    this.e = e;
    this.text = text;
    this.textSize = textSize;
  }
  
  void display() {
    fill(fill);
    stroke(stroke);
    rect(xpos, ypos, horizontal, vertical, 5);
    fill(textFill);
    textSize(textSize);
    text(text, xpos, ypos+10);
    if(mouseX > xpos-horizontal/2 
        && mouseX < xpos+horizontal/2
        && mouseY > ypos-vertical/2
        && mouseY < ypos+vertical/2
        && mousePressed) {
          e.performTasks();
    }
  }
}
