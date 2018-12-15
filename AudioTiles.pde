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
          
Button                                            a0, bb0, b0, 
          c1, db1, d1, eb1, e1, f1, gb1, g1, ab1, a1, bb1, b1,
          c2, db2, d2, eb2, e2, f2, gb2, g2, ab2, a2, bb2, b2,
          c3, db3, d3, eb3, e3, f3, gb3, g3, ab3, a3, bb3, b3,
          c4, db4, d4, eb4, e4, f4, gb4, g4, ab4, a4, bb4, b4,
          c5, db5, d5, eb5, e5, f5, gb5, g5, ab5, a5, bb5, b5,
          c6, db6, d6, eb6, e6, f6, gb6, g6, ab6, a6, bb6, b6,
          c7, db7, d7, eb7, e7, f7, gb7, g7, ab7, a7, bb7, b7,
          c8;
         
TripleArray search;

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
Button menu, settings, tuner, metronome, matrix, currentButton; 

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
  
  ab1 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Ab1), "Ab1", BLACK, 30);
  ab2 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Ab2), "Ab2", BLACK, 30);
  ab3 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Ab3), "Ab3", BLACK, 30);
  ab4 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Ab4), "Ab4", BLACK, 30);
  ab5 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Ab5), "Ab5", BLACK, 30);
  ab6 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Ab6), "Ab6", BLACK, 30);
  ab7 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Ab7), "Ab7", BLACK, 30);
  
  A0 = new SoundFile(this, "Piano.ff.A0.aiff");
  A1 = new SoundFile(this, "Piano.ff.A1.aiff");
  A2 = new SoundFile(this, "Piano.ff.A2.aiff");
  A3 = new SoundFile(this, "Piano.ff.A3.aiff");
  A4 = new SoundFile(this, "Piano.ff.A4.aiff");
  A5 = new SoundFile(this, "Piano.ff.A5.aiff");
  A6 = new SoundFile(this, "Piano.ff.A6.aiff");
  A7 = new SoundFile(this, "Piano.ff.A7.aiff");
  
  a0 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(A0), "A0", BLACK, 30);
  a1 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(A1), "A1", BLACK, 30);
  a2 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(A2), "A2", BLACK, 30);
  a3 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(A3), "A3", BLACK, 30);
  a4 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(A4), "A4", BLACK, 30);
  a5 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(A5), "A5", BLACK, 30);
  a6 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(A6), "A6", BLACK, 30);
  a7 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(A7), "A7", BLACK, 30);
  
  Bb0 = new SoundFile(this, "Piano.ff.Bb0.aiff");
  Bb1 = new SoundFile(this, "Piano.ff.Bb1.aiff");
  Bb2 = new SoundFile(this, "Piano.ff.Bb2.aiff");
  Bb3 = new SoundFile(this, "Piano.ff.Bb3.aiff");
  Bb4 = new SoundFile(this, "Piano.ff.Bb4.aiff");
  Bb5 = new SoundFile(this, "Piano.ff.Bb5.aiff");
  Bb6 = new SoundFile(this, "Piano.ff.Bb6.aiff");
  Bb7 = new SoundFile(this, "Piano.ff.Bb7.aiff");
  
  bb0 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Bb1), "Bb0", BLACK, 30);
  bb1 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Bb1), "Bb1", BLACK, 30);
  bb2 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Bb2), "Bb2", BLACK, 30);
  bb3 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Bb3), "Bb3", BLACK, 30);
  bb4 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Bb4), "Bb4", BLACK, 30);
  bb5 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Bb5), "Bb5", BLACK, 30);
  bb6 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Bb6), "Bb6", BLACK, 30);
  bb7 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Bb7), "Bb7", BLACK, 30);
  
  B0 = new SoundFile(this, "Piano.ff.B0.aiff");
  B1 = new SoundFile(this, "Piano.ff.B1.aiff");
  B2 = new SoundFile(this, "Piano.ff.B2.aiff");
  B3 = new SoundFile(this, "Piano.ff.B3.aiff");
  B4 = new SoundFile(this, "Piano.ff.B4.aiff");
  B5 = new SoundFile(this, "Piano.ff.B5.aiff");
  B6 = new SoundFile(this, "Piano.ff.B6.aiff");
  B7 = new SoundFile(this, "Piano.ff.B7.aiff");
  
  b0 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(B1), "B0", BLACK, 30);
  b1 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(B1), "B1", BLACK, 30);
  b2 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(B2), "B2", BLACK, 30);
  b3 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(B3), "B3", BLACK, 30);
  b4 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(B4), "B4", BLACK, 30);
  b5 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(B5), "B5", BLACK, 30);
  b6 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(B6), "B6", BLACK, 30);
  b7 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(B7), "B7", BLACK, 30);
  
  C1 = new SoundFile(this, "Piano.ff.C1.aiff");
  C2 = new SoundFile(this, "Piano.ff.C2.aiff");
  C3 = new SoundFile(this, "Piano.ff.C3.aiff");
  C4 = new SoundFile(this, "Piano.ff.C4.aiff");
  C5 = new SoundFile(this, "Piano.ff.C5.aiff");
  C6 = new SoundFile(this, "Piano.ff.C6.aiff");
  C7 = new SoundFile(this, "Piano.ff.C7.aiff");
  C8 = new SoundFile(this, "Piano.ff.C8.aiff");
  
  c1 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(C1), "C1", BLACK, 30);
  c2 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(C2), "C2", BLACK, 30);
  c3 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(C3), "C3", BLACK, 30);
  c4 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(C4), "C4", BLACK, 30);
  c5 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(C5), "C5", BLACK, 30);
  c6 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(C6), "C6", BLACK, 30);
  c7 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(C7), "C7", BLACK, 30);
  c8 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(C8), "C8", BLACK, 30);
  
  Db1 = new SoundFile(this, "Piano.ff.Db1.aiff");
  Db2 = new SoundFile(this, "Piano.ff.Db2.aiff");
  Db3 = new SoundFile(this, "Piano.ff.Db3.aiff");
  Db4 = new SoundFile(this, "Piano.ff.Db4.aiff");
  Db5 = new SoundFile(this, "Piano.ff.Db5.aiff");
  Db6 = new SoundFile(this, "Piano.ff.Db6.aiff");
  Db7 = new SoundFile(this, "Piano.ff.Db7.aiff");
  
  db1 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Db1), "Db1", BLACK, 30);
  db2 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Db2), "Db2", BLACK, 30);
  db3 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Db3), "Db3", BLACK, 30);
  db4 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Db4), "Db4", BLACK, 30);
  db5 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Db5), "Db5", BLACK, 30);
  db6 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Db6), "Db6", BLACK, 30);
  db7 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Db7), "Db7", BLACK, 30);
  
  D1 = new SoundFile(this, "Piano.ff.D1.aiff");
  D2 = new SoundFile(this, "Piano.ff.D2.aiff");
  D3 = new SoundFile(this, "Piano.ff.D3.aiff");
  D4 = new SoundFile(this, "Piano.ff.D4.aiff");
  D5 = new SoundFile(this, "Piano.ff.D5.aiff");
  D6 = new SoundFile(this, "Piano.ff.D6.aiff");
  D7 = new SoundFile(this, "Piano.ff.D7.aiff");
  
  d1 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(D1), "D1", BLACK, 30);
  d2 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(D2), "D2", BLACK, 30);
  d3 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(D3), "D3", BLACK, 30);
  d4 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(D4), "D4", BLACK, 30);
  d5 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(D5), "D5", BLACK, 30);
  d6 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(D6), "D6", BLACK, 30);
  d7 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(D7), "D7", BLACK, 30);
  
  Eb1 = new SoundFile(this, "Piano.ff.Eb1.aiff");
  Eb2 = new SoundFile(this, "Piano.ff.Eb2.aiff");
  Eb3 = new SoundFile(this, "Piano.ff.Eb3.aiff");
  Eb4 = new SoundFile(this, "Piano.ff.Eb4.aiff");
  Eb5 = new SoundFile(this, "Piano.ff.Eb5.aiff");
  Eb6 = new SoundFile(this, "Piano.ff.Eb6.aiff");
  Eb7 = new SoundFile(this, "Piano.ff.Eb7.aiff");
  
  eb1 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Eb1), "Eb1", BLACK, 30);
  eb2 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Eb2), "Eb2", BLACK, 30);
  eb3 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Eb3), "Eb3", BLACK, 30);
  eb4 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Eb4), "Eb4", BLACK, 30);
  eb5 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Eb5), "Eb5", BLACK, 30);
  eb6 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Eb6), "Eb6", BLACK, 30);
  eb7 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Eb7), "Eb7", BLACK, 30);
  
  E1 = new SoundFile(this, "Piano.ff.E1.aiff");
  E2 = new SoundFile(this, "Piano.ff.E2.aiff");
  E3 = new SoundFile(this, "Piano.ff.E3.aiff");
  E4 = new SoundFile(this, "Piano.ff.E4.aiff");
  E5 = new SoundFile(this, "Piano.ff.E5.aiff");
  E6 = new SoundFile(this, "Piano.ff.E6.aiff");
  E7 = new SoundFile(this, "Piano.ff.E7.aiff");
  
  e1 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(E1), "E1", BLACK, 30);
  e2 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(E2), "E2", BLACK, 30);
  e3 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(E3), "E3", BLACK, 30);
  e4 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(E4), "E4", BLACK, 30);
  e5 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(E5), "E5", BLACK, 30);
  e6 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(E6), "E6", BLACK, 30);
  e7 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(E7), "E7", BLACK, 30);

  F1 = new SoundFile(this, "Piano.ff.F1.aiff");
  F2 = new SoundFile(this, "Piano.ff.F2.aiff");
  F3 = new SoundFile(this, "Piano.ff.F3.aiff");
  F4 = new SoundFile(this, "Piano.ff.F4.aiff");
  F5 = new SoundFile(this, "Piano.ff.F5.aiff");
  F6 = new SoundFile(this, "Piano.ff.F6.aiff");
  F7 = new SoundFile(this, "Piano.ff.F7.aiff");
  
  f1 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(F1), "F1", BLACK, 30);
  f2 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(F2), "F2", BLACK, 30);
  f3 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(F3), "F3", BLACK, 30);
  f4 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(F4), "F4", BLACK, 30);
  f5 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(F5), "F5", BLACK, 30);
  f6 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(F6), "F6", BLACK, 30);
  f7 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(F7), "F7", BLACK, 30);
  
  Gb1 = new SoundFile(this, "Piano.ff.Gb1.aiff");
  Gb2 = new SoundFile(this, "Piano.ff.Gb2.aiff");
  Gb3 = new SoundFile(this, "Piano.ff.Gb3.aiff");
  Gb4 = new SoundFile(this, "Piano.ff.Gb4.aiff");
  Gb5 = new SoundFile(this, "Piano.ff.Gb5.aiff");
  Gb6 = new SoundFile(this, "Piano.ff.Gb6.aiff");
  Gb7 = new SoundFile(this, "Piano.ff.Gb7.aiff");
  
  gb1 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Gb1), "Gb1", BLACK, 30);
  gb2 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Gb2), "Gb2", BLACK, 30);
  gb3 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Gb3), "Gb3", BLACK, 30);
  gb4 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Gb4), "Gb4", BLACK, 30);
  gb5 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Gb5), "Gb5", BLACK, 30);
  gb6 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Gb6), "Gb6", BLACK, 30);
  gb7 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Gb7), "Gb7", BLACK, 30);
  
  G1 = new SoundFile(this, "Piano.ff.G1.aiff");
  G2 = new SoundFile(this, "Piano.ff.G2.aiff");
  G3 = new SoundFile(this, "Piano.ff.G3.aiff");
  G4 = new SoundFile(this, "Piano.ff.G4.aiff");
  G5 = new SoundFile(this, "Piano.ff.G5.aiff");
  G6 = new SoundFile(this, "Piano.ff.G6.aiff");
  G7 = new SoundFile(this, "Piano.ff.G7.aiff");
  
  g1 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(G1), "G1", BLACK, 30);
  g2 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(G2), "G2", BLACK, 30);
  g3 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(G3), "G3", BLACK, 30);
  g4 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(G4), "G4", BLACK, 30);
  g5 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(G5), "G5", BLACK, 30);
  g6 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(G6), "G6", BLACK, 30);
  g7 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(G7), "G7", BLACK, 30);
   
  BLACK = color(0,0,0);
  WHITE = color(0,0,100);
  LAVENDER = color(275, 50, 70);
  GREEN = color(120, 40, 100);
  
  settings = new Button(width/2, height/5, 200, 100, BLACK, GREEN, new ScreenChangeEvent(Screens.SETTINGS), "Settings", BLACK, 30);
  tuner = new Button(width/2, 2*height/5, 200, 100, BLACK, GREEN, new ScreenChangeEvent(Screens.TUNER), "Tuner", BLACK, 30);
  metronome = new Button(width/2, 3*height/5, 200, 100, BLACK, GREEN, new ScreenChangeEvent(Screens.METRONOME), "Metronome", BLACK, 30);
  matrix = new Button(width/2, 4*height/5, 200, 100, BLACK, GREEN, new ScreenChangeEvent(Screens.MATRIX), "Matrix", BLACK, 30);
  
  screen = Screens.STARTUP;
  
  currentButton = a4;
  
  search = new TripleArray();
}

void draw(){
  println(currentButton.text);
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
       background(LAVENDER);
       currentButton.display();
       if(keyPressed && keyCode == 38){
         currentButton = search.upOctave(currentButton.text);
         keyPressed = false;
       } else if (keyPressed && keyCode == 40) {
         currentButton = search.downOctave(currentButton.text);
         keyPressed = false;
       } else if (keyPressed && keyCode == 39) {
         currentButton = search.succ(currentButton.text);
         keyPressed = false;
       } else if (keyPressed && keyCode == 37) {
         currentButton = search.pred(currentButton.text);
         keyPressed = false;
       }
       break;
     case METRONOME:
       break;
     case MATRIX:
       break;
  }
}
