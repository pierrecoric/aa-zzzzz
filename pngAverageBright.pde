float pngAverageBright (PImage png){
  png.loadPixels();
  float countSolid = 0;
  float totalBright = 0;
  for(int i = 0; i<(png.width * png.height); i ++){
    float alphaPng = alpha(png.pixels[i]);
    if (alphaPng > 0){
      totalBright += brightness(png.pixels[i]);
      countSolid ++;
    }
  }
  float averageBright = (totalBright/countSolid);
  return (averageBright);
}
