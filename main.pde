import controlP5.*;

float camX = 0;
float camY = 0;

color baggrundsFarve = color(52, 1, 17);
color baggrundsFarve2 = color(95, 2, 31);
color knapFarve = color(86, 2, 28);
color knapHoverFarve = color(188, 4, 62);
color tekstFarve = color(50);
PFont font;

String skærm = "registrer";

float tilbageKnapX = 0;

PImage vandImage;
PImage saftImage;
PImage vodkaDrinkImage;

ControlP5 kontrolP5;

Button tilbageKnap;

ArrayList<Drink> drinks = new ArrayList<Drink>();
ArrayList<String> indgredienser = new ArrayList<String>();

String[] vandIndgredienser = {"Vand"};
float[] vandMængder = {200};
Drink vand = new Drink("Vand", vandIndgredienser, vandMængder, 0.0);

String[] saftIndgredienser = {"Saft", "Vand"};
float[] saftMængder = {20, 200};
Drink saft = new Drink("Saftevand", saftIndgredienser, saftMængder, 0.0);
String[] vodkaDrinkIndgredienser = {"Vodka", "Noget der ikke er vodka"};
float[] vodkaDrinkMængder = {50, 100};
Drink vodkaDrink = new Drink("Vodka Drink", vodkaDrinkIndgredienser, vodkaDrinkMængder, 10);

boolean includedIn(String thing, ArrayList<String> list) {
  boolean ah = false;
  for (String item : list) {
    if (thing == item) {
      return true;
    }
  }
  return ah;
}

void setup() {
  vandImage = loadImage("vand.png");
  vand.image = vandImage;
  saftImage = loadImage("saft.png");
  saft.image = saftImage;
  vodkaDrinkImage = loadImage("vodkaDrink.png");
  vodkaDrink.image = vodkaDrinkImage;
  fullScreen();
  for (Drink drink : drinks) {
    for (String indgrediens : drink.indgredienser) {
      if (includedIn(indgrediens, indgredienser) == false) {
        indgredienser.add(indgrediens);
      }
    }
  }
  kontrolP5 = new ControlP5(this);
  font = createFont("Century Gothic", width/80);
  setupRegistrerUI();
  setupLoginUI();
  drive("1-5", "2-4");
  //drive("1-2","2-4");
  flaskerKnap = addKnap(width/10*7-width/8, height/2-height/20, width/4, height/10, "FLASKER", font).onClick(new CallbackListener() {
    public void controlEvent(CallbackEvent event) {
      skærm = "flasker";
    }
  }
  );

  drinksKnap = addKnap(width/10*3-width/8, height/2-height/20, width/4, height/10, "Drinks", font).onClick(new CallbackListener() {
    public void controlEvent(CallbackEvent event) {
      skærm = "drinks";
    }
  }
  );

  tilbageKnap = addKnap(width/20, height/20+height, width/10, height/20, "Tilbage", font).onClick(new CallbackListener() {
    public void controlEvent(CallbackEvent event) {
      skærm = "registrer";
    }
  }
  );
}

void draw() {
  background(baggrundsFarve);
  timer = millis()-timedPoint;
  if (skærm.equals("registrer")) {
    camY = lerp(camY, 0, 0.1);
    camX = lerp(camX, 0, 0.1);
  }
  if (skærm.equals("hovedSkærm")) {
    camY = lerp(camY, height, 0.1);
    camX = lerp(camX, 0, 0.1);
    tilbageKnapX = lerp(tilbageKnapX, 0, 0.08);
    tilbageKnap.onClick(new CallbackListener() {
      public void controlEvent(CallbackEvent event) {
        skærm = "registrer";
      }
    }
    );
  } else {
    tilbageKnap.onClick(new CallbackListener() {
      public void controlEvent(CallbackEvent event) {
        skærm = "hovedSkærm";
      }
    }
    );
  }

  if (skærm.equals("flasker")) {
    camX = lerp(camX, width, 0.1);
    camY = lerp(camY, height, 0.1);
    tilbageKnapX = lerp(tilbageKnapX, width, 0.08);
  }

  if (skærm.equals("drinks")) {
    camX = lerp(camX, -width, 0.1);
    camY = lerp(camY, height, 0.1);
    tilbageKnapX = lerp(tilbageKnapX, -width, 0.08);
  }
  if (camY < 1) {
    tilbageKnapX = 0;
  }
  tilbageKnap.setPosition(width/20+tilbageKnapX-camX, height/20-camY+height);

  flaskerKnap.setPosition(width/10*7-width/8-camX, height/2-height/20-camY+height);
  drinksKnap.setPosition(width/10*3-width/8-camX, height/2-height/20-camY+height);

  registrerNavnFelt.setPosition(width/2-width/12-camX, height/20*8-camY);
  registrerPasswordFelt.setPosition(width/2-width/12-camX, height/20*10-camY);
  registrerAlderFelt.setPosition(width/2-width/12-camX, height/20*12-camY);
  registrerEmailFelt.setPosition(width/2-width/12-camX, height/20*14-camY);
  loginNavnFelt.setPosition(width/2-width/12-camX, height/20*8-camY);
  loginPasswordFelt.setPosition(width/2-width/12-camX, height/20*10-camY);
  registrerKlarKnappen.setPosition(width/2-width/30-camX, height/20*16-camY);
  skiftTilRegistrerKnappen.setPosition(width/2-width/30-camX, height/20*14-camY);
  skiftTilLoginKnappen.setPosition(width/2-width/30-camX, height/20*18-camY);
  loginKnappen.setPosition(width/2-width/30-camX, height/20*12-camY);

  fill(255);
  circle(width/2-camX, height/20*4-camY, width/10);
  fill(baggrundsFarve);
  circle(width/2-camX, height/20*4+width/22-camY, width/12);
  circle(width/2-camX, height/20*4-width/60-camY, width/30);
  //camY = lerp(camY, height, 0.1);
  fill(tekstFarve);
  textFont(font);

  textSize(28);
  textAlign(CENTER, CENTER);
  DrinkUI();
  if (nuværendeTilstand.equals("registrer")) {
    fill(255);
    text("Opret en Konto", width/2-camX, 30-camY);
  } else if (nuværendeTilstand.equals("login")) {
    fill(255);
    text("Login", width/2-camX, 30-camY);
  }
  if (timer < 2000) {
    textSize(16);
    fill(255, 0, 0);
    text(besked, width/2-camX, height - 40-camY);
  }
}

void mousePressed() {
  if (skærm.equals("drinks")) {
    selectedDrink = null;
    for (int i=0; i<drinks.size(); i++) {
      if (mouseX > width/12-width-camX && mouseX <  width/12-width-camX+width/2 && mouseY > height/8+height/5*i+height-camY && mouseY < height/8+height/5*i+height-camY+height/6) {
        selectedDrink = drinks.get(i);
      }
    }
  }
}

Button addKnap(float x, float y, int sX, int sY, String text, PFont font) {
  Button knap = kontrolP5.addButton(text)
    .setPosition(x, y)
    .setSize(sX, sY)
    .setFont(font)
    .setColorBackground(knapFarve)
    .setColorForeground(knapHoverFarve)
    .setColorActive(knapFarve);
  return knap;
}
