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
    return files[getFirstIndex(name, 0)];
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
