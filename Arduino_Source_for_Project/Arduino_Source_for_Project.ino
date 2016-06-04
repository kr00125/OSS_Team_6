/*****************************************
  Example Sound Level Sketch for the
  Adafruit Microphone Amplifier
****************************************/

const int sampleWindow = 50; // (50ms=20Hz) 20Hz로 샘플링. 20Hz는 사람의 최저 가청 한도.
unsigned int sample;  // 마이크 모듈에서 받아오는 값. 아날로그 핀은 0~1023까지 표현 가능.

/* setup() 함수 : 아두이노 스케치가 실행될 때 최초 1회 실행. */
void setup()
{
  Serial.begin(115200); // 시리얼 통신 사용을 알림. 매개변수인 speed에 정해진 Baud Rate(초당 전송받는 비트 수)값을 입력. 115200bps의 속도.
}

/* loop() 함수 : setup() 함수 수행 후 실행. 무한 반복되는 영역. */
void loop() {
  unsigned long startMillis = millis(); // millis() 함수 : 아두이노에 전원이 인가된 후의 시간. 밀리초 단위
  unsigned int peakToPeak = 0;  // 진폭. signalMax에서 signalMin을 뺀 값.

  unsigned int signalMax = 0; // 50ms마다 전압 최저값
  unsigned int signalMin = 1024;  // 50ms마다 전압 최고값.

  /* 50ms의 데이터를 수집 */
  while (millis() - startMillis < sampleWindow) // 현재 millis() 시간에서, loop문을 돌 때 저장된 startMillis의 값을 뺀 것이 50ms 보다 작을 때.
  {
    sample = analogRead(0); // 아날로그 A0 핀에 연결된 마이크 모듈의 현재 값을 저장. (0~1023)
    if (sample < 1024)  // 1024가 넘어가는 값들 버림.
    {
      if (sample > signalMax)
      {
        signalMax = sample; // 최고 레벨의 값을 저장.
      }
      else if (sample < signalMin)
      {
        signalMin = sample; // 최저 레벨의 값을 저장.
      }
    }
  }
  peakToPeak = signalMax - signalMin; // 진폭 값을 저장.
  //int amps = peakToPeak; // 프로세싱으로 보내려는 진폭 값을 저장.
  
  long amps = map(peakToPeak, 0, 680, 0, 255);  // peakToPeak의 범위 : 0~680, 프로세싱으로 0~255 사이의 값만이 전달되기 때문에 매핑.
  
  Serial.write(amps);  // 프로세싱에 매개변수 sensorValue 값(amps) 전송.
}

