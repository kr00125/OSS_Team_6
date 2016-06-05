/* tree worms                                                                            */
/* Making a tree without a recursive function to make points for particles to travel on. */
/* A neat little sketch that looks kinda cool                                            */
/* portfolio of Michael Pinn.                                                            */
/* http://slambeetle.tumblr.com                                                          */
/* member since May 13, 2014                                                             */

import processing.serial.*;  // 시리얼 통신을 하기 위한 준비.
Serial port;  // 시리얼 객체로 port 선언.
int amps;  // 아두이노에서 가져온 값을 저장할 변수 선언.

ArrayList nodes = new ArrayList();  
ArrayList nodes_right = new ArrayList();
// The temporary storage of end nodes which will later be transfered to the nodes list
ArrayList nextNodes = new ArrayList();
ArrayList nextNodes_right = new ArrayList();
 
Particle[] particles = new Particle[1000];
Particle[] particles_right = new Particle[1000];
 
// Default angle inbetween forked nodes
int mainAngle = 23;
// How big the tree will be in levels
int amount = 6;
// Default distance inbetween nodes
int distance = 130;
// DO NOT EDIT
int endNodeAmount = 2;

final int RAND_ANGLE_S = 0;     // random since value for angle
final int RAND_ANGLE_E = 15;    // random untill value for angle
final int RAND_DIST_S = 20;     // random since value for distance
final int RAND_DIST_E = 70;     // random untill value for distance
final int RAND_SPEED_S = 0;     // random since value for speed
final int RAND_SPEED_E = 5;     // random untill value for speed

int dB=0;                                        //input values 

float avadB = 30;                                // dB avarage
int nextdB = 60;                                // dB avarage, next target value 
float v_dB = (float)(nextdB - avadB)/20;         // Change values 
int framecount=1;                                // frame count
int dB_Queue_index = 0;                          // index for dB_Queue

int speedValue = 0;

ArrayList [] dB_Queue;          // Queue

PImage img;
PImage img2;
PImage img3;
PImage[] music = new PImage[3]; // Image

int bkR = 255;  // 바탕색(R)
int bkG = 255;  // 바탕색(G)
int bkB = 255;  // 바탕색(B)

////////////////////////////////////////////////////////////////////////set up
void setup() {
  printArray(Serial.list());  // 사용 가능한 시리얼 포트를 모두 리스트.
  port = new Serial(this, Serial.list()[2], 115200);  // 2번 시리얼 포트를 사용. (현재 컴퓨터에서 사용하는 아두이노 포트가 2번이기 때문). 통신 속도는  115200bps.
  frameRate(60);
  size(1280, 720);
  noStroke();
  fill(255);                    // background fill white color
  
  dB_Queue = new ArrayList[2];
  dB_Queue[0] = new ArrayList();
  dB_Queue[1] = new ArrayList();  // set dB_Queue
  
  img = loadImage("moombo1.png");
  img2 = loadImage("moombo2.png");
  img3 = loadImage("moombo3.png");
  music[0] = loadImage("phone.png");
  music[1] = loadImage("footstep.png");
  music[2] = loadImage("haha.png"); //////////////load image
  
                                // Add beginning node
  nodes.add(new Node(new PVector(0+50, height/2), 90, distance, 0));
  nodes_right.add(new Node(new PVector(width-50, height/2), 270, distance, 1));
                                // Create second node
  Node n = new Node(new PVector(0+distance+50, height/2), 90, distance, 0);
  Node n_right = new Node(new PVector(width-50-distance, height/2), 270, distance, 1);
                                // Make branching nodes
  n.addNextNodes();
  n_right.addNextNodes();
  n.mn = (Node) nodes.get(0);
  n.mn = (Node) nodes_right.get(0);
                                // Add node into list
  nodes.add(n);
  nodes_right.add(n_right);
 
  amount = (int)pow(amount, 2);
 
  while (nodes.size() <= amount) {
                                 // Get the nodes from the temporary arraylist and put them in the nodes arraylist.
    for (int i = 0; i < nextNodes.size(); i++) {
      Node n2 = (Node) nextNodes.get(i);
      nodes.add(n2);
    }
    for(int i=0; i<nextNodes_right.size(); i++){
      Node n2_right = (Node) nextNodes_right.get(i);
      nodes_right.add(n2_right);
    }
                                 // Clear temporary node list for next iteration
    nextNodes.clear();
    nextNodes_right.clear();
    for (int i = 0; i < nodes.size(); i++) {
                                 // The end nodes will always be at the end of the arraylist. We access them by seeing if
                                 // i > nodes size - the amount of end nodes + 1
      if (i > nodes.size()-(endNodeAmount+1)) {
        Node n3 = (Node) nodes.get(i);
                                 // Check again to see if we can add more points
        if (nodes.size() <= amount) {
          n3.addNextNodes();
        }
      }
      if (i > nodes_right.size()-(endNodeAmount+1)) {
        Node n3 = (Node) nodes_right.get(i);
                                 // Check again to see if we can add more points
        if (nodes_right.size() <= amount) {
          n3.addNextNodes();
        }
      }
    }
                                 // Amount of end points on a fractal tree increases by double the previous amount
    endNodeAmount *= 2;
  }
 
  for (int i = 0; i < particles.length; i++) {
    particles[i] = new Particle(0);
    particles_right[i] = new Particle(1);
  }
}
 
void draw() {
  if(port.available()>0)  // 불필요한 값 걸러냄.
  {
    amps = port.read();  // amps에 시리얼 통신으로 아두이노에서 얻어온 값을 저장.
  }
  println(amps);  // amps값 콘솔에 출력.
  
  background(bkR, bkG, bkB);
  
  if(avadB<20){
    bkR = 184;
    bkG = 229;
    bkB = 112;
    image(img, 0, 0);
  }
  else if(avadB>100){
    bkR = 226;
    bkG = 113;
    bkB = 113;
    image(img3, 0, 0);
  }
  else{
    bkR = 226;
    bkG = 172;
    bkB = 113;
    image(img2, 0, 0);
  }
  
  for (int i = 0; i < avadB/3; i++) {
    particles[i].draw(i);
    particles_right[i].draw(i);
    
    particles[i].move();
    particles_right[i].move();
  }
  
  dB = amps/2;
  
  dB_Queue[dB_Queue_index].add((int)dB);
  avadB += v_dB;
  if(framecount%20==0){
    int sum = 0;
    for(int x=0; x<dB_Queue[dB_Queue_index].size(); x++){
      sum+=(int)dB_Queue[dB_Queue_index].get(x);
    }
    avadB = nextdB;
    nextdB = sum/dB_Queue[dB_Queue_index].size();
    v_dB = (nextdB - avadB)/20;    
    if(dB_Queue_index==0) dB_Queue_index = 1;
    else dB_Queue_index=0;
   
    dB_Queue[dB_Queue_index].clear();
  }
  speedValue = (int)avadB/20;
  framecount++;
}
 
class Node {                             // Node Class
  PVector loc;                           // define vector loc
 
  float angle, dist;                     // define angle and distance
                                         // leftNode, rightNode and middleNode
                                         // The left and right are used to determine the particles next position, the middleNode is for making
                                         // lines with the bottom and second bottom nodes as they do not have left or right nodes
  Node ln, rn, mn;                       // Node ln(left), rn(right), mn(middle)
  int location;                          // check left or right. left is 0, right is 1
 
  Node(PVector l, float a, float d, int locate) {    //Node constructor
    loc = l.get();                       // loc <- l(vector)
    angle = a;                           // angle <- a(float)
    dist = d-20;                         // dist <- d(float)
    this.location = locate;              // add location
  }
 
  void addNextNodes() {                  // add next node function
                                         // Get the direction and distance the next point will be placed
    PVector vel = new PVector(sin(radians(angle-random(RAND_ANGLE_S, RAND_ANGLE_E)+mainAngle))*(dist-random(RAND_DIST_S, RAND_DIST_E)), cos(radians(angle-random(RAND_ANGLE_S, RAND_ANGLE_E)+mainAngle))*(dist-random(RAND_DIST_S, RAND_DIST_E)));
                                         // Add the x velocity onto loc.x. We subtract the y value because we are moving up
    ln = new Node(new PVector(loc.x+vel.x, loc.y-vel.y), angle+mainAngle, distance, location);
    
                                         // Subtract 45 degees to make the 90 degree difference between nodes
    vel = new PVector(sin(radians(angle+random(RAND_ANGLE_S, RAND_ANGLE_E)-mainAngle))*(dist-random(RAND_DIST_S, RAND_DIST_E)), cos(radians(angle+random(RAND_ANGLE_S, RAND_ANGLE_E)-mainAngle))*(dist-random(RAND_DIST_S, RAND_DIST_E)));
    rn = new Node(new PVector(loc.x+vel.x, loc.y-vel.y), angle-mainAngle, distance, location);
    if(location==0){
        nextNodes.add(ln);
        nextNodes.add(rn);
    }
    else if(location==1){
        nextNodes_right.add(ln);
        nextNodes_right.add(rn);
    }
  }
}
 
class Particle {                         // Particle Class (ipja)
  PVector loc, ploc;                     // define vertor loc and ploc
  int location;
  float speed = random(RAND_SPEED_S, RAND_SPEED_E);          // define particle speed -> random number 0.5~1
 
  Node node;                             // define Node class one named node
 
  Particle(int l) {    // Particle Constructor
    location = l;
    if(location==0){
      Node ns = (Node) nodes.get(0);       // define Node ns <- first element in nodes, arraylist
      loc = ns.loc.get();                  // vector loc is Node ns's vector
      node = (Node) nodes.get(1);          // Node node <- second element in nodes, arraylist
      ploc = node.loc.get();               // vector ploc is Node node's vector
    }
    else if(location==1){
      Node ns = (Node) nodes_right.get(0);     
      loc = ns.loc.get();                
      node = (Node) nodes_right.get(1);          
      ploc = node.loc.get();               
    }
  }
 
  void draw(int x) {                          // Particle draw to screen
    fill(255);
    //rect(loc.x, loc.y, 30, 30);            //draw Image
    image(music[x%3], loc.x-avadB/2, loc.y-avadB/2, avadB/1.5, avadB/1.5);
  }
 
  void move() {                          // Particle move function
    PVector vel = new PVector(ploc.x - loc.x, ploc.y - loc.y);  // define vector vel <- ploc-loc
    vel.normalize();                     // vel normalize the vector to a length of 1
    vel.mult(speed+speedValue);                     // vel scalar value is 'speed' 
    loc.add(vel);                        // loc<- loc + vel
 
    if (PVector.dist(loc, ploc) < speedValue+5) {   // calculate the distance between two points, loc and ploc if loc <-> ploc < 2
      nextNode();                        // call nextNode function 
    }
  }
 
  void nextNode() {                      // nextNode function
    // Pick between the left or right node
    if (random(1) < 0.5) {               // random 0~1 if random value 0.5 under(50%)
      node = node.ln;                    // node add left
    } else {
      node = node.rn;                    // node add right
    }
    // If there is no left or right not AKA we reached the end.
    if(location==0){
      if (node != null) {                  // if node value is not null 
        ploc = node.loc.get();             // ploc is node's vector loc 
      } else {
        // Set the location back to the beginning 
        node = (Node) nodes.get(0);        // node <- first element in nodes arraylist
        loc = node.loc.get();              // loc <- Modernized node's vector loc
        // Set the next location to the next point // 
        node = (Node) nodes.get(1);        // node <- second element in nodes arraylist
        ploc = node.loc.get();             // ploc <- Modernized node's vector loc
      }
    }
    else if(location==1){
      if (node != null) {                  // if node value is not null 
        ploc = node.loc.get();             // ploc is node's vector loc 
      } else {
        // Set the location back to the beginning 
        node = (Node) nodes_right.get(0);        // node <- first element in nodes arraylist
        loc = node.loc.get();              // loc <- Modernized node's vector loc
        // Set the next location to the next point // 
        node = (Node) nodes_right.get(1);        // node <- second element in nodes arraylist
        ploc = node.loc.get();             // ploc <- Modernized node's vector loc
      }
    }
  }
}