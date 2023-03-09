//
//  __objc_msgSend.mm
//  Rickenbacker
//
//  Created by Condy on 2021/10/2.
//

#import "__objc_msgSend.h"

// see RxCocoa -> _RxObjCRuntime.m for more information

typedef struct supported_type {
    const char *encoding;
} supported_type_t;

static supported_type_t supported_types[] = {
    { .encoding = @encode(void)},
    { .encoding = @encode(id)},
    { .encoding = @encode(Class)},
    { .encoding = @encode(void (^)(void))},
    { .encoding = @encode(char)},
    { .encoding = @encode(short)},
    { .encoding = @encode(int)},
    { .encoding = @encode(long)},
    { .encoding = @encode(long long)},
    { .encoding = @encode(unsigned char)},
    { .encoding = @encode(unsigned short)},
    { .encoding = @encode(unsigned int)},
    { .encoding = @encode(unsigned long)},
    { .encoding = @encode(unsigned long long)},
    { .encoding = @encode(float)},
    { .encoding = @encode(double)},
    { .encoding = @encode(BOOL)},
    { .encoding = @encode(const char*)},
};

static BOOL __objc_methodReturnTypeIsSupported(const char *type) {
    if (type == nil) {
        return NO;
    }
    
    for (int i = 0; i < sizeof(supported_types) / sizeof(supported_type_t); ++i) {
        if (supported_types[i].encoding[0] != type[0]) {
            continue;
        }
        if (strcmp(supported_types[i].encoding, type) == 0) {
            return YES;
        }
    }
    
    return NO;
}

static id _Nullable __objc_getReturnValue(NSInvocation *inv, NSMethodSignature *sig) {
    
    NSUInteger length = [sig methodReturnLength];
    if (length == 0) return nil;
    
    char *type = (char *)[sig methodReturnType];
    while (*type == 'r' || // const
           *type == 'n' || // in
           *type == 'N' || // inout
           *type == 'o' || // out
           *type == 'O' || // bycopy
           *type == 'R' || // byref
           *type == 'V') { // oneway
        type++; // cutoff useless prefix
    }
    
    if (strcmp(type, @encode(id)) == 0 || strcmp(type, @encode(Class)) == 0 || strcmp(type, @encode(void(^)(void))) == 0) {
        __unsafe_unretained id value = nil;
        [inv getReturnValue:&value];
        return value;
    } else if (strcmp(type, @encode(char)) == 0) {
        char value = 0;
        [inv getReturnValue:&value];
        return @(value);
    } else if (strcmp(type, @encode(short)) == 0) {
        short value = 0;
        [inv getReturnValue:&value];
        return @(value);
    } else if (strcmp(type, @encode(int)) == 0) {
        int value = 0;
        [inv getReturnValue:&value];
        return @(value);
    } else if (strcmp(type, @encode(long)) == 0) {
        long value = 0;
        [inv getReturnValue:&value];
        return @(value);
    } else if (strcmp(type, @encode(long long)) == 0) {
        long long value = 0;
        [inv getReturnValue:&value];
        return @(value);
    } else if (strcmp(type, @encode(unsigned char)) == 0) {
        unsigned char value = 0;
        [inv getReturnValue:&value];
        return @(value);
    } else if (strcmp(type, @encode(unsigned short)) == 0) {
        unsigned short value = 0;
        [inv getReturnValue:&value];
        return @(value);
    } else if (strcmp(type, @encode(unsigned int)) == 0) {
        unsigned int value = 0;
        [inv getReturnValue:&value];
        return @(value);
    }  else if (strcmp(type, @encode(unsigned long)) == 0) {
        unsigned long value = 0;
        [inv getReturnValue:&value];
        return @(value);
    }  else if (strcmp(type, @encode(unsigned long long)) == 0) {
        unsigned long long value = 0;
        [inv getReturnValue:&value];
        return @(value);
    }  else if (strcmp(type, @encode(float)) == 0) {
        float value = 0;
        [inv getReturnValue:&value];
        return @(value);
    }  else if (strcmp(type, @encode(double)) == 0) {
        double value = 0;
        [inv getReturnValue:&value];
        return @(value);
    }  else if (strcmp(type, @encode(BOOL)) == 0) {
        BOOL value = 0;
        [inv getReturnValue:&value];
        return @(value);
    }  else if (strcmp(type, @encode(const char *)) == 0) {
        const char * value = 0;
        [inv getReturnValue:&value];
        return @(value);
    } else {
        NSUInteger size = 0;
        NSGetSizeAndAlignment(type, &size, NULL);
        NSCParameterAssert(size > 0);
        uint8_t data[size];
        [inv getReturnValue:&data];
        return [NSValue valueWithBytes:&data objCType:type];
    }
}

id __objc_msgSend(id target, SEL selector, NSDictionary<NSString *, id> * arguments) {
    // 校验
    NSMethodSignature *signature = [target methodSignatureForSelector:selector];
    
    NSCAssert(signature, @"Method signature does not exists.");
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    NSCAssert(invocation, @"Invocation does not exists.");
    
    NSCAssert(__objc_methodReturnTypeIsSupported(signature.methodReturnType), @"Method return type is unsupported");
    
    // 符合预期
    invocation.target = target;
    invocation.selector = selector;
    if (arguments) { [invocation setArgument:&arguments atIndex:2]; /** skip self & _cmd */ }
    
    [invocation invoke];
    
    return __objc_getReturnValue(invocation, signature);
}
