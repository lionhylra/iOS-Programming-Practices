//
//  main.m
//  Question1
//
//  Created by HeYilei on 8/10/2015.
//  Copyright © 2015 HeYilei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Solution : NSObject
- (NSInteger)findPairsIn:(NSArray *)numbers difference:(NSInteger)difference;
@end

@implementation Solution

- (NSInteger)findPairsIn:(NSArray *)numbers difference:(NSInteger)difference {
    /* Sort array */
    NSArray *sortedArray = [numbers sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return NSOrderedAscending;
        }
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return NSOrderedDescending;
        }
        return NSOrderedSame;
    }];
    /* Find pairs */
    NSMutableSet *resultSet = [NSMutableSet set];
    for (int i = 0; i < sortedArray.count; ++i) {
        NSInteger rawNum = [sortedArray[i] integerValue];
        for (int j = i+1; j < sortedArray.count; ++j) {
            NSInteger rawNum2 = [sortedArray[j] integerValue];
            if (rawNum + difference == rawNum2) {
                [resultSet addObject:sortedArray[i]];
            }
        }
    }
    /* Print */
    NSLog(@"\nThe array is: %@", numbers);
    NSLog(@"\nThe Difference is: %ld", (long)difference);
    for (NSNumber *num in resultSet) {
        NSLog(@"\nFind a pair: (%ld, %ld)", (long)num.integerValue, (num.integerValue + difference));
    }
    NSLog(@"\nFind %ld pairs.",resultSet.count);
    return resultSet.count;
}

@end

int main(int argc, char * argv[]) {
    @autoreleasepool {
        NSArray *list1 = @[@4,@1,@8,@2,@3,@4,@5,@5,@6,@8];
        Solution *solution = [Solution new];
        [solution findPairsIn:list1 difference:3];
        [solution findPairsIn:list1 difference:0];
        
        return 0;
    }
}