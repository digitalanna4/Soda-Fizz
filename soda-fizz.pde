int[] bubblesX = new int[12]; //global variables for bubbles
int[] bubblesY = new int[12];
int[] bubblesUp = new int[12];
int[] bubbleSize = new int[12];
float carb = 0; //foam at top y distance
int calc = 0; //overflowing speed

void setup()
{
  size(500, 500);
  background(255);
  fill(255, 0, 0);

  for (int z = 0; z<12; z++)
  {
    bubblesX[z] = int(random(300)) + 100; //set bubbles to random points in cup
    bubblesY[z] = int(random(200)) + 300;
    bubblesUp[z] = int(random(7))+2; //speed
    bubbleSize[z] = int(random(4))+5;
  }
}

void draw() 
{
  background(0);

  int rot = 0;

  if (pmouseX-mouseX > 7) //if mouse moves fast across x axis
  {
    rot = 3;
    carb += (pmouseX-mouseX)/50; //add foam
  } else if (mouseX - pmouseX > 7)
  {
    rot = -3;
    carb += (mouseX-pmouseX)/50;
  } else
  {
    if (carb>0) //if no movement and foam exists, subtract foam
    {
      rot = 0;
      carb -= .2;
    }
    if (carb<0)
    {
      carb = 0;
    }
  }

  rotate(radians(rot));
  
  strokeWeight(2); //top rim of cup
  fill(255, 255, 255, 80);
  beginShape();
  vertex(450, 100);
  curveVertex(450, 60);
  curveVertex(450, 100);
  curveVertex(370, 123);
  curveVertex(250, 130);
  curveVertex(130, 123);
  curveVertex(50, 100);
  curveVertex(50, 60);
  vertex(50, 100);
  curveVertex(50, 140);
  curveVertex(50, 100);
  curveVertex(130, 77);
  curveVertex(250, 70);
  curveVertex(370, 77);
  curveVertex(450, 100);
  curveVertex(450, 140);
  endShape();
  
  fill(0, 0, 0, 255);//reset opacity
  
  carbonation();

  fill(10, 0, 5); //soda
  beginShape();
  vertex(103, 550);
  vertex(397, 550);
  vertex(440, 150);
  curveVertex(445, 150);
  curveVertex(440, 150);
  curveVertex(390, 170);
  curveVertex(250, 180);
  curveVertex(110, 170);
  curveVertex(60, 150);
  curveVertex(55, 150); 
  vertex(60, 150);
  endShape();

  bubbles();
  
  noStroke(); //cup (add more detail)
  fill(255, 255, 255, 30);
  beginShape();
  vertex(100, 550);
  vertex(400, 550);
  vertex(450, 100);
  curveVertex(450, 60);
  curveVertex(450, 100);
  curveVertex(370, 123);
  curveVertex(250, 130);
  curveVertex(130, 123);
  curveVertex(50, 100);
  curveVertex(50, 60);
  vertex(50, 100);
  endShape();
  
  fill(0, 0, 0, 255); //reset opacity
  
  if(carb > 50)
    overflow();
  else
    calc = 0;
}

void bubbles()
{
  fill(220, 200, 200);
  for (int z = 0; z<12; z++) //place and move 10 bubbles
  {
    ellipse(bubblesX[z], bubblesY[z], bubbleSize[z], bubbleSize[z]); //(should i add a size of bubble array?)
    bubblesY[z] -= bubblesUp[z];

    if (bubblesY[z] <= 155) //if above soda, move to bottom
    {
      bubblesY[z] = 500;
    }

    if (bubblesX[z] == 250) //if in middle, decide direction of bubble
    {
      bubblesX[z] += int(random(4)) - 2;
    } else if (bubblesX[z] < 249) //left bubbles move left, right bubbles move right
    {
      bubblesX[z] -= int(random(2));
    } else
    {
      bubblesX[z] += int(random(2));
    }

    if ((bubblesX[z] > 380 || bubblesX[z] < 120) && bubblesY[z] == 500) //if bubbles leave cup
    {
      bubblesX[z] = 250;
    }
  }
  //more bubbles when shaking?
}

void carbonation()
{

  if (carb == 0)
    fill(70, 50, 45);
  else if(carb < 5)
    fill(100, 80, 60);
  else
    fill(220, 210, 200);

  beginShape();
  vertex(60, 150);
  vertex(60-(carb/8), 150-carb);
  curveVertex(55, 150); //some complicated math that's probably unnecessary
  curveVertex(60-(carb/8), 150-carb); //aka rising the foam and keeping it in the cup
  curveVertex(110, 130-carb);
  curveVertex(250, 120-carb);
  curveVertex(390, 130-carb);
  curveVertex(440+(carb/8), 150-carb);
  curveVertex(445, 150);
  vertex(440+(carb/8), 150-carb);
  vertex(440, 150);
  curveVertex(445, 150);
  curveVertex(440, 150);
  curveVertex(390, 170);
  curveVertex(250, 180);
  curveVertex(110, 170);
  curveVertex(60, 150);
  curveVertex(55, 150); 
  vertex(60, 150);
  endShape();

  if (carb == 0)
    fill(60, 45, 40);
  else if(carb < 5)
    fill(100, 80, 70);
  else
    fill(220, 200, 190);
  beginShape();
  vertex(60, 150-carb);
  vertex(60-(carb/8), 150-carb);
  curveVertex(55, 150);
  curveVertex(60-(carb/8), 150-carb);
  curveVertex(110, 130-carb);
  curveVertex(250, 120-carb);
  curveVertex(390, 130-carb);
  curveVertex(440+(carb/8), 150-carb);
  curveVertex(445, 150);
  vertex(440+(carb/8), 150-carb);
  curveVertex(445, 150-carb);
  curveVertex(440+(carb/8), 150-carb);
  curveVertex(390, 170-carb);
  curveVertex(250, 180-carb);
  curveVertex(110, 170-carb);
  curveVertex(60-(carb/8), 150-carb);
  curveVertex(55, 150-carb); 
  vertex(60, 150-carb);
  endShape();
}

void overflow()
{
  calc += 3;
  
  fill(220, 210, 200);
  beginShape();
  vertex(60-(carb/8), 150-carb);
  curveVertex(55, 150);
  curveVertex(60-(carb/8), 150-carb);
  curveVertex(110, 130-carb);
  curveVertex(250, 120-carb);
  curveVertex(390, 130-carb);
  curveVertex(440+(carb/8), 150-carb);
  curveVertex(445, 150);
  vertex(440+(carb/8), 150-carb);
  bezierVertex(455+(carb/8), 180-carb, 460+(carb/8), 200-carb, 465+(carb/8), 230-carb+calc); // these guys make pythagorean theorm look basic
  vertex(30+(carb/8), 230-carb+calc);
  bezierVertex(35+(carb/8), 200-carb, 30+(carb/8), 180-carb, 60-(carb/8), 150-carb);
  endShape();
}
