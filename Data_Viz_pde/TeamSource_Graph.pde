/* written by Jessie Contour */
ArrayList noiseValues_bar = new ArrayList();
ArrayList noiseValues_line = new ArrayList();
int noiseValues_Venn;
int PROPER_VALUE = 60;
int framecount = 0;
 
void setup() {
  size(1280, 720);
  background(255);
  frameRate(5);
 
  for (int i = 0; i < 7; i++) { // setting array bargraph, value is -100 ~ 500
    noiseValues_bar.add(0);
  }
  for (int i = 0; i < 30; i++) { // setting array bargraph, value is -100 ~ 500
    noiseValues_line.add(0);
  }
}
void draw() {           // loop
  background(255);      // print to background white 
  
  for(int x=0; x<7; x++){
    stroke(0);
    strokeWeight(2);
    line(0, height-100*x, width, height-100*x);
  }
  
 //BARGRAPH ONE   
  
  for (int i=0; i < noiseValues_bar.size(); i++) {
    if((int)noiseValues_bar.get(i)>75){
     fill(225, 0, 0);// setting bar graph color 
    }
    else{
     fill(125, 0, 125);// setting bar graph color 
    }
    rect(i*width/7+width/14-50, height-200-(int)noiseValues_bar.get(i)*3, 100, (int)noiseValues_bar.get(i)*3+100);             // draw bargraph array
  }
 
  
  //LINE GRAPH
  for (int i=0; i < noiseValues_line.size()-1; i++) {       // sort, reverse and draw line graph
    strokeWeight(5);
    line(i*width/29, height-100-(int)noiseValues_line.get(i)*2, (i+1)*width/29, height-100-(int)noiseValues_line.get(i+1)*2);
  }
  for (int i=0; i < noiseValues_line.size()-1; i++) {       // sort, reverse and draw line graph
    strokeWeight(5);
    fill(125,225,0);        // setting line graph color by black
     ellipse(i*width/29, height-(int)noiseValues_line.get(i)*2-100, 20,20);
    }
   
}