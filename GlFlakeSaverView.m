//
//  GlFlakeSaverView.m
//  GlFlakeSaver
//
//  Created by Noah Paessel on 12/22/10.
//  Copyright (c) 2010, Concord Consortium. All rights reserved.
//

#import "GlFlakeSaverView.h"


@implementation GlFlakeSaverView

- (id)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
	self = [super initWithFrame:frame isPreview:isPreview];
	
	if (self) 
	{   
		NSOpenGLPixelFormatAttribute attributes[] = { 
			NSOpenGLPFAAccelerated,
			NSOpenGLPFADepthSize, 16,
			NSOpenGLPFAMinimumPolicy,
			NSOpenGLPFAClosestPolicy,
			0 };  
		NSOpenGLPixelFormat *format;
		
		format = [[[NSOpenGLPixelFormat alloc] 
				   initWithAttributes:attributes] autorelease];
		glView = [[MyGlView alloc] initWithFrame:NSZeroRect 
										 pixelFormat:format];
		
		if (!glView)
		{             
			NSLog( @"Couldn't initialize OpenGL view." );
			[self autorelease];
			return nil;
		} 
		
		[self addSubview:glView]; 
		[glView setup]; 
		[[glView openGLContext] makeCurrentContext];
		[glView prepareOpenGL];
		[self setAnimationTimeInterval:1/60.0];
	}
	return self;
}

- (void)startAnimation
{
    [super startAnimation];
}

- (void)stopAnimation
{
    [super stopAnimation];
}

- (void)drawRect:(NSRect)rect
{
    [super drawRect:rect];
	[[glView openGLContext] makeCurrentContext];
//	[glView update];
}

- (void)animateOneFrame
{
	[self setNeedsDisplay:YES];
    return;
}

- (BOOL)hasConfigureSheet
{
    return NO;
}

- (NSWindow*)configureSheet
{
    return nil;
}

- (void)dealloc
{
	[glView removeFromSuperview];
	[glView release];
	[super dealloc];
}

- (void)setFrameSize:(NSSize)newSize
{
	[super setFrameSize:newSize];
	[glView setFrameSize:newSize]; 
	
	[[glView openGLContext] makeCurrentContext];
	[[glView openGLContext] update];
}
@end
