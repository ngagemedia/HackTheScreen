/** //<>//
Simple Example for talking to Ngage API for Blob & Face tracking
It connects via OSC to the server, which then sends a osc data stream
to the client (this). 
 */

Ngage mApi;

void setup() {
  size(800, 400);
  frameRate(25);
  mApi = new Ngage();
}

void draw() {
  background(0);
  fill(255);
  for (int i = 0; i < mApi.blobs.size(); i++) {
    Blob b = mApi.blobs.get(i);

  }
}