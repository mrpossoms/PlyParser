//
//  NSMutableArray+NSMutableArray_StackBehavior.h
//  PlyParser
//
//  Created by Kirk Roerig on 3/18/15.
//  Copyright (c) 2015 Possom Games. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (NSMutableArray_StackBehavior)

- (id)removeFirstObject;

@end

@interface NSString (NSString_ParseHelpers)

- (BOOL)beginsWith:(NSString*)substring;

@end