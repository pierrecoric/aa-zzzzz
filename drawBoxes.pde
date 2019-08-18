void drawBoxes(int value, int weight){
    x = 0;
    y = 0;
    for (int i = 0; i < 35; i ++){
    noFill();
    stroke (value,value,value);
    strokeWeight(weight);
    rect (x,y,edge,edge);
    //fill(255-value);
    //rect(x + edge - edgeBox,y + edge - edgeBox,edgeBox, edgeBox);
    fill(value);
    textAlign(RIGHT);
    textSize(edgeBox);
    text(i,x + edge - 0.5*edgeBox,y + edge-edgeBox/2);
    x = x + edge;
    if (x >= width){
    x = 0;
    y = y + edge;
    }
    }
}
