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
int n = 0, i , j = 0, aux = 0, numberOfPoints = -2, aux2 = 0;
boolean done = false, drawBool = false, checkSubmit = false, mouseClick = true;
String temp, temp2;
Point[] hull, hull2; 
boolean firstHull = false, drawBool2 = false, secondHull = false;

void background()
{
   background(199,151,75);
   
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
  size(1200, 600);
  background();
  
  inputData = new ControlP5(this);
  inputData.addBang("Run").setPosition(10, 10).setSize(100, 20);
  textSize(12);
}

void Run() {
  numberOfPoints = n;

}

void draw() {
  
  frameRate(12);
  if(n == numberOfPoints && firstHull == false)
  {
    hull = convex_hull(pointArray).clone(); 
    firstHull = true;
    mouseClick = false;
  }
  if(firstHull)
  {
    if(aux < hull.length - 1)
    {
      hull[aux].print();
      stroke(0,0,255);
      line(hull[aux].x,hull[aux].y,hull[aux+1].x,hull[aux+1].y);
      delay(500);
      aux++;
    }
    else
      if(aux == hull.length - 1 && drawBool == false)
      {
         hull[aux].print();
         stroke(0,0,255);
         line(hull[aux].x,hull[aux].y,hull[0].x,hull[0].y);
         drawBool = true;
         text("ADD A NEW POINT",10, 60);
         mouseClick = true;
         delay(500);
       }
  }
  if(n == numberOfPoints + 1 && secondHull != true)
  {
    mouseClick = false;
    background();
    for(int i = 0; i < pointArray.length; i++)
    {
       if(i == pointArray.length - 1)
        fill(255,255,0);
       else
        fill(255,0,0);
       noStroke();
       ellipse(pointArray[i].x, pointArray[i].y, 10, 10);
       text("("+pointArray[i].x+","+pointArray[i].y+")",pointArray[i].x + 5,pointArray[i].y - 5);
    }
    hull2 = convex_hull(pointArray).clone(); 
    secondHull = true;
    aux2 = 0;
  }
  
  if(secondHull)
  {
     if(aux2 < hull2.length - 1)
     {
        hull2[aux2].print();
        stroke(0,0,255);
        line(hull2[aux2].x, hull2[aux2].y, hull2[aux2 + 1].x, hull2[aux2 + 1].y);
        delay(500);
        aux2++;
     }
     else
       if(aux2 == hull2.length - 1 && drawBool2 == false)
       {
          hull2[aux2].print();
          stroke(0,0,255);
          line(hull2[aux2].x,hull2[aux2].y,hull2[0].x,hull2[0].y);
          drawBool2 = true;
          delay(500);
          text("DONE!", 10, 60);
       }
  }
}

void mousePressed() {
  if(mouseClick == true) 
    if(mouseX > 125)
    {
      if(drawBool == true)
        fill(255,255,0);
      else
        fill(255,0,0);
      noStroke();
      ellipse(mouseX, mouseY, 10, 10);
      pointArray = (Point[])expand(pointArray,n+1);
      pointArray[n] = new Point(mouseX, mouseY);
      text("("+pointArray[n].x+","+pointArray[n].y+")",mouseX + 5,mouseY - 5);
      n++;
    }
  
}