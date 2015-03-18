//
//  NSMutableArray+NSMutableArray_StackBehavior.m
//  PlyParser
//
//  Created by Kirk Roerig on 3/18/15.
//  Copyright (c) 2015 Possom Games. All rights reserved.
//

#import "PlyCategories.h"

@implementation NSMutableArray (NSMutableArray_StackBehavior)

- (id)removeFirstObject
{
    id obj = self.firstObject;
    [self removeObjectAtIndex:0];
    
    return obj;
}

@end

@implementation NSString (NSString_ParseHelpers)

- (BOOL)beginsWith:(NSString*)substring
{
    NSString* pattern = [NSString stringWithFormat:@"%@.*", substring];
    NSPredicate* pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    
    return [pred evaluateWithObject:self];
}

@end