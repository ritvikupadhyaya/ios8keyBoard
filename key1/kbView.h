//
//  kbView.h
//  key
//
//  Created by Ritvik Upadhyaya on 22/11/14.
//  Copyright (c) 2014 Ritvik Upadhyaya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface kbView : UIView
@property (weak, nonatomic) IBOutlet UIButton *change;
@property (weak, nonatomic) IBOutlet UIButton *space;
@property (weak, nonatomic) IBOutlet UIButton *enter;
@property (weak, nonatomic) IBOutlet UIButton *dotKey;
@property (weak, nonatomic) IBOutlet UIButton *dashKey;
- (IBAction)pan:(UIScreenEdgePanGestureRecognizer *)sender;

@end
