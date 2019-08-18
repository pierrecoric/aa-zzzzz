String extension4 = ("");
String extension5 = ("");

int findExtension (String fileName){
  extension4 = fileName.substring(fileName.length() - 4, fileName.length());
  extension5 = fileName.substring(fileName.length() - 5, fileName.length());
  if (extension4.equals(".jpg") == true){
    return 1;
  }
  else if(extension5.equals(".jpeg") == true){
    return 2;
  }
  else if(extension4.equals(".JPEG") == true){
    return 3;
  }
  else if(extension4.equals(".gif") == true){
    return 4;
  }
  else if(extension4.equals(".png") == true){
    return 5;
  }
  else{
    return 6;
  }
}
