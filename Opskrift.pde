class Opskrift{
  private String navn;
  private int id;
  private String description;
  private Flasker flasker;
  private float mængder;
  private float alk;
  Opskrift(String tempNavn, int tempId, String tempDescription, Flasker tempFlasker, float tempMængder, float tempAlk){
    this.navn = tempNavn;
    this.id = tempId;
    this.description = tempDescription;
    this.flasker = tempFlasker;
    this.mængder = tempMængder;
    this.alk = tempAlk;
  }
  
  String getNavn(){
    return navn;
  }
  int getId(){
    return id;
  }
  String getDescription(){
    return description;
  }
  Flasker getFlasker(){
    return flasker;
  }
  float getMængder(){
    return mængder;
  }
  float getAlk(){
    return alk;
  }
}
