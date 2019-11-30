//
//  EAccountOpenAuthModel.h
//  EAccountSDK
//
//  Created by 陈永怀 on 2019/4/13.
//  Copyright © 2019年 陈永怀. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN



@interface CtccUIModel : NSObject

/*----------------------------------------登录界面配置-----------------------------------*/

/*----------------------------导航栏配置---------------------------------------*/


/**导航栏颜色*/
@property (nonatomic,strong) UIColor *navColor;

/**导航栏标题*/
@property (nonatomic,copy)  NSString *navText;
/**导航栏标题字体大小*/
@property (nonatomic,assign) CGFloat navTextSize;
/**导航栏标题颜色*/
@property (nonatomic,strong) UIColor *navTextColor;


/*----------------------------logo配置-------------------------------------*/

/**LOGO图片*/
@property (nonatomic,strong) UIImage *logoImg;

/**登录按钮文本*/
@property (nonatomic,strong) NSString *logBtnText;

/**登录按钮Y偏移量*/
@property (nonatomic,assign) CGFloat logBtnOffsetY;
/**登录按钮文本颜色*/
@property (nonatomic,strong) UIColor *logBtnTextColor;

/**登录按钮宽度*/
@property (nonatomic,assign) CGFloat logBtnWidth;
/**登录按钮高度
 若需单独修改登录按钮的高度，宽度logBtnWidth不传值或者传0即可
 */
@property (nonatomic,assign) CGFloat logBtnHeight;

/**登录按钮字体大小*/
@property (nonatomic,assign) CGFloat logBtnTextSize;

/**
 * 登录按钮的背景 可选设置为背景颜色、背景图片，若不传值即为默认，即选择使用xib默认背景
 * 选择使用默认背景 0 （与不传值相同）
 * 选择使用背景颜色 1
 * 选择使用背景图片 2
 */
@property (nonatomic, assign) NSUInteger logBtnBackground;

/**登录按钮圆角设置*/
@property (nonatomic,assign) CGFloat logBtnCornerRadius;

/**登录按钮背景颜色 正常*/
@property (nonatomic,strong) UIColor *logBtnBgColor_normal;

/**登录按钮背景颜色 不可按状态*/
@property (nonatomic,strong) UIColor *logBtnBgColor_disable;

/**登录按钮背景颜色 按下高亮*/
@property (nonatomic,strong) UIColor *logBtnBgColor_highlighted;

/**登录按钮背景图片添加到数组(顺序如下)
 @[激活状态的图片,不可按状态的图片,高亮状态的图片]
 */
@property (nonatomic,strong) NSArray *logBtnImgs;


/**隐私协议标签完整文字
 如: 登录即同意《天翼账号服务与隐私协议》与《自定义协议》并授权[应用名]获本机号码
 注意： 1.文案的前面部分“登录即同意《天翼账号服务与隐私协议》”不允许修改，具体按设计规范设置
 2.[应用名]必须替换为具体的app名字
 */
@property (nonatomic,strong) NSString *PALabelText;
/**隐私协议标签字体大小*/
@property (nonatomic,assign) CGFloat PALabelTextSize;
/**隐私协议标签字体行间距*/
@property (nonatomic,assign) CGFloat PALabelTextLineSpacing;

/**天翼账号隐私协议名称的起始位置 （用于修改协议名称的颜色 下同）
 如: 《天翼账号服务与隐私协议》在完整的协议文字中的起始位置是 5
 */
@property (nonatomic, assign) NSUInteger EAStartIndex;
/**天翼账号隐私协议名称的结束位置
 如: 《天翼账号服务与隐私协议》在完整的协议文字中的结束位置是 17
 */
@property (nonatomic, assign) NSUInteger EAEndIndex;

/**合作方隐私协议名称的起始位置
 如: 《自定义协议》在完整的协议文字中的起始位置是 19
 */
@property (nonatomic, assign) NSUInteger pStartIndex;
/**合作方隐私协议名称的结束位置
 如: 《自定义协议》在完整的协议文字中的结束位置是 25
 */
@property (nonatomic, assign) NSUInteger pEndIndex;
/**隐私协议标签上的其他文字的颜色
 除了隐私协议名称的其他文字的颜色
 */
@property (nonatomic,strong) UIColor *PALabelOtherTextColor;
/**隐私协议名称的颜色*/
@property (nonatomic,strong) UIColor *PANameColor;

/**合作方用户协议URL
 合作方可传入用户协议的URL，用户点击协议后，SDK加载打开协议页面
 */
@property (nonatomic, copy) NSString *PAUrl;

/**勾选按钮Y偏移量
 该控件底部（bottom）相对于屏幕（safeArea）底部（bottom）的距离
 */
@property (nonatomic,assign) CGFloat checkBtnOffsetY;
/**隐私协议标签Y偏移量
 该控件底部（bottom）相对于屏幕（safeArea）底部（bottom）的距离
 */
@property (nonatomic,assign) CGFloat PALabelOffsetY;
@end

NS_ASSUME_NONNULL_END
