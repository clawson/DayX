//
//  ViewController.m
//  DayX
//
//  Created by Dan Clawson on 4/7/15.
//  Copyright (c) 2015 Slacker Tools. All rights reserved.
//

#import "ViewController.h"

static NSString * const entryKey = @"entry";
static NSString * const titleKey = @"title";
static NSString * const contentKey = @"body";

@interface ViewController () <UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UIButton *clearButton;

@end

@implementation ViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    
    // Remember, we must adopt each delegate
    self.titleTextField.delegate = self;
    self.contentTextView.delegate = self;
    
    // We need to load the journal entry from NSUserDefaults
    NSDictionary *journalEntry = [[NSUserDefaults standardUserDefaults] objectForKey:entryKey];
    [self updateViewWithDictionary:journalEntry];
}

- (void) updateViewWithDictionary: (NSDictionary *) journalEntry {
    self.titleTextField.text = journalEntry[titleKey];
    self.contentTextView.text = journalEntry[contentKey];
}

- (IBAction) clearButtonPress: (id) sender {
    self.titleTextField.text = @"";
    self.contentTextView.text = @"";
    
}

- (BOOL) textFieldShouldReturn: (UITextField *) titleField {
    [titleField resignFirstResponder];
    return YES;
}

-(void) textFieldDidEndEditing: (UITextField *) textField {
    [self save:textField];
}

- (void) textViewDidChange: (UITextView *) textView {
    [self save:textView];
}

- (void) save: (id)sender {
    
    // Convert our journalEntry to a dictionary to add it to NSUserDefaults
    NSDictionary *journal = @{titleKey:self.titleTextField.text,  contentKey:self.contentTextView.text};
    
    [[NSUserDefaults standardUserDefaults] setObject:journal forKey:entryKey];
    
    // Write it immediately
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
