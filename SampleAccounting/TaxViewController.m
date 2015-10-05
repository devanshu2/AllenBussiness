//
//  TaxViewController.m
//  SampleAccounting
//
//  Created by Devanshu Saini on 10/3/15.
//  Copyright © 2015 Devanshu Saini. All rights reserved.
//

#import "TaxViewController.h"

@interface TaxViewController (){
    IBOutlet UITextField *principalAmount;
    IBOutlet UITextField *interestRate;
    IBOutlet UITextField *tenure;
    IBOutlet UIButton *calculateButton;
    IBOutlet UILabel *messageLabel;
}

@end

@implementation TaxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = @"Calculate EMI";
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self resignKeyboards];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)calculateEMI:(id)sender{
    [self resignKeyboards];
    messageLabel.text = @"";
    @try {
        NSDecimalNumber *loan = [NSDecimalNumber decimalNumberWithString:principalAmount.text];
        NSDecimalNumber *annualInterestRate = [NSDecimalNumber decimalNumberWithString:interestRate.text];
        NSInteger numberOfPayments = tenure.text.integerValue;
        if (!loan || !annualInterestRate || !numberOfPayments) {
            messageLabel.text = @"Invalid Inputs";
        }
        annualInterestRate = [annualInterestRate decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"100"]];
        NSDecimalNumber *temp1 = [annualInterestRate decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"12"]];
        NSDecimalNumber *temp2 = [temp1 decimalNumberByMultiplyingBy:loan];
        NSDecimalNumber *temp4 = [[NSDecimalNumber one] decimalNumberByAdding:temp1];
        NSDecimalNumber *temp5 = [[NSDecimalNumber one] decimalNumberByDividingBy:[temp4 decimalNumberByRaisingToPower:numberOfPayments]];
        NSDecimalNumber *temp6 = [[NSDecimalNumber one] decimalNumberBySubtracting:temp5];
        
        NSDecimalNumber *monthlyRate = [temp2 decimalNumberByDividingBy:temp6];
        NSLog(@"Monthly rate: %@", monthlyRate);
        NSNumberFormatter *frm = [[NSNumberFormatter alloc] init];
        [frm setNumberStyle:NSNumberFormatterDecimalStyle];
        [frm setMaximumFractionDigits:2];
        [frm setMinimumFractionDigits:2];
        NSString *formattedNumberStr = [frm stringFromNumber:monthlyRate];

        messageLabel.text = [NSString stringWithFormat:@"Monthly rate: %@", formattedNumberStr];
    }
    @catch (NSException *exception) {
        messageLabel.text = exception.description;
    }
}

- (void)resignKeyboards{
    [interestRate resignFirstResponder];
    [principalAmount resignFirstResponder];
    [tenure resignFirstResponder];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
