class Diamond {
  float w,h,x,y;
   float halfWidth, halfHeight;
   Diamond(float _x, float _y, float _w, float _h){
    w = _w;
    h = _h;
    x = _x;
    y = _y;
    halfWidth = w/2;
    halfHeight = h/2;
  }
  
  void setDiamond(float _x, float _y, float _w, float _h)
  {
     w = _w;
    h = _h;
    x = _x;
    y = _y;
  }
  
  void display(){
    image(diamond, x, y, w, h);
  }
  
  
  
}
