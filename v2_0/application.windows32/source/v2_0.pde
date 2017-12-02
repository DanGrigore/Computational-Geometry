import controlP5.*;

ControlP5 inputData;

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
int n = 0, i , j = 0;
boolean done = false;
String temp, temp2;

void background()
{
   for(i = 0; i <= height; i += 30)
   {
     stroke(255);
     line(120, i, width, i);
   }
   for(i =120; i <= width; i += 30)
   {
     if(i == 120)
        stroke(0);
     else
       stroke(255);
     line(i, 0, i, height);
   }     
}

void setup() {
  size(900, 900);
  //bg = loadImage("mathSheet.jpg");
  background();
  inputData = new ControlP5(this);
  inputData.addTextfield("N").setPosition(10, 10).setSize(50, 20).setAutoClear(false);
  inputData.addBang("Submit").setPosition(60, 10).setSize(50, 20);
  text("ADD A NEW POINT",10, 60);
  inputData.addTextfield("ox").setPosition(10, 70).setSize(25, 20).setAutoClear(false);
  inputData.addTextfield("oy").setPosition(35, 70).setSize(25, 20).setAutoClear(false);
  inputData.addBang("RUN").setPosition(60, 70).setSize(50, 20);
  //noLoop();
}

void RUN() {
  temp = inputData.get(Textfield.class, "ox").getText();

  temp2 = inputData.get(Textfield.class, "oy").getText();

   Punct newOne = new Punct(Integer.parseInt(temp),Integer.parseInt(temp2));
  fill(255,255,0);
  ellipse(newOne.x, newOne.y, 5, 5);
  text("("+newOne.x+","+newOne.y+")",newOne.x,newOne.y);
}

void draw() {
  //background(bg);
  frameRate(12);
  //println(mouseX + " : " + mouseY);
  //if(mousePressed == true)
  //{
  //  fill(255,0,0);
  //  ellipse(mouseX, mouseY, 5, 5);
  //  puncte = (Punct[])expand(puncte,n+1);
  //  //println(aux.x + " : " + aux.y);
  //  puncte[n] = new Punct(mouseX, mouseY);
  //  text("("+puncte[n].x+","+puncte[n].y+")",mouseX,mouseY);
  //  n++;
  //}
  //if(n == 6)
  //  if(j < n -1)
  //  {
  //    puncte[j].print();
  //    stroke(0,0,255);
  //    line(puncte[j].x,puncte[j].y,puncte[j+1].x,puncte[j+1].y);
  //    delay(1000);
  //    j++;
  //  }
  //  else
  //  {
  //    puncte[j].print();
  //    stroke(0,0,255);
  //    line(puncte[j].x,puncte[j].y,puncte[0].x,puncte[0].y);
  //    delay(1000);
  //  }
  
}

void keyPressed(){
  if(key == 'x'){
    if(j < n - 1)
    {
      puncte[j].print();
      stroke(0,0,255);
      line(puncte[j].x,puncte[j].y,puncte[j+1].x,puncte[j+1].y);
      //delay(1000);
      j++;
    }
    else 
      if(j == n - 1 && done == false)
        {
          puncte[j].print();
          stroke(0,0,255);
          line(puncte[j].x,puncte[j].y,puncte[0].x,puncte[0].y);
          done = true;
        }
  }
}

void mousePressed() {
  
  if(mouseX > 125)
  {
    fill(255,0,0);
    ellipse(mouseX, mouseY, 5, 5);
    puncte = (Punct[])expand(puncte,n+1);
    //println(aux.x + " : " + aux.y);
    puncte[n] = new Punct(mouseX, mouseY);
    text("("+puncte[n].x+","+puncte[n].y+")",mouseX,mouseY);
    n++;
  }
  //redraw();
}