int input0 =0;
int pinValue=0;

void setup(){
  pinMode(input0, INPUT);
  Serial.begin(9600);
}

void loop(){
  pinValue = analogRead(input0);
  Serial.println(pinValue);
}

