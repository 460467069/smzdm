//
//  YYBBDateFormatterFactory.h
//  GitHub Community
//
//  Created by Douglas Fischer on 4/20/13.
//  Copyright (c) 2013 XT3 Studios. All rights reserved.
//

@interface YYBBDateFormatterFactory : NSObject {
    
    NSCache *loadedDataFormatters;
    
}

+ (YYBBDateFormatterFactory *)sharedFactory;
- (NSDateFormatter *)dateFormatterWithFormat:(NSString *)format andLocale:(NSLocale *)locale;
- (NSDateFormatter *)dateFormatterWithFormat:(NSString *)format andLocaleIdentifier:(NSString *)localeIdentifier;
- (NSDateFormatter *)dateFormatterWithFormat:(NSString *)format;

- (NSDateFormatter *)dateFormatterWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle andLocale:(NSLocale *)locale;
- (NSDateFormatter *)dateFormatterWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle andLocaleIdentifier:(NSString *)localeIdentifier;
- (NSDateFormatter *)dateFormatterWithDateStyle:(NSDateFormatterStyle)dateStyle andTimeStyle:(NSDateFormatterStyle)timeStyle;

@end
