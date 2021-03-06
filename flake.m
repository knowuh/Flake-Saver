//
//  flake.m
//  flakeysaver
//
// Copyright (c)  2010 Noah Paessel
//
// The MIT License
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "flake.h"
#import "nrand.h"
@implementation Flake


/*
 *
 */
+ (void) initialize {
	seed(); // seed rnd number
}

/*
*
*/
- (id)init {
	self = [super init];
	if (self) {
		[self initValues];

	}
	return self;
}


/*
*
*/
- (void) initValues {
	needGenList = YES;
	
	x = float_between(-300, 300);
	y = float_between(-300, 300);
	z = float_between(-360, 0);
	
	xrot = float_between(0, 90);
	yrot = float_between(0, 90);
	zrot = float_between(0, 90);
	
	vxrot= float_between(-2.0, 2.0);
	vyrot= float_between(-2.0, 2.0);
	vzrot= float_between(-2.0, 2.0);
	numPoints = (int) float_between(4.0f, 10.0f);
	float max_hole_percent = float_between(1.0f,20.0f);

	maxRadius = float_between(0.01f, 0.8f);
	minRadius = maxRadius * (max_hole_percent/100.0f);
	// minRadius = minRadius < 0 ? 0 : minRadius;
	

	vx = float_between(-0.5,0.5);
	vy = float_between(-0.5,0.5);
	vz = float_between(0.2,1);	
	
}

/*	
 *	
 */
- (void) initshape {

	int symetry = 6;
	int j;
	flakeNumber = glGenLists(1);
	glNewList (flakeNumber, GL_COMPILE);

	glMatrixMode(GL_MODELVIEW_MATRIX);
	glPushMatrix();
	int k = 0;
	float max_width = 0.8f;
	float max_height = 1.0f;
	float width = 0;
	float height = 0;

	int num_segments = float_between(4,10);
	float *widths;
	widths = malloc(sizeof(float) * num_segments);
	float *heights;
	heights = malloc(sizeof(float) * num_segments);
	for (j=0; j < num_segments; j++) {
		width = float_between(0.01f, max_width);
		widths[j] = width;
		height += float_between(0.01f, max_height);
		heights[j] = height;
	}

	for (j = 0; j < symetry; j++) {
		glBegin(GL_QUAD_STRIP);
		for (k = 0; k < num_segments; k++) {
			width   =  widths[k];
			glVertex3f(-width, heights[k], 0); // left		
			glVertex3f( width, heights[k], 0); // right	
		}
		glEnd();
		glRotatef(360.0f/symetry, 0.0f, 0.0, 1.0f);
	}

	glPopMatrix();
	glEndList();
	needGenList = NO;
}


/*
 *
 */
- (void) draw {
	if (needGenList == YES) {
		glCallList(flakeNumber);
		[self initshape];
	}
	glMatrixMode(GL_MODELVIEW_MATRIX);
	glTranslated(x, y, z);
	glRotatef(xrot, 1.0, 0.0, 0.0);
	glRotatef(yrot, 0.0, 1.0, 0.0);
	glRotatef(zrot, 0.0, 0.0, 1.0);
	
	glColor4f(0.9f, 0.9f, 1.0f, 0.8f);
	glCallList(flakeNumber);
}



- (void) updateVeloc {
	[self move:vx dy:vy];
}

- (void) updateTrans {
// ?	
}

/*
*
*/			\
- (void) move:(float)dx dy:(float)dy {
	x += dx;
	y += dy;

}

- (void) tick {
	zrot += vzrot;
	xrot += vxrot;
	yrot += vyrot;
	z = z > 0.1 ? -360 : z;
	z += vz;
	x = x > 300 ? -300 : x;
	x = x < -300 ? 300 : x;	
	x += vx;	
	y = y > 300 ? -300 : y;
	y = y < -300 ? 300 : y;
	y += vy;

}

@end
