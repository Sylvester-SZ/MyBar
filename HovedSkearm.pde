import controlP5.*;

ControlP5 kontrol;

color background1 = #5F021F;
color background2 = #340111;
color button = #56021C;
color selected = #BC043E;

ControlFont cf1;

void setup(){
  cf1 = new ControlFont(createFont("Times New Roman", width/40));
  kontrol = new ControlP5(this);
  fullScreen();
  background(background2);
  addKnap(width/10*7-width/8, height/2-height/20, width/4, height/10, "FLASKER", cf1);
  addKnap(width/10*3-width/8, height/2-height/20, width/4, height/10, "Drinks", cf1);
}

void draw(){
  
}

void addKnap(float x, float y, int sX, int sY, String text, ControlFont font){
  kontrol.addButton(text)
  .setPosition(x, y)
  .setSize(sX, sY)
  .setFont(font)
  .setColorBackground(button)
  .setColorForeground(selected)
  .setColorActive(button);
}
