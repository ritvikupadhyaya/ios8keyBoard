//
//  KeyboardViewController.m
//  key1
//
//  Created by Ritvik Upadhyaya on 22/11/14.
//  Copyright (c) 2014 Ritvik Upadhyaya. All rights reserved.
//

#import "KeyboardViewController.h"
#import "kbView.h"

@interface KeyboardViewController ()
@property (strong, nonatomic)kbView *kbview;

@end

@implementation KeyboardViewController


- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    // Add custom view sizing constraints here
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.kbview = [[[NSBundle mainBundle] loadNibNamed:@"kbView" owner:nil options:nil] objectAtIndex:0];
    [self addGesturesToKeyboard];
    self.inputView = self.kbview;
    
    

//    let button = createButtonWithTitle("A")
//    self.view.addSubview(button)
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
    
}

# pragma mark Keyboards

-(void) addGesturesToKeyboard{
    [self.kbview.space addTarget:self action:@selector(pressSpaceKey) forControlEvents:UIControlEventTouchUpInside];
    [self.kbview.enter addTarget:self action:@selector(pressEnterKey) forControlEvents:UIControlEventTouchUpInside];
    [self.kbview.change addTarget:self action:@selector(advanceToNextInputMode) forControlEvents:UIControlEventTouchUpInside];
    [self.kbview.dotKey addTarget:self action:@selector(pressDotKey) forControlEvents:UIControlEventTouchUpInside];
    [self.kbview.dashKey addTarget:self action:@selector(pressDashKey) forControlEvents:UIControlEventTouchUpInside];
    UILongPressGestureRecognizer *left = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(leftRecog:)];
    left.minimumPressDuration = 1.0;
    left.allowableMovement = 100.0f;
    [self.kbview.dashKey addGestureRecognizer:left];
    
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipe)];
    [leftSwipe setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.kbview.dashKey addGestureRecognizer:leftSwipe];
    
}
-(void)pressSpaceKey{
    [self.textDocumentProxy insertText:@" "];
}
-(void)pressEnterKey{
    [self.textDocumentProxy insertText:@"\n"];
}
-(void)pressDotKey{
    [self.textDocumentProxy insertText:@"."];
}
-(void)pressDashKey{
    [self.textDocumentProxy insertText:@"-"];
}
-(void)leftRecog:(UIPanGestureRecognizer *)gesture{
        [self.textDocumentProxy deleteBackward];
}
-(void)leftSwipe{
    [self.textDocumentProxy deleteBackward];
}

@end
