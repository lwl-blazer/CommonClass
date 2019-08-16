//
//  BLPingService.h
//  CommonClass
//
//  Created by luowailin on 2019/5/27.
//  Copyright © 2019 blazer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BLPingService : NSObject

+ (instancetype)sharedManager;

- (void)startPingHost:(NSString *)host packetCount:(int)count resultHandler:(id)handler;

- (void)uStopPing;

@end

NS_ASSUME_NONNULL_END
