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


char ch[63] = {NULL,
    'T','E',
    'M','N','A','I',
    'O','G','K','D','W','R','U','S',
    NULL,NULL,'Q','Z','Y','C','X','B',
    'J','P',NULL,'L',NULL,'F','V','H',
    '0','9',NULL,'8',NULL,NULL,NULL,'7',
    NULL,NULL,NULL,NULL,NULL,'/',NULL,'6',
    '1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,
    '2',NULL,NULL,NULL,'3',NULL,'4','5',
};

int currIndex = 0;



- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    // Add custom view sizing constraints here
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self refreshChoices];
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

-(void) refreshChoices {
    [self.kbview.choiceL setTitle:[NSString stringWithFormat:@"%c", ch[currIndex * 2 + 1]] forState:UIControlStateNormal];
    [self.kbview.choiceM setTitle:[NSString stringWithFormat:@"%c", ch[currIndex]] forState:UIControlStateNormal];
    [self.kbview.choiceR setTitle:[NSString stringWithFormat:@"%c", ch[currIndex * 2 + 2]] forState:UIControlStateNormal];
}

-(void) addGesturesToKeyboard{
    [self.kbview.space addTarget:self action:@selector(pressSpaceKey) forControlEvents:UIControlEventTouchUpInside];
    [self.kbview.enter addTarget:self action:@selector(pressEnterKey) forControlEvents:UIControlEventTouchUpInside];
    [self.kbview.change addTarget:self action:@selector(advanceToNextInputMode) forControlEvents:UIControlEventTouchUpInside];
    [self.kbview.dotKey addTarget:self action:@selector(pressDotKey) forControlEvents:UIControlEventTouchUpInside];
    [self.kbview.dashKey addTarget:self action:@selector(pressDashKey) forControlEvents:UIControlEventTouchUpInside];
    [self.kbview.choiceL addTarget:self action:@selector(pressChoiceL) forControlEvents:UIControlEventTouchUpInside];
    [self.kbview.choiceM addTarget:self action:@selector(pressChoiceM) forControlEvents:UIControlEventTouchUpInside];
    [self.kbview.choiceR addTarget:self action:@selector(pressChoiceR) forControlEvents:UIControlEventTouchUpInside];
    UISwipeGestureRecognizer *left = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftRecog)];
    left.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.kbview.dashKey addGestureRecognizer:left];
    
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
-(void)leftRecog{
    [self.textDocumentProxy deleteBackward];
}
-(void) pressChoiceL {
    if (ch[currIndex * 2 + 1] != NULL) {
        [self.textDocumentProxy insertText:[NSString stringWithFormat:@"%c", ch[currIndex * 2 + 1]]];
        currIndex = 0;
    }
}
-(void) pressChoiceM {
    if (ch[currIndex] != NULL) {
        [self.textDocumentProxy insertText:[NSString stringWithFormat:@"%c", ch[currIndex]]];
        currIndex = 0;
    }
}
-(void) pressChoiceR {
    if (ch[currIndex * 2 + 2] != NULL) {
        [self.textDocumentProxy insertText:[NSString stringWithFormat:@"%c", ch[currIndex * 2 + 2]]];
        currIndex = 0;
    }
}

@end
