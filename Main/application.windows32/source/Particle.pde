

boolean onPressed;
color[] palette = { 
  #ff00ff, #00ffff, #00ff00, #7920FF, #FF3300, #ffff00
}; 

class Particle {
  PVector loc, vel, acc;
  int lifeSpan, passedLife;
  boolean dead;
  float alpha, weight, weightRange, decay, xOffset, yOffset;
  int c;
  String mode;

  Particle(float x, float y, float _xOffset, float _yOffset, String _mode) {
    loc = new PVector(x, y);

    float randDegrees = random(360);
    vel = new PVector(cos(radians(randDegrees)), sin(radians(randDegrees)));
    vel.mult(random(5));

    acc = new PVector(0, 0);
    lifeSpan = int(random(30, 90));
    decay = random(0.85, 0.95);
    weightRange = random(3, 50);

    c = (int) random(palette.length);

    xOffset = _xOffset;
    yOffset = _yOffset;
    
    mode = _mode;
  }

  void update() {
    if (passedLife>=lifeSpan) {
      dead = true;
    } else {
      passedLife++;
    }

    alpha = float(lifeSpan-passedLife)/lifeSpan * 70+50;
    weight = float(lifeSpan-passedLife)/lifeSpan * weightRange;

    acc.set(0, 0);

    float rn = (noise((loc.x+frameCount+xOffset)*0.01, (loc.y+frameCount+yOffset)*0.01)-0.5)*4*PI;
    float mag = noise((loc.y+frameCount)*0.01, (loc.x+frameCount)*0.01);
    PVector dir = new PVector(cos(rn), sin(rn));
    acc.add(dir);
    acc.mult(mag);

    float randDegrees = random(360);
    PVector randV = new PVector(cos(radians(randDegrees)), sin(radians(randDegrees)));
    randV.mult(0.5);
    acc.add(randV);

    vel.add(acc);
    vel.mult(decay);
    vel.limit(3);
    loc.add(vel);
  }

  void display() {
    //strokeWeight(20);
    //stroke(220,alpha);
    
    if(mode.equals("normal")) {
    point(loc.x, loc.y);

    strokeWeight(weight*.5+2);
    stroke(#6FFF00,alpha);
    stroke(palette[c],alpha);
    point(loc.x, loc.y);
    }
    
    else if(mode.equals("red")) {
    point(loc.x, loc.y);

    strokeWeight(weight*.5+2);
    stroke(240,0,0,alpha);
    stroke(240,0,0,alpha);
    point(loc.x, loc.y);
    }
    
    else if(mode.equals("blue")) {
    point(loc.x, loc.y);

    strokeWeight(weight*.5+2);
    stroke(0,0,240,alpha);
    stroke(0,0,240,alpha);
    point(loc.x, loc.y);
    }
    
    else if(mode.equals("ball")) {
    point(loc.x, loc.y);

    strokeWeight(weight*.5+2);
    stroke(235,alpha);
    stroke(235,alpha);
    point(loc.x, loc.y);
    }
    
    else if(mode.equals("miss")) {
    point(loc.x, loc.y);

    strokeWeight(weight*.5+2);
    stroke(185,alpha);
    stroke(185,alpha);
    point(loc.x, loc.y);
    }
  }
}