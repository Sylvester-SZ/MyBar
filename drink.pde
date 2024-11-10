class Drink{
  String navn;
  String[] indgredienser;
  float[] mængder;
  float alk;
  PImage image;
  Drink(String NAVN, String[] INDGREDIENSER, float[] MÆNGDER, float ALK){
    navn = NAVN;
    indgredienser = INDGREDIENSER;
    mængder = MÆNGDER;
    alk = ALK;
    drinks.add(this);
  }
  String getNavn(){
    return navn;
  }
  PImage getImage(){
    return image;
  }
  String[] getIndgredienser(){
    return indgredienser;
  }
  float[] getMængder(){
    return mængder;
  }
  float getAlk(){
    return alk;
  }
}
