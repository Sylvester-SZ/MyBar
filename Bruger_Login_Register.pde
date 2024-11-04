import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;

String nuværendeTilstand = "registrer";

ArrayList<Bruger> brugere = new ArrayList<Bruger>();

DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

Textfield registrerNavnFelt, registrerPasswordFelt, registrerAlderFelt, registrerEmailFelt, loginNavnFelt, loginPasswordFelt;
Button registrerKlarKnappen, skiftTilRegistrerKnappen, skiftTilLoginKnappen, loginKnappen;

String besked = "";

int brugerIdTæller = 0;



void setupRegistrerUI() {
  registrerNavnFelt = kontrolP5.addTextfield("RegistrerNavn")
    .setPosition(width/2-width/12, height/20*8)
    .setSize(width/6, height/30)
    .setAutoClear(false)
    .setFont(font)
    .setLabel("Navn")
    .setFocus(false)
    .setColorActive(baggrundsFarve2)
    .setColorForeground(baggrundsFarve2)
    .setColorBackground(baggrundsFarve2);

  registrerNavnFelt.getCaptionLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE)
    .setPadding(width/200, -height/18);

  registrerPasswordFelt = kontrolP5.addTextfield("RegistrerPassword")
    .setPosition(width/2-width/12, height/20*10)
    .setSize(width/6, height/30)
    .setPasswordMode(true)
    .setLabel("Password")
    .setFont(font)
    .setColorActive(baggrundsFarve2)
    .setColorForeground(baggrundsFarve2)
    .setColorBackground(baggrundsFarve2);

  registrerPasswordFelt.getCaptionLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE)
    .setPadding(width/200, -height/18);

  registrerAlderFelt = kontrolP5.addTextfield("RegistrerAlder")
    .setPosition(width/2-width/12, height/20*12)
    .setSize(width/6, height/30)
    .setInputFilter(ControlP5.INTEGER)
    .setLabel("Alder")
    .setFont(font)
    .setColorActive(baggrundsFarve2)
    .setColorForeground(baggrundsFarve2)
    .setColorBackground(baggrundsFarve2);

  registrerAlderFelt.getCaptionLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE)
    .setPadding(width/200, -height/18);

  registrerEmailFelt = kontrolP5.addTextfield("RegistrerEmail")
    .setPosition(width/2-width/12, height/20*14)
    .setSize(width/6, height/30)
    .setLabel("Email")
    .setFont(font)
    .setColorActive(baggrundsFarve2)
    .setColorForeground(baggrundsFarve2)
    .setColorBackground(baggrundsFarve2);

  registrerEmailFelt.getCaptionLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE)
    .setPadding(width/200, -height/18);

  registrerKlarKnappen = kontrolP5.addButton("RegistrerKlar")
    .setPosition(width/2-width/30, height/20*16)
    .setSize(width/15, height/30)
    .setLabel("Registrer")
    .setFont(font)
    .setColorBackground(knapFarve)
    .setColorForeground(knapFarve)
    .onClick(new CallbackListener() {
    public void controlEvent(CallbackEvent event) {
      registrerBruger();
    }
  }
  );

  skiftTilLoginKnappen = kontrolP5.addButton("SkiftTilLogin")
    .setPosition(width/2-width/30, height/20*18)
    .setSize(width/15, height/30)
    .setLabel("Login")
    .setFont(font)
    .setColorBackground(knapFarve)
    .setColorForeground(knapFarve)
    .onClick(new CallbackListener() {
    public void controlEvent(CallbackEvent event) {
      skiftTilLogin();
    }
  }
  );
}


void setupLoginUI() {
  fill(255);
  noStroke();
  circle(width/2, height/20*4, width/10);
  fill(baggrundsFarve);
  circle(width/2, height/20*4+width/22, width/12);
  circle(width/2, height/20*4-width/60, width/30);

  loginNavnFelt = kontrolP5.addTextfield("LoginEmail")
    .setPosition(width/2-width/12, height/20*8)
    .setSize(width/6, height/30)
    .setAutoClear(false)
    .setLabel("Email")
    .setFont(font)
    .setColorActive(baggrundsFarve2)
    .setColorBackground(baggrundsFarve2)
    .setColorForeground(baggrundsFarve2)
    .hide();

  loginNavnFelt.getCaptionLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE)
    .setPadding(width/200, -height/18);


  loginPasswordFelt = kontrolP5.addTextfield("LoginPassword")
    .setPosition(width/2-width/12, height/20*10)
    .setSize(width/6, height/30)
    .setPasswordMode(true)
    .setLabel("Password")
    .setFont(font)
    .setColorActive(baggrundsFarve2)
    .setColorBackground(baggrundsFarve2)
    .setColorForeground(baggrundsFarve2)
    .hide();

  loginPasswordFelt.getCaptionLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE)
    .setPadding(width/200, -height/18);

  loginKnappen = kontrolP5.addButton("LoginKnappen")
    .setPosition(width/2-width/30, height/20*12)
    .setSize(width/15, height/30)
    .setLabel("Login")
    .setFont(font)
    .setColorBackground(knapFarve)
    .setColorForeground(knapFarve)
    .onClick(new CallbackListener() {
    public void controlEvent(CallbackEvent event) {
      loginBruger();
    }
  }
  )
  .hide();

  skiftTilRegistrerKnappen = kontrolP5.addButton("SkiftTilRegistrer")
    .setPosition(width/2-width/30, height/20*14)
    .setSize(width/15, height/30)
    .setLabel("Registrer")
    .setFont(font)
    .setColorBackground(knapFarve)
    .setColorForeground(knapFarve)
    .onClick(new CallbackListener() {
    public void controlEvent(CallbackEvent event) {
      skiftTilRegistrer();
    }
  }
  )
  .hide();
}


void registrerBruger() {
  besked = "";

  String navn = kontrolP5.get(Textfield.class, "RegistrerNavn").getText().trim();
  String password = kontrolP5.get(Textfield.class, "RegistrerPassword").getText();
  String alderTekst = kontrolP5.get(Textfield.class, "RegistrerAlder").getText().trim();
  String emailTekst = kontrolP5.get(Textfield.class, "RegistrerEmail").getText().trim();

  if (navn.isEmpty() || password.isEmpty() || alderTekst.isEmpty() || emailTekst.isEmpty()) {
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
  }
  catch (NumberFormatException e) {
    besked = "Alder skal være et heltal.";
    return;
  }

  for (Bruger bruger : brugere) {
    if (bruger.getNavn().equalsIgnoreCase(navn)) {
      besked = "Bruger med dette navn eksisterer allerede.";
      return;
    }
  }

  LocalDate nuværendeDato = LocalDate.now();

  Bruger bruger = new Bruger(navn, brugerIdTæller++, password, nuværendeDato, alder, emailTekst);

  brugere.add(bruger);

  println("Bruger Registreret:");
  println("Navn: " + bruger.getNavn());
  println("ID: " + bruger.getId());
  println("Dato: " + bruger.getDato());
  println("Alder: " + bruger.getAlder());
  println("Email: " + bruger.getEmail());
  println("Hashed Password: " + bruger.getHashedPassword());
  println("Salt: " + bytesTilHex(bruger.getSalt()));
  println("-----------------------------------");

  kontrolP5.get(Textfield.class, "RegistrerNavn").clear();
  kontrolP5.get(Textfield.class, "RegistrerPassword").clear();
  kontrolP5.get(Textfield.class, "RegistrerAlder").clear();
  kontrolP5.get(Textfield.class, "RegistrerEmail").clear();

  skiftTilLogin();

  besked = "Registrering succesfuld! Log ind venligst.";
}

void skiftTilLogin() {
  background(52, 1, 17);
  nuværendeTilstand = "login";

  kontrolP5.get(Textfield.class, "RegistrerNavn").hide();
  kontrolP5.get(Textfield.class, "RegistrerPassword").hide();
  kontrolP5.get(Textfield.class, "RegistrerAlder").hide();
  kontrolP5.get(Textfield.class, "RegistrerEmail").hide();
  kontrolP5.get(Button.class, "RegistrerKlar").hide();
  kontrolP5.get(Button.class, "SkiftTilLogin").hide();

  kontrolP5.get(Textfield.class, "LoginEmail").show();
  kontrolP5.get(Textfield.class, "LoginPassword").show();
  kontrolP5.get(Button.class, "LoginKnappen").show();
  kontrolP5.get(Button.class, "SkiftTilRegistrer").show();
  fill(255);
  noStroke();
  circle(width/2, height/20*4, width/10);
  fill(baggrundsFarve);
  circle(width/2, height/20*4+width/22, width/12);
  circle(width/2, height/20*4-width/60, width/30);
}

void skiftTilRegistrer() {
  background(52, 1, 17);
  nuværendeTilstand = "registrer";

  kontrolP5.get(Textfield.class, "RegistrerNavn").show();
  kontrolP5.get(Textfield.class, "RegistrerPassword").show();
  kontrolP5.get(Textfield.class, "RegistrerAlder").show();
  kontrolP5.get(Textfield.class, "RegistrerEmail").show();
  kontrolP5.get(Button.class, "RegistrerKlar").show();
  kontrolP5.get(Button.class, "SkiftTilLogin").show();

  kontrolP5.get(Textfield.class, "LoginEmail").hide();
  kontrolP5.get(Textfield.class, "LoginPassword").hide();
  kontrolP5.get(Button.class, "LoginKnappen").hide();
  kontrolP5.get(Button.class, "SkiftTilRegistrer").hide();
  fill(255);
  noStroke();
  circle(width/2, height/20*4, width/10);
  fill(baggrundsFarve);
  circle(width/2, height/20*4+width/22, width/12);
  circle(width/2, height/20*4-width/60, width/30);

  besked = "";
}

void loginBruger() {
  besked = "";

  String email = kontrolP5.get(Textfield.class, "LoginEmail").getText().trim();
  String password = kontrolP5.get(Textfield.class, "LoginPassword").getText();

  if (email.isEmpty() || password.isEmpty()) {
    besked = "Indtast venligst både email og password.";
    return;
  }

  Bruger fundetBruger = null;
  for (Bruger bruger : brugere) {
    if (bruger.getEmail().equalsIgnoreCase(email)) {
      fundetBruger = bruger;
      skærm = "hovedSkærm";
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
    println("Bruger " + fundetBruger.getEmail() + " loggede ind succesfuldt.");
  } else {
    besked = "Forkert password.";
    println("Mislykket loginforsøg for bruger " + fundetBruger.getEmail() + ".");
  }

  kontrolP5.get(Textfield.class, "LoginEmail").clear();
  kontrolP5.get(Textfield.class, "LoginPassword").clear();
}


String bytesTilHex(byte[] bytes) {
  StringBuilder hexString = new StringBuilder();
  for (byte b : bytes) {
    String hex = Integer.toHexString(0xff & b);
    if (hex.length() == 1) hexString.append('0');
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
  }
  catch (NoSuchAlgorithmException e) {
    e.printStackTrace();
    return null;
  }
}

class Bruger {
  private String navn;
  private int id;
  private LocalDate dato;
  private int alder;
  private String email;

  private String hashedPassword;
  private byte[] salt;

  Bruger(String navn, int id, String password, LocalDate dato, int alder, String email) {
    this.navn = navn;
    this.id = id;
    this.dato = dato;
    this.alder = alder;
    this.email = email;

    this.salt = genererSalt();
    this.hashedPassword = hashPassword(password, this.salt);
  }

  String getNavn() {
    return navn;
  }
  int getId() {
    return id;
  }
  public LocalDate getDato() {
    return dato;
  }
  int getAlder() {
    return alder;
  }
  String getEmail() {
    return email;
  }
  String getHashedPassword() {
    return hashedPassword;
  }
  byte[] getSalt() {
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
    }
    catch (NoSuchAlgorithmException e) {
      e.printStackTrace();
      return null;
    }
  }
  private String bytesTilHex(byte[] bytes) {
    StringBuilder hexString = new StringBuilder();
    for (byte b : bytes) {
      String hex = Integer.toHexString(0xff & b);
      if (hex.length() == 1) hexString.append('0');
      hexString.append(hex);
    }
    return hexString.toString();
  }
}
