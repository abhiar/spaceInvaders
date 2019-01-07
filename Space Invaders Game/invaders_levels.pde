import processing.serial.*;
Serial Port;
Float randX[] = new Float[13];
PImage img;
PImage img2;
Invader invaders[] = new Invader[13];
Bullet bullet;
PFont f;

Spaceship ship;
int inv;
int init;
int count;
int prev=0;
int score;
  float lol=0;
  Integer[] wid = new Integer[13];

  int level=0;////
  int game=1;////
Integer y[]=new Integer[4];////
int total;
int fire=0, capVal=0;


void setup(){
  f=createFont("Arial.regular",36);
  size(1000,1000);
  String portName = Serial.list()[0];
  Port = new Serial(this, portName, 9600);
  Port.clear();
  for(int i=0;i<13;i++){
    if(i==0||i==7)
      randX[i] = random(0,width/20);
    else if(i==12||i==6)
      randX[i] = random(-width/30,0);
    else
      randX[i] = random(-width/30,width/20);
  }
  for(int i=0;i<13;i++){
    wid[i]=1;
  }
  for(int index=0;index<3;index++){
    y[index]=0;
  }////
  frameRate(180);
}

Integer[] speed = new Integer[3];

void draw(){
  speed[0]=400;
  speed[1]=300;
  speed[2]=150;
  if(game<4)
  {////
  bullet = new Bullet(0,0);
  background(255);
  img = loadImage("alien.png");
  img2 = loadImage("spaceship.png");
  y[game]= (millis()-prev)/speed[level];////
  for(inv=0;inv<13;inv++){
    if(inv<7){
      invaders[inv] = new Invader(inv*(width/7)+randX[inv], y[game]*10,wid[inv]);////
    }
    else if(inv<13 && inv>6){
      invaders[inv] = new Invader((inv-7)*(width/7)+randX[inv], y[game]*10+120,wid[inv]);////
    }
  }
  int next = millis();
  
  if ( Port.available() > 0) 
  {  
  String sig = Port.readStringUntil('\n');
  if(sig != null) {
    total = int(trim(sig));
    fire=total%100;
    capVal=int(map(total/100,30,200,0,width));
  }
  } 
  
  ship= new Spaceship(capVal,height-100);
  if(fire==10 && count==0){
    init=millis();
    count=1;
    bullet.active=1;
    lol = ship.xpos+40;
    fire=0;  
  }
    
  if(count==1)
  bullet = new Bullet(lol,ship.ypos-((millis()-init)));
  
  if(bullet.ypos<10){
    count=0;
  }
  for(int index=0;index<13;index++){
    if(bullet.xpos>invaders[index].xpos && bullet.xpos<(invaders[index].xpos+invaders[index].w)){
    for(int t=-50;t<50;t++ ){
      if(bullet.ypos == invaders[index].ypos+t){
        count=0;
        wid[index]=0;
        score+=100;
        println(score);
      }
    }
  }}
  
  if(invaders[10].ypos+120>950 && score!=1300){
    for(int i=0;i<13;i++){
      wid[i]=0;
    }
     
     y[game-1]=prev;////
     println("You lose!");
     background(255);
     //text("You Lose!",width/2,height/2);
     reset();////
  }
  
  if(score==1300*(level+1)){
  
  println("You won");
  nextLevel();
  }
  
  }
  
  else 
    println("GAME OVER");
}

void reset(){
  level=0;
  game++;
  for(int i=0;i<13;i++){
      wid[i]=1;
    }
  delay(3000);
  prev=millis();////
}////

void nextLevel(){
  level++;
  game++;
  for(int i=0;i<13;i++){
      wid[i]=1;
    }
  delay(3000);
  prev=millis();////
}////

class Invader{
  int w;
  int h=100;
  float xpos;
  float ypos;
  int active=1;
  Invader(float x, float y, int wid){
    xpos = x;
    ypos = y;
    w=100*wid;
    image(img,x,y,w,h);
    
  }
}


public class Spaceship{
  float xpos;
  float ypos;
  int w = 100;
  int h = 100;
  Spaceship(float x, float y){
    xpos=x;
    ypos=y;
    image(img2,xpos,ypos,w,h);
  }
}


//void toShoot(){  bullet[bul] = new Bullet(ship.xpos,ship.ypos);}

class Bullet{
  float xpos;
  float ypos;
  int w=20;
  int h=50;
  int active=0;
  Bullet(float x,float y){
    xpos = x;
    ypos=y;
    fill(255,0,0);
    rect(x,y,w,h);
  }
}