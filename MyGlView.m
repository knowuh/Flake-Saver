//
//  MyGlView.m
//  GoldenTriangle
//
// Copyright (c)  2010 Noah Paessel
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.
//

#import "MyGlView.h"
#import "Drawable.h"
#import "flake.h"

#include <OpenGL/gl.h>
#include <OpenGL/glu.h>

@implementation MyGlView
//squiggleArray = [[NSMutableArray alloc] init];

- (void)awakeFromNib {
	[self setup];
	
	timer = [NSTimer timerWithTimeInterval:0.001   //a 1ms time interval
									 target:self
								   selector:@selector(update)
								   userInfo:nil
									repeats:YES];
				   
				   [[NSRunLoop currentRunLoop] addTimer:timer 
												forMode:NSDefaultRunLoopMode];
				   [[NSRunLoop currentRunLoop] addTimer:timer 
												forMode:NSEventTrackingRunLoopMode]; //Ensure timer fires during resize
}

- (void) setup{

	drawables = [[NSMutableArray alloc] init];
	//[drawables addObject:[[Triangle alloc] init]];
	int i = 0;
	for (i = 0; i < 1000; i++) {
		[drawables addObject:[[Flake alloc] init]];	
	}
}

- (void) dealloc
{
    [drawables release];
    [super dealloc];
}

		  
- (void) addDrawable: (id <Drawable>) drawable 
{
	[drawables	addObject:drawable];
}

			 
- (void) update {
	[self setNeedsDisplay:YES];
}

- (void) updateObjects {
	for (id <Drawable> drawable in drawables) {
		[drawable tick];
	}
}

- (void) drawObjects {
	for (id <Drawable> drawable in drawables) {
		glPushMatrix();
		[drawable draw];
		glPopMatrix();
	}
	glFlush();
}

-(void) clear {	
	glClearColor(0, 0, 0.3, 1);
    glClear(GL_COLOR_BUFFER_BIT);
}

-(void) drawRect: (NSRect) bounds
{
	[self clear];
	[self doCamera];
	[self updateObjects];
	[self drawObjects];
    glFlush();
}

- (void) doCamera {
	glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    gluPerspective(70.0f, (GLfloat)aspectRatio, 0.2f,300.0f);
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();
	glTranslated(0.0, 0.0, -8.0);
}

// this method is called whenever the window/control is reshaped
// it is also called when the control is first opened
- (void) reshape
{
    NSSize bound = [self frame].size;
	aspectRatio = bound.width / bound.height;
    glViewport(0, 0, bound.width, bound.height);
	[self doCamera];
	[self update];
}


- (void) prepareOpenGL {

    glClearColor(0.0f, 0.0f, 0.0f, 0.0f);
	glShadeModel(GL_SMOOTH);						

	glClearDepth(1.0f);
	glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST);
    glHint(GL_POLYGON_SMOOTH_HINT, GL_NICEST);
	
//	glDepthFunc(GL_LESS);
//	glEnable(GL_DEPTH_TEST);
//	glEnable(GL_ALPHA);
//	glEnable (GL_BLEND);
//	glBlendFunc (GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

}


@end
