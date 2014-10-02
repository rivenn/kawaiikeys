#import "KeyboardViewController.h"

static NSString *reuseID = @"BNNCOLCELL";

@interface KeyboardViewController () <UICollectionViewDataSource, UICollectionViewDelegate,  UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSArray *emojiList;

@property (nonatomic, strong) UICollectionView *colview;
@property (nonatomic, strong) UIButton *nextKeyboardButton;

@property (nonatomic, strong) NSLayoutConstraint *leftCons,*rightCons;
@property (nonatomic, strong) NSLayoutConstraint *topCons,*bottomCons;
@end

@implementation KeyboardViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    self.emojiList = @[@"NEXT", @"^v^", @"TOT", @"<.<"];
  }
  return self;
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    // Add custom view sizing constraints here
}

- (void)addCollectionView {
  UICollectionViewLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];

  self.colview = [[UICollectionView alloc] initWithFrame:self.view.frame
                                    collectionViewLayout:flowLayout];
  [self.colview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseID];
  self.colview.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
  self.colview.delegate = self;
  self.colview.dataSource = self;
  self.colview.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
  
  [self.view insertSubview:self.colview atIndex:0];
}

- (UIButton *)xxNextKeyboardButton {
  // Perform custom UI setup here
  self.nextKeyboardButton = [UIButton buttonWithType:UIButtonTypeSystem];
  [self.nextKeyboardButton setTitle:@"NEXT KEYBD"
                           forState:UIControlStateNormal];
  [self.nextKeyboardButton sizeToFit];
  self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = NO;
  
  [self.nextKeyboardButton addTarget:self
                              action:@selector(advanceToNextInputMode)
                    forControlEvents:UIControlEventTouchUpInside];
  return self.nextKeyboardButton;
}

- (UIButton *)buttonWithText:(NSString *)text {
  UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
  
  btn.layer.borderColor = [[UIColor whiteColor] CGColor];
  btn.layer.borderWidth = 2.0f;
  btn.layer.cornerRadius = 5.0f;
  btn.userInteractionEnabled = NO;
  
  [btn setTitle:text forState:UIControlStateNormal];
  [btn sizeToFit];

  return btn;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // add views to keyboard
  
  [self addCollectionView];
  // add constraints
  
  self.leftCons = [NSLayoutConstraint constraintWithItem:self.colview attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
  self.rightCons = [NSLayoutConstraint constraintWithItem:self.colview attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0];
  self.topCons = [NSLayoutConstraint constraintWithItem:self.colview attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
  self.bottomCons = [NSLayoutConstraint constraintWithItem:self.colview attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
  [self.view addConstraints:@[self.leftCons, self.rightCons,self. topCons, self.bottomCons]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
}

- (void)textWillChange:(id<UITextInput>)textInput {
    // The app is about to change the document's contents. Perform any preparation here.
}

- (void)textDidChange:(id<UITextInput>)textInput {
    // The app has just changed the document's contents, the document context has been updated.
    
    UIColor *textColor = nil;
    if (self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearanceDark) {
        textColor = [UIColor whiteColor];
    } else {
        textColor = [UIColor blackColor];
    }
    //[self.nextKeyboardButton setTitleColor:textColor forState:UIControlStateNormal];
}

#pragma mark - UICollectionView Data Source
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return 3;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  UICollectionViewCell *cell = [collectionView
      dequeueReusableCellWithReuseIdentifier:reuseID forIndexPath:indexPath];
  /*
  cell.layer.borderColor = [[UIColor blackColor] CGColor];
  cell.layer.borderWidth = 1.0f;
  cell.layer.cornerRadius = 3.0f;
  */

  [cell.contentView addSubview:[self buttonWithText:[self.emojiList objectAtIndex:indexPath.row]]];
  return cell;
}

#pragma mark - UICollectionView Delegate

- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  [collectionView deselectItemAtIndexPath:indexPath animated:YES];
  if (indexPath.row == 0) {
    [self advanceToNextInputMode];
  }else{
    [self.textDocumentProxy insertText:self.emojiList[indexPath.row]];
  }
}

#pragma mark - UICollectionView Delegate FlowLayout

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
  return 10.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
  return 10.0f;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  return CGSizeMake(30, 30);
}

@end
