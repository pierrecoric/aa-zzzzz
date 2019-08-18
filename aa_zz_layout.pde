import java.util.Date;
String [] aa_zz = new String [676];
String [] alphabet = {"a" , "b" , "c" , "d" , "e" , "f" , "g" , "h" , "i" , "j" , "k" , "l" , "m" , "n" , "o" , "p" , "q" , "r" , "s" , "t" , "u" , "v" , "w" , "x" , "y" , "z"};
int firstLetter = 0;
int secondLetter = 0;
/////swithces
boolean initiation = false;
//////////
PImage currentImg ;
PrintWriter displayedFiles;
int countGoodPictures;
String currentFile;
/////layout variables
int edge = 500;
int x = 0;
int y = 0;
int padding = 60;
float verticalAdjust;
float horizontalAdjust;
float edgeBox = 25;
//alphaIndex is a variable to browse through the 676 combinations of 2 letters
int alphaIndex = 675;
void setup(){
  size(2500,3500);
  displayedFiles = createWriter("displayedFiles.txt");
  background(255);
}
void draw(){
  if (initiation == false){
    aa_zzGeneration();
    initiation = true;
  }
  while (alphaIndex < 676){
  File[] files = listFiles("data/" + aa_zz[alphaIndex]);
  int indexFile = 0;
  countGoodPictures = 0;
  while (countGoodPictures < 35){
    currentFile = (aa_zz[alphaIndex] + "/" + files[indexFile].getName());
    int extension = findExtension(files[indexFile].getName());
    indexFile ++;
  /////if the file is a nice good kind extension
  if (extension < 5){
    println(currentFile + " ok file");
    currentImg = loadImage("data/" + currentFile);
    /////cheking if the picture is readable
    if (isGoodPicture(currentImg) == true){
      switch(checkDimensions(currentImg)){
        case 0: //w = h
          image(currentImg,x + padding,y +padding,edge -2*padding,edge-2*padding);
          progression();
        break;
        case 1: //w > h
          currentImg.resize(edge-2*padding,0);
          verticalAdjust = (edge - currentImg.height)/2;
          image(currentImg,x + padding ,y + verticalAdjust);
          progression();
        break;
        case 2: //h > w
          currentImg.resize(0,edge-2*padding);
          horizontalAdjust = (edge - currentImg.width)/2;
          image(currentImg,x+ horizontalAdjust,y + padding);
          progression();
        break;
      }
      /////save reference picture
      displayedFiles.println(currentFile);
      countGoodPictures ++;
    }
    else{
      println (currentFile + " bad file");
    }
  }
  /////if the file is a png
  else if (extension == 5){
    println(currentFile + " .png file");
    currentImg = loadImage("data/" + currentFile);
    /////cheking if the picture is readable
    if (isGoodPicture(currentImg) == true){
      switch(checkDimensions(currentImg)){
        case 0: //w = h
          if(pngAverageBright(currentImg) > 220){
            noStroke();
            fill(0);
            rect(x + padding,y + padding,edge-2*padding,edge-2*padding);  
          }
          image(currentImg,x + padding,y + padding,edge-2*padding,edge-2*padding);
          progression();
        break;
        case 1: //w > h
          currentImg.resize(edge-2*padding,0);
          verticalAdjust = (edge - currentImg.height)/2;
          if(pngAverageBright(currentImg) > 220){
            noStroke();
            fill(0);
            rect(x + padding,y + verticalAdjust,currentImg.width,currentImg.height);  
          }
          image(currentImg,x + padding,y + verticalAdjust);
          progression();
        break;
        case 2: //h > w
          currentImg.resize(0,edge-2*padding);
          horizontalAdjust = (edge - currentImg.width)/2;
          if(pngAverageBright(currentImg) > 220){
            noStroke();
            fill(0);
            rect(x + horizontalAdjust,y + padding,currentImg.width,currentImg.height);  
          }
          image(currentImg,x+ horizontalAdjust,y + padding);
          progression();
        break;
      }
      /////save reference picture
      displayedFiles.println(currentFile);
      countGoodPictures ++;
    }
    else{
      println (currentFile + " bad file");
    }
  }
  /////if the file is some bullshit extension
  else{
    println (currentFile + " bad file");
  }
 }
  drawBoxes(0,3);
  filter(GRAY);
  save("export_spread/" + aa_zz[alphaIndex] + ".jpg");
  displayedFiles.println("");
  alphaIndex ++;
  background (255,255,255);
  x = 0;
  y = 0;
  }
    displayedFiles.flush();
    displayedFiles.close();
    exit();
}
