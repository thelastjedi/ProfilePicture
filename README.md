# ProfilePicture #

Display user's initials to serve as either the placeholder or as the main profile picture view.

## Why? ##

Gender-neutral alternative to placeholder images for your app users.

## How? ##

* Import  ``` “ProfilePicture.h”  ```

* Setup _profilepicture_ using the below method:
```objc
	-(void)loadUserImage:(id)image forUser:(NSString*)username;
```

* Customise:

```objc
	@property (nonatomic, strong) UIFont  * initialsFont;
	@property (nonatomic, strong) UIColor * initialsColor;
	@property (nonatomic, assign) CGFloat   imageInset;
	@property (nonatomic, assign) BOOL      isSquare;
```

* ProfilePicture-Example

![profilepicture-example](https://cloud.githubusercontent.com/assets/1327490/6333283/c01cc3f2-bbb1-11e4-94c3-996eb93112bd.png)
