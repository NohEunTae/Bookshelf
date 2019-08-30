//
//  Coding.m
//  BookShelf
//
//  Created by user on 30/08/2019.
//  Copyright © 2019 user. All rights reserved.
//

#import "Coding.h"
#import <objc/runtime.h>

@implementation Coding

-(void)encodeWithCoder:(NSCoder *)encoder {
    unsigned int propertyCount = 0;
    objc_property_t * properties = class_copyPropertyList([self class], &propertyCount);
    
    for (int i = 0; i < propertyCount; i++) {
        objc_property_t property = properties[i];
        NSString *p = [NSString stringWithFormat:@"%s", property_getName(property)];
        [encoder encodeObject:[self valueForKey:p] forKey:p];
    }
}

-(instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if(self) {
        unsigned int propertyCount = 0;
        objc_property_t * properties = class_copyPropertyList([self class], &propertyCount);
        
        for (int i = 0; i < propertyCount; i++) {
            objc_property_t property = properties[i];
            NSString *p = [NSString stringWithFormat:@"%s", property_getName(property)];
            id object = [decoder decodeObjectForKey:p];
            
            if (object != nil) {
                [self setValue:[decoder decodeObjectForKey:p] forKey:p];
            }
        }
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if(self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

@end
