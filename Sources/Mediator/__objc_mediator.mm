//
//  __objc_mediator.mm
//  Rickenbacker
//
//  Created by Condy on 2021/10/2.
//

#import "__objc_mediator.h"
#import "__objc_msgSend.h"

// 这里为简单起见，用assert处理了所有错误
id __objc_performSelector(NSString *selName, NSString *clsName, NSString *moduleName, NSDictionary<NSString *, id> *params) {
    // 参数检查
    NSCParameterAssert(selName);
    NSCParameterAssert(clsName);
    
    // 获取类名
    NSString *fullClassName = clsName;
    if (moduleName.length > 0) {
        fullClassName = [NSString stringWithFormat: @"%@.%@", moduleName, clsName];
    }
    // 获取类对象
    Class clazz = NSClassFromString(fullClassName);
    // 获取方法函数
    SEL sel = NSSelectorFromString(selName);
    
    NSCAssert(clazz, @"Class not found.");
    NSCAssert(sel, @"SEL not found.");
    
    // 获取目标对象
    id target = [[clazz alloc] init];
    
    NSCAssert([target respondsToSelector: sel], @"Target can not responds to input selector.");
    
    return __objc_msgSend(target, sel, params);
}
