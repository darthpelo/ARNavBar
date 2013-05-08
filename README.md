ARNavBar
========

Custom Navigation View and Drop Down menu developed in [VeespoFramework] (http://veespo.com).
With this simple project I want to show how to use this two class:
- VENavBar is a simple NavigationBar with one or two buttons configurable that using blocks to comunicate with UIViewController
- VEDropDownMenu is a menu directly ispired by [NIDropDown project] (https://github.com/BijeshNair/NIDropDown) that works with VENavBar or others UIView.

## VENavBar

To use simply add VENavBar.h and .m to your Xcode proj.

In your viewcontroller, initialize VENavBar passing frame and **configuration**. Configuration is defined with typedef **VENavBarConfiguration**
```objectivec
typedef enum {
    VENavBarDefault,
    VENavBarOnlyCloseBtn
} VENavBarConfiguration;
```
Using configuration you can, for example, decided if the navigationbar implements the drop down menu **VEDropDownMenu**.

```objectivec
- (id)initWithFrame:(CGRect)frame configuration:(VENavBarConfiguration)config;
```
Then you assign the block to the callback functions implemented by the class. VENavBar implemented three callback:
```objectivec
@property (nonatomic, copy) void (^menuPressed)(BOOL isOpen, VENavBar *navBar);
@property (nonatomic, copy) void (^closePressed)();
@property (nonatomic, strong) void (^functionRequest)(NSInteger number);
```
* **menuPressed** is called when menu button, if present, is pressed. **isOpen** inform you if the user has opened or closed the menu
* **closePressed** is called when the user pressed close button, in the case you want to close your viewcontroller
* **functionRequest** is called when the user select a voice in the drop down menu and **numeber** simply indicates which function has been selected. 

If you want to close the drop down menu programmatically and not through menu button, you can use
```objectivec
- (void)closeMenu;
```

## VEDropDownMenu

The main differences between my version and origianl [NIDropDown project] (https://github.com/BijeshNair/NIDropDown) are two:
* VEDropDownMenu implments block callbacks
* NIDropDown frame is designed in relation to the button that opens the menu, while I designed the menu in relation to the main view, in this specific case the navigation bar.

To use simply add VENavBar.h and .m to your Xcode proj.

In the code, to create ad instance of VEDropDownMenu, you should use the following method:
```objectivec
- (id)showDropDown:(UIView *)view titleList:(NSArray *)titleList imageList:(NSArray *)imageList directionDown:(BOOL)direction;
```
* **view** is the view from where the menu appears (is possibile to change this to a UIViewController)
* **titleList** array with the titles of the menu
* **imageList** icons fot each titles.
* **direction** determines whether the menu appears from top to bottom or vice versa.

I soon will replace NSArray with plist or NSDictionary.

This's a simple example about implementation of the menu in VENavBar, linked with a button.
```objectivec
- (IBAction)buttonPressed:(id)sender
{
    if (sender == closeBtn) {
        if (self.closePressed)
            self.closePressed();
    } else if (sender == menuBtn) {
        if(dropDown == nil) {
            self.menuPressed(YES, self);
            NSArray *arr = [NSArray arrayWithObjects:@"Add tag's comment", @"Tag info", @"Help", @"Languages", nil];
            NSArray *arrImage = [NSArray arrayWithObjects:[UIImage imageNamed:@"icona_commenti.png"],
                                 [UIImage imageNamed:@"icona_info.png"],
                                 [UIImage imageNamed:@"icona_help.png"],
                                 [UIImage imageNamed:@"cambio-lingua.png"], nil];
            dropDown = [[VEDropDownMenu alloc] showDropDown:self
                                                  titleList:arr
                                                  imageList:arrImage
                                              directionDown:YES];
            __weak id bSelf = self;
            dropDown.function = ^(NSInteger index){
                [bSelf closeMenu];
                [bSelf sendRequest:index];
            };
            dropDown.releseMenu = ^{
                [bSelf closeMenu];
            };
        } else {
            [self closeMenu];
            self.menuPressed(NO, self);
        }
    }
}
```
```objectivec
- (void)closeMenu
{
    [dropDown hideDropDown:self];
    dropDown = nil;
}
```

Authors
--------
[Alessio](mailto:roberto@veespo.com) developer

[Paco](mailto:paco@veespo.com) graphics

## Contact ##

[Alessio](mailto:roberto@veespo.com)

License
-------

This code is distributed under the terms and conditions of the [MIT license](LICENSE).
