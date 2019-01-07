#include<SoftwareSerial.h>

SoftwareSerial BTSerial(6, 7); //RX, TX

void setup() {
  Serial.begin(9600);
  BTSerial.begin(9600);
}
int check,fire,Xcoord;
void loop() {
  if(BTSerial.available()) {
      check=BTSerial.read();
      if(check==1) {
      while(!BTSerial.available());
      fire=BTSerial.read();
      }
      else if(check==2) {
      while(!BTSerial.available());
      int temp=BTSerial.read();
      if(temp!=2) Xcoord=temp;
      }
   Serial.println(Xcoord*100+fire);
   //Serial.println(Xcoord);
   fire=0;
   }
}
