//
//  BBTViewController.m
//  DahanLibrary
//
//  Created by AndyM129 on 11/29/2019.
//  Copyright (c) 2019 AndyM129. All rights reserved.
//

#import "BBTViewController.h"
#import <dahantclibrary/dahantclibrary.h>

NSString * const APPID = @"8516newworld";
NSString * const APPKEY = @"456.com";
NSString * const getPhoneByTokenUrl = @"https://www.dh3t.com/phone/rest/getPhoneNumByToken";
NSString * const verifyPhoneUrl = @"https://www.dh3t.com/phone/rest/verifyPhoneNumByToken";

@interface BBTViewController ()
@property(nonatomic, strong) UIButton *oneStepLoginButton;      //!< 一键登录
@property(nonatomic, strong) UITextField *phoneNumberTextField; //!< 手机号输入
@property(nonatomic, strong) UIButton *phoneNumberCheckButton;  //!< 号码校验
@property(nonatomic, strong) UITextView *consoleTextView;       //!< 调试输出
@end

@implementation BBTViewController

#pragma mark - Life Circle

- (void)dealloc {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"大汉三通 一键登录演示";
    self.view.backgroundColor = [UIColor whiteColor];
    self.oneStepLoginButton.hidden = NO;
    self.phoneNumberTextField.hidden = NO;
    self.phoneNumberCheckButton.hidden = NO;
    self.consoleTextView.hidden = NO;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [DahantcPhone initializeUser:APPID appKey:APPKEY];
    });
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

#pragma mark - Properties

- (UIButton *)oneStepLoginButton {
    if (!_oneStepLoginButton) {
        _oneStepLoginButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _oneStepLoginButton.layer.cornerRadius = 5;
        _oneStepLoginButton.layer.masksToBounds = YES;
        _oneStepLoginButton.layer.borderWidth = 1;
        _oneStepLoginButton.layer.borderColor = _oneStepLoginButton.tintColor.CGColor;
        [_oneStepLoginButton setTitle:@"一键登录" forState:UIControlStateNormal];
        [_oneStepLoginButton addTarget:self action:@selector(didClickOneStepLoginButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_oneStepLoginButton];
        [_oneStepLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20);
            make.width.mas_equalTo(self.view).offset(-40);
            make.height.mas_equalTo(40);
            make.centerX.mas_equalTo(self.view);
        }];
    }
    return _oneStepLoginButton;
}

- (UITextField *)phoneNumberTextField {
    if (!_phoneNumberTextField) {
        _phoneNumberTextField = [UITextField.alloc init];
        _phoneNumberTextField.placeholder = @"请输入手机号";
        _phoneNumberTextField.keyboardType = UIKeyboardTypeDecimalPad;
        _phoneNumberTextField.borderStyle = UITextBorderStyleRoundedRect;
        _phoneNumberTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self.view addSubview:_phoneNumberTextField];
        [_phoneNumberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.oneStepLoginButton.mas_bottom).offset(50);
            make.width.height.centerX.mas_equalTo(self.oneStepLoginButton);
        }];
    }
    return _phoneNumberTextField;
}

- (UIButton *)phoneNumberCheckButton {
    if (!_phoneNumberCheckButton) {
        _phoneNumberCheckButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _phoneNumberCheckButton.layer.cornerRadius = 5;
        _phoneNumberCheckButton.layer.masksToBounds = YES;
        _phoneNumberCheckButton.layer.borderWidth = 1;
        _phoneNumberCheckButton.layer.borderColor = _phoneNumberCheckButton.tintColor.CGColor;
        [_phoneNumberCheckButton setTitle:@"号码校验" forState:UIControlStateNormal];
        [_phoneNumberCheckButton addTarget:self action:@selector(didClickPhoneNumberCheckButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_phoneNumberCheckButton];
        [_phoneNumberCheckButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.phoneNumberTextField.mas_bottom).offset(10);
            make.width.height.centerX.mas_equalTo(self.phoneNumberTextField);
        }];
    }
    return _phoneNumberCheckButton;
}

- (UITextView *)consoleTextView {
    if (!_consoleTextView) {
        _consoleTextView = [UITextView.alloc init];
        _consoleTextView.backgroundColor = [UIColor colorWithWhite:0 alpha:.05];
        [self.view addSubview:_consoleTextView];
        [_consoleTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(self.view);
            make.top.mas_equalTo(self.phoneNumberCheckButton.mas_bottom).offset(20);
        }];
    }
    return _consoleTextView;
}

#pragma mark - Data & Networking

- (void)getPhone {
    CmccUIModel *uiModel= [CmccUIModel.alloc init];
    uiModel.currentVC = self;
    uiModel.privacyState = true;
    uiModel.logoImg = [UIImage imageNamed:@"DemoResource.bundle/logo"];
    uiModel.navText = [NSAttributedString.alloc initWithString:@"大汉三通"];
    uiModel.sloganText = [NSAttributedString.alloc initWithString:@"大汉三通提供" attributes:@{NSForegroundColorAttributeName:UIColor.whiteColor}];
    
    CtccUIModel *ctccModel = [CtccUIModel.alloc init];
    ctccModel.navText = @"大汉三通";
    ctccModel.logoImg = [UIImage imageNamed:@"DemoResource.bundle/logo"];
    ctccModel.logBtnText = @"一键登录";
    ctccModel.logBtnBackground = 2;
    ctccModel.logBtnImgs = @[[UIImage imageNamed:@"DemoResource.bundle/login.jpg"],
                             [UIImage imageNamed:@"DemoResource.bundle/login.jpg"],
                             [UIImage imageNamed:@"DemoResource.bundle/login.jpg"]];
    
    __weak typeof(self) weakSelf = self;
    [DahantcPhone GetUserPhone:uiModel CtccUIModel:ctccModel phoneListener:^(id listener) {
        [weakSelf log:[NSString stringWithFormat:@"请求结果: %@", listener]];
        
        if([@"success" isEqualToString:listener[@"result"]]){
            NSMutableDictionary *req = [NSMutableDictionary new];
            [req setObject:APPID forKey:@"account"];
            [req setObject:APPKEY.bbt_md5String.lowercaseString forKey:@"password"];
            [req setObject:listener[@"type"]  forKey:@"type"];
            [req setObject:listener[@"msgId"] forKey:@"msgId"];
            [weakSelf log:[NSString stringWithFormat:@"校验取号请求: %@", req]];
            
            [DahantcPhone sendHttp:getPhoneByTokenUrl reqData:req.bbt_JSONString handleResp:^(id rsp) {
                if([@"0" isEqualToString:rsp[@"respCode"]]){
                    [weakSelf log:[NSString stringWithFormat:@"%@%@",@"本机号码:",rsp[@"phone"]]];
                }else{
                    [weakSelf log:[NSString stringWithFormat:@"%@%@",@"未获取到本机号码，原因:",rsp[@"desc"]]];
                }
            }];
        } else {
            NSString *res = [NSString stringWithFormat:@"获取token失败,msg:%@",listener[@"msg"]];
            [weakSelf log:res];
        }
    }];
}

- (void)checkPhoneNumber {
    NSString *phone = self.phoneNumberTextField.text;
    if([@"" isEqualToString:phone]){
        [self log:@"请输入手机号"];
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    [DahantcPhone GetAccessCode :self phoneListener:^(id listener) {
        if([@"success" isEqualToString:listener[@"result"]]){
            NSMutableDictionary *req=[NSMutableDictionary new];
            [req setObject:APPID forKey:@"account"];
            [req setObject:APPKEY.bbt_md5String.lowercaseString forKey:@"password"];
            [req setObject:listener[@"type"]  forKey:@"type"];
            [req setObject:listener[@"msgId"] forKey:@"msgId"];
            [req setObject:phone forKey:@"phone"];
            
            NSString *resStr=[DahantcPhone jsonStringWithDictionary:req];
            NSLog(@"dahantcTest:校验校验请求:%@",resStr);
            [DahantcPhone sendHttp:verifyPhoneUrl reqData:resStr handleResp:^(id rsp){
                [weakSelf log:[NSString stringWithFormat:@"校验响应: %@", [rsp bbt_JSONString]]];
                
                if([@"0" isEqualToString:rsp[@"respCode"]]){
                    if( 0==[rsp[@"isVerify"] intValue]){
                        [weakSelf log:[NSString stringWithFormat:@"%@%@",phone,@" 是本机号码"]];
                    }else{
                        [self log:[NSString stringWithFormat:@"%@%@",phone,@" 不是本机号码"]];
                    }
                    
                }else{
                    [self log:[NSString stringWithFormat:@"%@%@",@"服务端异常:",rsp[@"desc"]]];
                }
            }];
        }else{
            NSString *re=[NSString stringWithFormat:@"获取token失败,msg:%@",listener[@"msg"]];
            [self log:re];
        }
    }];
}

#pragma mark - Layout Subviews

#pragma mark - Public Methods

#pragma mark - Private Methods

- (void)didClickOneStepLoginButton:(id)sender {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    [self getPhone];
}

- (void)didClickPhoneNumberCheckButton:(id)sender {
    NSLog(@"%@, %@", NSStringFromSelector(_cmd), self.phoneNumberTextField.text);
    [self checkPhoneNumber];
}

- (void)log:(id)string {
    NSLog(@"%@", string);
    if ([string isKindOfClass:NSDictionary.class]) {
        string = [string bbt_JSONString];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        self.consoleTextView.text = [self.consoleTextView.text stringByAppendingFormat:@"%@\n\n\n\n", string];
        if (self.consoleTextView.contentSize.height > self.consoleTextView.bounds.size.height) {
            [self.consoleTextView scrollToBottom];
        }
    });
}

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Delegate

#pragma mark - Override

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - Helper Methods

@end
