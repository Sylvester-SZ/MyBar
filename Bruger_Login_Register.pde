import controlP5.*;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;

ControlP5 kontrolP5;

String nuværendeTilstand = "registrer";

ArrayList<Bruger> brugere = new ArrayList<Bruger>();

DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

Textfield registrerNavnFelt, registrerPasswordFelt, registrerAlderFelt, registrerPræferencerFelt;
Button registrerKlarKnappen;

Textfield loginNavnFelt, loginPasswordFelt;
Button loginKnappen;
Button skiftTilRegistrerKnappen;

String besked = "";

int brugerIdTæller = 0;

color baggrundsFarve = color(245, 245, 245);
color knapFarve = color(70, 130, 180);
color knapHoverFarve = color(100, 149, 237);
color tekstFarve = color(50);
PFont font;

void setup() {
  size(600, 500);
  kontrolP5 = new ControlP5(this);
  font = createFont("Arial", 16);
  background(baggrundsFarve);
  setupRegistrerUI();
  setupLoginUI();
}

void draw() {
  background(baggrundsFarve);
  fill(tekstFarve);
  textFont(font);
  
  textSize(28);
  textAlign(CENTER, CENTER);
  
  if (nuværendeTilstand.equals("registrer")) {
    text("Opret en Konto", width/2, 30);
  } else if (nuværendeTilstand.equals("login")) {
    text("Login", width/2, 30);
  }
  
  textSize(16);
  fill(255, 0, 0);
  text(besked, width/2, height - 40);
}

void setupRegistrerUI() {
  registrerNavnFelt = kontrolP5.addTextfield("RegistrerNavn")
    .setPosition(150, 80)
    .setSize(300, 30)
    .setAutoClear(false)
    .setLabel("Navn")
    .setFont(font);
  
  registrerPasswordFelt = kontrolP5.addTextfield("RegistrerPassword")
    .setPosition(150, 140)
    .setSize(300, 30)
    .setPasswordMode(true)
    .setLabel("Password")
    .setFont(font);
  
  registrerAlderFelt = kontrolP5.addTextfield("RegistrerAlder")
    .setPosition(150, 200)
    .setSize(300, 30)
    .setInputFilter(ControlP5.INTEGER)
    .setLabel("Alder")
    .setFont(font);
  
  registrerPræferencerFelt = kontrolP5.addTextfield("RegistrerPræferencer")
    .setPosition(150, 260)
    .setSize(300, 30)
    .setLabel("Præferencer (komma adskilt)")
    .setFont(font);
  
  registrerKlarKnappen = kontrolP5.addButton("RegistrerKlar")
    .setPosition(250, 320)
    .setSize(100, 40)
    .setLabel("Registrer")
    .setFont(font)
    .setColorBackground(knapFarve)
    .setColorForeground(knapFarve)
    .onClick(new CallbackListener() {
      public void controlEvent(CallbackEvent event) {
        registrerBruger();
      }
    });
}

void setupLoginUI() {
  loginNavnFelt = kontrolP5.addTextfield("LoginNavn")
    .setPosition(150, 100)
    .setSize(300, 30)
    .setAutoClear(false)
    .setLabel("Navn")
    .setFont(font)
    .hide();
  
  loginPasswordFelt = kontrolP5.addTextfield("LoginPassword")
    .setPosition(150, 160)
    .setSize(300, 30)
    .setPasswordMode(true)
    .setLabel("Password")
    .setFont(font)
    .hide();
  
  loginKnappen = kontrolP5.addButton("LoginKnappen")
    .setPosition(250, 220)
    .setSize(100, 40)
    .setLabel("Login")
    .setFont(font)
    .setColorBackground(knapFarve)
    .setColorForeground(knapFarve)
    .onClick(new CallbackListener() {
      public void controlEvent(CallbackEvent event) {
        loginBruger();
      }
    })
    .hide();
  
  skiftTilRegistrerKnappen = kontrolP5.addButton("SkiftTilRegistrer")
    .setPosition(250, 280)
    .setSize(100, 30)
    .setLabel("Registrer")
    .setFont(font)
    .setColorBackground(knapFarve)
    .setColorForeground(knapFarve)
    .onClick(new CallbackListener() {
      public void controlEvent(CallbackEvent event) {
        skiftTilRegistrer();
      }
    })
    .hide();
}

void registrerBruger() {
  besked = "";
  
  String navn = kontrolP5.get(Textfield.class, "RegistrerNavn").getText().trim();
  String password = kontrolP5.get(Textfield.class, "RegistrerPassword").getText();
  String alderTekst = kontrolP5.get(Textfield.class, "RegistrerAlder").getText().trim();
  String præferencerTekst = kontrolP5.get(Textfield.class, "RegistrerPræferencer").getText().trim();
  
  if (navn.isEmpty() || password.isEmpty() || alderTekst.isEmpty()) {
    besked = "Udfyld venligst alle obligatoriske felter.";
    return;
  }
  
  int alder;
  try {
    alder = Integer.parseInt(alderTekst);
    if (alder <= 0) {
      besked = "Alder skal være et positivt heltal.";
      return;
    }
  } catch (NumberFormatException e) {
    besked = "Alder skal være et heltal.";
    return;
  }
  
  for (Bruger bruger : brugere) {
    if (bruger.getNavn().equalsIgnoreCase(navn)) {
      besked = "Bruger med dette navn eksisterer allerede.";
      return;
    }
  }
  
  ArrayList<String> præferencer = new ArrayList<String>();
  if (!præferencerTekst.isEmpty()) {
    for (String pref : præferencerTekst.split(",")) {
      præferencer.add(pref.trim());
    }
  }
  
  LocalDate nuværendeDato = LocalDate.now();
  
  Bruger bruger = new Bruger(navn, brugerIdTæller++, password, nuværendeDato, alder, præferencer);
  
  brugere.add(bruger);
  
  println("Bruger Registreret:");
  println("Navn: " + bruger.getNavn());
  println("ID: " + bruger.getId());
  println("Dato: " + bruger.getDato());
  println("Alder: " + bruger.getAlder());
  println("Præferencer: " + bruger.getPræferancer());
  println("Hashed Password: " + bruger.getHashedPassword());
  println("Salt: " + bytesTilHex(bruger.getSalt()));
  println("-----------------------------------");
  
  kontrolP5.get(Textfield.class, "RegistrerNavn").clear();
  kontrolP5.get(Textfield.class, "RegistrerPassword").clear();
  kontrolP5.get(Textfield.class, "RegistrerAlder").clear();
  kontrolP5.get(Textfield.class, "RegistrerPræferencer").clear();
  
  skiftTilLogin();
  
  besked = "Registrering succesfuld! Log ind venligst.";
}

void skiftTilLogin() {
  nuværendeTilstand = "login";
  
  kontrolP5.get(Textfield.class, "RegistrerNavn").hide();
  kontrolP5.get(Textfield.class, "RegistrerPassword").hide();
  kontrolP5.get(Textfield.class, "RegistrerAlder").hide();
  kontrolP5.get(Textfield.class, "RegistrerPræferencer").hide();
  kontrolP5.get(Button.class, "RegistrerKlar").hide();
  
  kontrolP5.get(Textfield.class, "LoginNavn").show();
  kontrolP5.get(Textfield.class, "LoginPassword").show();
  kontrolP5.get(Button.class, "LoginKnappen").show();
  kontrolP5.get(Button.class, "SkiftTilRegistrer").show();
}

void skiftTilRegistrer() {
  nuværendeTilstand = "registrer";
  
  kontrolP5.get(Textfield.class, "RegistrerNavn").show();
  kontrolP5.get(Textfield.class, "RegistrerPassword").show();
  kontrolP5.get(Textfield.class, "RegistrerAlder").show();
  kontrolP5.get(Textfield.class, "RegistrerPræferencer").show();
  kontrolP5.get(Button.class, "RegistrerKlar").show();
  
  kontrolP5.get(Textfield.class, "LoginNavn").hide();
  kontrolP5.get(Textfield.class, "LoginPassword").hide();
  kontrolP5.get(Button.class, "LoginKnappen").hide();
  kontrolP5.get(Button.class, "SkiftTilRegistrer").hide();
  
  besked = "";
}

void loginBruger() {
  besked = "";
  
  String navn = kontrolP5.get(Textfield.class, "LoginNavn").getText().trim();
  String password = kontrolP5.get(Textfield.class, "LoginPassword").getText();
  
  if (navn.isEmpty() || password.isEmpty()) {
    besked = "Indtast venligst både navn og password.";
    return;
  }
  
  Bruger fundetBruger = null;
  for (Bruger bruger : brugere) {
    if (bruger.getNavn().equalsIgnoreCase(navn)) {
      fundetBruger = bruger;
      break;
    }
  }
  
  if (fundetBruger == null) {
    besked = "Bruger ikke fundet.";
    return;
  }
  
  String hashedInputPassword = hashPassword(password, fundetBruger.getSalt());
  
  if (hashedInputPassword.equals(fundetBruger.getHashedPassword())) {
    besked = "Login succesfuld! Velkommen, " + fundetBruger.getNavn() + ".";
    println("Bruger " + fundetBruger.getNavn() + " loggede ind succesfuldt.");
  } else {
    besked = "Forkert password.";
    println("Mislykket loginforsøg for bruger " + fundetBruger.getNavn() + ".");
  }
  
  kontrolP5.get(Textfield.class, "LoginNavn").clear();
  kontrolP5.get(Textfield.class, "LoginPassword").clear();
}

String bytesTilHex(byte[] bytes) {
  StringBuilder hexString = new StringBuilder();
  for (byte b : bytes) {
    String hex = Integer.toHexString(0xff & b);
    if(hex.length() == 1) hexString.append('0');
    hexString.append(hex);
  }
  return hexString.toString();
}

String hashPassword(String password, byte[] salt) {
  try {
    MessageDigest md = MessageDigest.getInstance("SHA-256");
    md.update(salt);
    byte[] hashedBytes = md.digest(password.getBytes());
    return bytesTilHex(hashedBytes);
  } catch (NoSuchAlgorithmException e) {
    e.printStackTrace();
    return null;
  }
}

class Bruger {
  private String navn;
  private int id;
  private LocalDate dato;
  private int alder;
  private ArrayList<String> præferancer = new ArrayList<String>();
  
  private String hashedPassword;
  private byte[] salt;
  
  Bruger(String navn, int id, String password, LocalDate dato, int alder, ArrayList<String> præferancer){
    this.navn = navn;
    this.id = id;
    this.dato = dato;
    this.alder = alder;
    this.præferancer = præferancer;
    
    this.salt = genererSalt();
    this.hashedPassword = hashPassword(password, this.salt);
  }

  String getNavn(){
    return navn;
  }
  int getId(){
    return id;
  }
  public LocalDate getDato() {
    return dato;
  }
  int getAlder(){
    return alder;
  }
  ArrayList<String> getPræferancer(){
    return præferancer;
  }
  String getHashedPassword(){
    return hashedPassword;
  }
  byte[] getSalt(){
    return salt;
  }
  private byte[] genererSalt() {
    SecureRandom sr = new SecureRandom();
    byte[] salt = new byte[16];
    sr.nextBytes(salt);
    return salt;
  }
  private String hashPassword(String password, byte[] salt) {
    try {
      MessageDigest md = MessageDigest.getInstance("SHA-256");
      md.update(salt);
      byte[] hashedBytes = md.digest(password.getBytes());
      return bytesTilHex(hashedBytes);
    } catch (NoSuchAlgorithmException e) {
      e.printStackTrace();
      return null;
    }
  }
  private String bytesTilHex(byte[] bytes) {
    StringBuilder hexString = new StringBuilder();
    for (byte b : bytes) {
      String hex = Integer.toHexString(0xff & b);
      if(hex.length() == 1) hexString.append('0');
      hexString.append(hex);
    }
    return hexString.toString();
  }
}
