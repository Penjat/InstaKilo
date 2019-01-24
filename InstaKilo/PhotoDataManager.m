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
@property (strong,nonatomic)NSArray<NSArray<PhotoData*> *> *masterArray;
@end

@implementation PhotoDataManager
- (instancetype)init{
    self = [super init];
    if (self) {
        
        
        //TODO add tags
        PhotoData *photo1 = [[PhotoData alloc]initWithPath:@"bb" name:@"Buckethead" location:@"Buckethead Land" tags:@[@"buckethead",@"guitar"]];
        PhotoData *photo2 = [[PhotoData alloc]initWithPath:@"bucket" name:@"Buckethead on stage" location:@"Buckethead Land" tags:@[@"guitar",@"buckethead"]];
        PhotoData *photo3 = [[PhotoData alloc]initWithPath:@"ElSwordo" name:@"El Swordo" location:@"TV" tags:@[@"street sharks",@"kids tv"]];
        PhotoData *photo4 = [[PhotoData alloc]initWithPath:@"freakazoid" name:@"Buckethead" location:@"TV" tags:@[@"kids tv",@"comedy"]];
        PhotoData *photo5 = [[PhotoData alloc]initWithPath:@"orangutan" name:@"orangutan" location:@"Jungle" tags:@[@"animal"]];
        PhotoData *photo6 = [[PhotoData alloc]initWithPath:@"powerrangers" name:@"powerrangers" location:@"TV" tags:@[@"kids tv" ,@"action"]];
        PhotoData *photo7 = [[PhotoData alloc]initWithPath:@"reboot" name:@"reboot" location:@"TV" tags:@[@"kids tv" ,@"computers"]];
        PhotoData *photo8 = [[PhotoData alloc]initWithPath:@"buckethead" name:@"Power rangers" location:@"Buckethead Land" tags:@[@"buckethead",@"guitar"]];
        PhotoData *photo9 = [[PhotoData alloc]initWithPath:@"spongebob" name:@"spongebob" location:@"TV" tags:@[@"kids tv",@"comedy"]];
        
        _allPhotos = [[NSMutableArray alloc]initWithArray:@[photo1,photo2,photo3,photo4,photo5,photo6,photo7,photo8,photo9]];
        [self changeSortType:ALL];
    }
    return self;
}
-(PhotoData*)getDataForIndex:(NSIndexPath *)indexPath{
    
    if(self.sortType == ALL){
        long row = indexPath.row;
        return self.allPhotos[row  ];
    }
    return self.masterArray[indexPath.section][indexPath.row];
    
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
    
    NSMutableArray *masterArray = [[NSMutableArray alloc]init];
    NSMutableArray *tagArray = [[NSMutableArray alloc]init];
    
    BOOL itemsWithNoTag = NO;//keeps track if we need to create a no tag section
    //cycle through the photos
    for(PhotoData *photoData in self.allPhotos){
        //check all the photo's tags
        for(NSString *tag in photoData.tags){
            //see if we need to add
            NSUInteger index = [tagArray indexOfObject:tag];
            if( index == NSNotFound){
                [tagArray addObject:tag];
                NSMutableArray *newSectionArray = [[NSMutableArray alloc]init];
                [newSectionArray addObject:photoData];
                [masterArray addObject:newSectionArray];
            }else{
                NSMutableArray *sectionArray = [masterArray objectAtIndex:index];
                [sectionArray addObject:photoData];
            }
            
        }
        if(!itemsWithNoTag && photoData.tags.count ==0){
            itemsWithNoTag = YES;
        }
        //TODO make work for images with no tag
        
        
    }
    //if we found items with no tag
    if(itemsWithNoTag){
        [tagArray addObject:@"no tag"];
    }
    self.masterArray = masterArray;
    return [tagArray copy];
    
}
-(NSArray<NSString*> *)findAllLocations{
    NSMutableArray *masterArray = [[NSMutableArray alloc]init];
    
    NSMutableArray *locationArray = [[NSMutableArray alloc]init];
    
    
    for(PhotoData *photoData in self.allPhotos){
        NSUInteger index = [locationArray indexOfObject:photoData.location];
        if( index == NSNotFound){
            //if this section does not yet exist, add it to sections
            [locationArray addObject:photoData.location];
            //add a new array to master array
            NSMutableArray *newSectionArray = [[NSMutableArray alloc]init];
            [newSectionArray addObject:photoData];
            [masterArray addObject:newSectionArray];
        }else{
            //if this section already exist
            //add the object at the correct index
            NSMutableArray *sectionArray = [masterArray objectAtIndex:index];
            [sectionArray addObject:photoData];
        }
    }
    self.masterArray = masterArray;
    return [locationArray copy];
}

-(NSString*)getHeaderTitleForSection:(NSInteger)section{
    return self.sectionArray[section];
}
-(NSInteger)getNumberOfSections{
    
    return self.sectionArray.count;
}
-(NSInteger)getNumberOfCellsForSection:(NSInteger)section{
    if(self.sortType == ALL){
        return self.allPhotos.count;
    }
    return self.masterArray[section].count;
   
}
@end
