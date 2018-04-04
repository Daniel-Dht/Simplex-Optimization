
int n=1000;
float lX;
float lY;
float val_f=0;

Bloc[][] blocs = new Bloc[n][n];

float min;
float max;
float adjust ;
Particle simplex;
char lettre ;



void setup () {
  size(1000, 1000);
  background(200);
  lX = width/n;
  lY = height/n;

  simplex = new Particle(width/2,height/2);
  
  val_f = f(0,0);
 
  min = val_f;
  max= val_f;
  
  for (int i=0; i<n; i++) {
    for (int j=0; j<n; j++) {
       val_f = f(i,j);

      if (min>val_f) min = val_f;
      if (max<val_f) max = val_f;
    }
  }
  
  for (int i=0; i<n; i++) {
    for (int j=0; j<n; j++) {
      val_f = f(i,j);

      blocs[i][j] = new Bloc( lX/2+lX*i, lY/2+lY*j, lX, lY, val_f );
    }
  }

  rectMode(CENTER);
  for (int i=0; i<n; i++) {
    for (int j=0; j<n; j++) {
      blocs[i][j].display();
     // blocs[i][j].showVal();
     stroke(0);
     if(i-n/2==0) line(i*lX,0,i*lX,height);
     if(j-n/2==0) line(0,j*lY,width,j*lY);
    }
  }

  updateTrianglePoints(blocs,  simplex ,  'a' );
  updateTrianglePoints(blocs,  simplex ,  'b' );
  updateTrianglePoints(blocs,  simplex ,  'c' );
  //  print("val a : ",simplex.valA,"\n",
  //      "val b : ",simplex.valB,"\n",
  //      "val c : ",simplex.valC,"\n");
  
  //print("a : ",simplex.a[0],",",simplex.a[1],"\n",
  //      "b : ",simplex.b[0],",",simplex.b[1],"\n",
  //      "c : ",simplex.c[0],",",simplex.c[1],"\n");
  
  simplex.display();
  
  //lettre = simplex.findWorthPoint();
  //print("lettre : ",lettre,"\n");
  //print("val a : ",simplex.valA,"\n",
  //      "val b : ",simplex.valB,"\n",
  //      "val c : ",simplex.valC,"\n");
  //simplex.moveWorthPoint( lettre );
  //print("a : ",simplex.a[0],",",simplex.a[1],"\n",
  //      "b : ",simplex.b[0],",",simplex.b[1],"\n",
  //      "c : ",simplex.c[0],",",simplex.c[1],"\n");  
        
  //updateTrianglePoints(blocs,  simplex ,  lettre );
  //simplex.display();
}


void draw() {

  lettre = simplex.findWorthPoint();
  simplex.moveWorthPoint( lettre );
  updateTrianglePoints(blocs,  simplex ,  lettre );
  
  //for (int i=0; i<n; i++) {
  //  for (int j=0; j<n; j++) {
  //    blocs[i][j].display();
  //   // blocs[i][j].showVal();  
  //  }
  //}
  simplex.display();
  if(mousePressed) {
    simplex.mousePressed();
    updateTrianglePoints(blocs,  simplex ,  'a' );
    updateTrianglePoints(blocs,  simplex ,  'b' );
    updateTrianglePoints(blocs,  simplex ,  'c' );
  }
}

float f(int i, int j) {
  float a ;
  float x = (float(i)-n/2)/100; // x et y vont de -200 à 200 pour n=400;
  float y = (float(j)-n/2)/100;
  //a = (i-width/2)*(i-width/2)+(j-height/2)*(j-height/2);  // x²+y²
  //a = (i-width/2) + (j-height/2);      // x+y
  //a = (i-n/2)*(i-n/2)+(j-n/2)*(j-n/2);   // x²+y² en vrai
  a = pow( (x*x + y*y -18),2) + pow( (x + y*y-11),2) ; //4 min
  //a = pow( (x-1) , 2) + 10*pow((x*x-y*y),2); // cours 
  //a = pow( (x*x+y-20) , 11) + 10*pow((x-y*y-7),2); // cours
  return a ;
}



void updateTrianglePoints(Bloc[][] blocs, Particle smart, char lettre){
  // On prend le bloc le plus proche du point considéré
  // Puis on synchronise les attributs du point avec ceux du bloc
  float minA = lX;
  float minB = lX;
  float minC = lX;
  float temp = 0;
  float newX = smart.a[0];
  float newY = smart.a[1];
  float newVal =0;
    for (int i=0; i<n; i++) {
      for (int j=0; j<n; j++) {  
      
        if (lettre == 'a'){
          
          temp = smart.minDistA( blocs[i][j].m_x, blocs[i][j].m_y );
          if( temp <minA) {
            minA = temp ;
            newX =  blocs[i][j].m_x;
            newY =  blocs[i][j].m_y;
            newVal = blocs[i][j].m_value;        
          }
          
        } else if( lettre == 'b') {
           
            temp = smart.minDistB( blocs[i][j].m_x,blocs[i][j].m_y );
            if(temp <minB) {      
              minB = temp ;
              newX =  blocs[i][j].m_x;
              newY =  blocs[i][j].m_y;
              newVal = blocs[i][j].m_value;
            }
          
        } else if( lettre == 'c') {
             
            temp = smart.minDistC( blocs[i][j].m_x,blocs[i][j].m_y );
            if(temp <minC) {
              minC = temp ;
              newX =  blocs[i][j].m_x;
              newY =  blocs[i][j].m_y;
              newVal = blocs[i][j].m_value;
            }
          }     
      }
    }
    if (lettre == 'a'){
       smart.updateA( newX,newY,newVal );
    } else if( lettre == 'b') {
       smart.updateB( newX,newY,newVal );
    } else if( lettre == 'c') {
       smart.updateC(  newX,newY,newVal);
    }
}

void keyPressed() {
  //if(key=='v') save= !save;
  if (key=='s') saveFrame("nom_####.pnj");
}