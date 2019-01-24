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
    
    self.collectionView.dragInteractionEnabled = YES;
    self.collectionView.dragDelegate = self;
}
- (NSArray<UIDragItem *> *)collectionView:(UICollectionView *)collectionView
             itemsForBeginningDragSession:(id<UIDragSession>)session
                              atIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"begin dragging");
    
    UICollectionViewCell *item = [self.collectionView cellForItemAtIndexPath:indexPath];
    NSItemProvider *itemProvider = [[NSItemProvider alloc]initWithObject:item];
    UIDragItem *dragItem = [[UIDragItem alloc]initWithItemProvider:itemProvider];
    dragItem.localObject = item;
    return dragItem;
    
}

//    let item = self.items[indexPath.row]
//    let itemProvider = NSItemProvider(object: item as NSString)
//    let dragItem = UIDragItem(itemProvider: itemProvider)
//    dragItem.localObject = item
//    return [dragItem]

- (IBAction)switchAllPhotos:(id)sender {
    [self.photoDataManager changeSortType:ALL];
    [self.collectionView reloadData];
}
- (IBAction)switchLocationPhotos:(id)sender {
    [self.photoDataManager changeSortType:LOCATION];
    [self.collectionView reloadData];
}
- (IBAction)switchTagPhotos:(id)sender {
    [self.photoDataManager changeSortType:TAGS];
    [self.collectionView reloadData];
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
    
    return [self.photoDataManager getNumberOfCellsForSection:section];
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
