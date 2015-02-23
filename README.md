# ProfilePicture #

Display user's initials to serve as either the placeholder or as the main profile picture view.

## Why? ##

Gender-neutral alternative to placeholder images for your app users.

## How? ##

* Import  ``` “ProfilePicture.h”  ```

* Setup _profilepicture_ using the below method:
```
	-(void)loadUserImage:(id)image forUser:(NSString*)username;
```

* Customise:

```
	@property (nonatomic, strong) UIFont  * initialsFont;
	@property (nonatomic, strong) UIColor * initialsColor;
	@property (nonatomic, assign) CGFloat   imageInset;
	@property (nonatomic, assign) BOOL      isSquare;
```
