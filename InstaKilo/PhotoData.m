//
//  photoData.m
//  InstaKilo
//
//  Created by Spencer Symington on 2019-01-23.
//  Copyright © 2019 Spencer Symington. All rights reserved.
//

#import "PhotoData.h"

@implementation PhotoData

-(instancetype)initWithPath:(NSString*)path name:(NSString*)name location:(NSString*)location tags:(NSArray<NSString*>*)tags{
    
    self = [super init];
    if (self) {
        _path = path;
        _name = name;
        _location = location;
        _tags = tags;
        
    }
    return self;
    
}


@end
