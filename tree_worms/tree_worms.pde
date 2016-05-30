/* tree worms                                                                            */
/* Making a tree without a recursive function to make points for particles to travel on. */
/* A neat little sketch that looks kinda cool                                            */
/* portfolio of Michael Pinn.                                                            */
/* http://slambeetle.tumblr.com                                                          */
/* member since May 13, 2014                                                             */

ArrayList nodes = new ArrayList();  
// The temporary storage of end nodes which will later be transfered to the nodes list
ArrayList nextNodes = new ArrayList();
 
Particle[] particles = new Particle[450];
 
// Default angle inbetween forked nodes
int mainAngle = 30;
// How big the tree will be in levels
int amount = 9;
// Default distance inbetween nodes
int distance = 130;
 
 
// DO NOT EDIT
int endNodeAmount = 2;
 
void setup() {
  size(640, 640);
  noStroke();
  fill(255);                    // background fill white color
                                // Add beginning node
  nodes.add(new Node(new PVector(width/2, height-50), 0, distance));
                                // Create second node
  Node n = new Node(new PVector(width/2, height-50-distance), 0, distance);
                                // Make branching nodes
  n.addNextNodes();
  n.mn = (Node) nodes.get(0);
                                // Add node into list
  nodes.add(n);
 
  amount = (int)pow(amount, 2);
 
  while (nodes.size() <= amount) {
                                 // Get the nodes from the temporary arraylist and put them in the nodes arraylist.
    for (int i = 0; i < nextNodes.size(); i++) {
      Node n2 = (Node) nextNodes.get(i);
      nodes.add(n2);
    }
                                 // Clear temporary node list for next iteration
    nextNodes.clear();
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
    }
                                 // Amount of end points on a fractal tree increases by double the previous amount
    endNodeAmount *= 2;
  }
 
  for (int i = 0; i < particles.length; i++) {
    particles[i] = new Particle();
  }
}
 
void draw() {
  background(20);
  for (int i = 0; i < particles.length; i++) {
    particles[i].draw();
    particles[i].move();
  }
}
 
class Node {                             // Node Class
  PVector loc;                           // define vector loc
 
  float angle, dist;                     // define angle and distance
                                         // leftNode, rightNode and middleNode
                                         // The left and right are used to determine the particles next position, the middleNode is for making
                                         // lines with the bottom and second bottom nodes as they do not have left or right nodes
  Node ln, rn, mn;                       // Node ln(left), rn(right), mn(middle)
 
  Node(PVector l, float a, float d) {    //Node constructor
    loc = l.get();                       // loc <- l(vector)
    angle = a;                           // angle <- a(float)
    dist = d-20;                         // dist <- d(float)
  }
 
  void addNextNodes() {                  // add next node function
                                         // Get the direction and distance the next point will be placed
    PVector vel = new PVector(sin(radians(angle-random(0, 15)+mainAngle))*(dist-random(20, 70)), cos(radians(angle-random(0, 15)+mainAngle))*(dist-random(20, 70)));
                                         // Add the x velocity onto loc.x. We subtract the y value because we are moving up
    ln = new Node(new PVector(loc.x+vel.x, loc.y-vel.y), angle+mainAngle, distance);
    nextNodes.add(ln);
 
                                         // Subtract 45 degees to make the 90 degree difference between nodes
    vel = new PVector(sin(radians(angle+random(0, 15)-mainAngle))*(dist-random(20, 70)), cos(radians(angle+random(0, 15)-mainAngle))*(dist-random(20, 70)));
    rn = new Node(new PVector(loc.x+vel.x, loc.y-vel.y), angle-mainAngle, distance);
    nextNodes.add(rn);
  }
}
 
class Particle {                         // Particle Class (ipja)
  PVector loc, ploc;                     // define vertor loc and ploc
 
  float speed = random(0.5, 1);          // define particle speed -> random number 0.5~1
 
  Node node;                             // define Node class one named node
 
  Particle() {                           // Particle Constructor
    Node ns = (Node) nodes.get(0);       // define Node ns <- first element in nodes, arraylist
    loc = ns.loc.get();                  // vector loc is Node ns's vector
    node = (Node) nodes.get(1);          // Node node <- second element in nodes, arraylist
    ploc = node.loc.get();               // vector ploc is Node node's vector
  }
 
  void draw() {                          // Particle draw to screen
    rect(loc.x, loc.y, 2, 2);            // x -> loc.x, y -> loc.y 2x2 draw rectangle
  }
 
  void move() {                          // Particle move function
    PVector vel = new PVector(ploc.x - loc.x, ploc.y - loc.y);  // define vector vel <- ploc-loc
    vel.normalize();                     // vel normalize the vector to a length of 1
    vel.mult(speed);                     // vel scalar value is 'speed' 
    loc.add(vel);                        // loc<- loc + vel
 
    if (PVector.dist(loc, ploc) < 2) {   // calculate the distance between two points, loc and ploc if loc <-> ploc < 2
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
}