class Character1 {

  float w, h, x, y, vx, vy, accelerationX, accelerationY, speedLimit;

  color c1color;

  float friction, bounce, gravity;

  boolean isOnGround;
  float jumpForce;

  float halfWidth, halfHeight;
  String collisionSide;

  Character1(float w1, float h1, float x1, float y1) {
    w = w1;
    h = h1;
    x = x1;
    y = y1;
    vx = 0;
    vy = 0;
    accelerationX = 0;
    accelerationY = 0;
    speedLimit = 10;
    isOnGround = false;
    jumpForce = -6;
    //c1color = c;

    friction = 0.96;
    bounce = -0.7;
    gravity = .2;

    halfWidth = w/2;
    halfHeight = h/2;

    collisionSide = "";
  }

  void SetC1(int Xc, int Yc) {
    x = Xc;
    y = Yc;
  }

  void update() {

    if (left && !right) {
      accelerationX = -0.2;
      friction = 1;
      direction = -1;
      x-=speed;
    }
    if (right && !left) {
      accelerationX = 0.2;
      friction = 1;
      direction = 1;
      x+=speed;
    }
    if (!left&&!right) {
      accelerationX = 0;
    }

    if (keyPressed) {

      if (frameCount%speed==0) {
        step = (step+1) % 6;
      }
    }


    if (up && !down && isOnGround) {
      vy = jumpForce;
      isOnGround = false;
      //gravity = 0;
      friction = 1;
    }

    if (down && !up) {
      //accelerationY = 0.2;
      //friction = 1;
    }
    if (!up&&!down) {
      //accelerationY = 0;
    }
    //removing impulse reintroduces friction
    if (!up && !down && !left && !right) {
      friction = 0.96; 
      //gravity = 0.3;
    }

    vx += accelerationX;
    vy += accelerationY;

    //friction 1 = no friction
    vx *= friction;

    //apply gravity
    vy += gravity;

    ////correct for maximum speeds
    if (vx > speedLimit) {
      vx = speedLimit;
    }
    if (vx < -speedLimit) {
      vx = -speedLimit;
    }
    //need to let gravity ramp it up
    if (vy > 3 * speedLimit) {
      vy = 3 * speedLimit;
    }
    //don't need when jumping
    if (vy < -speedLimit) {
      //vy = -speedLimit;
    }

    //correct minimum speeds
    if (abs(vx) < 0.2) {
      vx = 0;
    }

    ////move the player
    x+=vx;
    y+=vy;

    checkBoundaries();
    checkPlatforms();
  }


  void checkBoundaries() {
    ////check boundaries
    ////left
    if (x < 0) {
      vx *= bounce;
      x = 0;
    }
    //// right
    if (x+ w > width) {
      vx *= bounce;
      x = width - w;
    }
    ////top
    if (y < 0) {
      vy *= bounce;
      y = 0;
    }
    if (y + h > height) {
      if (vy < 1) {
        isOnGround = true;
        vy = 0;
      } else {
        //reduced bounce for floor bounce
        vy *= bounce/2;
      }
      y = height - h;
    }
  }

  void checkPlatforms() {
    ////update for platform collisions
    if (collisionSide == "bottom" && vy >= 0) {
      if (vy < 1) {
        isOnGround = true;
        vy = 0;
        println("top");
      } else {
        //reduced bounce for floor bounce
        vy *= bounce/2;
      }
    } else if (collisionSide == "top" && vy <= 0) {
      vy = 0;
    } else if (collisionSide == "right" && vx >= 0) {
      vx = 0;
    } else if (collisionSide == "left" && vx <= 0) {
      vx = 0;
    }
    if (collisionSide != "bottom" && vy > 0) {
      isOnGround = false;
    }
  }

  void display() {
    fill(c1color);
    //rect(x, y, w, h);
    imageMode(CENTER);
    pushMatrix();
    //translate(w, h);
    scale(direction, 1);
    image(sprites[step], direction*x, y, w, h);
    popMatrix();

    // image(sprites[step], x, y, w, h);
  }
}
