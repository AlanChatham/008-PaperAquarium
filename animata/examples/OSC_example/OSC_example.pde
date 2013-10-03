import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

int receiveAtPort = 12345;
int sendToPort = 7110;      // port of animata
String host;
String oscP5event;

void setup()
{
  size(640, 480);
  frameRate(30);
  oscP5 = new OscP5(this, receiveAtPort);
  myRemoteLocation = new NetAddress("127.0.0.1", sendToPort);
}

// load example scene called "OSC_example.nmt"
// uncomment each line below to see the effect in animata
void draw()
{
  sendJointMsg("joint", mouseX, mouseY);
  //sendBoneMsg("bone", mouseX/(float)width);
  //sendPosMsg("bg", mouseX, mouseY, 0);
  //sendVisMsg("bg", (!mousePressed));
  //sendAlphaMsg("bg", mouseX/(float)width);
}


// animate the length of a bone
// name: string, name of the bone
// value: float [0 - 1] length of the bone
void sendBoneMsg(String name, float value) {
  OscMessage myMessage = new OscMessage("/anibone");
  myMessage.add(name);
  myMessage.add(value);
  oscP5.send(myMessage, myRemoteLocation);

  println("/anibone " + name + " " + value);
}

// animate a joint
// name: string, name of the joint
// x, y: float [local screen coordinates]
void sendJointMsg(String name, float x, float y) {
  OscMessage myMessage = new OscMessage("/joint");
  myMessage.add(name);
  myMessage.add(x);
  myMessage.add(y);
  oscP5.send(myMessage, myRemoteLocation);

  println("/joint " + name + " " + x +" " + y);
}


// turn on/off a layer (also turn on/off simulation of the layer)
// name: string, name of the layer
// v: boolean [true, false]
void sendVisMsg(String name, boolean v)
{
  OscMessage myMessage = new OscMessage("/layervis");
  myMessage.add(name);
  myMessage.add(v);
  oscP5.send(myMessage, myRemoteLocation);

  println("/layervis " + name + " " + v);
}


// change the alpha of a layer
// name: string, name of the layer
// value: float [0-1]
void sendAlphaMsg(String name, float value)
{
  OscMessage myMessage = new OscMessage("/layeralpha");
  myMessage.add(name);
  myMessage.add(value);
  oscP5.send(myMessage, myRemoteLocation);

  println("/layeralpha " + name + " " + value);
}

// set the position of a layer
// name: string, name of the layer
// x, y, z: float [local screen coodinates]
void sendPosMsg(String name, float x, float y, float z)
{
  OscMessage myMessage = new OscMessage("/layerpos");
  myMessage.add(name);
  myMessage.add(x);
  myMessage.add(y);
  myMessage.add(z);
  oscP5.send(myMessage, myRemoteLocation);

  println("/layerpos " + name + " " + x + " " + y + " " + z);
}

void oscEvent(OscIn oscIn) 
{
    // here you could process incoming OSC messages
}
