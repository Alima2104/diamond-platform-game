class Portal{
  float w,h,x,y;
  float halfWidth, halfHeight;
  
  Portal(float _x, float _y, float _w, float _h) {
    w = _w;
    h = _h;
    x = _x;
    y = _y;
    
    halfWidth = w/2;
    halfHeight = h/2;
  }
  
  void display(){
    noStroke();
    //fill(157, 72, 194);
    //rect(x,y,w,h);
    image(airplane, x, y, w, h);
  }
}
