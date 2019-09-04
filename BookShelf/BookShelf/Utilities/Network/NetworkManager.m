//
//  NetworkManager.m
//  BookShelf
//
//  Created by user on 30/08/2019.
//  Copyright © 2019 user. All rights reserved.
//

#import "NetworkManager.h"
#import "AFNetwork.h"

@interface NetworkManager ()

@property (nonatomic) AFHTTPSessionManager *sessionManager;

@end

@implementation NetworkManager

#pragma mark Shared Instance NetworkModel

+ (instancetype)sharedInstance {
    static NetworkManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NetworkManager alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        securityPolicy.allowInvalidCertificates = YES;
        securityPolicy.validatesDomainName = NO;
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.securityPolicy = securityPolicy;
    }
    return self;
}

#pragma mark Request

- (void)requestGetWithUrl:(NSString *)url with:(NSArray * __nullable)param withCompletionBlock:(void (^)(NetworkResult result, id __nullable data))completionBlock {
    
    self.sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString *urlString = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

    [[self.sessionManager GET:urlString parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  __nullable responseObject) {
        completionBlock(Success, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionBlock(Fail, nil);
        NSLog(@"[Error] Network Error .... %@", [self class]);
    }] resume];
}

- (void)downloadImageWithUrl:(NSString *)url withCompletionBlock:(void (^)(NetworkResult result, id __nullable data))completionBlock {    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    [[manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completionBlock(Success, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionBlock(Fail, nil);
    }] resume];
}

@end
