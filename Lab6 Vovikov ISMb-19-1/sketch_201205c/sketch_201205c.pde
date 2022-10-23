import processing.opengl.*;
import java.awt.event.KeyEvent;

boolean engineStarter = false, down = false, up = false, right = false, left = false;

float xmag, ymag = 0; 
float newXmag, newYmag = 0;

float X = 0, Y = 0, Z;
float speedMove = 2;
float speedRotatePropeller = 0;

float SpeedMax = 4;
float SpeedMin = 0;
float speed = 0;

float rotateHelicopter = 0;

float planeMax = 500;
float planeMin = -500;
float plane;
boolean planeUp = false, planeDown = false;

PImage Up, Down, Back, Front, Right, Left;

float test = 0;
PShape body;
PShape propeller;

public void keyPressed(KeyEvent e){
  if(e.getKeyCode() == KeyEvent.VK_ENTER){
    engineStarter = !engineStarter;
  }
  else if(e.getKeyCode() == KeyEvent.VK_DOWN){
    down = true;
  }else if(e.getKeyCode() == KeyEvent.VK_UP){
    up = true;
  }else if(e.getKeyCode() == KeyEvent.VK_RIGHT){
    right = true;
  }else if(e.getKeyCode() == KeyEvent.VK_LEFT){
    left = true;
  }
  
  if(e.getKeyCode() == 50){
    planeUp = true;
  }else if(e.getKeyCode() == 49){
    planeDown = true;
  }
}

public void keyReleased(KeyEvent e){
  if(e.getKeyCode() == KeyEvent.VK_DOWN){
    down = false;
  }else if(e.getKeyCode() == KeyEvent.VK_UP){
    up = false;
  }else if(e.getKeyCode() == KeyEvent.VK_RIGHT){
    right = false;
  }else if(e.getKeyCode() == KeyEvent.VK_LEFT){
    left = false;
  }
  
  if(e.getKeyCode() == 50){
    planeUp = false;
  }else if(e.getKeyCode() == 49){
    planeDown = false;
  }
}

void setup () {
size (1280,720,OPENGL);
colorMode(RGB,1);
noStroke();

Back = loadImage("Back.png");
Front = loadImage("Front.png");
Up = loadImage("Up.png");
Down = loadImage("Down.png");
Right = loadImage("Right.png");
Left = loadImage("Left.png");
textureMode(NORMAL);
body = loadShape("helicopter.obj");
propeller = loadShape("helicopter2.obj");

speed = 0.01;
}

void draw () {

background(0,0,0);
newXmag = mouseX/float(width) * TWO_PI;
newYmag = mouseY/float(height) * TWO_PI;
float diff = xmag-newXmag;
if (abs(diff) > 0.01) { xmag -= diff/4.0; }
diff = ymag-newYmag;
if (abs(diff) > 0.01) { ymag -= diff/4.0; }
translate(width/2, height/2);
rotateX(-ymag);
rotateY(-xmag);



if(engineStarter == true){
  speedRotatePropeller += speed;
  if(speed >= SpeedMax){
    speed = SpeedMax;
  }else{
    speed += 0.005;
  }
}else if((engineStarter == false) && (speedRotatePropeller > 0)){
  speedRotatePropeller -= speed;
  if(speed <= SpeedMin){
    speed = SpeedMin;
  }else{
    speed -= 0.005;
  }
}

if(speedRotatePropeller < 0){
  speedRotatePropeller = 0;
}

pushMatrix();
if(right == true){
  rotateHelicopter += 0.01;
}else if(left == true){
  rotateHelicopter -= 0.01;
}

rotateY(rotateHelicopter);

rotateX(4.70);
translate(-100,0);
scale(2000);


beginShape(QUADS);
texture(Down);
textureWrap(CLAMP);
vertex(1,-1,-1,  0, 0);
vertex(-1,-1,-1, 1, 0);
vertex(-1, 1,-1, 1, 1);
vertex( 1, 1,-1, 0, 1);
endShape();

beginShape(QUADS);
texture(Left);
vertex(-1,-1,-1, 0, 1);
vertex(-1,1,-1, 1, 1);
vertex(-1,1,1, 0, 0);
vertex(-1,-1,1, 1, 0);
endShape();

beginShape(QUADS);
texture(Back);
vertex(-1,-1,-1, 0, 1);
vertex(-1,-1,1, 0, 0);
vertex(1,-1,1, 1, 0);
vertex(1,-1,-1, 1, 1);
endShape();

beginShape(QUADS);
texture(Right);
vertex(1,1,1, 1, 0);
vertex(1,1,-1, 1, 1);
vertex(1,-1,-1, 0, 1);
vertex(1, -1, 1, 0, 0);
endShape();

beginShape(QUADS);
texture(Front);
vertex(1,1,1, 1, 0);
vertex(-1,1,1, 0, 0);
vertex(-1,1,-1, 1, 1);
vertex(1,1,-1, 0, 1);
endShape();

beginShape(QUADS);
texture(Up);
vertex(1,1,1, 0, 0);
vertex(1,-1,1, 1, 1);
vertex(-1,-1,1, 1, 0);
vertex(-1,1,1, 0, 1);

endShape();
popMatrix();


pushMatrix();

if(planeUp == true){
  if(plane < planeMax){
    plane += 1;
  }
}else if(planeDown == true){
  if(plane > planeMin){
    plane -= 1;
  }
}

pushMatrix();
if(up == true){
  Z -= speedMove;
}else if(down == true){
  Z += speedMove;
}

translate(0, plane, Z);
scale(50, 50, 50);
beginShape();
shape(body,0,0);
endShape();

popMatrix();

pushMatrix();
if(up == true){
  Z -= speedMove;
}else if(down == true){
  Z += speedMove;
}

translate(0, -47 + plane, Z);

if(speedRotatePropeller != 0){
  rotateY(speedRotatePropeller);
}

scale(50, 50,50);
beginShape();
shape(propeller,0,0);
endShape();
popMatrix();

popMatrix();

}
