// Matthew Loewen
// This code gets values sent from arduino 
// currently we skip things such as hand shaking
// Audio from: https://www.partnersinrhyme.com

import processing.serial.*;
import ddf.minim.*;

Minim minim;
AudioPlayer[] player = new AudioPlayer[10];


//object to hold serial info
Serial myPort;
//string to hold communication from arduino
String val;

void setup()
{
  //connect to the arduino
  //get ready for communication
  String portName = Serial.list()[1];
  myPort = new Serial(this, portName, 9600);

  minim = new Minim(this);
  for (int i=0; i<10; i++) {
    player[i] = minim.loadFile("./sounds/"+str(i)+".mp3");
  }
}

void draw()
{
  //check to see if connected 
  if ( myPort.available() > 0)
  {  // If data is available
    val = myPort.readStringUntil('\n');
  } 
  if (val != null) {
    println("ength is: " + val.length());
    print(val);
    val = val.trim();
    for (int i = 0; (i < val.length() && val.length() <= 10); i++) {
      if (val.charAt(i) == '1') {
        if(player[i].isPlaying()){}
        else {
          player[i].loop();
        }
      } else {
        player[i].pause();
      }
    }
  }
  frameRate(200);
}
