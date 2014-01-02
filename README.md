# TZShortKit
---

Small library with a few helpers that I use daily to save up some code. 

example:

instead of:
```ios
CGRect frame = view.frame;
frame.size.width -= 20;
view.frame = frame;
```

you can write:
```ios
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
```ios
BOOL IsRetinaScreen();
BOOL IsRetina4Screen();
CGFloat iOSVersion();
BOOL iOSVersionIsAtLeast(CGFloat version);
BOOL iOSVersionIsAtMost(CGFloat version);
BOOL iOSVersionIsGreatherThan(CGFloat version);
BOOL iOSVersionIsLessThan(CGFloat version);
```

* __Notification helpers__ 

```ios
On(NSString *event[, id subject], NotificationBlock block);
Off(NSString *event[, NotificationBlock block]);
Trigger(NSString *event[, NSDictionary *userInfo]);
```
