class Punct {
  int x,y;
  Punct(int x, int y){
    this.x = x;
    this. y = y;
  }
  void print(){
    println(x + " : " + y);
  }
}

Punct[] puncte = new Punct[1];  
PImage bg;
int n = 0, i;

void background()
{
   for(i = 0; i <= height; i += 30)
   {
     stroke(255);
     line(0, i, width, i);
   }
   for(i = 0; i <= width; i += 30)
   {
     stroke(255);
     line(i, 0, i, height);
   }     
}

void setup() {
  size(900, 900);
  //bg = loadImage("mathSheet.jpg");
  background();
}

void draw() {
  //background(bg);
  
  frameRate(12);
  //println(mouseX + " : " + mouseY);
  if(mousePressed == true)
  {
    fill(255,0,0);
    ellipse(mouseX, mouseY, 5, 5);
    puncte = (Punct[])expand(puncte,n+1);
    //println(aux.x + " : " + aux.y);
    puncte[n] = new Punct(mouseX, mouseY);
    text("("+puncte[n].x+","+puncte[n].y+")",mouseX,mouseY);
    n++;
  }
  for(i = 0; i < n - 1 ; i++)
  {
    puncte[i].print();
    stroke(0,0,255);
    line(puncte[i].x,puncte[i].y,puncte[i+1].x,puncte[i+1].y);
  }
  
}