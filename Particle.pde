

class Particle {
  float[] a,b,c;
  float valA, valB, valC ;
  float adx, ady;
  
  Particle(float _adx, float _ady)
  {
       adx = _adx;
       ady = _ady;
       a = new float[2];  float valA = 0;
       b = new float[2];  float valB = 0;
       c = new float[2];  float valC = 0;

       a[0] = width-100 ; a[1] = height-110;
       b[0] = width-110 ; b[1] =  height-105;
       c[0] = width-105 ; c[1] =  height-100;
  }
  void display() {
    stroke(255);
    strokeWeight(1);
    line(a[0],a[1],b[0],b[1]);
    line(a[0],a[1],c[0],c[1]);
    line(b[0],b[1],c[0],c[1]);
  }

  
  void updateA(float x,float y, float val) {
    a[0]=x;
    a[1]=y;
    valA = val;
  }
  void updateB(float x,float y, float val) {
    b[0]=x;
    b[1]=y;
    valB = val;
  }
  void updateC(float x,float y, float val) {
    c[0]=x;
    c[1]=y;
    valC = val;
  }
  
  float minDistA(float x, float y) {
    return sqrt( pow((x-a[0]),2) + pow((y-a[1]),2) ) ;
  }
  float minDistB(float x, float y) {
    return  sqrt( pow((x-b[0]),2) + pow((y-b[1]),2) );
  }
  float minDistC(float x, float y) {
    return sqrt( pow((x-c[0]),2) + pow((y-c[1]),2) );
  }
  
  char findWorthPoint() {
    char lettre = 'z';
    if(valA>=valC && valA>=valB) lettre = 'a';
    if(valB>=valC && valB>=valA) lettre = 'b';
    if(valC>=valA && valC>=valB) lettre = 'c';
    return lettre;
  }
  void moveWorthPoint(char lettre) {
    float x = 0; 
    float y = 0;
    //************************* LETTRE A
    if(lettre == 'a') {
      x = (b[0]*valC+c[0]*valB)/(valB+valC);
      y = (b[1]*valC+c[1]*valB)/(valB+valC);
      if(x > a[0]) {
        a[0] += 2*abs(a[0]-x); 
      } else {
        a[0] -= 2*abs(a[0]-x); 
      }
      if(y > a[1]) {
        a[1] += 2*abs(a[1]-y); 
      } else {
        a[1] -= 2*abs(a[1]-y); 
      }      
    } 
    //************************* LETTRE B
    else if (lettre =='b') {
      x = (a[0]*valC+c[0]*valA)/(valA+valC);
      y = (a[1]*valC+c[1]*valA)/(valA+valC);
      if(x > b[0]) {
        b[0] += 2*abs(b[0]-x); 
      } else {
        b[0] -= 2*abs(b[0]-x); 
      }  
      if(y > b[1]) {
        b[1] += 2*abs(b[1]-y); 
      } else {
        b[1] -= 2*abs(b[1]-y); 
      }  
    }
    //************************* LETTRE C
    else if (lettre =='c') {
      x = (a[0]*valB+b[0]*valA)/(valA+valB);
      y = (a[1]*valB+b[1]*valA)/(valA+valB);
      if(x > c[0]) {
        c[0] += 2*abs(c[0]-x); 
      } else {
        c[0] -= 2*abs(c[0]-x); 
      }  
      if(y > c[1]) {
        c[1] += 2*abs(c[1]-y); 
      } else {
        c[1] -= 2*abs(c[1]-y); 
      } 
    }
  }
  
  
  
  float triSize =1.5;
  void mousePressed() {
    if (mousePressed) {
       a[0] = mouseX -triSize*lX; ; a[1] = mouseY -triSize*lX ;
       b[0] = mouseX          ; b[1] = mouseY +triSize*lX ;
       c[0] = mouseX +triSize*lX ; c[1] = mouseY -triSize*lX ;
    }
  }  
}