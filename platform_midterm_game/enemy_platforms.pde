class Enemy {
  float w,h,x,y;
  String typeof;
  float halfWidth, halfHeight;

  Enemy(float _x, float _y, float _w, float _h){
    w = _w;
    h = _h;
    x = _x;
    y = _y;
    //typeof = _typeof;

    halfWidth = w/2;
    halfHeight = h/2;
  }

  void display(){
    noStroke();
    fill(255, 0, 0);
    rect(x,y,w,h);
  }
}
