}

class Circle 
{
  float r;
  float MaxR;
  float x;
  float y;
  float vx = 0.8;
  color c;
  Circle(int count){
    MaxR = random(100-count);
    r = MaxR;
    x = random(640); 
    y = random(640);
    setColor();
  }
  void draw(){
    fill(c);
    ellipse(x, y, r, r);
  }
  void setColor(){
    float CR = random(0);
    float CG = random(155);
    float CB = random(155);
    c = color((int)CR,(int)CG+100,(int)CB+100, 200);
  }
  boolean detectCollision(Circle c){
    if((c.x-x)*(c.x-x)+(c.y-y)*(c.y-y)>c.r*c.r+MaxR*MaxR){
      return false;
    }
    else{
      return true;
    }
  }
  void update(){
    r-=vx;
    if(r<0){
      r = 0.1;
      vx = -vx;
    }
    if(r>MaxR){
     r = MaxR; 
     vx = -vx;
    }
  }
}
 
 
    for(Circle c: clist){
     c.update();
     c.draw();
     if(count%10==0)
       c.setColor();
    }
    while(true){
      for(Circle c : clist){
       check = c.detectCollision(cir); 
       if(check){
         cir = new Circle(count);
         break;
       }
      }
      if(!check){
        break;        
      }
    }
    clist.add(cir);
    count++;
}

class Circle 
{
  float r;
  float MaxR;
  float x;
  float y;
  float vx = 0.8;
  color c;
  Circle(int count){
    MaxR = random(100-count);
    r = MaxR;
    x = random(640); 
    y = random(640);
    setColor();
  }
  void draw(){
    fill(c);
    ellipse(x, y, r, r);
  }
  void setColor(){
    float CR = random(0);
    float CG = random(155);
    float CB = random(155);
    c = color((int)CR,(int)CG+100,(int)CB+100, 200);
  }
  boolean detectCollision(Circle c){
    if((c.x-x)*(c.x-x)+(c.y-y)*(c.y-y)>c.r*c.r+MaxR*MaxR){
      return false;
    }
    else{
      return true;
    }
  }
  void update(){
    r-=vx;
    if(r<0){
      r = 0.1;
      vx = -vx;
    }
    if(r>MaxR){
     r = MaxR; 
     vx = -vx;
    }
  }
}
 
 
