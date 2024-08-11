import java.util.Random;        // because germs are so random
import java.util.LinkedList;    // for holding germs (ew)
import java.util.Iterator;      // for iterator through germs

import java.text.DecimalFormat; // for displaying capacity

// CUSTOM MOUSE CLICKING TOOL
boolean mouseChoose = false;
void mouseReleased() {
  mouseChoose = true;
  // set to false at the end of drawing phase
}

// CONSTANTS
int GERM_STARTING_COUNT = 5;
int MAX_GERM_COUNT = 10000;

// strength
int GERM_LOWEST = 50;
int GERM_HIGHEST = 2000;
int SUPER_LOWEST = 1000;
int SUPER_HIGHEST = 5000;

int GERM_MULTIPLY_LOW = 100;
int GERM_MULTIPLY_HIGH = 1000;

int GERM_BRIGHTNESS = 200;
int SUPER_BRIGHTNESS = 255;

// Sim Objects
Random r = new Random();

LinkedList<Germ> testificates = new LinkedList<Germ>();
LinkedList<Germ> testificatesToAdd = new LinkedList<Germ>();

// Sim Variables
boolean over = false;
DecimalFormat df = new DecimalFormat("0.0");

// Debug Sim Variables
float soapStrength = 0.9;


// Sim
void setup()
{
  size(1000, 700);
  for (int i = 0; i < GERM_STARTING_COUNT; i++)
  {
    testificates.add(new Germ());
  }
}

void draw()
{
  background(255, 255, 255);
  
  if (mouseChoose)
  {
    int killThreshold = (int)((float)GERM_HIGHEST * soapStrength);
    Iterator<Germ> it = testificates.iterator();
    while (it.hasNext())
    {
      Germ t = it.next();
      if (t.getStrength() <= killThreshold)
      {
        it.remove();
      }
    }
  }
  
  if (!over)
  {
    testificatesToAdd.clear();
    for (Germ germ : testificates)
    {
      germ.timeDown(testificatesToAdd);
      germ.drawGerm();
    }
    testificates.addAll(testificatesToAdd);
    if (testificates.size() >= MAX_GERM_COUNT)
    {
      over = true;
    }
    float capacity = (float)testificates.size() / MAX_GERM_COUNT;
    textAlign(CENTER);
    textSize(40);
    fill(255 * capacity, 0, 255);
    text(df.format((capacity * 100)) + "%", 500, 350);
  }
  
  else
  {
    textSize(40);
    textAlign(CENTER);
    fill(0, 0, 0);
    text("Too many germs...", 500, 350);
  }
  mouseChoose = false;
}
