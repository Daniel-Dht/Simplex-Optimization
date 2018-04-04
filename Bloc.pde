class Bloc {
  float m_x;
  float m_y;
  float m_value;
  int m_r;
  int m_g;
  int m_b;
  float m_lX;
  float m_lY;
  float  m_iso;
  
  Bloc(float x, float y, float lX, float lY, float val) {
    
    m_x = x;
    m_y = y;
    m_lX = lX;
    m_lY = lY;
    
    m_value = val;
    m_r = int( map(m_value,min,max,0,255) ); 
    

    //if (val<min+30){
    //  m_r = int( map(m_value,min,min+30,0,255) ); 
    //}
    //if (val<min+20){
    //  m_r = int( map(m_value,min,min+20,0,255) ); 
    //}
    //if (val<min+10){
    //  m_r = int( map(m_value,min,min+10,0,255) ); 
    //}
    
    m_iso = min+100;
    while(m_iso>min+10) {
      if (val<m_iso){
        m_r = int( map(m_value,min,m_iso,0,200) ); 
      }
      
       m_iso -=11;
    }
    //m_r = 100;
    m_g = 50 ;
    m_b = 70;
  }
  
  void display() {
      
      stroke(80);
      noStroke();
      fill(m_r, m_g, m_b);
      rect(m_x,m_y,m_lX,m_lY);
  }
  void showVal() {
    fill(255);
    text(m_value, m_x, m_y);  
  }
  
  void update() {
    
  }
}