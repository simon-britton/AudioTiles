import processing.sound.*;

SoundFile                                         A0, Bb0, B0, 
          C1, Db1, D1, Eb1, E1, F1, Gb1, G1, Ab1, A1, Bb1, B1,
          C2, Db2, D2, Eb2, E2, F2, Gb2, G2, Ab2, A2, Bb2, B2,
          C3, Db3, D3, Eb3, E3, F3, Gb3, G3, Ab3, A3, Bb3, B3,
          C4, Db4, D4, Eb4, E4, F4, Gb4, G4, Ab4, A4, Bb4, B4,
          C5, Db5, D5, Eb5, E5, F5, Gb5, G5, Ab5, A5, Bb5, B5,
          C6, Db6, D6, Eb6, E6, F6, Gb6, G6, Ab6, A6, Bb6, B6,
          C7, Db7, D7, Eb7, E7, F7, Gb7, G7, Ab7, A7, Bb7, B7,
          C8;
         
          
color BLACK, WHITE, LAVENDER, GREEN;

enum Screens { 
  STARTUP,
  MENU,
  SETTINGS,
  TUNER,
  METRONOME,
  MATRIX;
}

Screens screen;
Button menu, settings, tuner, metronome, matrix; 

void setup(){
  size(1000,618);
  colorMode(HSB, 360, 100, 100);
  rectMode(CENTER);
  textAlign(CENTER);

  Ab1 = new SoundFile(this, "Piano.ff.Ab1.aiff");
  Ab2 = new SoundFile(this, "Piano.ff.Ab2.aiff");
  Ab3 = new SoundFile(this, "Piano.ff.Ab3.aiff");
  Ab4 = new SoundFile(this, "Piano.ff.Ab4.aiff");
  Ab5 = new SoundFile(this, "Piano.ff.Ab5.aiff");
  Ab6 = new SoundFile(this, "Piano.ff.Ab6.aiff");
  Ab7 = new SoundFile(this, "Piano.ff.Ab7.aiff");
  
  A0 = new SoundFile(this, "Piano.ff.A0.aiff");
  A1 = new SoundFile(this, "Piano.ff.A1.aiff");
  A2 = new SoundFile(this, "Piano.ff.A2.aiff");
  A3 = new SoundFile(this, "Piano.ff.A3.aiff");
  A4 = new SoundFile(this, "Piano.ff.A4.aiff");
  A5 = new SoundFile(this, "Piano.ff.A5.aiff");
  A6 = new SoundFile(this, "Piano.ff.A6.aiff");
  A7 = new SoundFile(this, "Piano.ff.A7.aiff");
  
  Bb0 = new SoundFile(this, "Piano.ff.Bb0.aiff");
  Bb1 = new SoundFile(this, "Piano.ff.Bb1.aiff");
  Bb2 = new SoundFile(this, "Piano.ff.Bb2.aiff");
  Bb3 = new SoundFile(this, "Piano.ff.Bb3.aiff");
  Bb4 = new SoundFile(this, "Piano.ff.Bb4.aiff");
  Bb5 = new SoundFile(this, "Piano.ff.Bb5.aiff");
  Bb6 = new SoundFile(this, "Piano.ff.Bb6.aiff");
  Bb7 = new SoundFile(this, "Piano.ff.Bb7.aiff");
  
  B0 = new SoundFile(this, "Piano.ff.B0.aiff");
  B1 = new SoundFile(this, "Piano.ff.B1.aiff");
  B2 = new SoundFile(this, "Piano.ff.B2.aiff");
  B3 = new SoundFile(this, "Piano.ff.B3.aiff");
  B4 = new SoundFile(this, "Piano.ff.B4.aiff");
  B5 = new SoundFile(this, "Piano.ff.B5.aiff");
  B6 = new SoundFile(this, "Piano.ff.B6.aiff");
  B7 = new SoundFile(this, "Piano.ff.B7.aiff");
  
  C1 = new SoundFile(this, "Piano.ff.C1.aiff");
  C2 = new SoundFile(this, "Piano.ff.C2.aiff");
  C3 = new SoundFile(this, "Piano.ff.C3.aiff");
  C4 = new SoundFile(this, "Piano.ff.C4.aiff");
  C5 = new SoundFile(this, "Piano.ff.C5.aiff");
  C6 = new SoundFile(this, "Piano.ff.C6.aiff");
  C7 = new SoundFile(this, "Piano.ff.C7.aiff");
  C8 = new SoundFile(this, "Piano.ff.C8.aiff");
  
  Db1 = new SoundFile(this, "Piano.ff.Db1.aiff");
  Db2 = new SoundFile(this, "Piano.ff.Db2.aiff");
  Db3 = new SoundFile(this, "Piano.ff.Db3.aiff");
  Db4 = new SoundFile(this, "Piano.ff.Db4.aiff");
  Db5 = new SoundFile(this, "Piano.ff.Db5.aiff");
  Db6 = new SoundFile(this, "Piano.ff.Db6.aiff");
  Db7 = new SoundFile(this, "Piano.ff.Db7.aiff");
  
  D1 = new SoundFile(this, "Piano.ff.D1.aiff");
  D2 = new SoundFile(this, "Piano.ff.D2.aiff");
  D3 = new SoundFile(this, "Piano.ff.D3.aiff");
  D4 = new SoundFile(this, "Piano.ff.D4.aiff");
  D5 = new SoundFile(this, "Piano.ff.D5.aiff");
  D6 = new SoundFile(this, "Piano.ff.D6.aiff");
  D7 = new SoundFile(this, "Piano.ff.D7.aiff");
  
  Eb1 = new SoundFile(this, "Piano.ff.Eb1.aiff");
  Eb2 = new SoundFile(this, "Piano.ff.Eb2.aiff");
  Eb3 = new SoundFile(this, "Piano.ff.Eb3.aiff");
  Eb4 = new SoundFile(this, "Piano.ff.Eb4.aiff");
  Eb5 = new SoundFile(this, "Piano.ff.Eb5.aiff");
  Eb6 = new SoundFile(this, "Piano.ff.Eb6.aiff");
  Eb7 = new SoundFile(this, "Piano.ff.Eb7.aiff");
  
  E1 = new SoundFile(this, "Piano.ff.E1.aiff");
  E2 = new SoundFile(this, "Piano.ff.E2.aiff");
  E3 = new SoundFile(this, "Piano.ff.E3.aiff");
  E4 = new SoundFile(this, "Piano.ff.E4.aiff");
  E5 = new SoundFile(this, "Piano.ff.E5.aiff");
  E6 = new SoundFile(this, "Piano.ff.E6.aiff");
  E7 = new SoundFile(this, "Piano.ff.E7.aiff");

  F1 = new SoundFile(this, "Piano.ff.F1.aiff");
  F2 = new SoundFile(this, "Piano.ff.F2.aiff");
  F3 = new SoundFile(this, "Piano.ff.F3.aiff");
  F4 = new SoundFile(this, "Piano.ff.F4.aiff");
  F5 = new SoundFile(this, "Piano.ff.F5.aiff");
  F6 = new SoundFile(this, "Piano.ff.F6.aiff");
  F7 = new SoundFile(this, "Piano.ff.F7.aiff");
  
  Gb1 = new SoundFile(this, "Piano.ff.Gb1.aiff");
  Gb2 = new SoundFile(this, "Piano.ff.Gb2.aiff");
  Gb3 = new SoundFile(this, "Piano.ff.Gb3.aiff");
  Gb4 = new SoundFile(this, "Piano.ff.Gb4.aiff");
  Gb5 = new SoundFile(this, "Piano.ff.Gb5.aiff");
  Gb6 = new SoundFile(this, "Piano.ff.Gb6.aiff");
  Gb7 = new SoundFile(this, "Piano.ff.Gb7.aiff");
  
  G1 = new SoundFile(this, "Piano.ff.G1.aiff");
  G2 = new SoundFile(this, "Piano.ff.G2.aiff");
  G3 = new SoundFile(this, "Piano.ff.G3.aiff");
  G4 = new SoundFile(this, "Piano.ff.G4.aiff");
  G5 = new SoundFile(this, "Piano.ff.G5.aiff");
  G6 = new SoundFile(this, "Piano.ff.G6.aiff");
  G7 = new SoundFile(this, "Piano.ff.G7.aiff");
  
  BLACK = color(0,0,0);
  WHITE = color(0,0,100);
  LAVENDER = color(275, 50, 70);
  GREEN = color(120, 40, 100);
  
  settings = new Button(width/2, height/5, 200, 100, BLACK, GREEN, new ScreenChangeEvent(Screens.SETTINGS), "Settings", BLACK, 30);
  tuner = new Button(width/2, 2*height/5, 200, 100, BLACK, GREEN, new ScreenChangeEvent(Screens.TUNER), "Tuner", BLACK, 30);
  metronome = new Button(width/2, 3*height/5, 200, 100, BLACK, GREEN, new ScreenChangeEvent(Screens.METRONOME), "Metronome", BLACK, 30);
  matrix = new Button(width/2, 4*height/5, 200, 100, BLACK, GREEN, new ScreenChangeEvent(Screens.MATRIX), "Matrix", BLACK, 30);
  
  screen = Screens.STARTUP;
}

void draw(){
  switch(screen){
    case STARTUP:
      background(LAVENDER);
      fill(0,0,100);
      textSize(50);
      text("Welcome to AudioTiles v.0.0.1!", width/2, 150);
      textSize(20);
      text("by Blake Bruell, DJ Nelson, and Simon Britton", width/2, 200);
      fill(frameCount%360, 100, 100);
      textSize(35);
      text("PRESS TO START", width/2, 400);
      if(mousePressed) {
        screen = Screens.MENU;
      }
      break;
     case MENU:
       background(LAVENDER);
       settings.display();
       tuner.display();
       metronome.display();
       matrix.display();
       break;
     case SETTINGS:
       break;
     case TUNER:
       break;
     case METRONOME:
       break;
     case MATRIX:
       break;
  }
}
