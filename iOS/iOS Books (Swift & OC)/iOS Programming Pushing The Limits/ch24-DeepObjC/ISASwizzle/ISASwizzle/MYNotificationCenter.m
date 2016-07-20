
#import "MYNotificationCenter.h"

@implementation MYNotificationCenter
- (void)addObserver:(id)observer selector:(SEL)aSelector
               name:(NSString *)aName object:(id)anObject
{
  NSLog(@"Adding observer: %@", observer);
  [super addObserver:observer selector:aSelector name:aName 
              object:anObject];
}
@end
