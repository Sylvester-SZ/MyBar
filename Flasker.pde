class Flasker{
  private String navn;
  private Float mængde;
  private Float VOL;
  private Float maxVOL;
  private String imgURL;
  private int id;
  
  Flasker(String navn, Float mængde, Float VOL, String imgURL, int id){
    this.navn = navn;
    this.mængde = mængde;
    this.VOL = VOL;
    this.maxVOL = VOL;
    this.imgURL = imgURL;
    this.id = id;
  }
  
  String getNavn(){
    return navn;
  }
  Float getMængde(){
    return mængde;
  }
  Float getVOL(){
    return VOL;
  }
  Float getMaxVOL(){
    return maxVOL;
  }
  String getimgURL(){
    return imgURL;
  }
  int getid(){
    return id;
  }
  
  void setPump(int pumpNummer){
    
  }
}
