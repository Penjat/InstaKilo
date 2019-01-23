//
//  PhotoCollectionViewCell.m
//  InstaKilo
//
//  Created by Spencer Symington on 2019-01-23.
//  Copyright © 2019 Spencer Symington. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

@interface PhotoCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *photoImage;


@end

@implementation PhotoCollectionViewCell

-(void)setUpWithPhotoData:(PhotoData*)data{
    NSLog(@"setting up cell with data");
    self.photoImage.image = [UIImage imageNamed:data.path];
    
}
@end
