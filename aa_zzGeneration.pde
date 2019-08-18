void aa_zzGeneration(){
  for (int i = 0; i<676; i++){
    aa_zz[i] = (alphabet[secondLetter] + alphabet [firstLetter]);
    firstLetter ++;
    if (firstLetter > 25){
      firstLetter = 0;
      secondLetter ++;
    }
    //print (aa_zz[i]);
  }  
}
