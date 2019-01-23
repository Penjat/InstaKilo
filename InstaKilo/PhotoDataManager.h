//
//  PhotoDataManager.h
//  InstaKilo
//
//  Created by Spencer Symington on 2019-01-23.
//  Copyright © 2019 Spencer Symington. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhotoData.h"
#import <UIKit/UIKit.h>

enum SORT_TYPE{
    ALL,
    LOCATION,
    TAGS
    
};
NS_ASSUME_NONNULL_BEGIN

@interface PhotoDataManager : NSObject
@property (nonatomic,strong)NSMutableArray<PhotoData*> *allPhotos;
@property (strong,nonatomic)NSArray<NSString*> *sectionArray;

-(PhotoData*)getDataForIndex:(NSIndexPath *)indexPath;
-(void)changeSortType:(enum SORT_TYPE)sortType;
-(NSString*)getHeaderTitleForSection:(NSInteger)section;
-(NSInteger)getNumberOfSections;
@end

NS_ASSUME_NONNULL_END
