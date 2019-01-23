//
//  photoData.h
//  InstaKilo
//
//  Created by Spencer Symington on 2019-01-23.
//  Copyright © 2019 Spencer Symington. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhotoData : NSObject

@property (nonatomic,strong)NSString* path;
@property (nonatomic,strong)NSString* name;
@property (nonatomic,strong)NSString* location;
@property (nonatomic,strong)NSArray<NSString*> *tags;

-(instancetype)initWithPath:(NSString*)path name:(NSString*)name location:(NSString*)location tags:(NSArray<NSString*>*)tags;
@end

NS_ASSUME_NONNULL_END
