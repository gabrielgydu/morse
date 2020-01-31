import java.lang.Math;
import java.util.Map;
import g4p_controls.*;
import java.awt.Font;
import java.awt.*;
 
void setup() {
  size(600, 280, P3D);
  
  /* GUI config */
  createGUI();
  morse.setFont(new Font("Monospaced", Font.PLAIN, 12));
  input.setFont(new Font("Monospaced", Font.PLAIN, 12));
  button1.setFont(new Font("Monospaced", Font.PLAIN, 12));
  result.setFont(new Font("Monospaced", Font.PLAIN, 16));

  background(150);
}

void draw() {
  
}

void morseTranslate(String txt) {
  String[] morseChar = loadStrings("morseAlphabet.txt"); // load Morse Alphabet
  String[] morseNum = loadStrings("morseNumerals.txt"); // load Morse Numerals
  int n = txt.length(); // get lenght of input text
  int invalidCount=0;// count invalid chars like ' ', '.' so it doesn't use them for calculating frequency
  
  String msg = new String(); // to store translated message
  HashMap<String,Integer> map = new HashMap<String,Integer>(); 
  
  txt = txt.toUpperCase();
  
  for (int i=0; i < n; i++) {       // for each character in input text
    char c = txt.charAt(i);         // get the character
    println(int(c));
    
    if(c >= 65 && c <= 90){         // check if character is in valid ASCII range for a-z
      String mc = morseChar[c-65];
      msg = msg.concat(mc+" ");
      
      addToHashMap(map, mc);
    }else if(c >= 48 && c<=57){     // if it's numeral
      String mc = morseNum[c-48];
      msg = msg.concat(mc+" ");
      
      addToHashMap(map, mc);
    }else{                          // if the character is not in a-z or A-Z it's invalid, there's no morse code for it
      //println("Invalid character at position " + i+1 + " it will be skipped," ); 
      // Alternatively, it could print  ' / ' for invalid characters (doubles as space between words):
      msg = msg.concat(" / ");
      invalidCount++;
    }
    }
    
    //// Berechnung Wortlänge, Entropie, Redundanz 
    
    float H=0, L=0, pi=0;

    for(Map.Entry c : map.entrySet()){ // for each map entry c
      String s = c.getKey().toString(); // gets key i.e. morse code for the character //<>// //<>//
      float freq = map.get(s); // get value i.e. frequency 
     
      pi = freq/float(txt.length()-invalidCount);  //<>//
      println(s+": "+"pi= "+pi);

      L += pi * s.length();
      println("L= "+L);
      H += (-1)*pi * (log(pi)/log(2)); //<>//
      println("H= "+H);
    }
    println("L="+ L +"\n H:"+ H + "\n R = "+ (L-H));
    morse.setText(msg); //<>//
    result.setText("L="+ L +"\n H:"+ H + "\n R = "+ (L-H));
    
    // mittl Worlänge L = pi*Ni
    // Entropie H = - sigma pi*ld(pi)
};

void addToHashMap(HashMap<String,Integer> map, String c){
  Integer val = map.get(c);
      
  if(val != null)
     map.put(c, new Integer(val + 1)); 
  else 
     map.put(c,1); 
}
