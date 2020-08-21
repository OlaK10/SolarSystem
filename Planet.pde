class Planet {
  
  PVector pos;
  float radius;
  float angle;
  float distance;
  Planet[] planets;
  float orbitSpeed;
  PVector v;
  
  PShape globe;
  
  Planet(float r, float d, float o, PImage img) {
    v = PVector.random3D();
    radius = r;
    distance = d;
    v.mult(distance);
    angle = random(0, TWO_PI);
    orbitSpeed = o;
    
    noStroke();
    noFill();
    globe = createShape(SPHERE, radius);
    globe.setTexture(img);
  }
  
  
  void orbit() {
  
    angle += orbitSpeed; // angle will keep changing every second to simulate circular motion
    
    if (planets != null) {
      for (int i = 0; i < planets.length; i++) {
        planets[i].orbit();
      }
    }
  }
  
  void spawnMoons(int total, int level) {
    
    planets = new Planet[total];
    
    for (int i = 0; i < planets.length; i++) {
      
      float r = random(radius/(level*3), radius/(level*2)); // r refers to the small planet's radius
      float d = radius + r + random(0, 100);
      float o = random(-0.05, 0.05);
      PImage texture = textures[4];
      
      if (level == 1) {
        switch (i) {
        case 0: 
          texture = textures[0];
          break;
         case 1:
           texture = textures[1];
           break;
         case 2:
           texture = textures[2];
           break;
         case 3:
           texture = textures[3];
           break;
          default:
          texture = sunTexture;
          break;
        }
      }
      
      planets[i] = new Planet(r, d / level, o, texture);
      
      if (level < 2) {
        // stuff is all over the place xD 
        int numberOfMoons = int(random(0, 3));
        planets[i].spawnMoons(numberOfMoons, level+1); // kind of a tree date structure :) This would never end
      }
    
    }
  
  }
  
  void show() {
    
   pushMatrix();
   noStroke();
   
   PVector v2 = new PVector(1, 0, 1);
   PVector p = v.cross(v2);
   rotate(angle, p.x, p.y, p.z);
   stroke(255);
   
   
   
   // line(0, 0, 0, v.x*10, v.y*10, v.z*10);
   // line(0, 0, 0, p.x*10, p.y*10, p.z*10);
   
   translate(v.x, v.y, v.z);
   noStroke();
   fill(255);
   
   //sphere(radius);
   shape(globe);
   // ellipse(0, 0, radius*2, radius*2);
   
   if (planets != null) {
     for (int i = 0; i < planets.length; i++) {
     planets[i].show();
     }
   }
   
   popMatrix();
  }
  

}
