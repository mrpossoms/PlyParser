//
//  PlyMesh.h
//  PlyParser
//
//  Created by Kirk Roerig on 3/18/15.
//  Copyright (c) 2015 Possom Games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

@interface PlyVertex : NSObject

@property GLKVector3 position;
@property GLKVector3 normal;
@property GLKVector2 textureCoordinate;
@property GLKVector3 color;

@end

@interface PlyEdge : NSObject

@property PlyVertex *v1, *v2;

@end

@interface PlyMesh : NSObject

@property (readonly) NSArray* vertices;
@property (readonly) NSArray* edges;
@property (readonly) NSArray* faces;

- (instancetype)initWithFilePath:(NSString*)path;

@end
