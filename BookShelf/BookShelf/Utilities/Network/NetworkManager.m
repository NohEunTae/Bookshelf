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
    [[self.sessionManager GET:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  __nullable responseObject) {
        completionBlock(Success, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionBlock(Fail, nil);
        NSLog(@"[Error] Network Error .... %@", [self class]);
    }] resume];
}

- (void)downloadImageWithUrl:(NSString *)url withCompletionBlock:(void (^)(NetworkResult result, id __nullable data))completionBlock {
    NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    self.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [[self.sessionManager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        if (error == nil) {
            completionBlock(Success, filePath);
        } else {
            completionBlock(Fail, nil);
        }
    }] resume];
}

@end
