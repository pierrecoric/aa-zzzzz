int checkDimensions (PImage currentImg){
  if(currentImg.width == currentImg.height){
    return (0);
  }
  else if(currentImg.width > currentImg.height){
    return(1);
  }
  else{
    return (2);
  }
}
