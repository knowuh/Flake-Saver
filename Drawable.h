//
//  Drawable.h
//  GoldenTriangle
//
//  Created by Noah Paessel on 12/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@protocol Drawable
	- (void) draw;
	- (void) tick;
@end
