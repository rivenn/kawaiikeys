#import "SecondViewController.h"

static NSString *reuseID = @"BNNCOLCELL";

@interface SecondViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property NSArray *emojiList;
@end

@implementation SecondViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    self.emojiList = @[@"^v^", @"TOT", @"<.<",@"^v^", @"TOT", @"<.<"];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  CGRect frame = self.view.frame;
  CGRect nframe=CGRectMake(frame.origin.x,frame.origin.y+100,frame.size.width,frame.size.height);
  
  UICollectionViewLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
  UICollectionView *colview = [[UICollectionView alloc] initWithFrame:nframe
                                                 collectionViewLayout:flowLayout];
  [colview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseID];
  colview.backgroundColor = [UIColor grayColor];
  
  colview.delegate = self;
  colview.dataSource = self;
  
  [self.view addSubview:colview];
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (UIButton *)buttonWithText:(NSString *)text {
  UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  btn.layer.borderColor = [[UIColor grayColor] CGColor];
  btn.layer.borderWidth = 1.0f;
  btn.layer.cornerRadius = 3.0f;
  btn.userInteractionEnabled = NO;
  
  [btn setTitle:text forState:UIControlStateNormal];
  [btn sizeToFit];
  btn.translatesAutoresizingMaskIntoConstraints = NO;
  return btn;
}

#pragma mark - collection view data source
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return [self.emojiList count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  UICollectionViewCell *cell = [collectionView
      dequeueReusableCellWithReuseIdentifier:reuseID forIndexPath:indexPath];
  
  [cell.contentView addSubview:
      [self buttonWithText:[self.emojiList objectAtIndex:indexPath.row]]];
  return cell;
}

#pragma mark - collection view delegate

- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  [collectionView deselectItemAtIndexPath:indexPath animated:YES];
  NSLog(@"%@", self.emojiList[indexPath.row]);
}

@end
