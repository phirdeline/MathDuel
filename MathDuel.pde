//Decalring variables...
color cWhite = color(255);
color cBlue = color(40, 37, 124);
color cOrange = color(252, 207, 89);
color cRed = color(220, 90, 90);
color cGreen = color(100, 200, 100);
int textSize1, textSize2;
int p0Score = 0, p1Score = 0;
float[] p0OptionXs = new float[3];
float[] p0OptionYs = new float[2];
float firstOptionX, firstOptionY;
float optionStepW, optionStepH;
float buttonW, buttonH, buttonR;
int mainA, mainB;
int[] option = new int[6];
int rightIndex ;
int winner;
int state2Frame;
float rounds, round;
int gameState = 1;

//do once
void setup() {
  orientation(PORTRAIT);
  fullScreen();
  frameRate(30);
  textAlign(CENTER, CENTER);
  rectMode(CENTER);
  ellipseMode(CENTER);
  textSize1 = width/18;
  textSize2 = width/9;
  gameState = 0;
  round = 1;
  //preparing to draw buttons...
  buttonW = 28*width/100;
  buttonH = 14*height/100; 
  buttonR = buttonH/6;
  optionStepW = buttonW + buttonW/8;
  optionStepH = buttonH + buttonH/8;
  firstOptionX = width/2 - optionStepW;
  firstOptionY = 3*height/4;
  for (int i = 0; i < 3; i++) p0OptionXs[i] = firstOptionX + optionStepW*i;
  for (int j = 0; j < 2; j++) p0OptionYs[j] = firstOptionY + optionStepH*j;
  //preparing math equation and random numbers
  mainA = int(random(1000));
  mainB = int(random(1000));
  for (int i = 0; i < option.length; i++) { 
    do
      option[i] = int(random(1000000));
    while ((option[i]%10)!=((mainA*mainB)%10));
  };
  rightIndex = int(random(1200))%6;
  option[rightIndex] = mainA * mainB;
}

//do every frame
void draw() {
  textSize(textSize1);
  background(cWhite);
  
  //depending on what the current scene is supposed to be...
  switch(gameState) {
  case 0:
    //drawing things
    fill(cBlue);
    text("Choose the number of rounds", width/2, height/4);
    noFill();
    stroke(cBlue);
    strokeWeight(width/120);
    rect(width/3, 4*height/8, buttonW, buttonH, buttonR);
    rect(2*width/3, 4*height/8, buttonW, buttonH, buttonR);
    rect(width/2, 5.3*height/8, buttonW, buttonH, buttonR);
    text("5", width/3, 4*height/8);
    text("10", 2*width/3, 4*height/8);
    text("Infinity", width/2, 5.3*height/8);
    //when a button touched the scene switches
    if (mousePressed) {
      if ( (mouseY > 4*height/8-buttonH/2)&&(mouseY < 4*height/8+buttonH/2) ) {
        if ( (mouseX > width/3-buttonW/2)&&(mouseX < width/3+buttonW/2) ) {
          rounds = 5;
          gameState = 1;
          delay(1000);
        };
        if ( (mouseX > 2*width/3-buttonW/2)&&(mouseX < 2*width/3+buttonW/2) ) {
          rounds = 10;
          gameState = 1;
          delay(1000);
        };
      };
      if ( (mouseY > 5.3*height/8-buttonH/2)&&(mouseY < 5.3*height/8+buttonH/2) )
        if ( (mouseX > width/2-buttonW/2)&&(mouseX < width/2+buttonW/2) ) {
          rounds = -1;
          gameState = 1;
          delay(1000);
        };
    }
    break;
  case 1:
    //for every button on one side... (code in between pushMatrix() and popMatrix() mirrors everything to the other side)
    for (int i = 0, k = 0; i < 3; i++) { 
      for (int j = 0; j < 2; j++, k++) {
        //draw stuff
        noFill();
        stroke(cBlue);
        strokeWeight(width/120);
        rect(p0OptionXs[i], p0OptionYs[j], buttonW, buttonH, buttonR);
        pushMatrix();
        translate(width, height);
        rotate(PI);
        rect(p0OptionXs[i], p0OptionYs[j], buttonW, buttonH, buttonR);
        popMatrix();
        //switch game state when a choice is made, keeping which player it is in memory
        if (mousePressed) {
          float invertedMouseX;
          float invertedMouseY;
          invertedMouseX = width - mouseX;
          invertedMouseY = height - mouseY;
          if ( (mouseX > p0OptionXs[i]-buttonW/2)&&(mouseX < p0OptionXs[i]+buttonW/2) ) {
            if ( (mouseY > p0OptionYs[j]-buttonH/2)&&(mouseY < p0OptionYs[j]+buttonH/2) ) {
              switchGameState(k, rightIndex, 0);
            }
          };
          if ( (invertedMouseX > p0OptionXs[i]-buttonW/2)&&(invertedMouseX < p0OptionXs[i]+buttonW/2) ) {
            if ( (invertedMouseY > p0OptionYs[j]-buttonH/2)&&(invertedMouseY < p0OptionYs[j]+buttonH/2) ) {
              switchGameState(k, rightIndex, 1);
            }
          };
        };
        //draw more stuff
        fill(cBlue);
        text(str(option[k]), p0OptionXs[i], p0OptionYs[j]);
        pushMatrix();
        translate(width, height);
        rotate(PI);
        text(str(option[k]), p0OptionXs[i], p0OptionYs[j]);
        popMatrix();
      };
    };
    //draw more stuff
    stroke(cBlue);
    strokeWeight(width/180);
    line(width/3, height/2, 2*width/3, height/2);
    fill(cBlue);
    textSize(textSize2);
    text(str(mainA)+"*"+str(mainB), width/2, 14*height/24);
    pushMatrix();
    translate(width, height);
    rotate(PI);
    text(str(mainA)+"*"+str(mainB), width/2, 14*height/24);
    popMatrix();
    break;
  case 2:
    //count frames, since the framerate is set to 30 it is as good as counting time
    state2Frame++;
    //draw stuff
    stroke(cBlue);
    strokeWeight(width/180);
    line(width/3, height/2, 2*width/3, height/2);
    fill(cWhite);
    ellipse(width/2, height/2, width/10, width/10);
    if (rounds!=-1) {
      stroke(cBlue);
      fill(cWhite);
      if (round!=rounds) strokeWeight(width/360);
      ellipse(width/2, height/2, (round/rounds)*(width/10), (round/rounds)*(width/10));
    };
    noFill();
    strokeWeight(width/72);
    if (winner==0) stroke(cOrange);
    if (winner==1) stroke(cBlue);
    ellipse(width/2, 3*height/4, width/1.8, width/1.8);
    if (winner==1) stroke(cOrange);
    if (winner==0) stroke(cBlue);
    pushMatrix();
    translate(width, height);
    rotate(PI);
    ellipse(width/2, 3*height/4, width/1.8, width/1.8);
    popMatrix();
    fill(cBlue);
    textSize(textSize2);
    //draw stuff depending on how many frames have passed
    if (winner==0) {
      if (state2Frame<1*30) {
        text(str(p0Score-1), width/2, 3*height/4);
      } else {
        text(str(p0Score), width/2, 3*height/4);
      };
      pushMatrix();
      translate(width, height);
      rotate(PI);
      text(str(p1Score), width/2, 3*height/4);
      popMatrix();
    };
    if (winner == 1) {
      if (state2Frame<1*30) {
        pushMatrix();
        translate(width, height);
        rotate(PI);
        text(str(p1Score-1), width/2, 3*height/4);
        popMatrix();
      } else {
        pushMatrix();
        translate(width, height);
        rotate(PI);
        text(str(p1Score), width/2, 3*height/4);
        popMatrix();
      };
      text(str(p0Score), width/2, 3*height/4);
    }
    if (state2Frame<1*30) {
      if (winner == 0) 
        text(str(p0Score-1), width/2, 3*height/4);
    } else {
      text(str(p0Score), width/2, 3*height/4);
    };
    //doesn't happen on the last round
    if (round!=rounds) {
      stroke(cOrange);
      strokeWeight(width/180);
      fill(cWhite);
      if (((state2Frame > 2*30)&&(state2Frame < 2.2*30))
        || ((state2Frame > 3*30)&&(state2Frame < 3.2*30)) 
        || ((state2Frame > 4*30)&&(state2Frame < 4.2*30))) {
        line(width/3, height/2, 2*width/3, height/2);
        ellipse(width/2, height/2, width/10, width/10);
        if (rounds!=-1) {
          stroke(cBlue);
          fill(cWhite);
          strokeWeight(width/360);
          ellipse(width/2, height/2, (round/rounds)*(width/10), (round/rounds)*(width/10));
          if (round==rounds) {
            stroke(cOrange);
            noFill();
            strokeWeight(width/180);
            ellipse(width/2, height/2, width/10, width/10);
          }
        };
      };
    };
    if (state2Frame > 5*30) switchGameState(-1, -1, -1);
    break;
  };
}

//function that switches between game states, resets and updates some variables
void switchGameState(int k, int rightInd, int player) {
  switch(gameState) {
  case 1:
    gameState = 2;
    if (k == rightInd) {
      switch(player) {
      case 0:
        p0Score++;
        break;
      case 1:
        p1Score++;
        break;
      };
      winner = player;
    } else {
      switch(player) {
      case 1:
        p0Score++;
        break;
      case 0:
        p1Score++;
        break;
      };
      winner = 1-player;
    }
    state2Frame = 0;
    break;
  case 2:
    gameState = 1;
    if (rounds != -1) {
      round++;
      if (round > rounds) {
        round = 1;
        gameState = 0;
        p0Score = 0;
        p1Score = 0;
        break;
      };
    }
    for (int i = 0; i < 3; i++) p0OptionXs[i] = firstOptionX + optionStepW*i;
    for (int j = 0; j < 2; j++) p0OptionYs[j] = firstOptionY + optionStepH*j;
    mainA = int(random(1000));
    mainB = int(random(1000));
    for (int i = 0; i < option.length; i++) {
      do
        option[i] = int(random(1000000));
      while ((option[i]%10)!=((mainA*mainB)%10)) ;
    };
    rightIndex = int(random(1200))%6;
    option[rightIndex] = mainA * mainB;
    break;
  }
}
