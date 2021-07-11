//
//  ObjCFirst.m
//  ObjCFirst
//
//  Created by Svetlana Fomina on 11.07.2021.
//

#import "ObjCFirst.h"

@implementation ObjCFirst

-(void) testThree {
	NSLog(@"First Obj-C static library");
}

-(void) testAnotherObjCLibrary {
	ObjCSecond* objCSecond = [[ObjCSecond alloc] init];
	[objCSecond testObjCSecondLibrary];
}

@end
