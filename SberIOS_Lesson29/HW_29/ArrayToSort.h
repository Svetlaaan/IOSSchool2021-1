//
//  ArrayToSort.h
//  HW_29
//
//  Created by Svetlana Fomina on 06.07.2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ArrayToSortDelegate <NSObject>

- (NSArray *)getArray;

@end


@interface ArrayToSort : NSObject <ArrayToSortDelegate>

- (NSArray *)getArray;

@end

NS_ASSUME_NONNULL_END
