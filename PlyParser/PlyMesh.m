//
//  PlyMesh.m
//  PlyParser
//
//  Created by Kirk Roerig on 3/18/15.
//  Copyright (c) 2015 Possom Games. All rights reserved.
//

#import "PlyMesh.h"
#import "PlyCategories.h"

@interface PlyMesh()

@property (readwrite) NSMutableArray* vertices;
@property (readwrite) NSMutableArray* edges;
@property (readwrite) NSMutableArray* faces;

@property NSInteger vertexCount, edgeCount, faceCount;
@property NSInteger vertexPropCount, edgePropCount, facePropCount;


@end

@implementation PlyMesh

- (instancetype)initWithFilePath:(NSString *)path
{
    self = [super init];
    if(!self) return self;

    NSError* error;
    NSString *text = [[NSString alloc] initWithContentsOfFile:path
                                                     encoding:NSUTF8StringEncoding
                                                        error:&error
                      ];
    
    NSMutableArray* lines = [[text componentsSeparatedByString:@"\n"] mutableCopy];
    
    [self readHeaderFromLines:lines];
    
    
    return self;
}

- (NSUInteger)readPropertiesFromLines:(NSMutableArray*)lines
{
    NSUInteger propCount = 0;
    while([((NSString*)lines.firstObject) beginsWith:@"property"]){
        [lines removeFirstObject];
        ++propCount;
    }
    
    return propCount;
}

- (void)readElementsFromLines:(NSMutableArray*)lines
{
    while([((NSString*)lines.firstObject) beginsWith:@"element"]){
        NSString* line = [lines removeFirstObject];
        NSScanner* scanner = [[NSScanner alloc] initWithString:line];
        
        // strip the element word
        [scanner scanString:@"element " intoString:nil];
        
        if([line containsString:@"vertex"]){
            [scanner scanString:@"vertex " intoString:nil];
            [scanner scanInteger:&_vertexCount];
            _vertexPropCount = [self readPropertiesFromLines:lines];
        }
        else if([line containsString:@"edge"]){
            [scanner scanString:@"edge " intoString:nil];
            [scanner scanInteger:&_edgeCount];
            _edgePropCount = [self readPropertiesFromLines:lines];
        }
        else if([line containsString:@"face"]){
            [scanner scanString:@"face " intoString:nil];
            [scanner scanInteger:&_faceCount];
            _faceCount = [self readPropertiesFromLines:lines];
        }
        
    }
}

- (BOOL)readHeaderFromLines:(NSMutableArray*)lines
{
    // consume basic header fluff
    if(![[lines removeFirstObject] beginsWith:@"ply"]) return NO;
    if(![[lines removeFirstObject] beginsWith:@"format"]) return NO;
    
    // eat the comments
    while([((NSString*)lines.firstObject) beginsWith:@"comment"]){
        [lines removeFirstObject];
    }
    
    // read all the elements and their properties
    [self readElementsFromLines:lines];
    
    if([[lines removeFirstObject] beginsWith:@"end_header"]){
        return YES;
    }
    
    return NO;
}

@end
