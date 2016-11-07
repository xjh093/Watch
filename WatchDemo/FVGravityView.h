//
//  FVGravityView.h
//  FVGravityView
//
//  Created by Fernando Valente on 3/21/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FVGravityView : UIView <UIAccelerometerDelegate> {
	float velocity;
	BOOL isDragable;
	BOOL isDragging;
	BOOL isInverse;
}

-(void)update;

@property (readwrite) BOOL isInverse;
@property (readwrite) float velocity;
@property (readwrite) BOOL isDragable;

@end
