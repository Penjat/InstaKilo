//
//  PhotoCollectionViewCell.h
//  InstaKilo
//
//  Created by Spencer Symington on 2019-01-23.
//  Copyright © 2019 Spencer Symington. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoData.h"

NS_ASSUME_NONNULL_BEGIN

@interface PhotoCollectionViewCell : UICollectionViewCell
-(void)setUpWithPhotoData:(PhotoData*)data;
@end

NS_ASSUME_NONNULL_END
