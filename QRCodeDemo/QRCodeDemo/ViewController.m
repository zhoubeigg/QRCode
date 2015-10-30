//
//  ViewController.m
//  QRCodeDemo
//
//  Created by YK on 15/10/30.
//  Copyright © 2015年 ZhouBei. All rights reserved.
//

#import "ViewController.h"
#import "QRReaderViewController.h"

@interface ViewController () <QRReaderViewControllerDelegate>

@property (nonatomic, strong) UIButton *showQRReaderButton;
@property (nonatomic, strong) UIButton *qrReaderResultButton;
@property (nonatomic, strong) NSURL *url;

@end

@implementation ViewController

- (void)initViewAndSubViews {
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    self.showQRReaderButton =
    [[UIButton alloc] initWithFrame:CGRectMake(0, 100, screenWidth, 44)];
    [self.showQRReaderButton setTitle:@"开始扫描二维码" forState:UIControlStateNormal];
    [self.showQRReaderButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.showQRReaderButton.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.showQRReaderButton];
    [self.showQRReaderButton addTarget:self action:@selector(showQRReader:)
                      forControlEvents:UIControlEventTouchDown];
    
    self.qrReaderResultButton =
    [[UIButton alloc] initWithFrame:CGRectMake(0, 200, screenWidth, 44)];
    self.qrReaderResultButton.backgroundColor = [UIColor yellowColor];
    [self.qrReaderResultButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.qrReaderResultButton addTarget:self action:@selector(openUrl) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.qrReaderResultButton];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"二维码扫描器";
    
    [self initViewAndSubViews];
}

// 读二维码
- (void)showQRReader:(id)sender {
    // 扫描二维码
    // 1. init ViewController
    QRReaderViewController *VC = [[QRReaderViewController alloc] init];
    
    // 2. configure ViewController
    VC.delegate = self;
    
    // 3. show ViewController
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark - QRReaderViewControllerDelegate

- (void)didFinishedReadingQR:(NSString *)string {
    NSLog(@"result string: %@", string);
    [self.qrReaderResultButton setTitle:string forState:UIControlStateNormal];
    
    // 判断是否为URL
    //    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSString *regex = @"^(http://|https://)?((?:[A-Za-z0-9]+-[A-Za-z0-9]+|[A-Za-z0-9]+)\\.)+([A-Za-z]+)[/\\?\\:]?.*$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL isURL = [identityCardPredicate evaluateWithObject:string];
    
    if (isURL) {
        self.qrReaderResultButton.enabled = YES;
        // 用此url打开Safari
        NSURL *url = [[NSURL alloc] initWithString:string];
        self.url = url;
    } else
    {
        self.qrReaderResultButton.enabled = NO;
    }
}

- (void)openUrl
{
    [[UIApplication sharedApplication] openURL:self.url];
}

@end
