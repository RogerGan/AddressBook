//
//  LoginViewController.m
//  AddressBook
//
//  Created by gancj on 15/4/28.
//  Copyright (c) 2015年 gancj. All rights reserved.
//

#import "LoginViewController.h"
#import "ContactTableViewController.h"
#import "MBProgressHUD+MJ.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UISwitch *rembSwitch;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
- (IBAction)loginAction;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //需要用到观察者模式来检查是否有输入账号及密码
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.nameField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.pwdField];
    
}

- (void)textChange{
    /*
    if (self.nameField.text.length && self.pwdField.text.length) {
        self.loginBtn.enabled = YES;
    }else{
        self.loginBtn.enabled = NO;
    }
    */
    //等价于
    self.loginBtn.enabled = (self.nameField.text.length && self.pwdField.text.length);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // 1.Get the new view controller using [segue destinationViewController].
    // 2.Pass the selected object to the new view controller.
    // 1.取得目标控制器
    UIViewController *contactVc = segue.destinationViewController;
    // 2.设置标题（传值）
    contactVc.title = [NSString stringWithFormat:@"%@的联系人列表", self.nameField.text];
    
}

//登录
- (IBAction)loginAction {
    if (![self.nameField.text isEqualToString:@"jike"]) {
        [MBProgressHUD showError:@"账号不存在"];
    }
    if (![self.pwdField.text isEqualToString:@"qq"]) {
        [MBProgressHUD showError:@"密码错误"];
    }
    //显示萌版（遮盖）
    [MBProgressHUD showMessage:@"努力加载中"];
    //模拟2秒后跳转，以后要发送网络请求
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int16_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //取消遮盖
        [MBProgressHUD hideHUD];
        [self performSegueWithIdentifier:@"LoginToContact" sender:nil];
    });
}
@end
