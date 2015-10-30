//
//  QRReaderViewController.h
//  QRCodeDemo
//
//  Created by ZhouBei on 15/10/30.
//  Copyright © 2015年 ZhouBei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QRReaderViewControllerDelegate;

@interface QRReaderViewController : UIViewController

@property (nonatomic, assign) id<QRReaderViewControllerDelegate> delegate;

@end

@protocol QRReaderViewControllerDelegate <NSObject>

- (void)didFinishedReadingQR:(NSString *)string;

@end

