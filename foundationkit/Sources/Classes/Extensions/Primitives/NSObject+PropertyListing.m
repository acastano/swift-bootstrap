
#import "NSObject+PropertyListing.h"
#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@implementation NSObject (NSObject_PropertyListing)

- (NSMutableDictionary *)propertiesObject {
   
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    
    unsigned int outCount, i;
    
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    
    for (i = 0; i < outCount; i++) {
    
        objc_property_t property = properties[i];
        
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        
        if (propertyValue) {
        
            props[propertyName] = propertyValue;
        
        }else {
        
            props[propertyName] = [NSNull null];
        
        }
        
    }
    
    free(properties);
    
    return props;
    
}

@end