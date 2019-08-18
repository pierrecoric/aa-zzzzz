import java.util.Date;
import gifAnimation.*;


String [] aa_zz = new String [676];
String [] alphabet = {"a" , "b" , "c" , "d" , "e" , "f" , "g" , "h" , "i" , "j" , "k" , "l" , "m" , "n" , "o" , "p" , "q" , "r" , "s" , "t" , "u" , "v" , "w" , "x" , "y" , "z"};
int firstLetter = 0;
int secondLetter = 0;

boolean initiation = false;

PImage currentImg;
int countGoodPictures;
String currentFile;

int edge = 150;
int x = 0;
int y = 0;
int padding = 35;
float verticalAdjust;
float horizontalAdjust;

int alphaIndex = 0;

GifMaker gifExport;
int frames = 0;
int totalFrames = 25;


void setup(){
  size(150,150);
  background(255);
}

void draw(){
  if (initiation == false){
    aa_zzGeneration();
  }
  initiation = true;
  
  if(alphaIndex < 676){
    File[] files = listFiles("data/" + aa_zz[alphaIndex]);
    int indexFile = 0;
    countGoodPictures = 0;
    gifExport = new GifMaker(this, "save/"  + aa_zz[alphaIndex] + ".gif", 100);
    gifExport.setRepeat(0); // make it an "endless" animation
    while (countGoodPictures < 25){
     currentFile = (aa_zz[alphaIndex] + "/" + files[indexFile].getName());
    int extension = findExtension(files[indexFile].getName());
    indexFile ++;  
    /////
    if (extension < 5){
      println (currentFile + "good file");
      currentImg = loadImage("data/" + currentFile);
      if (isGoodPicture(currentImg) == true){
        switch(checkDimensions(currentImg)){
          case 0: //w = h
            background(255);
            image(currentImg,x + padding,y +padding,edge -2*padding,edge-2*padding); 
            addToGif();
          break;
          
          case 1: // w > h
            background(255);
            currentImg.resize(edge-2*padding,0);
            verticalAdjust = (edge - currentImg.height)/2;
            image(currentImg,x + padding ,y + verticalAdjust);
            addToGif();
          break;
          
          case 2: // h > w
            background(255);
            currentImg.resize(0,edge-2*padding);
            horizontalAdjust = (edge - currentImg.width)/2;
            image(currentImg,x+ horizontalAdjust,y + padding);
            addToGif();
          break;
        }
        countGoodPictures ++;
      }
    }
    
    else if (extension == 5){
      println (currentFile + "good file");
      currentImg = loadImage("data/" + currentFile);
      if (isGoodPicture(currentImg) == true){
        switch(checkDimensions(currentImg)){
          case 0: //w = h
            background(255);
            if(pngAverageBright(currentImg) > 220){
            noStroke();
            fill(0);
            rect(x + padding,y + padding,edge-2*padding,edge-2*padding);  
            }
          image(currentImg,x + padding,y + padding,edge-2*padding,edge-2*padding);
          addToGif();
          break;
          
          case 1: // w > h
            background(255);
            currentImg.resize(edge-2*padding,0);
            verticalAdjust = (edge - currentImg.height)/2;
            if(pngAverageBright(currentImg) > 220){
            noStroke();
            fill(0);
            rect(x + padding,y + verticalAdjust,currentImg.width,currentImg.height);  
            }
            image(currentImg,x + padding,y + verticalAdjust);
            addToGif();
          break;
          
          case 2: // h > w
            background(255);
            currentImg.resize(0,edge-2*padding);
            horizontalAdjust = (edge - currentImg.width)/2;
            if(pngAverageBright(currentImg) > 220){
            noStroke();
            fill(0);
            rect(x + horizontalAdjust,y + padding,currentImg.width,currentImg.height);  
            }
            image(currentImg,x+ horizontalAdjust,y + padding);
            addToGif();
          break;
        }
        countGoodPictures ++;
      }
    }
    
    else{
      println("caca file");
    }
    
    }
    
    background (255);
    alphaIndex ++;
    gifExport.finish();
  }
  
  else{
      exit();

  }
  
}
