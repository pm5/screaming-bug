// Please check http://ubaa.net/shared/processing/opencv/ for OPENCV 4 Processing installation instructions
// - Ca3rine
import hypermedia.video.*;
import java.awt.Rectangle;
import java.awt.Point;

OpenCV opencv;

// contrast/brightness values
int contrast_value    = 0;
int brightness_value  = 0;

int threshold = 80;

boolean debug = true;


void setup() {

    size( 320, 240 );

    opencv = new OpenCV( this );
    opencv.capture( width, height );                   // open video stream



}


public void stop() {
    opencv.stop();
    super.stop();
}



void draw() {
  println(blobDetection());
}

//built based on blobs example of OpenCV


boolean blobDetection(){
  
  opencv.read();
  opencv.absDiff();
  opencv.threshold(threshold);
  
  // working with blobs
  Blob[] blobs = opencv.blobs( 100, width*height/3, 20, true );
  
  if(debug){
    image( opencv.image(), 0, 0 );
    for( int i=0; i<blobs.length; i++ ) {
  
      Rectangle bounding_rect  = blobs[i].rectangle;
      float area = blobs[i].area;
      float circumference = blobs[i].length;
      Point centroid = blobs[i].centroid;
      Point[] points = blobs[i].points;
  
      // rectangle
      noFill();
      stroke( blobs[i].isHole ? 128 : 64 );
      rect( bounding_rect.x, bounding_rect.y, bounding_rect.width, bounding_rect.height );
  
  
      // centroid
      stroke(0,0,255);
      line( centroid.x-5, centroid.y, centroid.x+5, centroid.y );
      line( centroid.x, centroid.y-5, centroid.x, centroid.y+5 );
      noStroke();
      fill(0,0,255);
      text( area,centroid.x+5, centroid.y+5 );
  
  
      fill(255,0,255,64);
      stroke(255,0,255);
      if ( points.length>0 ) {
          beginShape();
          for( int j=0; j<points.length; j++ ) {
              vertex( points[j].x, points[j].y );
          }
          endShape(CLOSE);
      }
  
      noStroke();
      fill(255,0,255);
      text( circumference, centroid.x+5, centroid.y+15 );
  
    }
  }
  
  return (blobs.length>0)?true:false;
}

void keyPressed() {
    if ( key==' ' ) opencv.remember();
}


