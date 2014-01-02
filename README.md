# TZShortKit

Small library with a few helpers that I use daily to save up some code. 

example:

instead of:
```objc
CGRect frame = view.frame;
frame.size.width -= 20;
view.frame = frame;
```

you can write:
```objc
view.frame.width -= 20;
```
## Categories provided

* `UIImage.width` and `UIImage.height`
* `UIView`: 
    * `CGFloat x`
    * `CGFloat y`
    * `CGFloat width`
    * `CGFloat height`
    * `CGFloat boundsX`
    * `CGFloat boundsY`
    * `CGFloat boundsWidth`
    * `CGFloat boundsHeight`
    * `CGPoint origin`
    * `CGPoint boundsOrigin`
    * `CGSize size`
    * `CGSize boundsSize`
* `UIButton`
    * `UIImage *image`
    * `UIImage *backgroundImage`
    * `UIImage *selectedImage`
    * `UIImage *selectedBackgroundImage`
    * `NSString *title`
    * `NSString *selectedTitle`

## Other helpers:

* __Device helpers__
```objc
BOOL IsRetinaScreen();
BOOL IsRetina4Screen();
CGFloat iOSVersion();
BOOL iOSVersionIsAtLeast(CGFloat version);
BOOL iOSVersionIsAtMost(CGFloat version);
BOOL iOSVersionIsGreatherThan(CGFloat version);
BOOL iOSVersionIsLessThan(CGFloat version);
```

* __Notification helpers__ _(I tried to make notifications as easy and flexible as possible, so there are a lot of optional parameters)_
  ```objc
  On(NSString *event[, id object], NotificationBlock block);
  On(NSString *event[, id object], id target, NSString *selectorName);
  ```
  ```objc
  Off(NSString *event[, NotificationBlock block]);
  Off(NSString *event[, id target, NSString *selectorName]);
  ```
  ```objc
  Trigger([id sender,] NSString *event [, NSDictionary *userInfo]);
  ```
  * Clarifying notification parameters:
  The second `On` method could be originally written as:

  ```objc
  [[NSNotificationCenter defaultCenter] addObserver:target
                                        selector:NSSelectorFromString(selectorName)
                                        name:event
                                        object:object];
  ```
  Alternatively you may substitute the target and selector for a block...
