class ScreenChangeEvent implements ActionEvent {
  Screens newScreen;
  
  ScreenChangeEvent(Screens newScreen){
    this.newScreen = newScreen;
  }
  
  public void performTasks() {
    screen = newScreen;
  }
}
