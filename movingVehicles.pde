float car1Y;
float car1X;
float busX;
int sunIndexI = 0;
float cloudY;
float cloudX;
float redCarX;
float belowRoadY;
float aboveRoadY;
int rotateTireLeft;
int rotateTireRight;
float inc = 0; // for ufo
float randomLaserX;
float blackCarX;
float bettleCarX;
float BettleCarY;

/*  TODOS
 * TODO: convert all vehicle parameters to (example)carX+width instead of carX*1.05
 */

void setup() {
    size(400,400);
    background(#87ceeb);
    cloudX = 0;
    cloudY = height/10*1.1;
    redCarX = -width/5;
    belowRoadY = height/10*7;
    aboveRoadY = height/10*5.8;
    rotateTireRight = width*2;
    busX = width/10*5;
    randomLaserX = -width/10*1;
    blackCarX =  width+width/10*1.9;
    bettleCarX = -width/10*5;
    BettleCarY = height/10*7.4;
}

void drawRoad() {
    noStroke();
    /* important parameters for cars:
     * (height/10*6+height/10*2)/4 = quarter of road. 
     * cars going left should be here
     * cars going right should be at     
     * (height/10*6+height/10*2)/4*3
     */
    
    // draw cement
    fill(#808080);
    rect(0,height/10*5.7,width,height/10*2.3);
    
    // draw 5 white road lines
    float centerY = height/10*6.9;
    float centerX = width/10;
    float i = 0;
    fill(0xff,0xff,0xff);
    // draw them in loop
    do {
        /* push and pop required because of it shows excess 
         * cement otherwise
         */
        push();
        rectMode(CENTER);
        rect(centerX,centerY,width/10, height/10*.1,1);
        pop();
        centerX+=width/10*2; // increment x by width/10*2
        i++;
    }  while(i < 5);
}

void drawBuilding() {
    // draw office building
    fill(#818B99);
    rect(0,0,width/10*3,height/10*4);
    
    // draw windows
    int j=0;
    float leftX = width/10*.5;
    float leftY = height/10*.5;
    float windowW = width/10*.5;
    float windowH = height/10*.5;
    
    // use for loop for column of windows
    fill(#a8ccd7);
    for(int i=0;i<4;i++) {
        // use nested loop for single row of windows
        do {
            rect(leftX,leftY,windowW,windowH);

            // glass shadow
            push();
            fill(#08555B);
            rect(leftX,leftY,width/10*.1,
                 windowH);
            rect(leftX,leftY,windowW,
                 height/10*.1);
            pop();
            
            leftX+=width/10*.8;
            j++;
        } while(j<3);
        j=0; // reset j
        leftX = width/10*.5; // reset leftX
        leftY+=height/10*.8;
    }
}

void drawCloud(float x,float y) {
    // declare ellipse parameters for cloud
    float cloudW = width/10*.8;
    float cloudH = height/10*.8;
    float radius = cloudW/2;
    
    fill(0xff,0xff,0xff);
    ellipse(x,y,cloudW*2.5,cloudH/1.2);
    ellipse(x+radius,y-radius,cloudW,cloudH);
    ellipse(x+radius*2,y-radius,cloudW,cloudH);
    ellipse(x+radius,y+radius,cloudW,cloudH);
    ellipse(x+radius*2.5,y,cloudW,cloudH);
    ellipse(x-radius*1.5,y,cloudW,cloudH);
    ellipse(x-radius+radius/2,y-radius,cloudW,cloudH);
    ellipse(x-radius+radius/2,y+radius,cloudW,cloudH);
}

void drawTree(float x, float y, float treeHeight) {
    float trunkWidth = width/10*.3;
    float trunkHeight = 3*treeHeight/4;
    float leafHeightOverTrunk = treeHeight/4;
    
    // trunk
    fill(89,55,1);
    rect(x-trunkWidth, y-trunkHeight,trunkWidth,trunkHeight);
    push();
    translate(x+trunkWidth-trunkWidth/1.8,
              y-trunkHeight+trunkHeight/4);
    rotate(radians(20));
    rect(0,0,trunkWidth/2.5,
         trunkHeight-trunkHeight/1.5);
    pop();
    noStroke();
    
    // Leaves
    fill(0,255,0);
    ellipse(x-trunkWidth*1.5,
            y-trunkHeight*.95,2*leafHeightOverTrunk,     
            2*leafHeightOverTrunk);
    ellipse(x-trunkWidth,
            y-trunkHeight*1.3,2*leafHeightOverTrunk,
            2*leafHeightOverTrunk);
    ellipse(x+trunkWidth/5,
            y-trunkHeight,2*leafHeightOverTrunk,     
            2*leafHeightOverTrunk);
}

// red van
void drawRedCar(float carX,float carY,int num) {
    /* 5th parameter is for smoother surface */
    
    // car body
    fill(237, 24, 24);
    rect(carX,carY,width/10,height/10*.6,4);
    rect(carX+width/10*.66,carY,width/10*1.2,height/10*.6,8);
    rect(carX,carY-height/10*.35,width/10*1.5,height/10*.6,8);
    
    // detail on the car body
    push();
    fill(0,0,0);
    strokeWeight(width/100*.5);
    rect(carX,carY,width/10*1.8,height/10*.02);
    rect(carX+width/10, carY,width/10*.02,height/10*.6);
    
    // door handle
    rect(carX+width/10*1.2,carY+height/10*.21,width/10*.08,height/10*.05,150);
    
    // color on top
    rect(carX,carY-height/10*.335,width/10*1.2,height/10*.045);
    pop();
    
    // tires
    fill(0,0,0);
    arc(carX+width/10*.4,carY+height/10*.63,width/10*.5,height/10*.5,0,PI);
    arc(carX+width/10*1.4,carY+height/10*.63,width/10*.5,height/10*.5,0,PI);
    
    // tire rims
    fill(0xff,0xff,0xff);
    arc(carX+width/10*.4,carY+height/10*.63,width/10*.3,height/10*.3,0,PI);
    arc(carX+width/10*1.4,carY+height/10*.63,width/10*.3,height/10*.3,0,PI);
    
    /* rim lines */
    // back tire
    push();
    translate(carX+width/10*.4,carY+height/10*.63);
    rotate(radians(num)); // rotating tires
    fill(0,0,0);
    for(int i=1;i<10;i++) {
      rotate(radians(360/i));
      rect(0,0,width/10*.02,height/10*.15);
    }
    pop();
    
    // front tire
    push();
    translate(carX+width/10*1.4,carY+height/10*.63);
    rotate(radians(num)); // rotating tires
    fill(0,0,0);
    for(int i=1;i<10;i++) {
      rotate(radians(360/i));
      rect(0,0,width/10*.02,height/10*.15);
    }
    pop();
    
    // grey car line at the bottom
    fill(#aaa9ad);
    rect(carX,carY+height/10*.49,width/10*2,height/10*.15,150);
        
    // glass
    strokeWeight(2);
    fill(#23acc4);
    rect(carX+width/10,carY-height/10*.35,width/10*.5,height/10*.3,4);
    
}

void drawStopSign(float hexX, float hexY) {
    /*
    busX = width/10*5, hexX = busX*1.1 = 220
    x:
    0 = 228
    1 = 224
    2 = 216
    3 = 212
    4 = 216
    5 = 224
    6 = 228
    busY = height/10*5.8, hexY = busY*1.04 = 241.28
    y:
    0 = 241.28
    1 = 248.21
    2 = 248.20
    3 = 241.28
    4 = 234.35
    5 = 234.35
    6 = 240.28
    
    */
     //draw hexagonal stop sign for school bus
    push();
    beginShape();
    stroke(0xff,0xff,0xff); // white stroke around stop sign
    strokeWeight(1.3);
    fill(214, 14, 0);
    vertex(hexX+width/10*.22,hexY);
    vertex(hexX+width/10*.11,hexY+height/10*.182);
    vertex(hexX-width/10*.11,hexY+height/10*.182);
    vertex(hexX-width/10*.165,hexY-height/10*.061);
    vertex(hexX+width/10*.11, hexY-height/10*.151);
    vertex(hexX+width/10*.22,hexY);
    endShape();
    
    fill(0xff,0xff,0xff);
    textSize(5.2);
    PFont stopSignFont = createFont(" Bold Cambria", 5.2);
    textFont(stopSignFont);
    text("STOP",hexX*.98,hexY*1.01);
    pop();
}

// goes right
void drawSchoolBus(float sBusX,float sBusY,int num) {
    // body
    fill(230, 232, 65);
    rect(sBusX,sBusY+height/10*.13,width/10*2.4,height/10*.4,6);
    rect(sBusX+width/10*.5,sBusY-height/10*.24,width/10*1.9,height/10*.5,3);
    
    // tires
    fill(0,0,0);
    arc(sBusX+width/10*.5,sBusY+height/10*.55,width/10*.5,height/10*.5,0,PI);
    arc(sBusX+width/10*1.75,sBusY+height/10*.55,width/10*.5,height/10*.5,0,PI);
    
    // tire rims
    fill(0xff,0xff,0xff);
    arc(sBusX+width/10*.5,sBusY+height/10*.55,width/10*.3,height/10*.3,0,PI);
    arc(sBusX+width/10*1.75,sBusY+height/10*.55,width/10*.3,height/10*.3,0,PI);
    
    /* rim lines */
    // back tire
    push();
    translate(sBusX+width/10*.5,sBusY+height/10*.58);
    rotate(radians(num)); // rotating tires
    fill(0,0,0);
    for(int i=1;i<10;i++) {
      rotate(radians(360/i));
      rect(0,0,width/10*.02,height/10*.15);
    }
    pop();
    
    // front tire
    push();
    translate(sBusX+width/10*1.75,sBusY+height/10*.58);
    rotate(radians(num)); // rotating tires
    fill(0,0,0);
    for(int i=1;i<10;i++) {
      rotate(radians(360/i));
      rect(0,0,width/10*.02,height/10*.15);
    }
    pop();
    
    // bus lines
    fill(215, 217, 48);
    rect(sBusX,sBusY+height/10*.429,width/10*2.4,height/10*.15,10);
    fill(0,0,0);
    rect(sBusX,sBusY+height/10*.29,width/10*2.4,height/10*.04);
    rect(sBusX,sBusY+height/10*.406,width/10*2.4,height/10*.04);
    
    // text
    textSize(width/50); // choose text size
    text("School Bus", sBusX+width/10,sBusY+height/10*.174);
    
    // windows
    push();
    float busWindowX = sBusX+width/10*.9;
    for(int i=1;i<4;i++) { // 3 windows other than the driver window
      strokeWeight(0.5);
      fill(36, 149, 214);
      stroke(0, 0, 0);
      rect(busWindowX,sBusY-height/10*.2339,width/10*.3,height/10*.25,4);
      busWindowX+= width/10*.5;
    }
    pop();
    fill(36, 149, 214);
    rect(sBusX+width/10*.5,sBusY-height/10*.2339,width/10*.3,height/10*.3,2);
    
    // stop sign
    drawStopSign(sBusX+width/10*.5,sBusY+height/10*.2322);
    
    // front headlights
    fill(252, 246, 207);
    rect(sBusX,sBusY+height/10*.2899,width/10*.1,height/10*.1,4);
    fill(179, 43, 43);
    rect(sBusX,sBusY+height/10*.377,width/10*.1,height/10*.1,2);
    
    // back headlights
    fill(252, 246, 207);
    rect(sBusX+width/10*2.35,sBusY+height/10*.2899,width/10*.1,height/10*.1,4);
    fill(179, 43, 43);
    rect(sBusX+width/10*2.35,sBusY+height/10*.377,width/10*.1,height/10*.1,2);
}

// goes right
void drawBlackCar(float carX,float carY,int num) {
    /* 5th parameter is for smoother surface */
    fill(10,10,10);
    rect(carX,carY,width/10*1.9,height/10*.5,4);
    fill(46, 44, 44);
    rect(carX-width/10*0.04,carY+height/10*0.4,width/10*2,height/10*.1,10);
    
    // tires
    fill(0,0,0);
    arc(carX+width/10*.5,carY+height/10*.5,width/10*.5,height/10*.5,0,PI);
    arc(carX+width/10*1.5,carY+height/10*.5,width/10*.5,height/10*.5,0,PI);
    
    // tire rims
    fill(0xff,0xff,0xff);
    arc(carX+width/10*.5,carY+height/10*.5,width/10*.3,height/10*.3,0,PI);
    arc(carX+width/10*1.5,carY+height/10*.5,width/10*.3,height/10*.3,0,PI);
    
    /* rim lines */
    // back tire
    push();
    translate(carX+width/10*1.5,carY+height/10*.5);
    rotate(radians(num)); // rotating tires
    fill(0,0,0);
    for(int i=1;i<10;i++) {
      rotate(radians(360/i));
      rect(0,0,width/10*.02,height/10*.15);
    }
    pop();
    
    // front tire
    push();
    translate(carX+width/10*.5,carY+height/10*.5);
    rotate(radians(num)); // rotating tires
    fill(0,0,0);
    for(int i=1;i<10;i++) {
      rotate(radians(360/i));
      rect(0,0,width/10*.02,height/10*.15);
    }
    pop();
    
    // top of the body
    fill(10,10,10);
    push();
    translate(carX+width/10*.4,carY-height/10*.35);
    rotate(radians(14));
    rect(0,0,width/10*.15,height/10*.4); // line on front
    pop();
    rect(carX+width/10*.9,carY-height/10*.3,width/10*.12,
         height/10*.4,4); // middle line
    push();
    translate(carX+width/10*1.3,carY-height/10*.3);
    rotate(radians(-14));
    rect(0,0,width/10*.15,height/10*.4); // back line
    pop();
    
    // top line
    rect(carX+width/10*.4,carY-height/10*.39,width/10*1.05,height/10*.1,1);
    
    // glass
    fill(36, 149, 214,99);
    quad(carX+width/10*.44,carY,carX+width/10*.94,carY,carX+width/10*.83,
         carY-height/10*0.325,carX+width/10*.56,carY-height/10*0.325);
    
    /* back glass is open */
    
    // headlights
    fill(212, 200, 36);
    rect(carX,carY+height/10*.1,width/10*.1,height/10*.1,25);
    rect(carX+width/10*1.85,carY+height/10*.1,width/10*.1,height/10*.1,25);
    fill(204, 6, 6);
    rect(carX,carY+height/10*.2,width/10*.1,height/10*.1,25);
    rect(carX+width/10*1.85,carY+height/10*.2,width/10*.1,height/10*.1,25);
}

// goes right
void drawBettleCar(float carX,float carY,int num) {
    // draw car body
    fill(#F5F5DC);
    arc(carX,carY,width/10*1.5,height/10*.9,PI,PI+HALF_PI); // back half
    push();
    translate(carX+width/10*.5,carY);
    rotate(radians(90));
    arc(0,0,width/10*.9,height/10*1.4,PI,PI+HALF_PI); // front half
    pop();
    
    push();
    stroke(.001);
    strokeWeight(.9);
    
    // car middle body
    rect(carX,carY-height/10*.5,width/10*.5,height/10*.5);

    // top car body
    arc(carX+width/10*.25,carY-height/10*.4,width/10*1.1,
        height/10*1.2,PI,TWO_PI);
    pop();
    
    // tires
    fill(0,0,0);
    arc(carX-width/10*.2,carY+height/10*.05,width/10*.5,height/10*.5,0,PI);
    arc(carX+width/10*.7,carY+height/10*.05,width/10*.5,height/10*.5,0,PI);
    
    // tire rims
    fill(0xff,0xff,0xff);
    arc(carX-width/10*.2,carY+height/10*.05,width/10*.3,height/10*.3,0,PI);
    arc(carX+width/10*.7,carY+height/10*.05,width/10*.3,height/10*.3,0,PI);
    
    /* rim lines */
    // back tire
    push();
    translate(carX+width/10*.7,carY+height/10*.05);
    rotate(radians(num)); // rotating tires
    fill(0,0,0);
    for(int i=1;i<10;i++) {
      rotate(radians(360/i));
      rect(0,0,width/10*.02,height/10*.15);
    }
    pop();
    
    // front tire
    push();
    translate(carX-width/10*.2,carY+height/10*.05);
    rotate(radians(num)); // rotating tires
    fill(0,0,0);
    for(int i=1;i<10;i++) {
      rotate(radians(360/i));
      rect(0,0,width/10*.02,height/10*.15);
    }
    pop();
      
    // car line on the bottom
    push();
    rectMode(CENTER);
    fill(#F5F5DC);
    /* draw car body on top of tire so rim lines are only
     * on bottom half
     */
    rect(carX+width/10*.2,carY-height/10*.009,width/10*2,
         height/10*.18,35);
    stroke(.001);
    strokeWeight(.05);
    fill(166, 151, 151);
    rect(carX+width/10*.2,carY+height/10*.009,width/10*2,
         height/10*.1,35);
    pop();
    
    // back glass
    fill(35, 157, 174);
    push(); // use push and pop for stroke
    stroke(.0001);
    strokeWeight(.6);
    arc(carX+width/10*.2,carY-height/10*.45,width/10*.85,
        height/10*.85,PI,PI+HALF_PI);
    pop();
    
    // front glass
    push(); // use push and pop for rotate
    stroke(.0001);
    strokeWeight(.6);
    translate(carX+width/10*.3,carY-height/10*.45);
    rotate(radians(90));
    arc(0,0,width/10*.85,height/10*.85,PI,PI+HALF_PI);
    pop();
    
    // door handle
    fill(5,5,5);
    rect(carX+width/10*.3,carY-height/10*.3,width/10*.08,
         height/10*.04);
    
    fill(212, 200, 36);
    // top white-ish headlight on the back of the car
    rect(carX-width/10*.72,carY-height/10*.3,width/10*.12,height/10*.12,10);
    
    // top white-ish headlight on the front of the car
    rect(carX+width/10*1.02,carY-height/10*.3,width/10*.12,height/10*.12,10);
    
    fill(204, 6, 6);
    // bottom red headlight on the back of the car
    rect(carX-width/10*.75,carY-height/10*.2,width/10*.12,height/10*.12,10);
    
    // bottom red headlight on the front of the car
    rect(carX+width/10*1.05,carY-height/10*.2,width/10*.12,height/10*.12,10);
}

float currentMouseX=0;
float currentMouseY=0;
boolean isMousePressed=false;
long laserWaitTime = millis()+4000;
int complexity = 50;
float randomY20to380 = random(width/20,width);
boolean lost; // if game lost
color shootingLaserColor = color(199, 22, 6);
float ufoX = mouseX;
float ufoY = mouseY;
int gamePoints = 0;

// draw UFO that follows cursor and shoots lasers
void drawUfo() {
    push();
    rectMode(CENTER);
    
    // draw body
    fill(148, 142, 142);
    ellipse(ufoX,ufoY,width/10*2,height/10*.8);
    
    // draw green lights
    fill(44, 237, 40);
    ellipse(ufoX-width/10*.53,ufoY*.99,width/10*.4,height/10*.4);
    ellipse(ufoX,ufoY*.99,width/10*.4,height/10*.4);
    ellipse(ufoX+width/10*.53,ufoY*.99,width/10*.4,height/10*.4);
    
    // draw glass
    fill(6, 144, 199,99);
    arc(ufoX,ufoY-height/10*.3,width/10*1.5,height/10*2,PI,TWO_PI);
    
    while(mousePressed) {
        currentMouseX = mouseX*2+width/10*.3;
        currentMouseY = mouseY;
        inc = mouseX;
        isMousePressed = true;
        break;
    }
    
    // shoot lasers if mouse pressed
    if(isMousePressed) {
      fill(199, 22, 6);
      rect(currentMouseX-inc,currentMouseY,width/10*1,height/10*.1,10);
    }
    inc+=3;
    
    // draw random lasers to avoid, using ufo
    if(millis() >= laserWaitTime) {

      laserWaitTime = millis()+4000-complexity;
    }
    complexity+=50;
    fill(shootingLaserColor);
    rect(randomLaserX,randomY20to380,width/10*1,height/10*.1,10);
    
    // if ufo's laser hits oncoming lasers, player gets 100 points
    if(currentMouseX-inc <= randomLaserX+width/10*1 &&
       currentMouseX-inc >= randomLaserX-width/10*1 &&
       currentMouseY <= randomY20to380+height/10*.1 &&
       currentMouseY >= randomY20to380-height/10*.1) {
        randomLaserX = -width/10*1;
        randomY20to380 = random(height/20,height-height/20);
        gamePoints+=100;
    }
    
    // if ufo x and y same as random laser
    if(mouseX <= randomLaserX && mouseX >= randomLaserX-width/10 &&
       mouseY <= randomY20to380+height/10*1.4 && mouseY >= randomY20to380-height/10*.5) {
        lost = true;
        shootingLaserColor = color(199, 22, 6,0); // 0 = opacity
    } else {
        randomLaserX+=3;
    }
        
    // if game is lost, print message to say player lost
    if (lost) {
        textSize(20);
        fill(0,0,0);
        text("game lost",width/10*5,height/10*5);
        
        // stop laser so that the player doesn't get points once game is lost
        randomLaserX-=3;
        
        if(ufoY <= height) {
          ufoY+=2; // increment for fall animation
          ufoX+=.5; // increment for fall animation
        }
    } else {
        ufoX = mouseX;
        ufoY = mouseY;
    }
    if(randomLaserX > width+width/10*2) {
        randomY20to380 = random(20,380); // re-initiliaze random y coordinate
        randomLaserX = 0;

        // if avoided random laser, player gets 10 points
        gamePoints+=10;
        
    }
    pop();
    
    // display points
    push();
    textSize(25);
    fill(0,0,0);
    text("points: " + gamePoints, width/10*6,height/10*1);
    pop();
}

// draw the traffic light body with conditional colors
void drawTrafficLight(color on, color offGreen,
                      color offRed,color offYellow,
                      String state) {
    // initialize traffic light variables
    float poleX = width/10*9.5;
    float poleW = width/10*.1;
    float circleW = poleW*2;
    float circleH = height/10*.1*2;
    float poleY = height/10*4.1;
    
    strokeWeight(1);
    
    // draw pole
    fill(#aaa9ad);
    rect(poleX,poleY, poleW,height/10*1.5);
    
    push();
    rectMode(CENTER);
    
    // draw base
    fill(219, 115, 18);
    rect(poleX,height/10*4.2,poleW*3,height/10);
    
    // draw traffic light
    if(state == "red") {
        fill(on); // red
        ellipse(poleX,poleY-height/10*.25,circleW,circleH);
        fill(offYellow); // yellow
        ellipse(poleX,poleY,circleW,circleH);
        fill(offGreen); // green
        ellipse(poleX,poleY+height/10*.25,circleW,circleH);
    }
    else if(state == "yellow") {
        fill(offRed); // red
        ellipse(poleX,poleY-height/10*.25,circleW,circleH);
        fill(on); // yellow
        ellipse(poleX,poleY,circleW,circleH);
        fill(offGreen); // green
        ellipse(poleX,poleY+height/10*.25,circleW,circleH);
    }
    else { // green
        fill(offRed); // red
        ellipse(poleX,poleY-height/10*.25,circleW,circleH);
        fill(offYellow); // yellow
        ellipse(poleX,poleY,circleW,circleH);
        fill(on); // green
        ellipse(poleX,poleY+height/10*.25,circleW,circleH);
    }
    pop();
    
}

// wait time to turn traffic light from changing colors
long waitTime = millis()+10000; // 10 seconds
int index = 0;
int speedDec = 0; // decrement speed

// declare traffic light state
String trafficLightState = "green";

// traffic light states to get every 5 seconds
String[] trafficLightStates = {"green","yellow","red"};

String TrafficLight() {
    // choose state of traffic light
    if(millis() >= waitTime) {
        index++; // increment index by 1
        index%=3; // incremented index mod 3
        trafficLightState = trafficLightStates[index];
        waitTime = millis()+10000;
    }
    
    // if red light not on
    color offRed = color(196, 35, 29);
    
    // if Yellow light not on
    color offYellow = color(173, 166, 26);
    
    // if green light not on
    color offGreen = color(16, 173, 18); 

    // if color on
    color onColor;

    // find which color is on light
    switch(trafficLightState) {
        case "green": // if green light on
            onColor = color(7, 232, 33);
            break;
        case "yellow": // if yellow light on
            onColor = color(212, 219, 9);
            break;
        case "red": // if red light on
            onColor = color(255, 17, 0);
            break;
        default: // green
            onColor = color(9, 219, 30);
    }
    // draw traffic light
    drawTrafficLight(onColor,offGreen,offRed,offYellow,
                     trafficLightState);
    
    // return traffic light state
    return trafficLightState;
}

void drawHouse(float houseW,float houseH, float houseX,
               float houseY, String houseColour)
{    
    // set house color
    switch(houseColour) {
        case "white":
            fill(5,5,5);
            break;
        // if user doesn't know which house colour to use
        case "don\'t know":
            fill(6, 50, 64);
            break;
        case "red":
            fill(0xff,10,10);
            break;
        case "brick":
            fill(#cb4154);
        default: // if none of the above
            fill(230, 85, 32);
            break;
    }
    
    /* draw house */
    // base
    rect(houseX, houseY, houseW,houseH);

    // roof
    fill(0xbf,0,0x23);
    triangle(houseX/1.04, houseY, houseX+houseX/5, houseY/10,
             houseW+houseX/.96, houseY);

    // window
    fill(#a8ccd7);
    rect(houseX/17*18, houseY/24*30, houseW/4,houseH/4);

    // door
    fill(0x50,0x40,0x00);
    rect(houseX*1.2, houseY*1.35, houseW/2.6, houseH/1.6);
}

// the height of cloud when it spawns
float rand1To3 = random(1,3);

void drawBackground() {
    float sunX = width/10*9;
    float sunY = height/10*1;
    drawRoad();
    
    // draw the sun
    push();
    translate(sunX,sunY);
    rotate(radians(sunIndexI));
    fill(#f9d71c);
    ellipse(0,0,width/10*1.5,height/10*1.5);
    sunIndexI+=10;
    if(sunIndexI > 360) {
        sunIndexI=0;
    }
    pop();

    // draw non moving cloud
    drawCloud(width/10*8,cloudY);
  
  
    // draw moving cloud
    if(cloudX < width+width/10) {
        drawCloud(cloudX,height/10*rand1To3);
        cloudX+=.3;
    } else {
      cloudX=width/10;
      drawCloud(cloudX,height/10*rand1To3);
    }
  
    // draw grass above and below road
    push();
    noStroke();
    fill(#567d46);
    rect(0,height/10*8,width,height/10*2); // below road
    rect(0,height/10*4,width,height/10*1.7); // above road
    pop();

    // draw building after cloud so it overlaps correctly
    drawBuilding();
    
    // draw house next to building
    drawHouse(width/10*2,height/10*2,width/10*5.3,
              height/10*2.1, "brick");
    
    // draw first tree
    drawTree(width/10*2,height/10*5,height/10*2);

    // draw second tree
    drawTree(width/10*5,height/10*5.6,height/10*2);

    // draw third tree
    drawTree(width/10*8,height/10*5,height/10*2);
}

void draw() {
    // declare traffic light state
    String trafficLightState;
    
    background(#87ceeb);
    drawBackground();
    
    // draw traffic light
    trafficLightState = TrafficLight();
    
     drawSchoolBus(busX,aboveRoadY,rotateTireRight);
    
     drawBlackCar(blackCarX,aboveRoadY,rotateTireRight);

     drawRedCar(redCarX,belowRoadY,rotateTireLeft);
          
     drawBettleCar(bettleCarX,BettleCarY,rotateTireLeft);
          
     drawUfo();
     
     rotateTireRight-=2;

     // stop cars from overlapping
     // if red car overlapping bettle car
     if(redCarX <= bettleCarX+width*10*3 && redCarX >= bettleCarX-width/10*3) {
         redCarX+=5;
     }
     
     // seperate conditional statment for top lane cars overlapping
     if(blackCarX <= busX+width*10*4 && blackCarX >= busX-width/10*1) {
         blackCarX+=1;
     }
     else if(busX <= blackCarX+width*10*4 && busX >= blackCarX-width/10*1) {
         blackCarX-=1;
     } else {
         blackCarX = width*4;
         blackCarX-=10;
     }
      
      // if red stop, if green or yellow continue
      if(trafficLightState == "green" || trafficLightState == "yellow") {
          redCarX+=2;
          rotateTireLeft+=2;
          bettleCarX+=2;
       /* if red, stops by decrementing speed */
      } else if (trafficLightState == "red") {
          if(redCarX < bettleCarX) {
              if((bettleCarX <= width/10*7.5) && 
                 !(bettleCarX >= width/10*7)) {
                  bettleCarX+=2;
                  rotateTireLeft+=2;
              }
              if((redCarX <= width/10*5) &&
                 !(redCarX >= width/10*3)) {
                  redCarX+=2;
                  rotateTireLeft+=2;
              }
          } else {
              if((redCarX <= width/10*7.5) && 
                 !(redCarX >= width/10*7)) {
                  redCarX+=2;
                  rotateTireLeft+=2;
              }
              if((bettleCarX <= width/10*5) &&
                 !(bettleCarX >= width/10*3)) {
                  bettleCarX+=2;
                  rotateTireLeft+=2;
              }
              
          }
      }
      blackCarX-=2;
      busX-=2;
            
      // reset car location
      /* make sure to stop cars from overlapping by starting 2 of 
       * the cars way before the other car appears
       */
      if(redCarX >= width+width/10) {
          redCarX = -width/5 -width/10*5; // reset
      }
      else if(bettleCarX >= width+width/10*5) {
           bettleCarX = -width/10*5; // reset
      }
      else if(blackCarX <= -width/10*1.9) {
          blackCarX = (width+width/10*1.9)*2.5; // reset
      }
      else if(busX <= -width/10*3) {
          busX = width+width/10*1.9; // reset
      }
}
