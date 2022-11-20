#include "DigiKeyboard.h"
#include <EEPROM.h>

/* 

   Aleph8 Digital Key

   Code: 5970 Bytes
   EEPROM used: 61 bits

   Binary encode: 1 - long , 0 - short
   
*/

const int PASS_SIZE = 30;
const int random1 = 1000;
const int n_components = 36;
const int combination[4] = {1,0,1,1};
float initTime = millis();
int components[n_components] = {KEY_A,KEY_B,KEY_C,KEY_D,KEY_E,KEY_F,KEY_G,KEY_H,KEY_I,KEY_J,KEY_K,KEY_L,KEY_M,KEY_N,KEY_O,KEY_P,KEY_Q,KEY_R,KEY_S,KEY_T,KEY_U,KEY_V,KEY_W,KEY_X,KEY_Y,KEY_Z,KEY_1,KEY_2,KEY_3,KEY_4,KEY_5,KEY_6,KEY_7,KEY_8,KEY_9,KEY_0};
int first_time,second_time,sentinel,digit;
bool t;


void setup() {for (int i = random(1,4) ; i < 5 ; i++){randomOrder(components);}pinMode(2,INPUT);DigiKeyboard.sendKeyStroke(0);DigiKeyboard.println("Waiting...");sentinel = 0;EEPROM.get(0,t);}

void loop() {
  DigiKeyboard.delay(500);
  //DigiKeyboard.println(t);
  first_time = millis();
  if (digitalRead(2) == 0){
    while(digitalRead(2)==0){}
    second_time = millis()-first_time;
    //DigiKeyboard.println(second_time);
    if(second_time < 1000){validation(0);}else if(second_time < 4000){validation(1);}else if(second_time < 9000){password(false);}else{DigiKeyboard.println("Reset...");t = true;EEPROM.put( 0, t );}
  }
}

void validation(int n){
  digit = n;
  if( digit == combination[sentinel]){
    sentinel++;
    if(sentinel == 4){password(true);sentinel = 0;}
  }else{sentinel = 0;}  
}

void password(bool b){
      digitalWrite(1,HIGH);
      DigiKeyboard.delay(1000*random(0,3));
      DigiKeyboard.sendKeyStroke(0);
      int a[PASS_SIZE];
      if( (t || t == 255) && b ){
        genPass(a);
        t = false;
        EEPROM.put( 0, t );
        EEPROM.put( 9, a );
      }else if( !t && b ){
        EEPROM.get( 9, a );
        translatePass(a);
      }else{genPass(a);translatePass(a);}
      digitalWrite(1,LOW);
}

void randomOrder(int pass[PASS_SIZE]){
  int tmp,rdm;
  randomSeed(analogRead(PB1)+(millis()-initTime));
  for(int i = 0 ; i < PASS_SIZE ; i ++){
    rdm = random(0,n_components);
    tmp = pass[i];
    pass[i] = pass[rdm];
    pass[rdm] = tmp; 
  }
}

void translatePass(int pass[PASS_SIZE]){
  for(int i = 0; i < PASS_SIZE;i++){
    DigiKeyboard.sendKeyStroke(pass[i]);
  }
  DigiKeyboard.sendKeyStroke(KEY_ENTER);
}

void genPass(int pass[PASS_SIZE]){
  randomSeed(random(analogRead(PB1),random1)/millis()-initTime);
  for(int i = 0; i < PASS_SIZE ; i++){
    pass[i] = components[random(0,(n_components-1))];
    DigiKeyboard.delay(500);
  }
}
