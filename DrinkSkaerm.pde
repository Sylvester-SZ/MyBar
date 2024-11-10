Drink selectedDrink = null;

void DrinkUI() {
  for (int i=0; i<drinks.size(); i++) {
    if (drinks.get(i) == selectedDrink) {
      fill(knapHoverFarve);
    } else {
      fill(knapFarve);
    }
    rect(width/12-width-camX, height/8+height/5*i+height-camY, width/2, height/6);
    image(drinks.get(i).getImage(), width/12*1.1-width-camX, height/8*1.1+height/5*i+height-camY, width/8*0.85, height/6*0.85);
    textSize(width/40);
    fill(255);
    textAlign(LEFT, TOP);
    text(drinks.get(i).getNavn(), width/12*1.1-width-camX+width/8, height/8*1.1+height/5*i+height-camY);
    textAlign(LEFT, BOTTOM);
    float mængde = 0;
    for (float værdi : drinks.get(i).getMængder()) {
      mængde+=værdi;
    }
    textSize(width/60);
    text(mængde+"ml", width/12*1.1-width-camX+width/8, height/8*1.1+height/5*i+height-camY+ height/6*0.85);
    textAlign(RIGHT, TOP);
    text("alk: "+drinks.get(i).getAlk()+"%", width/12-width-camX+width/2*0.98, height/8*1.1+height/5*i+height-camY);
  }
  if (selectedDrink != null) {
    float mængde = 0;
    for (float værdi : selectedDrink.getMængder()) {
      mængde+=værdi;
    }
    fill(baggrundsFarve2);
    rect(width/12+width/2+width/24-width-camX, height/8+height-camY, width/3, height*0.8);
    textAlign(LEFT, TOP);
    textSize(width/40);
    fill(255);
    text(selectedDrink.getNavn(), width/12+width/2+width/20-width-camX, height/8+height/40+height-camY, width/3, height*0.8);
    image(selectedDrink.getImage(), width/12+width/2+width/24+width/6-width/6*0.45-width-camX, height/8+height/40+height/20+height-camY, width/6*0.9, width/6*0.9);
    textSize(width/60);
    text(mængde+"ml", width/12+width/2+width/20-width-camX, height/8+height/40+height/20+width/6*0.92+height-camY, width/3, height*0.8);
    text("alk: "+selectedDrink.getAlk()+"%", width/12+width/2+width/20-width-camX, height/8+height/40+height/20+width/6*0.92+height/30+height-camY, width/3, height*0.8);
    text("Indgredienser:", width/12+width/2+width/20-width-camX, height/8+height/40+height/20+width/6*0.92+height/30*3+height-camY, width/3, height*0.8);
    textSize(width/80);
    for (int i=0; i<selectedDrink.getIndgredienser().length; i++) {
      text(selectedDrink.getIndgredienser()[i]+" "+selectedDrink.getMængder()[i]+"ml", width/12+width/2+width/20-width-camX, height/8+height/40+height/20+width/6*0.92+height/30*4+height/40*i+height-camY, width/3, height*0.8);
    }
    fill(baggrundsFarve);
    rect((width/12+width/2+width/24)*1.05-width-camX, height/8+height-camY+height*0.6, width/3*0.8, height*0.15);
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(width/30);
    text("Skænk", (width/12+width/2+width/24)*1.05+width/3*0.4-width-camX, height/8+height+height*0.075-camY+height*0.6, width/3*0.8);
  }
}
