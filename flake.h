//
//  flake.h
//  flakeysaver
//
//  Created by Noah Paessel on 10/19/06.
//  Copyright 2006 __MyCompanyName__. All rights reserved.
//

#include "Drawable.h"
#import <Cocoa/Cocoa.h>
#import "nrand.h"


@interface Flake : NSObject <Drawable>{
	bool			needGenList;
	int				numPoints;
	int				flakeNumber;
	float			maxRadius;
	float			minRadius;
	float			alpha;
	float			lineWidth;
	
	float			x;
	float			y;
	float			z;
	
	float			vx;
	float			vy;
	float			vz;
	
	float			xrot;
	float			yrot;
	float			zrot;
	
	float			vxrot;
	float			vyrot;
	float			vzrot;
	
//	
//	float			vscale;
//	
//	float			scale;
//	float			angle;
//
//	float			screen_width;
//	float			screen_height;
	
	NSBezierPath*		shapePath;
	NSAffineTransform*	transform;
	NSColor*			fillColor;
	NSColor*			strokeColor;
	NSColor*			blurColor;
}
- (void) initshape;
- (void) draw;
- (void) move:(float)dx dy:(float)dy;
- (void) updateTrans;
- (void) updateVeloc;
- (void) initValues;

@end
