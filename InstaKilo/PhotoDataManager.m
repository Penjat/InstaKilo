//
//  PhotoDataManager.m
//  InstaKilo
//
//  Created by Spencer Symington on 2019-01-23.
//  Copyright © 2019 Spencer Symington. All rights reserved.
//

#import "PhotoDataManager.h"

@interface PhotoDataManager ()
@property (nonatomic)enum SORT_TYPE sortType;
@end

@implementation PhotoDataManager
- (instancetype)init{
    self = [super init];
    if (self) {
        
        
        //TODO add tags
        PhotoData *photo1 = [[PhotoData alloc]initWithPath:@"bb" name:@"Buckethead" location:@"Buckethead Land" tags:@[]];
        PhotoData *photo2 = [[PhotoData alloc]initWithPath:@"bucket" name:@"Buckethead on stage" location:@"Buckethead Land" tags:@[]];
        PhotoData *photo3 = [[PhotoData alloc]initWithPath:@"ElSwordo" name:@"El Swordo" location:@"TV" tags:@[]];
        PhotoData *photo4 = [[PhotoData alloc]initWithPath:@"freakazoid" name:@"Buckethead" location:@"TV" tags:@[]];
        
        _allPhotos = [[NSMutableArray alloc]initWithArray:@[photo1,photo2,photo3,photo4]];
        [self changeSortType:TAGS];
    }
    return self;
}
-(PhotoData*)getDataForIndex:(NSIndexPath *)indexPath{
    
    //basic, just return the photoData from the array
    long row = indexPath.row;
    return self.allPhotos[row  ];
}
-(void)changeSortType:(enum SORT_TYPE)sortType{
    self.sortType = sortType;
    
    if(sortType == ALL){
        self.sectionArray = @[@"All Photos"];
    }else if(sortType == LOCATION){
        self.sectionArray = [self findAllLocations];
    }else if(sortType == TAGS){
        self.sectionArray = [self findAllTags];
        
    }
}
-(NSArray<NSString*> *)findAllTags{
    NSMutableArray *tagArray = [[NSMutableArray alloc]init];
    
    BOOL itemsWithNoTag = NO;//keeps track if we need to create a no tag section
    //cycle through the photos
    for(PhotoData *photoData in self.allPhotos){
        //check all the photo's tags
        for(NSString *tag in photoData.tags){
            //see if we need to add
            if( [tagArray containsObject:tag] == NO){
                [tagArray addObject:tag];
            }
            
        }
        if(!itemsWithNoTag && photoData.tags.count ==0){
            itemsWithNoTag = YES;
        }
        
        
    }
    //if we found items with no tag
    if(itemsWithNoTag){
        [tagArray addObject:@"no tag"];
    }
    
    return [tagArray copy];
    
}
-(NSArray<NSString*> *)findAllLocations{
    NSMutableArray *locationArray = [[NSMutableArray alloc]init];
    for(PhotoData *photoData in self.allPhotos){
        if( [locationArray containsObject:photoData.location] == NO){
            [locationArray addObject:photoData.location];
        }
    }
    return [locationArray copy];
}

-(NSString*)getHeaderTitleForSection:(NSInteger)section{
    return self.sectionArray[section];
}
-(NSInteger)getNumberOfSections{
    
    return self.sectionArray.count;
}
@end
