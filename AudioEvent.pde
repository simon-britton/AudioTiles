class AudioEvent implements ActionEvent {
  SoundFile file;
  
  AudioEvent(SoundFile file){
    this.file = file;
  }
  
  public void performTasks(){
    file.play();
  }
}
