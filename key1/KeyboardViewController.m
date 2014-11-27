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


char ch[63] = {
    NULL,
    'E','T',
    'I','A','N','M',
    'S','U','R','W','D','K','G','O',
    'H','V','F',NULL,'L',NULL,'P','J',
        'B','X','C','Y','Z','Q',NULL,NULL,
    '5','4',NULL,'3',NULL,NULL,NULL,'2',
        NULL,NULL,'+',NULL,NULL,NULL,NULL,'1',
        '6','=','/',NULL,NULL,NULL,NULL,NULL,
        '7',NULL,NULL,NULL,'8',NULL,'9','0'
};

int currIndex = 0;
int morseCount = 0;
int mode = 2;
bool firstLetter = true;

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    // Add custom view sizing constraints here
}

- (void)viewDidLoad {
    mode = 0;
    [super viewDidLoad];
    [self.textDocumentProxy setAutocapitalizationType:UITextAutocapitalizationTypeSentences];
    self.kbview = [[[NSBundle mainBundle] loadNibNamed:@"kbView" owner:nil options:nil] objectAtIndex:0];
    [self addGesturesToKeyboard];
    self.inputView = self.kbview;
    [self gotoHeadNode];

    [self refreshChoices];
    

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

# pragma mark Keyboard Event Handler

-(void) refreshChoices {
    [self.kbview.choiceL setTitle:[self stringCase:[NSString stringWithFormat:@"%c", ch[currIndex * 2 + 1]]] forState:UIControlStateNormal];
    [self.kbview.choiceM setTitle:[NSString stringWithFormat:@"%c", ch[currIndex]] forState:UIControlStateNormal];
    [self.kbview.choiceR setTitle:[NSString stringWithFormat:@"%c", ch[currIndex * 2 + 2]] forState:UIControlStateNormal];
}
-(void) clearTempMorse {
    int temp = morseCount;
    for (int i = 0; i < temp; i++) {
        [self.textDocumentProxy deleteBackward];
        [self gotoParentNode];
    }
}
-(void) gotoParentNode {
    if (currIndex > 0) {
        currIndex = (currIndex / 2 - (1 - (currIndex % 2)));
        morseCount--;
        [self refreshChoices];
    }
}
-(void) gotoHeadNode {
    while (currIndex>0) {
        NSLog(@"-----------CURRINDEX-------:%d",currIndex);
        [self gotoParentNode];
    }

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
    
    UILongPressGestureRecognizer *left = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(leftRecog:)];
    left.minimumPressDuration = 1.0;
    left.allowableMovement = 100.0f;
    [self.kbview.dashKey addGestureRecognizer:left];
    
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipe)];
    [leftSwipe setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.kbview.dashKey addGestureRecognizer:leftSwipe];
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipe)];
    [rightSwipe setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.kbview.dotKey addGestureRecognizer:rightSwipe];
    
    UISwipeGestureRecognizer *downSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(downSwipe)];
    [downSwipe setDirection:UISwipeGestureRecognizerDirectionDown];
    [self.kbview.dotKey addGestureRecognizer:downSwipe];
    [self.kbview.dashKey addGestureRecognizer:downSwipe];
    
    UISwipeGestureRecognizer *upSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(upSwipe)];
    [upSwipe setDirection:UISwipeGestureRecognizerDirectionDown];
    [self.kbview.dashKey addGestureRecognizer:upSwipe];
    [self.kbview.dotKey addGestureRecognizer:upSwipe];

}

-(void)pressSpaceKey{
    NSString * temp =[self.textDocumentProxy documentContextBeforeInput];
    int len = [temp length];
    if (len>0) {
        len = len - 1;
    }
    NSString *trimmedTemp = [temp stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceCharacterSet]];
    int trimmedLen = [trimmedTemp length];
    if (trimmedLen>0) {
        trimmedLen = trimmedLen - 1;
    }
    
        if([[NSString stringWithFormat:@"%c",[temp characterAtIndex:len] ] isEqual:@" "] &&!([[NSString stringWithFormat:@"%c",[trimmedTemp characterAtIndex:trimmedLen] ] isEqual:@"."])){
                [self.textDocumentProxy deleteBackward];
            [self.textDocumentProxy insertText:@". "];
            firstLetter = true;
        }else{
        [self.textDocumentProxy insertText:@" "];
        }
}

-(void)pressEnterKey{
    [self.textDocumentProxy insertText:@"\n"];
    firstLetter = true;
}

-(void)pressDotKey{
    [self.textDocumentProxy insertText:@"."];
    morseCount++;
    if (currIndex < 32) {
        currIndex = currIndex * 2 + 1;
    } else {
        [self clearTempMorse];
        currIndex = 0;
        morseCount = 0;
    }
    firstLetter = false;
    [self refreshChoices];
}

-(void)pressDashKey{
    [self.textDocumentProxy insertText:@"-"];
    morseCount++;   //Outside
    if (currIndex < 32) {
        currIndex = currIndex * 2 + 2;
    } else {
        [self clearTempMorse];
        currIndex = 0;
        morseCount = 0;
    }
    firstLetter = false;
    [self refreshChoices];
}

#pragma mark Swipe Gestures

-(void)leftRecog:(UIPanGestureRecognizer *)gesture{
    [self.textDocumentProxy deleteBackward];
    [self gotoParentNode];
}
-(void)leftSwipe{
    [self.textDocumentProxy deleteBackward];
    [self gotoParentNode];
}
-(void)rightSwipe{
    [self pressChoiceM];    
}
-(void)downSwipe{
    if (mode > 1) {
        mode--;
    }
}
-(void)upSwipe{
    if (mode < 3) {
        mode++;
    }
}

#pragma mark Mode Based Insertion Correction

-(NSString *)stringCase:(NSString *)inStr{
    NSString *outStr = nil;
    switch (mode) {
        case 1:
           outStr = [inStr lowercaseString];
            return outStr;
            break;
        case 2:
            if (firstLetter) {
               outStr = [inStr uppercaseString];
                return outStr;
            }
            else{
                outStr = [inStr lowercaseString];
                return outStr;
            }
            break;
        case 3:
            outStr = [inStr uppercaseString];
            return outStr;
            break;
        default:
            outStr = [inStr lowercaseString];
            return outStr;
            break;
    }
    return outStr;
}


#pragma mark Choice Selection

-(void) pressChoiceL {
    if (ch[currIndex * 2 + 1] != NULL) {
        int temp = currIndex;
        [self clearTempMorse];
        [self.textDocumentProxy insertText:[self stringCase:[NSString stringWithFormat:@"%c", ch[temp * 2 + 1]]]];
        currIndex = 0;
        morseCount = 0;
        [self refreshChoices];
    }
}
-(void) pressChoiceM {
    if (ch[currIndex] != NULL) {
        int temp = currIndex;
        [self clearTempMorse];
        [self.textDocumentProxy insertText:[self stringCase:[NSString stringWithFormat:@"%c", ch[temp]]]];
        currIndex = 0;
        morseCount = 0;
        [self refreshChoices];
    }
}
-(void) pressChoiceR {
    if (ch[currIndex * 2 + 2] != NULL) {
        int temp = currIndex;
        [self clearTempMorse];
        [self.textDocumentProxy insertText:[ self stringCase:[NSString stringWithFormat:@"%c", ch[temp * 2 + 2]]]];
        currIndex = 0;
        morseCount = 0;
        [self refreshChoices];
    }
}

@end
