//
//  ViewController.m
//  SampleAccounting
//
//  Created by Devanshu Saini on 10/2/15.
//  Copyright © 2015 Devanshu Saini. All rights reserved.
//

#import "ViewController.h"
#import "TextViewController.h"
#import "TaxViewController.h"

#define SKYBLUECOLOR [UIColor colorWithRed:(110.0/255.0) green:(183.0/255.0) blue:(235.0/255.0) alpha:1.0]

@interface ViewController (){
    IBOutlet UIView *buttonWrapper;
    IBOutlet UIButton *aboutButton;
    IBOutlet UIButton *taxtipButton;
    IBOutlet UIButton *loanCalculatorButton;
    IBOutlet UIButton *bookButton;
    IBOutlet UIButton *mapButton;
    IBOutlet UIImageView *callButton;
    IBOutlet UIImageView *smsButton;
    IBOutlet UIImageView *mailButton;
    IBOutlet UIImageView *facebookButton;
    TextViewController *textController;
    TaxViewController *taxController;
    MFMessageComposeViewController *smsController;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UtilityClass colorFromHexString:@"1f2e1b"]];
    
    self.navigationController.navigationBarHidden = YES;
    buttonWrapper.layer.cornerRadius = 5.0;
    aboutButton.layer.cornerRadius = 5.0;
    taxtipButton.layer.cornerRadius = 5.0;
    loanCalculatorButton.layer.cornerRadius = 5.0;
    bookButton.layer.cornerRadius = 5.0;
    
    [aboutButton setBackgroundColor:SKYBLUECOLOR];
    [taxtipButton setBackgroundColor:SKYBLUECOLOR];
    [loanCalculatorButton setBackgroundColor:SKYBLUECOLOR];
    [bookButton setBackgroundColor:SKYBLUECOLOR];
    
    UITapGestureRecognizer *callGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callAction)];
    callGesture.numberOfTapsRequired = 1;
    [callButton addGestureRecognizer:callGesture];
    
    UITapGestureRecognizer *smsGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(smsAction)];
    smsGesture.numberOfTapsRequired = 1;
    [smsButton addGestureRecognizer:smsGesture];
    
    UITapGestureRecognizer *mailGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mailAction)];
    mailGesture.numberOfTapsRequired = 1;
    [mailButton addGestureRecognizer:mailGesture];
    
    UITapGestureRecognizer *fbGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fbAction)];
    fbGesture.numberOfTapsRequired = 1;
    [facebookButton addGestureRecognizer:fbGesture];
    
//    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
//    loginButton.center = self.view.center;
//    [self.view addSubview:loginButton];
    //Here you would display navigationController.view somehow
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Button Action

- (IBAction)aboutAction:(id)sender{
    if (!textController) {
        textController = [[TextViewController alloc] initWithNibName:@"TextViewController" bundle:nil];
    }

    textController.navTitle = @"About Us";
    [self.navigationController pushViewController:textController animated:YES];
}

- (IBAction)taxTipAction:(id)sender{
    if (!textController) {
        textController = [[TextViewController alloc] initWithNibName:@"TextViewController" bundle:nil];
    }
    textController.navTitle = @"Tax Tips";
    [self.navigationController pushViewController:textController animated:YES];
}

- (IBAction)loanCalculatorAction:(id)sender{
    if (!taxController) {
        taxController = [[TaxViewController alloc] initWithNibName:@"TaxViewController" bundle:nil];
    }
    [self.navigationController pushViewController:taxController animated:YES];
}

- (IBAction)bookAction:(id)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.google.com"]];
}

- (IBAction)mapAction:(id)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.google.com/maps/place/India/@20.9857003,82.7526305,5z/data=!3m1!4b1!4m2!3m1!1s0x30635ff06b92b791:0xd78c4fa1854213a6"]];
}

- (void)callAction{
    NSURL *URL = [NSURL URLWithString:@"tel://844-752-3757"]; [[UIApplication sharedApplication] openURL:URL];
}

- (void)mailAction{
    NSString *recipients = @"mailto:first@example.com?cc=second@example.com,third@example.com&subject=Hello from California!";
    
    NSString *body = @"&body=It is raining in sunny California!";
    
    NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
    
    email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}

- (void)smsAction{
    smsController = [[MFMessageComposeViewController alloc] init];
    if([MFMessageComposeViewController canSendText])
    {
        smsController.body = @"Hello Friends this is sample text message.";
        smsController.recipients = [NSArray arrayWithObjects:@"8447523757", nil];
        smsController.messageComposeDelegate = self;
        [self presentViewController:smsController animated:YES completion:nil];
    }
}

- (void)fbAction{    
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
    content.contentURL = [NSURL URLWithString:@"http://developers.facebook.com"];
    [FBSDKShareDialog showFromViewController:self
                                 withContent:content
                                    delegate:nil];
}


- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    NSString *message = nil;
    switch (result) {
        case MessageComposeResultCancelled:
            message = @"Cancelled";
            break;
        case MessageComposeResultFailed:
            message = @"Failed";
            break;
        case MessageComposeResultSent:
            message = @"Send";
            break;
        default:
            break;
    }
    if (message) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    NSString *message = nil;
    if (result == MFMailComposeResultSent) {
        message = @"It's away!";
    }
    if (message) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
