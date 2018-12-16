class StartMetronome implements ActionEvent {  
  StartMetronome(){
  }
  
  public void performTasks() {
    Pattern pat = Pattern.compile("^\\d+$");
    Matcher m = pat.matcher(bpmInput.Text);
    Matcher m2 = pat.matcher(timeSig.Text.split("/")[0]);
    Matcher m3 = pat.matcher(divisionsInput.Text);
    if(m.matches()&&m2.matches()&&m3.matches()){
       divisions = Integer.parseInt(divisionsInput.Text);
       bpm =Integer.parseInt(bpmInput.Text);
       accents=Integer.parseInt(timeSig.Text.split("/")[0]);
       startTime = System.currentTimeMillis();
       metronomeRunning=true;
    }else{
      println("Invalid Input");
    }
  }
  public void startMetronome(){
    
  }
}
