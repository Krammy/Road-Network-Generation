// int seed = 400;
//int seed = 689;
int seed = 198;
// int seed = (int)random(1, 1000);
float smoothness = 0.001;
float roadWidth = 30;
float roadCurve = 500;

color roadColour = color(35, 26, 27);
color bgColour = color(135, 125, 113);

PGraphics roadNetwork, bgNoise;

void setup() {
  print(seed);
  noiseSeed(seed);
  size(1024, 1024);
  background(bgColour);
  
  strokeJoin(ROUND);
  surface.setLocation(0,0);
  //surface.setResizable(true);
  roadNetwork = createNoise(roadColour, 0.2, 0.01);
  PGraphics roadMask = createRoads(color(255));
  
  roadNetwork.mask(roadMask);
  
  bgNoise = createNoise(bgColour, 0.2, 0.01);
  
}

void draw() {
  scale(512f/width, 512f/height);
  
  image(bgNoise, 0, 0);
  image(roadNetwork, 0, 0);
  
  //image(roads, 0, 0);
  noLoop();
}

PGraphics createRoads(color col) {
  PGraphics roadImage = createGraphics(width, height);
  
  roadImage.beginDraw();
  
  roadImage.stroke(col);
  roadImage.strokeWeight(roadWidth);
  
  drawLineUp(roadImage, (float)1/3);
  drawLineUp(roadImage, (float)2/3);
  
  drawLineRight(roadImage, (float)1/3);
  drawLineRight(roadImage, (float)2/3);
  
  roadImage.endDraw();
  
  return roadImage;
}

PGraphics createNoise(color col, float weight, float scale) {
  PGraphics noiseImage = createGraphics(width, height);
  noiseImage.beginDraw();
  for (int x = 0; x < noiseImage.width; x++) {
    for (int y = 0; y < noiseImage.height; y++) {
      float noiseValue = noise(x * scale, y * scale);
      noiseImage.set(x, y, col + color(noiseValue*255*weight));
    }
  }
  noiseImage.endDraw();
  
  return noiseImage;
}



void drawLineUp(PGraphics graphic, float xPos) {
  graphic.beginShape(LINES);
  for (int y = 0; y < graphic.height; y++) {
    float noiseValue = noise((xPos * 10000) + y * smoothness);
    float vertexOffsetX = (noiseValue * 2 - 1) * roadCurve;
    
    graphic.vertex(graphic.width*xPos + vertexOffsetX, y);
  }
  graphic.endShape();
}

void drawLineRight(PGraphics graphic, float yPos) {
  graphic.beginShape(LINES);
  for (int x = 0; x < graphic.width; x++) {
    float noiseValue = noise((yPos * 20000) + x * smoothness);
    float vertexOffsetY = (noiseValue * 2 - 1) * roadCurve;
    
    graphic.vertex(x, graphic.height*yPos + vertexOffsetY);
  }
  graphic.endShape();
}
