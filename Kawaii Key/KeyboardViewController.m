#import "KeyboardViewController.h"

#import "KeyboardPreference.h"

static NSString *reuseID = @"BNNCOLCELL";

@interface KeyboardViewController () <UICollectionViewDataSource, UICollectionViewDelegate >

@property (nonatomic, strong) NSDictionary *emojiDict;
@property (nonatomic, strong) NSArray *emojiList;

@end

@implementation KeyboardViewController

#pragma mark - Init Methods

- (void)initialzeData {
  // Data
  NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"emojiDict" ofType:@"plist"];
  self.emojiDict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
  self.emojiList = self.emojiDict[@"helpless"];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:@"KeyboardViewController" bundle:[NSBundle mainBundle]];
  if (self) {
    [self initialzeData];
    NSLog(@"initializing data... w/nib");
  }
  return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self initialzeData];
    NSLog(@"initializing data... w/coder");
  }
  return self;
}

#pragma mark - View Methods

- (void)updateViewConstraints {
    [super updateViewConstraints];
    // Add custom view sizing constraints here
  NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self.backButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.spacebarButton attribute:NSLayoutAttributeHeight multiplier:1.0 constant:1.0];
  [self.view addConstraint:constraint];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  [self.colview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseID];
  [self setCollectionViewUIToPreference:self.colview];
  
  [self setButtonUIToPreference:self.backButton];
  [self setButtonUIToPreference:self.enterButton];
  [self setButtonUIToPreference:self.nextKeyboardButton];
  [self setButtonUIToPreference:self.spacebarButton];
  
  NSArray *keys = [self.emojiDict allKeys];
  [self.segmentedControl removeAllSegments];
  for (int i=0; i<[keys count]; i++) {
    [self.segmentedControl insertSegmentWithTitle:[keys objectAtIndex:i] atIndex:i animated:NO];
  }
  self.segmentedControl.selectedSegmentIndex=0;
  [self valueChanged:self.segmentedControl];
  
  

  
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
  return [self.emojiList count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  UICollectionViewCell *cell = [collectionView
      dequeueReusableCellWithReuseIdentifier:reuseID forIndexPath:indexPath];
  
  UIButton *btn = [self buttonWithText:[self.emojiList objectAtIndex:indexPath.row]];
  [cell.contentView addSubview:btn];
  return cell;
}

#pragma mark - UICollectionView Delegate

- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  [collectionView deselectItemAtIndexPath:indexPath animated:YES];
  [self.textDocumentProxy insertText:self.emojiList[indexPath.row]];
}

#pragma mark - Action Methods

-(IBAction)emojiTextButtonPressed:(id)sender {
  UIButton *btn = (UIButton *)sender;
  [self.textDocumentProxy insertText:btn.titleLabel.text];
}

-(IBAction)nextKeyboardPressed:(id)sender{
  [self advanceToNextInputMode];
}

-(IBAction)dismissPressed:(id)sender {
  [self dismissKeyboard];
}

- (IBAction)backPressed:(id)sender {
  [self.textDocumentProxy deleteBackward];
}

- (IBAction)spacePressed:(id)sender {
  [self.textDocumentProxy insertText:@" "];
}

- (IBAction)enterPressed:(id)sender {
  [self dismissKeyboard];
}

- (IBAction)valueChanged:(id)sender {
  UISegmentedControl *sctrl = (UISegmentedControl *)sender;
  
  NSArray *keys = [self.emojiDict allKeys];
  self.emojiList = self.emojiDict[keys[sctrl.selectedSegmentIndex]];
  [self.colview reloadData];
}


#pragma mark - Helper Methods

- (UIButton *)buttonWithText:(NSString *)text {
  UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
  btn.frame = CGRectMake(5, 0, 54, 40);
  [btn setTitle:text forState:UIControlStateNormal];
  [btn addTarget:self action:@selector(emojiTextButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
  [self setButtonUIToPreference:btn];
  return btn;
}

- (void)setButtonUIToPreference:(UIButton *)button {
  button.backgroundColor = [KeyboardPreference KPBackgroundColor];
  button.layer.borderColor = [KeyboardPreference KPBorderColor];
  button.layer.borderWidth = 1.0f;
  button.layer.cornerRadius = 3.0f;
  button.tintColor = [KeyboardPreference KPTintColor];
}

- (void)setCollectionViewUIToPreference:(UICollectionView *)colview{
  colview.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.5f];
  colview.layer.borderColor = [KeyboardPreference KPBorderColor];
  colview.layer.borderWidth = 1.0f;
  //colview.layer.cornerRadius = 3.0f;
  //button.tintColor = [KeyboardPreference KPTintColor];
}

@end
