import java.text.DecimalFormat;
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;
NetAddress myRemoteLocationBoom;
NetAddress myRemoteLocationBlue;
NetAddress myRemoteLocationStart;
NetAddress myRemoteLocationMiss;
NetAddress myRemoteLocationMenu;

float ballY1 = -30;
float ballY2 = -30;
float ballY3 = -30;
float ballY4 = -30;
float ballY5 = -30;
float ballY6 = -30;
float ballY7 = -4500;

float ballX1 = 0;
float ballX2 = 0;
float ballX3 = 0;
float ballX4 = 0;
float ballX5 = 0;
float ballX6 = 0;
float ballX7 = 0;

float speed = 1;
int count = 0;
int combo = 0;
int highestCombo = 0;
boolean reward = false;
int rewardCount = 0;

int life = 0;
int rewardLifeCount = 0;
int score = 0;
int highestScore = 0;
float mouse = 0;
//String over = "";
int board = 35;
int boardCount = 0;

boolean begin = false;
boolean replay = false;
String mode = "";

boolean danger = false;
int dangerCount = 0;

DecimalFormat df = new DecimalFormat("#0.0");

ArrayList<Particle> pts;

void setup() {
  //noCursor();
  size(650, 760);
  frameRate(50);
  life = width;
  ballPosition1();
  ballPosition2();
  ballPosition3();
  ballPosition4();
  ballPosition5();
  ballPosition6();
  ballPosition7();
  
  oscP5 = new OscP5(this,12345);
  myRemoteLocationBoom = new NetAddress("127.0.0.1",12346);
  myRemoteLocationBlue = new NetAddress("127.0.0.1",12346);
  myRemoteLocationStart = new NetAddress("127.0.0.1",12346);
  myRemoteLocationMiss = new NetAddress("127.0.0.1",12346);
  myRemoteLocationMenu = new NetAddress("127.0.0.1",12346);
   
  pts = new ArrayList<Particle>();
  //speed = 1;
  //score = 0;
  //textSize(40);
  //text("CATCH THEM ALL",155,height/3);
}

void draw() {
  if(!begin && !replay) {
    background(200,200,200);
    
    //for (int i=0; i<1; i++) {
    //  Particle newP = new Particle(random(mouseX+0, mouseX-0), random(mouseY+0, mouseY-0), i+pts.size(), i+pts.size());
    //  pts.add(newP);
    //  }
    //  for (int i=0; i<pts.size (); i++) {
    //  Particle p = pts.get(i);
    //  p.update();
    //  p.display();
    //  }
    //  for (int i=pts.size ()-1; i>-1; i--) {
    //  Particle p = pts.get(i);
    //  if (p.dead) {
    //  pts.remove(i);
    //  }
    //  }
    
    noStroke();
    fill(120);
    rect(0, height-25, life, 25);
    fill(205);
    textSize(20);
    text("♥ " + life, 6, height-5);
    fill(100);
    textSize(21);
    text("SPEED: " + df.format(speed) + "x", width-160, 50);
    text("SCORE: " + score + "   COMBO: " + combo + "   HIGHEST: " + highestCombo, 50, 50);
    textSize(20);
    fill(50);
    text("Easy mode", 275, height/2 - 40);
    text("Normal mode", 260, height/2);
    text("Hard mode", 273, height/2 + 40);
  
    noStroke();
    if(mouseX > 275 && mouseX < 380 && mouseY > 325 && mouseY < 345) {
      OscMessage myMessage = new OscMessage("/puredata/playSound/5");
      oscP5.send(myMessage, myRemoteLocationMenu);
      fill(50);
      ellipse(random(235-5,235+5), random(335-5, 335+5), 20, 20);
      ellipse(random(420-5, 420 + 5), random(335-5, 335+5), 20, 20);
      fill(80,0,0);
      text("Easy mode", 275, height/2 - 40);
    }
    if(mouseX > 260 && mouseX < 395 && mouseY > 365 && mouseY < 385) {
      OscMessage myMessage = new OscMessage("/puredata/playSound/5");
      oscP5.send(myMessage, myRemoteLocationMenu);
      fill(50);
      ellipse(random(235-5,235+5), random(375-5, 375+5), 20, 20);
      ellipse(random(420-5, 420 + 5), random(375-5, 375+5), 20, 20);
      fill(80,0,0);
      text("Normal mode", 260, height/2);
    }
    if(mouseX > 275 && mouseX < 380 && mouseY > 405 && mouseY < 425) {
      OscMessage myMessage = new OscMessage("/puredata/playSound/5");
      oscP5.send(myMessage, myRemoteLocationMenu);
      fill(50);
      ellipse(random(235-5,235+5), random(415-5, 415+5), 20, 20);
      ellipse(random(420-5, 420 + 5), random(415-5, 415+5), 20, 20);
      fill(80,0,0);
      text("Hard mode", 273, height/2 + 40);
    }
  }
  //background(245,245,245,100);
  //fill(50);
  //  text("Easy mode", 275, height/2 - 40);
  //    text("Normal mode", 260, height/2);
  //  text("Hard mode", 273, height/2 + 40);
  //text(mouseX + " . " + mouseY, 240, height/3);
  if (begin) {
    myRemoteLocation = new NetAddress("127.0.0.1",12346);
    
    if (danger) {
      background(245,245,245,100);
      fill(random(60, 255), 0, 0);
      textSize(48);
      text("DANGER!", width/2-90, height/2);
    } else {
      background(245,245,245,100);
    }
    if (life<=150)
      fill(200, 0, 0);
    else if (life>width)
      fill(0, 200, 0);
    else
      fill(120);
      rect(0, height-25, life, 25);
      fill(205);
      textSize(20);
      text("♥ " + life, 6, height-5);
      fill(100);
      textSize(24);
      
      for (int i=0; i<pts.size (); i++) {
      Particle p = pts.get(i);
      p.update();
      p.display();
      }
      for (int i=pts.size ()-1; i>-1; i--) {
      Particle p = pts.get(i);
      if (p.dead) {
      pts.remove(i);
      }
      }

    if (mouseX > ballX1 - board && mouseX < ballX1 + board && ballY1 > mouse-7*speed && ballY1 < mouse+7*speed) {
      ballY1 = -50;
      ++score;
      ++combo;
      reward = true;
      
      effect(ballX1, 0, "normal");
      
      ballPosition1();
      
      //OscMessage myMessage = new OscMessage("/puredata/playSound");
      //oscP5.send(myMessage, myRemoteLocation);
      
      randomOscMessage();
      RepeatSound repeat = new RepeatSound(randomOscMessage());
      repeat.start();
     
    } else if (ballY1 < height && ballY1 != -100) {
      noFill();
      stroke(100);
      strokeWeight(2);
      ellipse(ballX1, ballY1, 20, 20);
      ballY1 = ballY1 + 3 * speed;
      
      effect(ballX1, ballY1, "ball");
      //++ count;
    } else {
      //background(0);
      //fill((200));
      //textSize(48);
      //text("MISS",width/2-50,height/2);
      OscMessage myMessage = new OscMessage("/puredata/playSound/6");
      oscP5.send(myMessage, myRemoteLocationMiss);
      
      life = life - 10;
      calcunateHighestCombo(combo);
      fill(200, 0, 0);
      rect(0, height-25, life, 25);
      ballY1 = -50;
      
      effect(ballX1, ballY1, "miss");
      
      ballPosition1();
    }
  
    if (mouseX > ballX2 - board && mouseX < ballX2 + board && ballY2 > mouse-7*speed && ballY2 < mouse+7*speed) {
      ballY2 = -50;
      ++score;
      ++combo;
      reward = true;
      
      effect(ballX2, 0, "normal");
      
      ballPosition2();
      
      //OscMessage myMessage = new OscMessage("/puredata/playSound");
      //oscP5.send(myMessage, myRemoteLocation);
      
      RepeatSound repeat = new RepeatSound(randomOscMessage());
      repeat.start();
      
    } else if (ballY2 < height && ballY2 != -100) {
      noFill();
      stroke(100);
      strokeWeight(2);
      ellipse(ballX2, ballY2, 20, 20);
      ballY2 = ballY2 + 4.5 * speed;
      
      effect(ballX2, ballY2, "ball");
      //++ count;
    } else {
      //background(0);
      //fill((200));
      //textSize(48);
      //text("MISS",width/2-50,height/2);
      OscMessage myMessage = new OscMessage("/puredata/playSound/6");
      oscP5.send(myMessage, myRemoteLocationMiss);
      
      life = life - 10;
      calcunateHighestCombo(combo);
      fill(200, 0, 0);
      rect(0, height-25, life, 25);
      ballY2 = -50;
      
      effect(ballX2, ballY2, "miss");
      
      ballPosition2();
    }

    if (mouseX > ballX3 - board && mouseX < ballX3 + board && ballY3 > mouse-7*speed && ballY3 < mouse+7*speed) {
      ballY3 = -50;
      ++score;
      ++combo;
      reward = true;
      
      effect(ballX3, 0, "normal");
      
      ballPosition3();
      
      //OscMessage myMessage = new OscMessage("/puredata/playSound");
      //oscP5.send(myMessage, myRemoteLocation);
      
      RepeatSound repeat = new RepeatSound(randomOscMessage());
      repeat.start();
      
    } else if (ballY3 < height && ballY3 != -100) {
      noFill();
      stroke(100);
      strokeWeight(2);
      ellipse(ballX3, ballY3, 20, 20);
      ballY3 = ballY3 + 5.8 * speed;
      
      effect(ballX3, ballY3, "ball");
      //++ count;
    } else {
      //background(0);
      //fill(200);
      //textSize(48);
      //text("MISS",width/2-50,height/2);
      OscMessage myMessage = new OscMessage("/puredata/playSound/6");
      oscP5.send(myMessage, myRemoteLocationMiss);
      
      life = life - 10;
      calcunateHighestCombo(combo);
      fill(200, 0, 0);
      rect(0, height-25, life, 25);
      ballY3 = -50;
      
      effect(ballX3, ballY3, "miss");
      
      ballPosition3();
    }
    
  if(speed > 1) {
    if (mouseX > ballX4 - board && mouseX < ballX4 + board && ballY4 > mouse-7*speed && ballY4 < mouse+7*speed) {
      OscMessage myMessage = new OscMessage("/puredata/playSound/8");
      oscP5.send(myMessage, myRemoteLocationBoom);
      if(life>100){
      danger = true;
      dangerCount = 50;
      }
      background(255, 0, 0);
      fill(200);
      textSize(48);
      text("DANGER!", width/2-90, height/2);
      life = life - 100;
      calcunateHighestCombo(combo);
      fill(200, 0, 0);
      rect(0, height-25, life, 25);
      ballY4 = -50;
      
      effect(ballX4, 0, "red");
      
      ballPosition4();
      
    } else if (ballY4 < height && ballY4 != -100) {
      fill(random(60, 255), 0, 0);
      noStroke();
      ellipse(ballX4, ballY4, 20, 20);
      ballY4 = ballY4 + 2 * speed;
      effect(ballX4, ballY4, "ball");
      //++ count;
    } else {
      ballY4 = -50;
      ballPosition4();
    }
  }
  
    if (speed > 1.6) {
      if (mouseX > ballX7 - board && mouseX < ballX7 + board && ballY7 > mouse-7*speed && ballY7 < mouse+7*speed) {
        OscMessage myMessage = new OscMessage("/puredata/playSound/7");
        oscP5.send(myMessage, myRemoteLocationBlue);
        
        //background(0, 0, 200);
        //fill(200);
        //textSize(48);
        //text("DANGER!",width/2-90,height/2);
        //life = life - 100;
        //reward = 0;
        //if (speed > 2) {
        //  speed = speed + 0.5;
        //}
        if (board < 49) {
          board = board + 7;
        }
        boardCount = 850;
        if (life < 120) {
          rewardLifeCount=50;
          life = life + 80;
          fill(0, 200, 0);
          rect(0, height-25, life, 25);
        }
        fill(200, 0, 0);
        rect(0, height-25, life, 25);
        ballY7 = -4500;
        
        effect(ballX7, 0, "blue");
        
        ballPosition7();
        
      } else if (ballY7 < height && ballY7 != -5000) {
        fill(0, 0, 200);
        noStroke();
        ellipse(ballX7, ballY7, 20, 20);
        if(speed < 2.5)
        ballY7 = ballY7 + 13;
        else
        ballY7 = ballY7 + 14;
        
        effect(ballX7, ballY7, "ball");
        //++ count;
      } else {
        ballY7 = -4500;
        ballPosition7();
      }
    }

    if (speed > 2.0) {
      if (mouseX > ballX5 - board && mouseX < ballX5 + board && ballY5 > mouse-7*speed && ballY5 < mouse+7*speed) {
        OscMessage myMessage = new OscMessage("/puredata/playSound/8");
        oscP5.send(myMessage, myRemoteLocationBoom);
        
        if(life>100){
          danger = true;
          dangerCount = 50;
        }
        background(255, 0, 0);
        fill(200);
        textSize(48);
        text("DANGER!", width/2-90, height/2);
        life = life - 100;
        calcunateHighestCombo(combo);
        fill(200, 0, 0);
        rect(0, height-25, life, 25);
        ballY5 = -50;
        
        effect(ballX5, 0, "red");
        
        ballPosition5();
        
      } else if (ballY5 < height && ballY5 != -100) {
        fill(random(60, 255), 0, 0);
        noStroke();
        ellipse(ballX5, ballY5, 20, 20);
        ballY5 = ballY5 + 2.5 * speed;
        
        effect(ballX5, ballY5, "ball");
        //++ count;
      } else {
        ballY5 = -50;
        ballPosition5();
      }
    }

    if (speed > 2.6) {
      if (mouseX > ballX6 - board && mouseX < ballX6 + board && ballY6 > mouse-7*speed && ballY6 < mouse+7*speed) {
        ballY6 = -50;
        ++score;
        ++combo;
        reward = true;
        
        effect(ballX6, 0, "normal");
        
        ballPosition6();
        
        //OscMessage myMessage = new OscMessage("/puredata/playSound");
        //oscP5.send(myMessage, myRemoteLocation);
        
        RepeatSound repeat = new RepeatSound(randomOscMessage());
        repeat.start();
      
      } else if (ballY6 < height && ballY6 != -100) {
        noFill();
        stroke(100);
        strokeWeight(2);
        ellipse(ballX6, ballY6, 20, 20);
        ballY6 = ballY6 + 6.8 * speed;
        
        effect(ballX6, ballY6, "ball");
        //++ count;
      } else {
        //background(0);
        //fill(200);
        //textSize(48);
        //text("MISS",width/2-50,height/2);
        OscMessage myMessage = new OscMessage("/puredata/playSound/6");
        oscP5.send(myMessage, myRemoteLocationMiss);
        
        life = life - 10;
        calcunateHighestCombo(combo);
        fill(200, 0, 0);
        rect(0, height-25, life, 25);
        ballY6 = -50;
        
        effect(ballX6, ballY6, "miss");
        
        ballPosition6();
      }
    }
    if (count > 600) {
      faster();
      count = 0;
      if (life <= width-150 && life > 120) {
        rewardLifeCount=50;
        life = life + 10;
        fill(0, 200, 0);
        rect(0, height-25, life, 25);
      }
      if (life <= 120) {
        rewardLifeCount=50;
        life = life + 40;
        fill(0, 200, 0);
        rect(0, height-25, life, 25);
      }
    }
    
    if(dangerCount>0) {
      --dangerCount;
    }
    if(dangerCount==0) {
      danger=false;
    }
    
    if (rewardCount>0 && (combo > 10 || combo > 20) && combo < 30) {
      fill(80,0,0);
      text("GOOD!", 285, height/2);
      --rewardCount;
    }
    if (rewardCount>0 && (combo > 35 || combo > 45) && combo < 50) {
      fill(80,0,0);
      text("GREAT!", 285, height/2);
      --rewardCount;
    }
    if (rewardCount>0 && (combo > 55  || combo > 65) && combo < 70) {
      fill(80,0,0);
      text("EXCELLENT!", 275, height/2);
      --rewardCount;
    }
    if (rewardCount>0 && combo > 80) {
      fill(80,0,0);
      text("AMAZING!", 275, height/2);
      --rewardCount;
    }
    if (combo==10 || combo==20 || combo==35 || combo==45 || combo==55 || combo==65 || combo==80) {
       rewardCount = 100;
    }
    if (combo==35 && reward) {
      rewardLifeCount=50;
      life = life + 10;
      fill(0, 200, 0);
      rect(0, height-25, life, 25);
      reward = false;
      //rewardCount = 120;
      //++combo;
    }
    if (combo==55 && reward) {
      rewardLifeCount=50;
      life = life + 10;
      fill(0, 200, 0);
      rect(0, height-25, life, 25);
      reward = false;
      //rewardCount = 120;
      //++combo;
    }
    if (combo==80 && reward) {
      if (life<=120) {
        rewardLifeCount=50;
        life = life + 100;
        fill(0, 200, 0);
        rect(0, height-25, life, 25);
        reward = false;
        //rewardCount = 120;
        //++combo;
      } else {
        rewardLifeCount=50;
        life = life + 20;
        fill(0, 200, 0);
        rect(0, height-25, life, 25);
        reward = false;
       // ++combo;
      }
    }
    
    if (rewardLifeCount>0) {
      textSize(20);
      fill(0,200,0);
      text("++♥", 310, height/2+35);
      --rewardLifeCount;
    }
    
    if (life<=10) {
      dangerCount=0;
    }

    if (life<1) {
      calcunateHighestScore(score);
      ballY1=-100;
      ballY2=-100;
      ballY3=-100;
      ballY4=-100;
      ballY5=-100;
      ballY6=-100;
      ballY7=-5000;
      life = 0;
      begin = false;
      replay = true;
      background(0);
      //setup();
      //over = "GAME OVER";
      fill(170);
      textSize(20);
      text("Click mouse to play again", 210, height/2);
    }

    if (boardCount > 0) {
      --boardCount;
    }
    if (boardCount==1) {
      board = 35;
    }
    fill(100);
    noStroke();

    if (mouseY < height*0.76-10)
      mouse = mouseY-(mouseY-height*0.75)*0.85-10;
    else if (mouseY > height*0.9)
      mouse = height*0.9-10;
    else 
    mouse = mouseY-10;
    rect(mouseX-board, mouse, board*2, 10);

    fill(100);
    textSize(21);
    if (!replay)
      text("SCORE: " + score + "   COMBO: " + combo + "   HIGHEST: " + highestCombo, 50, 50);
    else {
      text("SCORE: " + score + "   HIGHEST COMBO: " + highestCombo, 50, 50);
      text("GAME OVER", width-160, 80);
      text("HIGHEST SCORE SO FAR: " + highestScore,50, 80);
      //text("HIGHEST SCORE SO FAR: " + highestScore, 50, 50);
      //text("GAME OVER", 50, 200);
    }
      text("SPEED: " + df.format(speed) + "x", width-160, 50);
    
    ++ count;
  }
  
}

void effect(float position, float positionY, String mode) {
  if(mode.equals("normal")){
  if(speed < 1.3) {
  for (int i=0; i<50; i++) {
      Particle newP = new Particle(position, mouse, i+pts.size(), i+pts.size(), mode);
      pts.add(newP);
      }
  } else if(speed < 1.8) {
  for (int i=0; i<22; i++) {
      Particle newP = new Particle(position, mouse, i+pts.size(), i+pts.size(), mode);
      pts.add(newP);
      }
  } else if(speed < 2.3) {
  for (int i=0; i<11; i++) {
      Particle newP = new Particle(position, mouse, i+pts.size(), i+pts.size(), mode);
      pts.add(newP);
      }
  } else if(speed < 2.9) {
     for (int i=0; i<6; i++) {
      Particle newP = new Particle(position, mouse, i+pts.size(), i+pts.size(), mode);
      pts.add(newP);
      }
  } else {
    for (int i=0; i<3; i++) {
      Particle newP = new Particle(position, mouse, i+pts.size(), i+pts.size(), mode);
      pts.add(newP);
      }
  }
  } else if(mode.equals("ball")){
    for (int i=0; i<1; i++) {
      Particle newP = new Particle(position, positionY, i+pts.size(), i+pts.size(), mode);
      pts.add(newP);
      }
  } else if(mode.equals("miss")){
    for (int i=0; i<150; i++) {
      Particle newP = new Particle(position, height-10, i+pts.size(), i+pts.size(), mode);
      pts.add(newP);
      }
  } else {
    for (int i=0; i<120; i++) {
      Particle newP = new Particle(position, mouse, i+pts.size(), i+pts.size(), mode);
      pts.add(newP);
      }
  }
}

void ballPosition1() {
  ballX1 = random(100, width-100);
}
void ballPosition2() {
  ballX2 = random(ballX1+46, ballX1-46);
}
void ballPosition3() {
  ballX3 = random(ballX2+46, ballX2-46);
}
void ballPosition4() {
  ballX4 = random(200, width-200);
}
void ballPosition5() {
  ballX5 = random(160, width-160);
}
void ballPosition6() {
  ballX6 = random(ballX1-25, ballX3-25);
}
void ballPosition7() {
  ballX7 = random(30, width-30);
}

void faster() {
  //if (speed < 2)
  speed = speed + 0.1;
  //else if (speed > 3)
  //speed = speed + 0.08;
  //else
  //speed = speed + 0.06;
}

void calcunateHighestCombo(int combo) {
  if (combo > highestCombo) {
    highestCombo = combo;
    this.combo = 0;
  } else {
    this.combo = 0;
  }
}

void calcunateHighestScore(int score) {
  if (score > highestScore) {
    highestScore = score;
  }
}

String randomOscMessage() {
  String num = String.valueOf(int(random(0,5)));
  return num;
}

void mousePressed() {
  if (replay) {
    begin = true;
    OscMessage myMessage = new OscMessage("/puredata/playSound");
    oscP5.send(myMessage, myRemoteLocationStart);
    //over = "";
    if (mode.equals("easy"))
      speed = 0.7;
    else if (mode.equals("normal"))
      speed = 1.3;
    else if (mode.equals("hard"))
      speed = 2;
    score = 0;
    count = 0;
    combo = 0;
    ballY1 = -30;
    ballY2 = -30;
    ballY3 = -30;
    ballY4 = -30;
    ballY5 = -30;
    ballY6 = -30;
    ballY7 = -4500;
    board = 35;
    setup();
    replay = false;
    
    for (int i=0; i<150; i++) {
      Particle newP = new Particle(random(mouseX+0, mouseX-0), random(mouseY+0, mouseY-0), i+pts.size(), i+pts.size(), "normal");
      pts.add(newP);
      }
      for (int i=0; i<pts.size (); i++) {
      Particle p = pts.get(i);
      p.update();
      p.display();
      }
      for (int i=pts.size ()-1; i>-1; i--) {
      Particle p = pts.get(i);
      if (p.dead) {
      pts.remove(i);
      }
      }
  }
  else {
    for (int i=0; i<150; i++) {
      Particle newP = new Particle(random(mouseX+0, mouseX-0), random(mouseY+0, mouseY-0), i+pts.size(), i+pts.size(), "normal");
      pts.add(newP);
      }
      for (int i=0; i<pts.size (); i++) {
      Particle p = pts.get(i);
      p.update();
      p.display();
      }
      for (int i=pts.size ()-1; i>-1; i--) {
      Particle p = pts.get(i);
      if (p.dead) {
      pts.remove(i);
      }
      }
    if(mouseX > 275 && mouseX < 380 && mouseY > 325 && mouseY < 345) {
      OscMessage myMessage = new OscMessage("/puredata/playSound/6");
      oscP5.send(myMessage, myRemoteLocationStart);
      mode = "easy";
      speed = 0.7;
      begin = true;
      try{
      Thread.sleep(500);
      }catch(Exception e){
      System.exit(0);
      }
    }
    else if(mouseX > 260 && mouseX < 395 && mouseY > 365 && mouseY < 385) {
      OscMessage myMessage = new OscMessage("/puredata/playSound/6");
      oscP5.send(myMessage, myRemoteLocationStart);
      mode = "normal";
      speed = 1.3;
      begin = true;
      try{
      Thread.sleep(500);
      }catch(Exception e){
      System.exit(0);
      }
    }
    else if(mouseX > 275 && mouseX < 380 && mouseY > 405 && mouseY < 425) {
      OscMessage myMessage = new OscMessage("/puredata/playSound/6");
      oscP5.send(myMessage, myRemoteLocationStart);
      mode = "hard";
      speed = 2.0;
      begin = true;
      try{
      Thread.sleep(500);
      }catch(Exception e){
      System.exit(0);
      }
    }
  }
}