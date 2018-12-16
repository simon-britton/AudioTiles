import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.sound.*; 
import java.util.regex.*; 
import java.util.TimerTask; 
import java.util.Timer; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class AudioTiles extends PApplet {






SoundFile                                         A0, Bb0, B0, 
  C1, Db1, D1, Eb1, E1, F1, Gb1, G1, Ab1, A1, Bb1, B1, 
  C2, Db2, D2, Eb2, E2, F2, Gb2, G2, Ab2, A2, Bb2, B2, 
  C3, Db3, D3, Eb3, E3, F3, Gb3, G3, Ab3, A3, Bb3, B3, 
  C4, Db4, D4, Eb4, E4, F4, Gb4, G4, Ab4, A4, Bb4, B4, 
  C5, Db5, D5, Eb5, E5, F5, Gb5, G5, Ab5, A5, Bb5, B5, 
  C6, Db6, D6, Eb6, E6, F6, Gb6, G6, Ab6, A6, Bb6, B6, 
  C7, Db7, D7, Eb7, E7, F7, Gb7, G7, Ab7, A7, Bb7, B7, 
  C8, High, Low;

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

int BLACK, WHITE, LAVENDER, GREEN;

SliderButton volumeSlider;

float volume;

FFT fft;
AudioIn in;
int bands;
float[] spectrum;

enum Screens { 
  STARTUP, 
    MENU, 
    SETTINGS, 
    TUNER, 
    METRONOME, 
    MATRIX, 
    VISUALIZER;
}

final int WIDTH = 1000;
final int HEIGHT = 618;

Timer incrementalTimer;

Tile[][] tiles;
Tile play;
int tileHOffset = width/2;
int tileVOffset = height/2;
int tileLoop = 0;
boolean isCancelled = true;

int bpm = 80;
long startTime = System.currentTimeMillis();
int accents = 4;
int divisions = 1;
long timePrevious;
boolean metronomeRunning = false;

TextBox bpmInput;
TextBox divisionsInput;
TextBox timeSig;
ArrayList<TextBox> textboxes = new ArrayList<TextBox>();

Screens screen, saveScreen;
Button menu, settings, tuner, metronome, matrix, currentButton, backMenu, backSettings, visualizer, cornerBack, startMetronome; 

public void setup() {
  
  colorMode(HSB, 360, 100, 100);
  rectMode(CENTER);
  textAlign(CENTER);

  bpmInput = new TextBox(width/2, height/5, 100, 50);
  timeSig  = new TextBox(width/2, 2*height/5, 100, 50);
  divisionsInput  = new TextBox(width/2, 3*height/5, 100, 50);
  textboxes.add(bpmInput);
  textboxes.add(timeSig);
  textboxes.add(divisionsInput);

  High = new SoundFile(this, "High.wav");
  Low = new SoundFile(this, "Low.wav");

  BLACK = color(0, 0, 0);
  WHITE = color(0, 0, 100);
  LAVENDER = color(275, 50, 70);
  GREEN = color(120, 40, 100);

  screen = Screens.STARTUP;
  saveScreen = Screens.STARTUP;

  Ab1 = new SoundFile(this, "Piano.ff.Ab1.aiff");
  Ab2 = new SoundFile(this, "Piano.ff.Ab2.aiff");
  Ab3 = new SoundFile(this, "Piano.ff.Ab3.aiff");
  Ab4 = new SoundFile(this, "Piano.ff.Ab4.aiff");
  Ab5 = new SoundFile(this, "Piano.ff.Ab5.aiff");
  Ab6 = new SoundFile(this, "Piano.ff.Ab6.aiff");
  Ab7 = new SoundFile(this, "Piano.ff.Ab7.aiff");

  ab1 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Ab1), "Ab1", BLACK, 50);
  ab2 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Ab2), "Ab2", BLACK, 50);
  ab3 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Ab3), "Ab3", BLACK, 50);
  ab4 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Ab4), "Ab4", BLACK, 50);
  ab5 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Ab5), "Ab5", BLACK, 50);
  ab6 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Ab6), "Ab6", BLACK, 50);
  ab7 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Ab7), "Ab7", BLACK, 50);

  A0 = new SoundFile(this, "Piano.ff.A0.aiff");
  A1 = new SoundFile(this, "Piano.ff.A1.aiff");
  A2 = new SoundFile(this, "Piano.ff.A2.aiff");
  A3 = new SoundFile(this, "Piano.ff.A3.aiff");
  A4 = new SoundFile(this, "Piano.ff.A4.aiff");
  A5 = new SoundFile(this, "Piano.ff.A5.aiff");
  A6 = new SoundFile(this, "Piano.ff.A6.aiff");
  A7 = new SoundFile(this, "Piano.ff.A7.aiff");

  a0 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(A0), "A0", BLACK, 50);
  a1 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(A1), "A1", BLACK, 50);
  a2 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(A2), "A2", BLACK, 50);
  a3 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(A3), "A3", BLACK, 50);
  a4 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(A4), "A4", BLACK, 50);
  a5 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(A5), "A5", BLACK, 50);
  a6 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(A6), "A6", BLACK, 50);
  a7 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(A7), "A7", BLACK, 50);

  Bb0 = new SoundFile(this, "Piano.ff.Bb0.aiff");
  Bb1 = new SoundFile(this, "Piano.ff.Bb1.aiff");
  Bb2 = new SoundFile(this, "Piano.ff.Bb2.aiff");
  Bb3 = new SoundFile(this, "Piano.ff.Bb3.aiff");
  Bb4 = new SoundFile(this, "Piano.ff.Bb4.aiff");
  Bb5 = new SoundFile(this, "Piano.ff.Bb5.aiff");
  Bb6 = new SoundFile(this, "Piano.ff.Bb6.aiff");
  Bb7 = new SoundFile(this, "Piano.ff.Bb7.aiff");

  bb0 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Bb1), "Bb0", BLACK, 50);
  bb1 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Bb1), "Bb1", BLACK, 50);
  bb2 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Bb2), "Bb2", BLACK, 50);
  bb3 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Bb3), "Bb3", BLACK, 50);
  bb4 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Bb4), "Bb4", BLACK, 50);
  bb5 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Bb5), "Bb5", BLACK, 50);
  bb6 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Bb6), "Bb6", BLACK, 50);
  bb7 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Bb7), "Bb7", BLACK, 50);

  B0 = new SoundFile(this, "Piano.ff.B0.aiff");
  B1 = new SoundFile(this, "Piano.ff.B1.aiff");
  B2 = new SoundFile(this, "Piano.ff.B2.aiff");
  B3 = new SoundFile(this, "Piano.ff.B3.aiff");
  B4 = new SoundFile(this, "Piano.ff.B4.aiff");
  B5 = new SoundFile(this, "Piano.ff.B5.aiff");
  B6 = new SoundFile(this, "Piano.ff.B6.aiff");
  B7 = new SoundFile(this, "Piano.ff.B7.aiff");

  b0 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(B1), "B0", BLACK, 50);
  b1 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(B1), "B1", BLACK, 50);
  b2 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(B2), "B2", BLACK, 50);
  b3 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(B3), "B3", BLACK, 50);
  b4 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(B4), "B4", BLACK, 50);
  b5 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(B5), "B5", BLACK, 50);
  b6 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(B6), "B6", BLACK, 50);
  b7 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(B7), "B7", BLACK, 50);

  C1 = new SoundFile(this, "Piano.ff.C1.aiff");
  C2 = new SoundFile(this, "Piano.ff.C2.aiff");
  C3 = new SoundFile(this, "Piano.ff.C3.aiff");
  C4 = new SoundFile(this, "Piano.ff.C4.aiff");
  C5 = new SoundFile(this, "Piano.ff.C5.aiff");
  C6 = new SoundFile(this, "Piano.ff.C6.aiff");
  C7 = new SoundFile(this, "Piano.ff.C7.aiff");
  C8 = new SoundFile(this, "Piano.ff.C8.aiff");

  c1 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(C1), "C1", BLACK, 50);
  c2 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(C2), "C2", BLACK, 50);
  c3 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(C3), "C3", BLACK, 50);
  c4 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(C4), "C4", BLACK, 50);
  c5 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(C5), "C5", BLACK, 50);
  c6 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(C6), "C6", BLACK, 50);
  c7 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(C7), "C7", BLACK, 50);
  c8 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(C8), "C8", BLACK, 50);

  Db1 = new SoundFile(this, "Piano.ff.Db1.aiff");
  Db2 = new SoundFile(this, "Piano.ff.Db2.aiff");
  Db3 = new SoundFile(this, "Piano.ff.Db3.aiff");
  Db4 = new SoundFile(this, "Piano.ff.Db4.aiff");
  Db5 = new SoundFile(this, "Piano.ff.Db5.aiff");
  Db6 = new SoundFile(this, "Piano.ff.Db6.aiff");
  Db7 = new SoundFile(this, "Piano.ff.Db7.aiff");

  db1 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Db1), "Db1", BLACK, 50);
  db2 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Db2), "Db2", BLACK, 50);
  db3 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Db3), "Db3", BLACK, 50);
  db4 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Db4), "Db4", BLACK, 50);
  db5 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Db5), "Db5", BLACK, 50);
  db6 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Db6), "Db6", BLACK, 50);
  db7 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Db7), "Db7", BLACK, 50);

  D1 = new SoundFile(this, "Piano.ff.D1.aiff");
  D2 = new SoundFile(this, "Piano.ff.D2.aiff");
  D3 = new SoundFile(this, "Piano.ff.D3.aiff");
  D4 = new SoundFile(this, "Piano.ff.D4.aiff");
  D5 = new SoundFile(this, "Piano.ff.D5.aiff");
  D6 = new SoundFile(this, "Piano.ff.D6.aiff");
  D7 = new SoundFile(this, "Piano.ff.D7.aiff");

  d1 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(D1), "D1", BLACK, 50);
  d2 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(D2), "D2", BLACK, 50);
  d3 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(D3), "D3", BLACK, 50);
  d4 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(D4), "D4", BLACK, 50);
  d5 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(D5), "D5", BLACK, 50);
  d6 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(D6), "D6", BLACK, 50);
  d7 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(D7), "D7", BLACK, 50);

  Eb1 = new SoundFile(this, "Piano.ff.Eb1.aiff");
  Eb2 = new SoundFile(this, "Piano.ff.Eb2.aiff");
  Eb3 = new SoundFile(this, "Piano.ff.Eb3.aiff");
  Eb4 = new SoundFile(this, "Piano.ff.Eb4.aiff");
  Eb5 = new SoundFile(this, "Piano.ff.Eb5.aiff");
  Eb6 = new SoundFile(this, "Piano.ff.Eb6.aiff");
  Eb7 = new SoundFile(this, "Piano.ff.Eb7.aiff");

  eb1 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Eb1), "Eb1", BLACK, 50);
  eb2 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Eb2), "Eb2", BLACK, 50);
  eb3 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Eb3), "Eb3", BLACK, 50);
  eb4 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Eb4), "Eb4", BLACK, 50);
  eb5 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Eb5), "Eb5", BLACK, 50);
  eb6 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Eb6), "Eb6", BLACK, 50);
  eb7 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Eb7), "Eb7", BLACK, 50);

  E1 = new SoundFile(this, "Piano.ff.E1.aiff");
  E2 = new SoundFile(this, "Piano.ff.E2.aiff");
  E3 = new SoundFile(this, "Piano.ff.E3.aiff");
  E4 = new SoundFile(this, "Piano.ff.E4.aiff");
  E5 = new SoundFile(this, "Piano.ff.E5.aiff");
  E6 = new SoundFile(this, "Piano.ff.E6.aiff");
  E7 = new SoundFile(this, "Piano.ff.E7.aiff");

  e1 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(E1), "E1", BLACK, 50);
  e2 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(E2), "E2", BLACK, 50);
  e3 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(E3), "E3", BLACK, 50);
  e4 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(E4), "E4", BLACK, 50);
  e5 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(E5), "E5", BLACK, 50);
  e6 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(E6), "E6", BLACK, 50);
  e7 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(E7), "E7", BLACK, 50);

  F1 = new SoundFile(this, "Piano.ff.F1.aiff");
  F2 = new SoundFile(this, "Piano.ff.F2.aiff");
  F3 = new SoundFile(this, "Piano.ff.F3.aiff");
  F4 = new SoundFile(this, "Piano.ff.F4.aiff");
  F5 = new SoundFile(this, "Piano.ff.F5.aiff");
  F6 = new SoundFile(this, "Piano.ff.F6.aiff");
  F7 = new SoundFile(this, "Piano.ff.F7.aiff");

  f1 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(F1), "F1", BLACK, 50);
  f2 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(F2), "F2", BLACK, 50);
  f3 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(F3), "F3", BLACK, 50);
  f4 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(F4), "F4", BLACK, 50);
  f5 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(F5), "F5", BLACK, 50);
  f6 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(F6), "F6", BLACK, 50);
  f7 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(F7), "F7", BLACK, 50);

  Gb1 = new SoundFile(this, "Piano.ff.Gb1.aiff");
  Gb2 = new SoundFile(this, "Piano.ff.Gb2.aiff");
  Gb3 = new SoundFile(this, "Piano.ff.Gb3.aiff");
  Gb4 = new SoundFile(this, "Piano.ff.Gb4.aiff");
  Gb5 = new SoundFile(this, "Piano.ff.Gb5.aiff");
  Gb6 = new SoundFile(this, "Piano.ff.Gb6.aiff");
  Gb7 = new SoundFile(this, "Piano.ff.Gb7.aiff");

  gb1 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Gb1), "Gb1", BLACK, 50);
  gb2 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Gb2), "Gb2", BLACK, 50);
  gb3 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Gb3), "Gb3", BLACK, 50);
  gb4 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Gb4), "Gb4", BLACK, 50);
  gb5 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Gb5), "Gb5", BLACK, 50);
  gb6 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Gb6), "Gb6", BLACK, 50);
  gb7 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(Gb7), "Gb7", BLACK, 50);

  G1 = new SoundFile(this, "Piano.ff.G1.aiff");
  G2 = new SoundFile(this, "Piano.ff.G2.aiff");
  G3 = new SoundFile(this, "Piano.ff.G3.aiff");
  G4 = new SoundFile(this, "Piano.ff.G4.aiff");
  G5 = new SoundFile(this, "Piano.ff.G5.aiff");
  G6 = new SoundFile(this, "Piano.ff.G6.aiff");
  G7 = new SoundFile(this, "Piano.ff.G7.aiff");

  g1 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(G1), "G1", BLACK, 50);
  g2 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(G2), "G2", BLACK, 50);
  g3 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(G3), "G3", BLACK, 50);
  g4 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(G4), "G4", BLACK, 50);
  g5 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(G5), "G5", BLACK, 50);
  g6 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(G6), "G6", BLACK, 50);
  g7 = new Button(width/2, height/2, width/2, height/2, BLACK, GREEN, new AudioEvent(G7), "G7", BLACK, 50);

  settings = new Button(width/2, height/6, 150, 75, BLACK, GREEN, new ScreenChangeEvent(Screens.SETTINGS), "Settings", BLACK, 22);
  tuner = new Button(width/2, 2*height/6, 150, 75, BLACK, GREEN, new ScreenChangeEvent(Screens.TUNER), "Tuner", BLACK, 22);
  metronome = new Button(width/2, 3*height/6, 150, 75, BLACK, GREEN, new ScreenChangeEvent(Screens.METRONOME), "Metronome", BLACK, 22);
  matrix = new Button(width/2, 4*height/6, 150, 75, BLACK, GREEN, new ScreenChangeEvent(Screens.MATRIX), "Matrix", BLACK, 22);
  visualizer = new Button(width/2, 5*height/6, 150, 75, BLACK, GREEN, new ScreenChangeEvent(Screens.VISUALIZER), "Visualizer", BLACK, 22);
  startMetronome = new Button(width/2, 4*height/5, 350, 100, BLACK, GREEN, new StartMetronome(), "Start Metronome", BLACK, 30);

  backSettings = new Button(width-75, height-37.5f, 150, 75, BLACK, GREEN, new ScreenChangeEvent(saveScreen), "Back", BLACK, 22);
  backMenu = new Button(width-75, height-37.5f, 150, 75, BLACK, GREEN, new ScreenChangeEvent(Screens.MENU), "Back", BLACK, 22);
  cornerBack = new Button(width-75, 37.5f, 150, 75, BLACK, GREEN, new ScreenChangeEvent(Screens.MENU), "Back", BLACK, 22);

  currentButton = a4;

  search = new TripleArray();

  volumeSlider = new SliderButton(width/2, height/2, "Volume");

  volume = 1;

  tiles = initializeTiles();
  play = new Tile(width/2 + 75, height/2, 50, 25, BLACK, WHITE, "Play", BLACK, 15, null);
  incrementalTimer = new Timer();

  bands = 512;
  spectrum = new float[bands];
  fft = new FFT(this, bands);
  in = new AudioIn(this, 0);
  in.start();
  fft.input(in);
}

public void draw() {
  switch(screen) {
  case STARTUP:
    background(LAVENDER);
    fill(0, 0, 100);
    textSize(50);
    text("Welcome to AudioTiles v.0.0.1!", width/2, 150);
    textSize(20);
    text("by Blake Bruell, DJ Nelson, and Simon Britton", width/2, 200);
    fill(frameCount%360, 100, 100);
    textSize(35);
    text("PRESS TO START", width/2, 400);
    if (mousePressed) {
      screen = Screens.MENU;
    }
    saveScreen = Screens.STARTUP;
    break;
  case MENU:
    background(LAVENDER);
    settings.display();
    tuner.display();
    metronome.display();
    matrix.display();
    visualizer.display();
    saveScreen = Screens.MENU;
    break;
  case SETTINGS:
    background(LAVENDER);
    backSettings.display();
    volumeSlider.display();
    volume = volumeSlider.getValue();
    break;
  case TUNER:
    background(LAVENDER);
    currentButton.display();
    if (keyPressed && keyCode == 38) {
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
    saveScreen = Screens.TUNER;
    backMenu.display();
    break;
  case METRONOME:
    background(WHITE);
    for (TextBox t : textboxes)
      t.DRAW();
    text("BPM", width/2, height/5-40);
    text("Time Signature", width/2, 2*height/5-40);
    text("Divisions", width/2, 3*height/5-40);
    startMetronome.display();
    if (metronomeRunning) {
      int tempBpm = bpm*divisions;
      long timeDif = (System.currentTimeMillis()-startTime);
      if (timePrevious%(60000/tempBpm)> timeDif%(60000/tempBpm)) {
        if (timePrevious%(accents*60000/bpm)>timeDif%(accents*60000/bpm)) {
          High.play();
        } else {
          Low.play();
        }
      }
      timePrevious = System.currentTimeMillis()-startTime;
    }
    saveScreen = Screens.METRONOME;
    backMenu.display();
    break;
  case MATRIX:
    background(LAVENDER);
    for (Tile[] tileArr : tiles) {
      for (Tile t : tileArr) {
        t.display();
      }
    }
    play.display();
    //println(play.isEnabled());
    if (play.isEnabled() && isCancelled) {
      println("Django!!!!");
      isCancelled = false;
      incrementalTimer.schedule(new TimerTask() {
        @Override
          public void run() {
          for (Tile[] tileArr : tiles) {
            for (Tile t : tileArr) {
              if (t.isEnabled()) {
                t.play();
                println("woot");
              }
            }
            delay(1000);
          }
          //for (Tile[] tileArr : tiles) {
          //  for (Tile t : tileArr) {
          //    if (t.isEnabled()) {
          //      t.stop();
          //      println("toow");
          //    }
          //  }
          //}
        }
      }
      , 3000);
    } else if (!play.isEnabled() && !isCancelled) {
      if (!isCancelled) {
        //incrementalTimer.cancel();
        isCancelled = true;
      }
    }
    saveScreen = Screens.MATRIX;
    backMenu.display();
    break;
  case VISUALIZER:
    background(0, 0, 0);
    fft.analyze(spectrum);
    for (int i=0; i<bands; i++) {
      stroke(i*360/512, 100, 100);
      line(2*i, height, 2*i, height - spectrum[i]*height*10);
    }
    cornerBack.display();
    break;
  }
  backSettings.e = new ScreenChangeEvent(saveScreen);
}

public void mousePressed() {
  for (TextBox t : textboxes) {
    t.PRESSED(mouseX, mouseY);
  }
}

public void keyPressed() {
  for (TextBox t : textboxes)
    t.KEYPRESSED(key, (int)keyCode);
}

public Tile[][] initializeTiles() {
  Tile[][] tiles = new Tile[6][6];
  String name = "A";
  for (int i = 0; i < 6; i++) {
    switch(i) {
    case 0:
      name = "A";
      break;
    case 1:
      name = "B";
      break;
    case 2:
      name = "C";
      break;
    case 3:
      name = "D";
      break;
    case 4:
      name = "E";
      break;
    case 5:
      name = "F";
      break;
    case 6:
      name = "G";
      break;
    }
    for (int j = 0; j < 6; j++) {
      tiles[i][j] = new Tile(tileHOffset + (50 * i), tileVOffset + (50 * j), 50, 50, BLACK, WHITE, "(" + i + ", " + j + ")", BLACK, 15, search.getFile(name + (j+1)));
    }
  }
  return tiles;
}

interface ActionEvent {
  public void performTasks();
}
class AudioEvent implements ActionEvent {
  SoundFile file;
  
  AudioEvent(SoundFile file){
    this.file = file;
  }
  
  public void performTasks(){
    file.amp(volume);
    file.play();
  }
}
class Button {
  float xpos, ypos, horizontal, vertical;
  int stroke, fill, textFill;
  ActionEvent e;
  String text;
  int textSize;
  
  Button(float xpos,float ypos, float horizontal, float vertical, int stroke, int fill, ActionEvent e, String text, int textFill, int textSize){
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
  
  public void display() {
    textAlign(CENTER);
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
class ScreenChangeEvent implements ActionEvent {
  Screens newScreen;
  
  ScreenChangeEvent(Screens newScreen){
    this.newScreen = newScreen;
  }
  
  public void performTasks() {
    screen = newScreen;
  }
}
class SliderButton {
  float xpos, ypos;
  float boxXpos = xpos+875;
  String text;
  
  SliderButton(float xpos, float ypos, String text) {
    this.xpos = xpos;
    this.ypos = ypos;
    this.text = text;
  }
  
  public void display() {
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
  
  public float getValue() {
    return (boxXpos-(xpos-365))/(750-20);
  }
  
}
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
public class TextBox {
   public int X = 0, Y = 0, H = 35, W = 200;
   public int TEXTSIZE = 24;
   // COLORS
   public int Background = color(0xffDBDBDB);
   public int Foreground = color(0, 0, 0);
   public int BackgroundSelected = color(0xff797979);
   public int Border = color(30, 30, 30);
   
   public boolean BorderEnable = true;
   public int BorderWeight = 1;
   
   public String Text = "";
   public int TextLength = 0;

   private boolean selected = false;
   
   TextBox() {
      // CREATE OBJECT DEFAULT TEXTBOX
   }
   
   TextBox(int x, int y, int w, int h) {
      X = x; Y = y; W = w; H = h;
   }
   
   public void DRAW() {
      // DRAWING THE BACKGROUND
      if (selected) {
         fill(BackgroundSelected);
      } else {
         fill(Background);
      }
      
      if (BorderEnable) {
         strokeWeight(BorderWeight);
         stroke(Border);
      } else {
         noStroke();
      }
      
      rect(X, Y, W, H);
      
      // DRAWING THE TEXT ITSELF
      fill(Foreground);
      textSize(TEXTSIZE);
      text(Text, X, Y+TEXTSIZE/2);
   }
   
   // IF THE KEYCODE IS ENTER RETURN 1
   // ELSE RETURN 0
   public boolean KEYPRESSED(char KEY, int KEYCODE) {
      if (selected) {
         if (KEYCODE == (int)BACKSPACE) {
            BACKSPACE();
         } else if (KEYCODE == 32) {
            // SPACE
            addText(' ');
         } else if (KEYCODE == (int)ENTER) {
            selected=false;
            return true;
         } else {
            addText(KEY);
         }
      }
      
      return false;
   }
   
   private void addText(char text) {
      // IF THE TEXT WIDHT IS IN BOUNDARIES OF THE TEXTBOX
      if (textWidth(Text + text) < W) {
         Text += text;
         TextLength++;
      }
   }
   
   private void BACKSPACE() {
      if (TextLength - 1 >= 0) {
         Text = Text.substring(0, TextLength - 1);
         TextLength--;
      }
   }
   

   private boolean overBox(int x, int y) {
      if(x >= X-W/2 && x <= X+W/2 && y >= Y-H/2 && y <= Y+H/2)
        return true;
      return false;
   }
   
   public void PRESSED(int x, int y) {
      if (overBox(x, y)) {
         selected = true;
      } else {
         selected = false;
      }
   }
}
class Tile {
  float xpos, ypos, horizontal, vertical;
  int stroke, fill, textFill;
  String text;
  int textSize;
  boolean enabled;
  SoundFile file;

  Tile(float xpos, float ypos, float horizontal, float vertical, int stroke, int fill, String text, int textFill, int textSize, SoundFile file) {
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

  public void display() {
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
  
  public void play(){
    file.play();
  }
  public void stop(){
    file.stop();
  }
  
  public boolean isEnabled(){
    return enabled;
  }
}
class TripleArray {
  Button[] buttons = {
                                          a0, bb0, b0, 
  c1, db1, d1, eb1, e1, f1, gb1, g1, ab1, a1, bb1, b1,
  c2, db2, d2, eb2, e2, f2, gb2, g2, ab2, a2, bb2, b2,
  c3, db3, d3, eb3, e3, f3, gb3, g3, ab3, a3, bb3, b3,
  c4, db4, d4, eb4, e4, f4, gb4, g4, ab4, a4, bb4, b4,
  c5, db5, d5, eb5, e5, f5, gb5, g5, ab5, a5, bb5, b5,
  c6, db6, d6, eb6, e6, f6, gb6, g6, ab6, a6, bb6, b6,
  c7, db7, d7, eb7, e7, f7, gb7, g7, ab7, a7, bb7, b7,
  c8 };

  SoundFile[] files = 
                                          {A0, Bb0, B0, 
  C1, Db1, D1, Eb1, E1, F1, Gb1, G1, Ab1, A1, Bb1, B1,
  C2, Db2, D2, Eb2, E2, F2, Gb2, G2, Ab2, A2, Bb2, B2,
  C3, Db3, D3, Eb3, E3, F3, Gb3, G3, Ab3, A3, Bb3, B3,
  C4, Db4, D4, Eb4, E4, F4, Gb4, G4, Ab4, A4, Bb4, B4,
  C5, Db5, D5, Eb5, E5, F5, Gb5, G5, Ab5, A5, Bb5, B5,
  C6, Db6, D6, Eb6, E6, F6, Gb6, G6, Ab6, A6, Bb6, B6,
  C7, Db7, D7, Eb7, E7, F7, Gb7, G7, Ab7, A7, Bb7, B7,
  C8 };
  
  String[] names =                       {"A0", "Bb0", "B0", 
  "C1", "Db1", "D1", "Eb1", "E1", "F1", "Gb1", "G1", "Ab1", "A1", "Bb1", "B1",
  "C2", "Db2", "D2", "Eb2", "E2", "F2", "Gb2", "G2", "Ab2", "A2", "Bb2", "B2",
  "C3", "Db3", "D3", "Eb3", "E3", "F3", "Gb3", "G3", "Ab3", "A3", "Bb3", "B3",
  "C4", "Db4", "D4", "Eb4", "E4", "F4", "Gb4", "G4", "Ab4", "A4", "Bb4", "B4",
  "C5", "Db5", "D5", "Eb5", "E5", "F5", "Gb5", "G5", "Ab5", "A5", "Bb5", "B5",
  "C6", "Db6", "D6", "Eb6", "E6", "F6", "Gb6", "G6", "Ab6", "A6", "Bb6", "B6",
  "C7", "Db7", "D7", "Eb7", "E7", "F7", "Gb7", "G7", "Ab7", "A7", "Bb7", "B7",
  "C8" };
  
  public int getFirstIndex(String name, int start) {
    for(int i=start; i<names.length; i++){
      if(names[i].indexOf(name) != -1){
        return i;
      }
    } 
    return -1;
  }
  
  public int getLastIndex(String name, int start) {
    for(int i=start; i>=0; i--) {
      if(names[i].indexOf(name) != -1){
        return i;
      }
    }
    return -1;
  }
  
  public Button getButton(String name) {
    return buttons[getFirstIndex(name, 0)];
  }
  
  public SoundFile getFile(String name) {
    int index = getFirstIndex(name, 0);
    if(index == -1){
      return null;
    }
    return files[index];
  }
  
  public Button upOctave(String name) {
    int index = getFirstIndex(name, 0);
    String note = name.substring(0, name.length()-1);
    int numb = Integer.parseInt(name.substring(name.length()-1, name.length()));
    if(numb <= 6) {
      return buttons[index+12];
    } else {
      if(numb == 7) {
        if(note.equals("A") || note.equals("Bb") || note.equals("B")){
          return buttons[getFirstIndex(note+"0", 0)];
        } if(note.equals("C")){
          return buttons[getFirstIndex("C8", 0)];
        } else {
          return buttons[getFirstIndex(note+"1", 0)];
        }
      } else {
        return buttons[getFirstIndex("C1", 0)];
      }
    }
  }
  
  public Button downOctave(String name) {
    int index = getFirstIndex(name, 0);
    String note = name.substring(0, name.length()-1);
    int numb = Integer.parseInt(name.substring(name.length()-1, name.length()));
    if(numb > 1) {
      return buttons[index-12];
    } else {
      if(numb == 1) {
        if(note.equals("A") || note.equals("Bb") || note.equals("B")){
          return buttons[getFirstIndex(note+"0", 0)];
        } else {
          return buttons[getFirstIndex(note+"7", 0)];
        }
      } else {
        if(note.equals("C")){
          return buttons[getFirstIndex("C8", 0)];
        } else {
          return buttons[getFirstIndex(note+"7", 0)];
        }
      }
    }
  }
  
  public Button succ(String name) {
    int index = getFirstIndex(name, 0);
    if(index+1 == buttons.length) {
      return buttons[0];
    } else {
      return buttons[index+1];
    }
  }
  
  public Button pred(String name) {
    int index = getFirstIndex(name, 0);
    if(index-1 < 0) {
      return buttons[buttons.length-1];
    } else {
      return buttons[index-1];
    }
  }
}
  public void settings() {  size(1000, 618); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "AudioTiles" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
