#import "KeyboardPreference.h"

@implementation KeyboardPreference

+ (UIColor *)KPBackgroundColor {
  return [UIColor whiteColor];
}

+ (CGColorRef)KPBorderColor{
  return [[UIColor colorWithWhite:0.5f alpha:0.5f] CGColor];
}

+ (UIColor *)KPTintColor{
  return [UIColor blackColor];
}

@end
