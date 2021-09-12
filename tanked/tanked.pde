import processing.sound.*;

/*

Tanked game, written -- oops -- coded by Max Parry.

*/


ArrayList<tank> robots = new ArrayList<tank>(); // Creating an arraylist of robot tanks.
PImage logo, blackpix, tank, mousecursor;
PFont tkdfont;
SoundFile logomusic;
String[] posTanks = { "red", "green", "blue", "black", "white" };
tank player;
int m;
boolean mainmenu, gamesetup, gameplay;
void setup() { // Setup for EVERYTHING.
  mainmenu = true;
  gamesetup = false;
  frameRate(120);
  background(0); // A blackground -- like my pun?
  fullScreen(P2D);
  surface.setTitle("tanked || a game by Import Studios || " + str(frameRate) + " FPS");
  tkdfont = createFont("ProductSans.ttf", 200);
  blackpix = loadImage("blackpixel.png");
  mousecursor = loadImage("default_mouse.png");
  logomusic = new SoundFile(this, "logo.wav");
  tank = loadImage("tank.png");
  player = new tank(width/2, height/2, 0.25, 0, "red", false, "default"); // The player's constructor
  imageMode(CENTER);
  logo = loadImage("IMPORT_LOGO.png");
  image(logo, width/2, height/2, logo.width*3, logo.height*3); // Adding the logo
  logomusic.play();
  m = millis();
  cursor(mousecursor); // Adding the cool, tanked cursor.
  // background(0);
}

void draw() { // A forever loop.
  if (millis() - m > 10000) { // The m variable was stated in the setup, as millis(). The event is called when the setup was called more than 10000 milliseconds ago.
      
      background(100);
      if(mainmenu) { // Creating a main menu!
        background(100);
        fill(0,200,0);
        rectMode(CENTER);
        rect((width/2), (height/2)-20, 150*2, 50*2, 30);
        fill(255,0,0);
        textFont(tkdfont);
        textSize(80);
        textAlign(CENTER);
        text("tanked", width/2, height/2);
        text("Press R to start...", width/2, (height/2)+100);
        // textSize(80);
        fill(0,0,255);
        rect(width-400, (height/2)+100, tank.width+300, tank.height/2+500);
        image(tank, width-400, (height/2), tank.width/2, tank.height/2);
        fill(255,0,0);
        textSize(40);
        text("Trying your best isn't trying enough.", width/2, (height)-80);
        image(logo, width/2, (height/2)-300, logo.width*3, logo.height*3);
        if(keyPressed) {
          if(key == 'r') {
            gamesetup = true;
            mainmenu = false;
          }
        }
      }
      if(gamesetup) { // The games' setup.
        background(100);
        textFont(tkdfont);
        textSize(80);
        textAlign(CENTER);
        text("LOADING...", width/2, height/2); 
        gameplay = true;
        gamesetup = false;
      }
      if(gameplay) {
        background(100);
        for(int i = 0; i < robots.size(); i++) {
          robots.get(i).ai(); // ARTIFICIAL INTELLEGENCE!! (not really)
          robots.get(i).display(); // Draw all the robots.
        }
        if((int) (Math.random() * 101) == 1) { // Low chance that robot will spawn
          robots.add(new tank(0, 0, 0.75, 0, posTanks[(int) (Math.random() * posTanks.length)], true, "default")); // Adding it to the ArrayList. The fifth perimeter chooses a random team/color.
        }
        player.display();
      }
  }
}
void keyPressed() {
 if(key == 'z') { // Gives the user an oppertunity to exit the application if z is pressed.
   exit();
 }
}
class tank {
 int x, y, rotation, m = millis(); // Setting up, creating variables, etc.
 float easing = 0.0005;
 float size, angle;
 boolean robot;
 String tanktype, team;
 tank(int _x, int _y, float _size, int _rotation, String _team, boolean _robot, String _tanktype) { // The constructor for a tank.
    x = _x;
    y = _y;
    size = _size;
    team = _team;
    robot = _robot;
    tanktype = _tanktype;
    rotation = _rotation;
    if(robot) { // ONLY if it is a robot
         int switcher = (int) random(1,5);
         // Constructor
         switch(switcher) {
            case 1:
              x = (int) random(width);
              y = 0;
              break;
            case 2:
              x = (int) random(width);
              y = height;
              break;
            case 3:
              x = 0;
              y = (int) random(height);
              break;
            case 4:
              x = width;
              y = (int) random(height);
              break;
         } 
    }
 } 
 void display() { // The drawing of the tank.
    if(robot) { // If the current object is a robot.
       pushMatrix(); // All of this is NOT actually tank.png in the data folder, it is a shape made out of various things, such as rect()s and ellipse()s.
       angle = atan2(x-player.x, y-player.y); // Complex algorithm for the rotation
       translate(x, y); // Making 0, 0, the shapes x and y co-ordinates
       rotate(-angle-HALF_PI); // Rotate the shape
       stroke(0); // The line color completely black 
       strokeWeight(5); // Outline pretty big
       rectMode(CORNER);
       ellipseMode(CENTER);
       fill(120); // Gray for the tanks kill thingymajig.
       rect(0, -((100/(size*4))/2)/2, 100/(size*4), (100/(size*4))/2);
       if(team == "red") { // Tanks color if statement
         fill(255, 0, 0); // Using RGB values to make a red
       } else if(team == "blue") {
         fill(0, 0, 255); // Using RGB values to make a blue
       } else if(team == "green") {
         fill(0, 255, 0); // Using RGB values to make a black
       } else if(team == "black") {
         fill(0); // Using RGB values to make a black
       } else if(team == "white") {
         fill(255);
       } else { // If your team isn't any of these, you are alone.
         exit();
       }
       ellipse(0, 0, 100/(size*4), 100/(size*4));
       popMatrix();
       // Drawing a small tank, aka a robot.
    } else { // if the tank is not a robot
       pushMatrix(); // All of this is NOT actually tank.png in the data folder, it is a shape made out of various things, such as rect()s and ellipse()s.
       angle = atan2(x-mouseX, y-mouseY); // Complex algorithm for the rotation
       translate(x, y); // Making 0, 0, the shapes x and y co-ordinates
       rotate(-angle-HALF_PI); // Rotate the shape
       stroke(0); // The line color completely black 
       strokeWeight(5); // Outline pretty big
       rectMode(CORNER);
       ellipseMode(CENTER);
       fill(120); // Gray for the tanks kill thingymajig.
       rect(0, -((100/(size*4))/2)/2, 100/(size*4), (100/(size*4))/2);
       if(team == "red") { // Tanks color if statement
         fill(255, 0, 0); // Using RGB values to make a red
       } else if(team == "blue") {
         fill(0, 0, 255); // Using RGB values to make a blue
       } else if(team == "green") {
         fill(0, 255, 0); // Using RGB values to make a black
       } else if(team == "black") {
         fill(0); // Using RGB values to make a black
       } else if(team == "white") {
         fill(255);
       } else { // If your team isn't any of these, you are alone.
         exit();
       }
       ellipse(0, 0, 100/(size*4), 100/(size*4));
       popMatrix();
    }
 }
 void ai() { // Not a very smart tank
   if(robot) {
    float targetX = mouseX;
    float dx = targetX - x;
    x += dx * easing;
    
    float targetY = mouseY;
    float dy = targetY - y;
    y += dy * easing;
   } else {
     println("WARNING: ai() was executed on a non-robot tank. Due to my confusion, nothing will happen.");
   }
 }
}
