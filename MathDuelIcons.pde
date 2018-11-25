PGraphics g; //invisible layer of canvas where all the drawing would happen, initially is transparent
PImage temp; //temporary used in the end
size(400, 400); 
g = createGraphics(width, height); 
color cBlue = color(40, 37, 124); 
colorMode(HSB); //hue, saturation, brightness
g.beginDraw(); //required to start drawing on g
g.noStroke(); 
g.rect(0, 0, width, height, 80); // rectangle with rounded corners
g.loadPixels(); //loads pixel color values into memory as pixels[] array
//the loop makes a gradient
//for every pixel..
for (int i = 0; i < width*height; i++) { 
  //if pixel isn't black or too transparent
  if ((g.pixels[i]!=color(0))&&(alpha(g.pixels[i]) > 50)) 
    //change brightness
    g.pixels[i] = color(hue(g.pixels[i]), saturation(g.pixels[i]), brightness(g.pixels[i])-0.1*i/width);
}; 
g.updatePixels();//update pixels
  //scales 2.5 times (changes coodinate system)
  g.pushMatrix(); 
  g.translate(width/2, height/2); 
  g.scale(2.5); 
    //what is scaled
    g.stroke(cBlue); 
    g.strokeWeight(2); 
    g.noFill(); 
    g.line(width/3-width/2, height/2-height/2, width/2-width/20-width/2, height/2-height/2); 
    g.line(width/2 + width/20 - width/2, height/2-height/2, 2*width/3-width/2, height/2-height/2); 
    g.ellipse(width/2-width/2, height/2-height/2, width/10, width/10); 
    g.stroke(cBlue); 
    g.strokeWeight(1); 
    g.ellipse(width/2-width/2, height/2-height/2, (width/30), (width/30)); 
  g.popMatrix(); //coordinate system reset to normal
g.endDraw(); 
image(g, 0, 0); //draws g on canvas
temp = g.get(); // temp becomes copy of g (otherwise .resize() would ruin image quality)
temp.resize(36, 36); 
temp.save("D://Documents/icon-36.png"); // saves the icon
temp = g.get(); 
temp.resize(48, 48); 
temp.save("D://Documents/icon-48.png"); 
temp = g.get(); 
temp.resize(72, 72); 
temp.save("D://Documents/icon-72.png"); 
temp = g.get(); 
temp.resize(96, 96); 
temp.save("D://Documents/icon-96.png"); 
temp = g.get(); 
temp.resize(144, 144); 
temp.save("D://Documents/icon-144.png"); 
temp = g.get(); 
temp.resize(192, 192); 
temp.save("D://Documents/icon-192.png");
