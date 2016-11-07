//
//  FVGravityView.m
//  FVGravityView
//
//  Created by Fernando Valente on 3/21/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "FVGravityView.h"


@implementation FVGravityView
@synthesize velocity, isDragable, isInverse;

-(id)initWithFrame:(CGRect)f{
	if(self = [super initWithFrame:f]){
		[[UIAccelerometer sharedAccelerometer] setDelegate:self];
		velocity = 20;
		isDragable = NO;
		isDragging = NO;
	}
	return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	if(!isDragable)
		return;
	isDragging = YES;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if(!isDragable)
		return;
	
	UITouch *touch = [touches anyObject];
    CGPoint currentTouch = [touch locationInView:[self superview]];
	[self setFrame:CGRectMake(currentTouch.x, currentTouch.y, self.frame.size.width, self.frame.size.height)];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent*)event{
    if(!isDragable)
		return;
	isDragging = NO;
}

-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
	if(isDragging)
		return;
	CGSize size = [self superview].frame.size;
	CGRect f = [self frame];
	
	
	if(isInverse){
		f.origin.x += (acceleration.x * velocity) * -1;
		f.origin.y += (acceleration.y * velocity) * 1;
	}
	else{
		f.origin.x += (acceleration.x * velocity) * 1;
		f.origin.y += (acceleration.y * velocity) * -1;
	}
	
	if(f.origin.x < 0)
		f.origin.x = 0;
	if(f.origin.y < 0)
		f.origin.y = 0;
	
	if(f.origin.x > (size.width - f.size.width))
		f.origin.x = (size.width - f.size.width);
	if(f.origin.y > (size.height - f.size.height))
		f.origin.y = (size.height - f.size.height);
	
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.1];
	[self setFrame:f];
	[UIView commitAnimations];
}

@end
