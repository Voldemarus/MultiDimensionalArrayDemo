//
//  DemoClass.m
//  MultoDimensionalArrayDemo
//
//  Created by Водолазкий В.В. on 09.05.2020.
//  Copyright © 2020 Водолазкий В.В. All rights reserved.
//

#import "DemoClass.h"

#define DIM1    3
#define DIM2    4
#define DIM3    2

@interface DemoClass() {
    int src[DIM1][DIM2][DIM3];  // source (initial) array

    int dst[DIM1][DIM2][DIM3];  // destination array
}
@end

@implementation DemoClass

- (instancetype) init
{
    if (self = [super init]) {
        for (int i = 0; i < DIM1; i++) {
            for (int j = 0; j < DIM2; j++) {
                for (int k = 0; k < DIM3; k++) {
                    int value = i*100 + j*10 + k;
                    src[i][j][k] = value;
                }
            }
        }
    }
    return self;
}

int getIntFromArray(int *array, int i, int j, int k) {
    int offset = j*DIM3 + i*DIM2*DIM3;
    return array[offset];
}

void putIntToArray(int *array, int i, int j, int k, int value) {
    int offset = j*DIM3 + i*DIM2*DIM3;
    array[offset] = value;
}

- (void) run
{
    // Step 1. Save array into NSData
    NSInteger s = sizeof(int)*DIM1*DIM2*DIM3;
    NSData *data = [[NSData alloc] initWithBytes:src length:s];
    NSAssert(data, @"NSData should be created");
    //Step2 - Create new array
    int *bytes = (int *)[data bytes];
    memcpy(dst,bytes,s);
    // Step 3. Compare src and dst
    for (int i = 0; i < DIM1; i++) {
        for (int j = 0; j < DIM2; j++) {
            for (int k = 0; k < DIM3; k++) {
                int template = i*100 + j*10 + k;
                int s = src[i][j][k];
                int d = dst[i][j][k];
 //               NSLog(@"i %d j %d k %d -->s = %d  d = %d",i,j,k,s,d);
                NSAssert(s == template, @"Source array should have value from template");
                NSAssert(d == s, @"Destination array should be identical to the source");
            }
        }
    }

}

@end
