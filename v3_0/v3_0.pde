import controlP5.*;
import java.util.Arrays;

ControlP5 inputData;

class Point implements Comparable<Point> {
  int x,y;
  Point(int x, int y){
    this.x = x;
    this. y = y;
  }
  
  public int compareTo(Point p) {
    if (this.x == p.x) {
      return this.y - p.y;
    } else {
      return this.x - p.x;
    }
  }
  
  
  void print(){
    println(x + " : " + y);
  }
}

  long cross(Point O, Point A, Point B) {
    return (A.x - O.x) * (B.y - O.y) - (A.y - O.y) * (B.x - O.x);
  }

  Point[] convex_hull(Point[] P) {

    if (P.length > 1) {
      int noPoints = P.length, k = 0;
      Point[] H = new Point[2 * noPoints];

      Arrays.sort(P);

      // Build lower hull
      for (int i = 0; i < noPoints; ++i) {
        while (k >= 2 && cross(H[k - 2], H[k - 1], P[i]) <= 0)
          k--;
        H[k++] = P[i];
      }

      // Build upper hull
      for (int i = noPoints - 2, t = k + 1; i >= 0; i--) {
        while (k >= t && cross(H[k - 2], H[k - 1], P[i]) <= 0)
          k--;
        H[k++] = P[i];
      }
      if (k > 1) {
        H = Arrays.copyOfRange(H, 0, k - 1); // remove non-hull vertices after k; remove k - 1 which is a duplicate
      }
      return H;
    } else if (P.length <= 1) {
      return P;
    } else{
      return null;
    }
  }


Point[] pointArray = new Point[1];  
PImage bg;
int n = 0, i , j = 0, aux = 0, numberOfPoints = -2;
boolean done = false, drawBool = false;
String temp, temp2;

void background()
{
  background(255, 204, 0);
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
  size(1200,600);
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
boolean checkSubmit = false;
void Submit(){
  if(!checkSubmit)
  {
    temp = inputData.get(Textfield.class,"N").getText();
    numberOfPoints = Integer.parseInt(temp);
    checkSubmit = true;
  }
}

void RUN() {
  temp = inputData.get(Textfield.class, "ox").getText();

  temp2 = inputData.get(Textfield.class, "oy").getText();

  Point newOne = new Point(Integer.parseInt(temp),Integer.parseInt(temp2));
  fill(255,255,0);
  ellipse(newOne.x, newOne.y, 5, 5);
  text("("+newOne.x+","+newOne.y+")",newOne.x,newOne.y);
}

Point[] hull, hull2; 
boolean firstHull = false, drawBool2 = false, secondHull = false;

void draw() {
  
  println(numberOfPoints);
  frameRate(12);
  if(n == numberOfPoints)
  {
    hull = convex_hull(pointArray).clone(); 
    firstHull = true;  
  }
  if(firstHull)
  {
     if(aux < hull.length - 1)
     {
      hull[aux].print();
      stroke(0,0,255);
      line(hull[aux].x,hull[aux].y,hull[aux+1].x,hull[aux+1].y);
      delay(1000);
      aux++;
     }
     else
       if(aux == hull.length - 1 && drawBool == false)
       {
          hull[aux].print();
          stroke(0,0,255);
          line(hull[aux].x,hull[aux].y,hull[0].x,hull[0].y);
          drawBool = true;
          delay(1000);
       }
  }
  
  if(n == numberOfPoints + 1 && secondHull != true)
  {
    background();
    for(int i = 0; i < pointArray.length; i++)
    {
       fill(255,0,0);
       ellipse(pointArray[i].x, pointArray[i].y, 5, 5);
       text("("+pointArray[i].x+","+pointArray[i].y+")",pointArray[i].x,pointArray[i].y);
    }
    hull2 = convex_hull(pointArray).clone(); 
    secondHull = true;
    aux = 0;
  }
  
  if(secondHull)
  {
     if(aux < hull2.length - 1)
     {
        hull2[aux].print();
        stroke(0,0,255);
        line(hull2[aux].x,hull2[aux].y,hull2[aux+1].x,hull2[aux+1].y);
        delay(2000);
        aux++;
     }
     else
       if(aux == hull2.length - 1 && drawBool2 == false)
       {
          hull2[aux].print();
          stroke(0,0,255);
          line(hull2[aux].x,hull2[aux].y,hull2[0].x,hull2[0].y);
          drawBool2 = true;
          delay(1000);
       }
  }
}

void keyPressed(){
  if(n == 6)
  if(key == 'x'){
    if(j < n - 1)
    {
      pointArray[j].print();
      stroke(0,0,255);
      line(pointArray[j].x,pointArray[j].y,pointArray[j+1].x,pointArray[j+1].y);
      //delay(1000);
      j++;
    }
    else 
      if(j == n - 1 && done == false)
        {
          pointArray[j].print();
          stroke(0,0,255);
          line(pointArray[j].x,pointArray[j].y,pointArray[0].x,pointArray[0].y);
          done = true;
        }
  }
}

void mousePressed() {
  
  if(mouseX > 125)
  {
    fill(255,0,0);
    ellipse(mouseX, mouseY, 5, 5);
    pointArray = (Point[])expand(pointArray,n+1);
    //println(aux.x + " : " + aux.y);
    pointArray[n] = new Point(mouseX, mouseY);
    text("("+pointArray[n].x+","+pointArray[n].y+")",mouseX,mouseY);
    n++;
  }
  //redraw();
}