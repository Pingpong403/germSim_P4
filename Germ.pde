class Germ
{
  // STATS
  protected int strength;
  protected int multiplyTimer;
  
  // ATTRIBUTES
  protected int posX;
  protected int posY;
  
  
  public Germ()
  {
    strength = r.nextInt(GERM_LOWEST, GERM_HIGHEST);
    multiplyTimer = r.nextInt(GERM_MULTIPLY_LOW, GERM_MULTIPLY_HIGH);
    posX = r.nextInt(0, 1000);
    posY = r.nextInt(0, 700);
  }
  
  public Germ(int posX, int posY)
  {
    strength = r.nextInt(GERM_LOWEST, GERM_HIGHEST);
    multiplyTimer = r.nextInt(GERM_MULTIPLY_LOW, GERM_MULTIPLY_HIGH);
    this.posX = posX;
    this.posY = posY;
  }
  
  public Germ(int posX, int posY, int strength)
  {
    this.strength = strength;
    multiplyTimer = r.nextInt(GERM_MULTIPLY_LOW, GERM_MULTIPLY_HIGH);
    this.posX = posX;
    this.posY = posY;
  }
  
  public int getStrength()
  {
    return strength;
  }
  
  public void drawGerm()
  {
    noStroke();
    int adjustedHigh = GERM_HIGHEST - GERM_LOWEST;
    int adjustedStr = this.strength - GERM_LOWEST;
    float ratio = (float)adjustedStr / adjustedHigh;
    fill(GERM_BRIGHTNESS - (ratio * GERM_BRIGHTNESS), GERM_BRIGHTNESS, 0);
    ellipse(posX, posY, 10, 10);
  }
  
  public void timeDown(LinkedList<Germ> germs)
  {
    multiplyTimer--;
    if (multiplyTimer == 0)
    {
      multiply(germs);
      multiplyTimer = r.nextInt(GERM_MULTIPLY_LOW, GERM_MULTIPLY_HIGH);
    }
  }
  
  private void multiply(LinkedList<Germ> germs)
  {
    // figure out angle and new positions
    float angleParent = (float)r.nextInt(0, 360000) / 1000;
    float angleChild = angleParent + 180.0;
    
    int newPosXParent = (int)((float)posX + 5 * cos(angleParent));
    int newPosYParent = (int)((float)posY + 5 * sin(angleParent));
    int newPosXChild =  (int)((float)posX + 5 * cos(angleChild));
    int newPosYChild =  (int)((float)posY + 5 * sin(angleChild));
    
    this.posX = newPosXParent;
    this.posY = newPosYParent;
    
    if (r.nextInt(0, 50) == 1)
    {
      germs.add(new SuperGerm(newPosXChild, newPosYChild));
    }
    else
    {
      germs.add(new Germ(newPosXChild, newPosYChild));
    }
  }
}

class SuperGerm extends Germ
{
  public SuperGerm()
  {
    super();
    strength = r.nextInt(SUPER_LOWEST, SUPER_HIGHEST);
  }
  
  public SuperGerm(int posX, int posY)
  {
    super(posX, posY);
    strength = r.nextInt(SUPER_LOWEST, SUPER_HIGHEST);
  }
  
  public SuperGerm(int posX, int posY, int strength)
  {
    super(posX, posY, strength);
  }
  
  public void drawGerm()
  {
    noStroke();
    int adjustedHigh = SUPER_HIGHEST - SUPER_LOWEST;
    int adjustedStr = this.strength - SUPER_LOWEST;
    float ratio = (float)adjustedStr / adjustedHigh;
    fill(SUPER_BRIGHTNESS, SUPER_BRIGHTNESS - (ratio * SUPER_BRIGHTNESS), 0);
    ellipse(posX, posY, 10, 10);
  }
  
  private void multiply(LinkedList<Germ> germs)
  {
    if (r.nextInt(0, 25) == 1)
    {
      germs.add(new SuperGerm());
    }
    else
    {
      germs.add(new Germ());
    }
  }
}
