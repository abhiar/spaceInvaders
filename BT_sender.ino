#include <CapacitiveSensor.h>
#include<SoftwareSerial.h>

SoftwareSerial BTSerial(6,7); //RX,TX

int accVal;
int plateVal;
int prevData, platePrev;

CapacitiveSensor   cs = CapacitiveSensor(4,2);
void setup()                    
{
   cs.set_CS_AutocaL_Millis(0xFFFFFFFF);
   Serial.begin(9600);
   BTSerial.begin(9600);
   
   prevData=map(analogRead(A0),250,450,0,255);
   platePrev=cs.capacitiveSensor(30);
}

void loop()                    
{   plateVal = cs.capacitiveSensor(30);
    if(plateVal>300 && platePrev<300) {
      BTSerial.write(1);
      delay(1);
      BTSerial.write(10);
      //delay(1);
      //BTSerial.write(1);
      //delay(1);
      //BTSerial.write(1);
    }
    int a=map(analogRead(A0),250,450,0,255);
    if(a-prevData>10 || prevData-a>10) {
      BTSerial.write(2);
      delay(1);
      BTSerial.write(a);
      prevData=a;
    }
    platePrev=plateVal;
}
