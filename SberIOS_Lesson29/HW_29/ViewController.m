//
//  ViewController.m
//  HW_29
//
//  Created by Svetlana Fomina on 01.07.2021.
//

#import "ViewController.h"
#import "ArrayToSort.h"

@interface ViewController () 

@property (strong, nonatomic) id<ArrayToSortDelegate> delegate;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	self.delegate = [[ArrayToSort alloc] init];
	NSArray *arrayToSort = [self.delegate getArray];
	[self sortByNumberOfCharacters:arrayToSort];
}

- (void)sortByNumberOfCharacters:(NSArray *)array {
	NSString *myLetter = @"s";

	NSArray *sortedArray = [array sortedArrayUsingComparator: ^NSComparisonResult(id string1, id string2) {
		NSUInteger countMyLetter1 = [[string1 componentsSeparatedByString:myLetter] count];
		NSUInteger countMyLetter2 = [[string2 componentsSeparatedByString:myLetter] count];

		if (countMyLetter1 < countMyLetter2) {
			return NSOrderedDescending;
		} else if (countMyLetter1 > countMyLetter2) {
			return NSOrderedAscending;
		} else {
			return NSOrderedSame;
		}
	}];

	NSLog(@"%@", sortedArray);
}


@end
