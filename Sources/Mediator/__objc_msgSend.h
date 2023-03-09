//
//  __objc_msgSend.h
//  Rickenbacker
//
//  Created by Condy on 2021/10/2.
//

#import <Foundation/Foundation.h>

/**
 Sends a specified message to the receiver and returns the result of the message.

 @param target The receiver
 @param selector A selector identifying the message to send
 @param arguments Parameters type must correspond to the selector's method declaration
 @return An object that is the result of the message.
 @discussion The selector's return value will be wrap as NSNumber or NSValue
             if the selector's `return type` is not object. It always returns nil
             if the selector's `return type` is void.
 */
FOUNDATION_EXTERN
id _Nullable __objc_msgSend(id _Nonnull target, SEL _Nonnull selector, NSDictionary<NSString *, id> * _Nullable arguments);
