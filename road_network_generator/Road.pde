class Road
{
  float[] vertexOffsets;
  
  Road(int seed, int roadLength)
  {
    vertexOffsets = new float[roadLength];
    
    for (int i = 0; i < roadLength; i++)
    {
      float noiseValue = noise(seed + i * smoothness);
      float vertexOffset = (noiseValue * 2 - 1) * roadCurve;
      
      vertexOffsets[i] = vertexOffset;
    }
  }
}
