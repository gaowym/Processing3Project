import oscP5.*;
import netP5.*;

class RepeatSound extends Thread {
  
NetAddress myRemoteLocationRepeat = new NetAddress("127.0.0.1",12346);
String num;

RepeatSound (String num) {
  this.num = num;
}

public void run() {
  if(speed<2) {
  for(int i=0; i<4; i++) {
    OscMessage myMessage = new OscMessage("/puredata/playSound/" + num);
    oscP5.send(myMessage, myRemoteLocationRepeat);
    try{
    Thread.sleep(1700);
    }catch(Exception e){
    System.exit(0);
    }
    }
  }
  
  if(speed>=2 && speed < 2.7) {
  for(int i=0; i<3; i++) {
    OscMessage myMessage = new OscMessage("/puredata/playSound/" + num);
    oscP5.send(myMessage, myRemoteLocationRepeat);
    try{
    Thread.sleep(2000);
    }catch(Exception e){
    System.exit(0);
    }
    }
  }
  
  if(speed>=2.7 && speed < 3.5) {
  for(int i=0; i<2; i++) {
    OscMessage myMessage = new OscMessage("/puredata/playSound/" + num);
    oscP5.send(myMessage, myRemoteLocationRepeat);
    try{
    Thread.sleep(2400);
    }catch(Exception e){
    System.exit(0);
    }
    }
  }
  
  if(speed>=3.5) {
  for(int i=0; i<1; i++) {
    OscMessage myMessage = new OscMessage("/puredata/playSound/" + num);
    oscP5.send(myMessage, myRemoteLocationRepeat);
    try{
    Thread.sleep(2900);
    }catch(Exception e){
    System.exit(0);
    }
    }
  }
}
}