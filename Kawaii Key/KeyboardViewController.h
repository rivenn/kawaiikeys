#import <UIKit/UIKit.h>

@interface KeyboardViewController : UIInputViewController

@property (nonatomic, strong) IBOutlet UICollectionView *colview;
@property (nonatomic, strong) IBOutlet UIButton *nextKeyboardButton;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *spacebarButton;
@property (weak, nonatomic) IBOutlet UIButton *enterButton;


@end
