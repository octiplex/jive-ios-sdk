//
//  JivePeopleRequestOptionsTests.m
//  jive-ios-sdk
//
//  Created by Orson Bushnell on 11/29/12.
//  Copyright (c) 2012 Jive Software. All rights reserved.
//

#import "JivePeopleRequestOptionsTests.h"

@implementation JivePeopleRequestOptionsTests

- (JivePeopleRequestOptions *)peopleOptions {
    
    return (JivePeopleRequestOptions *)self.options;
}

- (void)setUp {
    
    self.options = [[JivePeopleRequestOptions alloc] init];
}

- (void)testTitle {
    
    self.peopleOptions.title = @"Head Honcho";
    
    NSString *asString = [self.options toQueryString];
    
    STAssertNotNil(asString, @"Invalid string returned");
    STAssertEqualObjects(@"filter=title(Head Honcho)", asString, @"Wrong string contents");
    
    self.peopleOptions.title = @"grunt";
    asString = [self.options toQueryString];
    STAssertNotNil(asString, @"Invalid string returned");
    STAssertEqualObjects(@"filter=title(grunt)", asString, @"Wrong string contents");
}

- (void)testTitleWithFields {
    
    self.peopleOptions.title = @"Head Honcho";
    [self.peopleOptions addField:@"name"];
    
    NSString *asString = [self.options toQueryString];
    
    STAssertNotNil(asString, @"Invalid string returned");
    STAssertEqualObjects(@"fields=name&filter=title(Head Honcho)", asString, @"Wrong string contents");

    [self.peopleOptions addTag:@"dm"];
    asString = [self.options toQueryString];
    STAssertNotNil(asString, @"Invalid string returned");
    STAssertEqualObjects(@"fields=name&filter=tag(dm)&filter=title(Head Honcho)", asString, @"Wrong string contents");
}

- (void)testDepartment {
    
    self.peopleOptions.department = @"Engineering";
    
    NSString *asString = [self.options toQueryString];
    
    STAssertNotNil(asString, @"Invalid string returned");
    STAssertEqualObjects(@"filter=department(Engineering)", asString, @"Wrong string contents");
    
    self.peopleOptions.department = @"Human Resources";
    asString = [self.options toQueryString];
    STAssertNotNil(asString, @"Invalid string returned");
    STAssertEqualObjects(@"filter=department(Human Resources)", asString, @"Wrong string contents");
}

- (void)testDepartmentWithFields {
    
    self.peopleOptions.department = @"Engineering";
    [self.peopleOptions addField:@"name"];
    
    NSString *asString = [self.options toQueryString];
    
    STAssertNotNil(asString, @"Invalid string returned");
    STAssertEqualObjects(@"fields=name&filter=department(Engineering)", asString, @"Wrong string contents");
    
    [self.peopleOptions addTag:@"dm"];
    asString = [self.options toQueryString];
    STAssertNotNil(asString, @"Invalid string returned");
    STAssertEqualObjects(@"fields=name&filter=tag(dm)&filter=department(Engineering)", asString, @"Wrong string contents");
    
    self.peopleOptions.title = @"Head Honcho";
    asString = [self.options toQueryString];
    STAssertNotNil(asString, @"Invalid string returned");
    STAssertEqualObjects(@"fields=name&filter=tag(dm)&filter=title(Head Honcho)&filter=department(Engineering)", asString, @"Wrong string contents");
}

- (void)testLocation {
    
    self.peopleOptions.location = @"Portland";
    
    NSString *asString = [self.options toQueryString];
    
    STAssertNotNil(asString, @"Invalid string returned");
    STAssertEqualObjects(@"filter=location(Portland)", asString, @"Wrong string contents");
    
    self.peopleOptions.location = @"Boulder";
    asString = [self.options toQueryString];
    STAssertNotNil(asString, @"Invalid string returned");
    STAssertEqualObjects(@"filter=location(Boulder)", asString, @"Wrong string contents");
}

- (void)testLocationWithFields {
    
    self.peopleOptions.location = @"Portland";
    [self.peopleOptions addField:@"name"];
    
    NSString *asString = [self.options toQueryString];
    
    STAssertNotNil(asString, @"Invalid string returned");
    STAssertEqualObjects(@"fields=name&filter=location(Portland)", asString, @"Wrong string contents");
    
    [self.peopleOptions addTag:@"dm"];
    asString = [self.options toQueryString];
    STAssertNotNil(asString, @"Invalid string returned");
    STAssertEqualObjects(@"fields=name&filter=tag(dm)&filter=location(Portland)", asString, @"Wrong string contents");
    
    self.peopleOptions.department = @"Engineering";
    asString = [self.options toQueryString];
    STAssertNotNil(asString, @"Invalid string returned");
    STAssertEqualObjects(@"fields=name&filter=tag(dm)&filter=department(Engineering)&filter=location(Portland)", asString, @"Wrong string contents");
}

- (void)testCompany {
    
    self.peopleOptions.company = @"Jive";
    
    NSString *asString = [self.options toQueryString];
    
    STAssertNotNil(asString, @"Invalid string returned");
    STAssertEqualObjects(@"filter=company(Jive)", asString, @"Wrong string contents");
    
    self.peopleOptions.company = @"Amex";
    asString = [self.options toQueryString];
    STAssertNotNil(asString, @"Invalid string returned");
    STAssertEqualObjects(@"filter=company(Amex)", asString, @"Wrong string contents");
}

- (void)testCompanyWithFields {
    
    self.peopleOptions.company = @"Jive";
    [self.peopleOptions addField:@"name"];
    
    NSString *asString = [self.options toQueryString];
    
    STAssertNotNil(asString, @"Invalid string returned");
    STAssertEqualObjects(@"fields=name&filter=company(Jive)", asString, @"Wrong string contents");
    
    [self.peopleOptions addTag:@"dm"];
    asString = [self.options toQueryString];
    STAssertNotNil(asString, @"Invalid string returned");
    STAssertEqualObjects(@"fields=name&filter=tag(dm)&filter=company(Jive)", asString, @"Wrong string contents");
    
    self.peopleOptions.location = @"Portland";
    asString = [self.options toQueryString];
    STAssertNotNil(asString, @"Invalid string returned");
    STAssertEqualObjects(@"fields=name&filter=tag(dm)&filter=location(Portland)&filter=company(Jive)", asString, @"Wrong string contents");
}

- (void)testOffice {
    
    self.peopleOptions.office = @"PDX";
    
    NSString *asString = [self.options toQueryString];
    
    STAssertNotNil(asString, @"Invalid string returned");
    STAssertEqualObjects(@"filter=office(PDX)", asString, @"Wrong string contents");
    
    self.peopleOptions.office = @"Jiverado";
    asString = [self.options toQueryString];
    STAssertNotNil(asString, @"Invalid string returned");
    STAssertEqualObjects(@"filter=office(Jiverado)", asString, @"Wrong string contents");
}

- (void)testOfficeWithFields {
    
    self.peopleOptions.office = @"PDX";
    [self.peopleOptions addField:@"name"];
    
    NSString *asString = [self.options toQueryString];
    
    STAssertNotNil(asString, @"Invalid string returned");
    STAssertEqualObjects(@"fields=name&filter=office(PDX)", asString, @"Wrong string contents");
    
    [self.peopleOptions addTag:@"dm"];
    asString = [self.options toQueryString];
    STAssertNotNil(asString, @"Invalid string returned");
    STAssertEqualObjects(@"fields=name&filter=tag(dm)&filter=office(PDX)", asString, @"Wrong string contents");
    
    self.peopleOptions.company = @"Jive";
    asString = [self.options toQueryString];
    STAssertNotNil(asString, @"Invalid string returned");
    STAssertEqualObjects(@"fields=name&filter=tag(dm)&filter=company(Jive)&filter=office(PDX)", asString, @"Wrong string contents");
}

- (void)testDateRange {
    
    self.peopleOptions.hiredAfter = [NSDate dateWithTimeIntervalSince1970:0];
    
    NSString *asString = [self.options toQueryString];
    
    STAssertNil(asString, @"Invalid string returned");
    
    self.peopleOptions.hiredBefore = [NSDate dateWithTimeIntervalSince1970:1000];
    asString = [self.options toQueryString];
    STAssertNotNil(asString, @"Invalid string returned");
    STAssertEqualObjects(@"filter=hire-date(1970-01-01 00:00:00 +0000,1970-01-01 00:16:40 +0000)", asString, @"Wrong string contents");

    self.peopleOptions.hiredAfter = [NSDate dateWithTimeIntervalSince1970:1001];
    asString = [self.options toQueryString];
    STAssertNil(asString, @"Invalid string returned");
    
    self.peopleOptions.hiredAfter = nil;
    asString = [self.options toQueryString];
    STAssertNil(asString, @"Invalid string returned");
}

- (void)testDateRangeWithFields {
    
    self.peopleOptions.hiredAfter = [NSDate dateWithTimeIntervalSince1970:0];
    self.peopleOptions.hiredBefore = [NSDate dateWithTimeIntervalSince1970:1000];
    [self.peopleOptions addField:@"name"];
    
    NSString *asString = [self.options toQueryString];
    
    STAssertNotNil(asString, @"Invalid string returned");
    STAssertEqualObjects(@"fields=name&filter=hire-date(1970-01-01 00:00:00 +0000,1970-01-01 00:16:40 +0000)", asString, @"Wrong string contents");
    
    [self.peopleOptions addTag:@"dm"];
    asString = [self.options toQueryString];
    STAssertNotNil(asString, @"Invalid string returned");
    STAssertEqualObjects(@"fields=name&filter=tag(dm)&filter=hire-date(1970-01-01 00:00:00 +0000,1970-01-01 00:16:40 +0000)", asString, @"Wrong string contents");
    
    self.peopleOptions.office = @"PDX";
    asString = [self.options toQueryString];
    STAssertNotNil(asString, @"Invalid string returned");
    STAssertEqualObjects(@"fields=name&filter=tag(dm)&filter=office(PDX)&filter=hire-date(1970-01-01 00:00:00 +0000,1970-01-01 00:16:40 +0000)", asString, @"Wrong string contents");
}

- (void)testIDs {
    
    [self.peopleOptions addID:@"1005"];
    
    NSString *asString = [self.options toQueryString];
    
    STAssertNotNil(asString, @"Invalid string returned");
    STAssertEqualObjects(@"ids=1005", asString, @"Wrong string contents");
    
    [self.peopleOptions addID:@"54321"];
    asString = [self.options toQueryString];
    STAssertNotNil(asString, @"Invalid string returned");
    STAssertEqualObjects(@"ids=1005,54321", asString, @"Wrong string contents");
}

- (void)testIDsWithOtherOptions {
    
    [self.peopleOptions addID:@"1005"];
    [self.peopleOptions addField:@"name"];
    
    NSString *asString = [self.options toQueryString];
    
    STAssertNotNil(asString, @"Invalid string returned");
    STAssertEqualObjects(@"fields=name&ids=1005", asString, @"Wrong string contents");
    
    [self.peopleOptions addTag:@"dm"];
    asString = [self.options toQueryString];
    STAssertNotNil(asString, @"Invalid string returned");
    STAssertEqualObjects(@"fields=name&filter=tag(dm)&ids=1005", asString, @"Wrong string contents");
}

- (void)testQuery {
    
    self.peopleOptions.query = @"search term";
    
    NSString *asString = [self.options toQueryString];
    
    STAssertNotNil(asString, @"Invalid string returned");
    STAssertEqualObjects(@"query=search term", asString, @"Wrong string contents");
    
    self.peopleOptions.query = @"alternate search";
    asString = [self.options toQueryString];
    STAssertNotNil(asString, @"Invalid string returned");
    STAssertEqualObjects(@"query=alternate search", asString, @"Wrong string contents");
}

- (void)testQueryWithFields {
    
    self.peopleOptions.query = @"search term";
    [self.peopleOptions addField:@"name"];
    
    NSString *asString = [self.options toQueryString];
    
    STAssertNotNil(asString, @"Invalid string returned");
    STAssertEqualObjects(@"fields=name&query=search term", asString, @"Wrong string contents");
    
    [self.peopleOptions addTag:@"dm"];
    asString = [self.options toQueryString];
    STAssertNotNil(asString, @"Invalid string returned");
    STAssertEqualObjects(@"fields=name&filter=tag(dm)&query=search term", asString, @"Wrong string contents");
    
    [self.peopleOptions addID:@"1005"];
    asString = [self.options toQueryString];
    STAssertNotNil(asString, @"Invalid string returned");
    STAssertEqualObjects(@"fields=name&filter=tag(dm)&ids=1005&query=search term", asString, @"Wrong string contents");
}

@end
