import java.lang.Math;
import java.util.Map;

void setup() {
  //size(600, 300);
  //background(#FFFFFF);
  morseTranslate("A"); // Muss zwischen a und A unterscheiden
}

void morseTranslate(String txt) {
  String[] morseChar = loadStrings("morseAlphabet.txt"); // load Morse Alphabet
  
  int n = txt.length(); // get lenght of input text
  
  String[] msg = new String[n]; // to store translated message
  HashMap<String,Integer> map = new HashMap<String,Integer>(); 
  
  for (int i=0; i < n; i++) {       // for each character in input text
  
    char c = txt.charAt(i);         // get the character
    
    if(c >= 65 && c <= 90){         // check if character is lowercase using ASCII 
      msg[i]=morseChar[c-65];       // get the morse code for the char by shifting the ASCII by 65 (since a in ASCII is 65)
    }else if(c >= 97 && c <= 122){  // if not lower, check if uppercase
      msg[i]=morseChar[c-97];       // get the morse code as above, shifting by 97, ASCII for A is 97
    }else{                          // if the character is not in a-z or A-Z it's invalid, there's no morse code for it
      println("Invalid character at position " + i+1 + " it will be skipped," ); 
      // Alternatively, it could print # for invalid characters
    }
    
    Integer val = map.get(msg[i]);
    if(val != null){
        map.put(msg[i], new Integer(val + 1)); 
      }else{
        map.put(msg[i],1); }
    }
    
    //// Berechnung Wortlänge, Entropie, Redundanz 
    
    float H=0, L=0;
    float pi=0;
   

    for(Map.Entry c : map.entrySet()){ // for each map entry c
      String s = c.getKey().toString(); // gets key i.e. morse code for the character
      float freq = map.get(s); // get value i.e. frequency 
     
      pi = freq/msg.length; 

      L += pi * s.length();
      H -= pi * (log(pi)/log(2)); //<>//
    }
    println("L="+ L +"\n H:"+ H + "\n R = "+ (L-H));
      
    
    // mittl Worlänge L = pi*Ni
    // Entropie H = - sigma pi*ld(pi)
};
