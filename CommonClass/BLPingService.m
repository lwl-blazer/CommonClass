
//
//  BLPingService.m
//  CommonClass
//
//  Created by luowailin on 2019/5/27.
//  Copyright © 2019 blazer. All rights reserved.
//

#import "BLPingService.h"

@interface BLPingService ()

@property (nonatomic,strong) NSMutableDictionary *pingResDic;

@end

@implementation BLPingService

+ (instancetype)sharedManager{
    static BLPingService *pingService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        pingService = [[BLPingService alloc] init];
    });
    return pingService;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

/*
- (void)startPingHost:(NSString *)host packetCount:(int)count resultHandler:(id)handler{
    if (_uPing) {
        _uPing = nil;
        _uPing = [[PhonePing alloc] init];
        
    }else{
        _uPing = [[PhonePing alloc] init];
    }
    _uPing.delegate = self;
    [_uPing startPingHosts:host packetCount:count];
}

- (void)uStopPing{
    [self.uPing stopPing];
}


- (void)addPingResToPingResContainer:(PPingResModel *)pingItem andHost:(NSString *)host
{
    if (host == NULL || pingItem == NULL) {
        return;
    }
    
    NSMutableArray *pingItems = [self.pingResDic objectForKey:host];
    if (pingItems == NULL) {
        pingItems = [NSMutableArray arrayWithArray:@[pingItem]];
    }else{
        [pingItems addObject:pingItem];
        /*
        try {
            [pingItems addObject:pingItem];
        } catch (NSException *exception) {
            log4cplus_warn("PhoneNetPing", "func: %s, exception info: %s , line: %d",__func__,[exception.description UTF8String],__LINE__);
        }*/
    /*}
    
    if (pingItems) {
        [self.pingResDic setObject:pingItems forKey:host];
    }

    
    if (pingItem.status == PhoneNetPingStatusFinished) {
        NSArray *pingItems = [self.pingResDic objectForKey:host];
        NSDictionary *dict = [PPingResModel pingResultWithPingItems:pingItems];

        PReportPingModel *reportPingModel = [PReportPingModel uReporterPingmodelWithDict:dict];
        
        NSString *pingSummary = [NSString stringWithFormat:@"%d packets transmitted , loss:%d , delay:%0.3fms , ttl:%d",reportPingModel.totolPackets,reportPingModel.loss,reportPingModel.delay,reportPingModel.ttl];
        
        NSLog(@"pingSummary:%@", pingSummary);
       // self.pingResultHandler(pingSummary);
        
        [self removePingResFromPingResContainerWithHostName:host];
    }
}

- (void)removePingResFromPingResContainerWithHostName:(NSString *)host
{
    if (host == NULL) {
        return;
    }
    [self.pingResDic removeObjectForKey:host];
}


- (void)pingResultWithUCPing:(PhonePing *)ucPing pingResult:(PPingResModel *)pingRes pingStatus:(PhoneNetPingStatus)status{
    
    */
    /*
    NSString *pingDetail = [NSString stringWithFormat:@"%d bytes form %@: icmp_seq=%d ttl=%d time=%.3fms",(int)pingRes.dateBytesLength,pingRes.IPAddress,(int)pingRes.ICMPSequence,(int)pingRes.timeToLive,pingRes.timeMilliseconds];
    
    switch (status) {
        case PhoneNetPingStatusDidFailToSendPacket:
        case PhoneNetPingStatusDidTimeout:
        case PhoneNetPingStatusError:
            NSLog(@"Error:-----%@", pingDetail);
            break;
        case PhoneNetPingStatusFinished:
            NSLog(@"Finish:-----%@", pingDetail);
            break;
        default:
            NSLog(@"------%@", pingDetail);
            break;
    }
*//*
    [self addPingResToPingResContainer:pingRes andHost:pingRes.IPAddress];
    
    if (status == PhoneNetPingStatusFinished) {
        return;
    }
    
    NSString *pingDetail = [NSString stringWithFormat:@"%d bytes form %@: icmp_seq=%d ttl=%d time=%.3fms",(int)pingRes.dateBytesLength,pingRes.IPAddress,(int)pingRes.ICMPSequence,(int)pingRes.timeToLive,pingRes.timeMilliseconds];
    NSLog(@"pingDetail:%@", pingDetail);
}
*/

@end
