
// 1. Follow the recipe instructions inside the Segment class.

// The Segment class will be used to represent each part of the moving snake.

class Segment {

  //2. Create x and y member variables to hold the location of each segment.
      int x;
      int y;
  // 3. Add a constructor with parameters to initialize each variable.
    Segment(int xPos, int yPos) {
       this.x = xPos;
       this.y = yPos;
    }

  // 4. Add getter and setter methods for both the x and y member variables.
  
  int getX() {
    return x;
  }
  int getY() {
    return y;
  }
  void setX(int newX) {
    x  = newX;
  }
  void setY(int newY) {
    y = newY;
  }
}


// 5. Create (but do not initialize) a Segment variable to hold the head of the Snake
Segment head;


// 6. Create and initialize a String to hold the direction of your snake e.g. "up"
String direction;


// 7. Create and initialize a variable to hold how many pieces of food the snake has eaten.
// give it a value of 1 to start.
int foodCount = 1000;


// 8. Create and initialize foodX and foodY variables to hold the location of the food.
int foodX = int(random(10,40))*10;
int foodY =  int(random(10,40))*10;

boolean isDisco = false;


// (Hint: use the random method to set both the x and y to random locations within the screen size (500 by 500).)

//int foodX = ((int)random(50)*10);



void setup() {

  // 9. Set the size of your sketch (500 by 500).

  size(500, 500);


  // 10. initialize your head to a new segment.
      head = new Segment(250,250);

  // 11. Use the frameRate(int rate) method to set the rate to 20.
    frameRate(10);
    direction = "up";
    noStroke();
}


void draw() {

  background(0);


  //12. Call the manageTail, drawFood, drawSnake, move, and collision methods.
  manageTail();
  drawFood();
  drawSnake();
  move();
  collision();
  
}


// 13. Complete the drawFood method below. (Hint: each piece of food should be a 10 by 10 rectangle).

void drawFood() {
  fill(255,0,0);
  rect(foodX, foodY, 10,10);
  fill(255,255,255);
}


//14. Draw the snake head (use a 10 by 10 rectangle)

void drawSnake() {
  if(isDisco == true) {
   fill(random(0,255),random(0,255),random(0,255));
  }
  else {
      fill(255,215,0);
   }
 
  rect(head.getX(), head.getY(), 10,10);
  fill(255,255,255);
  //test your code
}


// 15. Complete the move method below.

void move() {

  // 16. Using a switch statement, make your snake head move by 10 pixels in the correct direction.
  //This is an incomplete switch statement:
  switch(direction) {
  case "up":
    head.setY(head.getY()-10);
    break;
  case "down":
    head.setY(head.getY()+10);
    break;
  case "left":
      head.setX(head.getX()-10);
    break;
  case "right":
    head.setX(head.getX()+10);
    break;
  }
  


  // 17. Call the checkBoundaries method to make sure the snake head doesn't go off the screen.
  checkBoundaries();
}


// 18. Complete the keyPressed method below. Use if statements to set your direction variable depending on what key is pressed.

void keyPressed() {
  if(key == 'w') {
     if(direction != "down") {
    direction = "up";
     }
  }
  if(key == 'a') {
     if(direction != "right") {
    direction = "left";
     }
  }
  if(key == 's') {
    if(direction != "up") {
    direction = "down";
    }
    
  }
  if(key == 'd') {
     if(direction != "left") {
    direction = "right";
     }
  }
  if(key == 'i') {
    if(isDisco == false) {
      isDisco = true;
    }
    else {
      isDisco = false;
    }
  }
}



// 19. check if your head is out of bounds (teleport your snake head to the other side).

void checkBoundaries() {
  if(head.getX() > width) {
    head.setX(1);
  }
  if(head.getX() < 0) {
    head.setX(width-1);
  }
  if(head.getY() > height) {
    head.setY(1);
  }
  if(head.getY() < 0) {
    head.setY(height-1);
  }
}



//20. Make sure that the key for your current direction’s opposite doesn’t work(i.e. If you’re going up, down key shouldn’t work)



// 21. Complete the missing parts of the collision method below.

void collision() {

  // If the segment is colliding with a piece of food...
     // Increase the amount of food eaten and set foodX and foodY to new random locations.
     if(head.getX() >= foodX-5 && head.getX() <= foodX+5) {
       if(head.getY() >= foodY-5 && head.getY() <= foodY+5) {
         foodCount = foodCount + 1;
         foodX =  int(random(10,40))*10;
         foodY =  int(random(10,40))*10;
       }
     }
}



/**
 
 ** Part 2: making the tail (the rest of the snake)
 
 **/

//  1. Create and initialize an ArrayList of Segments. (This will be your snake tail!)
  ArrayList<Segment> tailArr = new ArrayList<Segment>();

// 2. Complete the missing parts of the manageTail method below and call it in the draw method.

void manageTail() {

  //Call the drawTail and checkTailCollision methods.
    drawTail();
    checkTailCollision();
  // Add a new Segment to your ArrayList that has the same X and Y as the head of your snake.
    tailArr.add(new Segment(head.getX(), head.getY()));
  // To keep your tail the right length:
  // while the tail size is greater than the number of food pieces eaten, remove the first Segment in your tail.
    if(tailArr.size() > foodCount) {
       tailArr.remove(0);
    }
}

void drawTail() {
  boolean darkGreen = false;
    // Draw a 10 by 10 rectangle for each Segment in your snake ArrayList.
    for(Segment current : tailArr) {
      if(darkGreen) {
        fill(0,100,0);
        darkGreen = false;
      }
      else {
        if(isDisco == true) {
           fill(random(0,255),random(0,255),random(0,255));
        }
        else {
          fill(0,255,0);
        }
       
        //darkGreen = true;
      }
      
      rect(current.getX(), current.getY(), 10, 10);
      fill(255,255,255);
      
    }
}    


// 3. Complete the missing parts of the bodyCollision method below.

void checkTailCollision() {

  // If your head has the same location as one of your segments...
    for(Segment check : tailArr) {
      if(head.getX() >= check.getX()-5 && head.getX() <= check.getX()+5) {
       if(head.getY() >= check.getY()-5 && head.getY() <= check.getY()+5) {
         print("hi");
          foodCount = 1;
          tailArr.clear();
          break;
       }
     }
    }
  // reset your food variable

  //Call this method at the beginning of your manageTail method.
}
