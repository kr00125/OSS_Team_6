/* written by Jessie Contour */
ArrayList noiseValues_bar = new ArrayList();
ArrayList noiseValues_line = new ArrayList();
int noiseValues_Venn;
int PROPER_VALUE = 50;
int framecount = 0;
final int HEIGHT_HALF = 360; 
 
void setup() {
  size(1280, 720);
  background(255);
  frameRate(5);
 
  for (int i = 0; i < 7; i++) { // setting array bargraph, value is -100 ~ 500
    noiseValues_bar.add(0);
  }
  for (int i = 0; i < 20; i++) { // setting array bargraph, value is -100 ~ 500
    noiseValues_line.add(0);
  }
}


void draw() {           // loop
  background(255);      // print to background white 
  
  line(0, HEIGHT_HALF, width, HEIGHT_HALF);
  
 //BARGRAPH ONE   
  
  for (int i=0; i < noiseValues_bar.size(); i++) {
    if((int)noiseValues_bar.get(i)>75){
     fill(225, 0, 0);// setting bar graph color 
    }
    else{
     fill(125, 0, 125);// setting bar graph color 
    }
    rect(i*width/7+width/14-50, height-(int)noiseValues_bar.get(i)*3, 100, (int)noiseValues_bar.get(i)*3+100);             // draw bargraph array
  }
 
  
  //LINE GRAPH
  for (int i=0; i < noiseValues_line.size()-1; i++) {       // sort, reverse and draw line graph
    strokeWeight(5);
    line(i*width/29, (HEIGHT_HALF-50)-(int)noiseValues_line.get(i)*2, (i+1)*width/29, (HEIGHT_HALF-50)-(int)noiseValues_line.get(i+1)*2);
  }
  for (int i=0; i < noiseValues_line.size(); i++) {       // sort, reverse and draw line graph
    strokeWeight(5);
    fill(125,225,0);        // setting line graph color by black
     ellipse(i*width/29, (HEIGHT_HALF-50)-(int)noiseValues_line.get(i)*2, 20,20);
    }

 //VENN DIAGRAM
 
 for (int i = 0; i < noiseValues_line.size(); i++) {           // setting diagram values
    noiseValues_Venn+= (int)noiseValues_line.get(i);   
  }
  noiseValues_Venn/=20;
  if(noiseValues_Venn<=PROPER_VALUE){
    fill(20,200,PROPER_VALUE*1.2);
  }
  else if(noiseValues_Venn<=PROPER_VALUE*1.2){
    fill(200,200,PROPER_VALUE*1.2);
  }
  else{
    fill(255,100,PROPER_VALUE*1.2);
  }
  ellipse(width-300, HEIGHT_HALF/2, noiseValues_Venn*2, noiseValues_Venn*2);
  fill(20,200,PROPER_VALUE*1.2);
  ellipse(width-100, HEIGHT_HALF/2, PROPER_VALUE*2, PROPER_VALUE*2);               // draw venn diagram proper values and dB_value;
   
  noiseValues_bar.remove(0);
  noiseValues_bar.add(framecount);
  noiseValues_line.remove(0);
  noiseValues_line.add(framecount);
  framecount = (int)random(35,80);  /////////////////dB_value;
}