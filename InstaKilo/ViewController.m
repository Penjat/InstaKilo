//
//  ViewController.m
//  InstaKilo
//
//  Created by Spencer Symington on 2019-01-23.
//  Copyright © 2019 Spencer Symington. All rights reserved.
//

#import "ViewController.h"
#import "PhotoCollectionViewCell.h"
#import "PhotoDataManager.h"
#import "HeaderView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong,nonatomic)PhotoDataManager *photoDataManager;
@property (strong,nonatomic)UICollectionViewFlowLayout *myLayout;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.photoDataManager = [[PhotoDataManager alloc]init];
    
    self.collectionView.dataSource = self;
    [self setUpLayout];
    self.collectionView.collectionViewLayout = self.myLayout;
}
-(void)setUpLayout{
    self.myLayout = [[UICollectionViewFlowLayout alloc] init];
    self.myLayout.itemSize = CGSizeMake(100, 100);
    self.myLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    self.myLayout.minimumLineSpacing = 5;
    self.myLayout.minimumInteritemSpacing = 5;
    
    self.myLayout.headerReferenceSize = CGSizeMake(CGRectGetWidth(self.collectionView.frame), 80);
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.photoDataManager.allPhotos.count;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView
                                   cellForItemAtIndexPath:(nonnull NSIndexPath*)indexPath
{
    NSString *cellId = @"photoCell";  // Reuse identifier
    
    
    
    PhotoCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:cellId
                                                                                forIndexPath:indexPath];
    
    //Set up cell with data
    PhotoData* photoData = [self.photoDataManager getDataForIndex:indexPath];
    [cell setUpWithPhotoData:photoData];
    
    return cell;

}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath{
    
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        NSLog(@"creating a header view");
        HeaderView *headerView = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                           withReuseIdentifier:@"SectionView"
                                                                                  forIndexPath:indexPath];
        headerView.sectionTitle.text = [self.photoDataManager getHeaderTitleForSection:indexPath.section];
        return headerView;
    }
    else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        
        return nil;
    }
    else {
        return nil;
    }
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [self.photoDataManager getNumberOfSections ];
}
@end
