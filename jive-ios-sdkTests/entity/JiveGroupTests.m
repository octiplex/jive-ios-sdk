//
//  JiveGroupTests.m
//  jive-ios-sdk
//
//  Created by Orson Bushnell on 12/28/12.
//  Copyright (c) 2012 Jive Software. All rights reserved.
//

#import "JiveGroupTests.h"
#import "JivePerson.h"

@implementation JiveGroupTests

- (void)setUp {
    self.place = [[JiveGroup alloc] init];
}

- (JiveGroup *)group {
    return (JiveGroup *)self.place;
}

- (void)testTaskToJSON {
    JivePerson *creator = [[JivePerson alloc] init];
    NSString *tag = @"wordy";
    NSDictionary *JSON = [self.group toJSONDictionary];
    
    STAssertTrue([[JSON class] isSubclassOfClass:[NSDictionary class]], @"Generated JSON has the wrong class");
    STAssertEquals([JSON count], (NSUInteger)1, @"Initial dictionary is not empty");
    STAssertEqualObjects([JSON objectForKey:@"type"], @"group", @"Wrong type");
    
    creator.displayName = @"Harold";
    [self.group setValue:creator forKey:@"creator"];
    self.group.groupType = @"OPEN";
    [self.group setValue:[NSNumber numberWithInt:1] forKey:@"memberCount"];
    [self.group setValue:[NSArray arrayWithObject:tag] forKey:@"tags"];
    
    JSON = [self.group toJSONDictionary];
    
    STAssertTrue([[JSON class] isSubclassOfClass:[NSDictionary class]], @"Generated JSON has the wrong class");
    STAssertEquals([JSON count], (NSUInteger)5, @"Initial dictionary had the wrong number of entries");
    STAssertEqualObjects([JSON objectForKey:@"type"], self.group.type, @"Wrong type");
    STAssertEqualObjects([JSON objectForKey:@"groupType"], self.group.groupType, @"Wrong groupType");
    STAssertEqualObjects([JSON objectForKey:@"memberCount"], self.group.memberCount, @"Wrong memberCount");
    
    NSArray *tagsJSON = [JSON objectForKey:@"tags"];
    
    STAssertTrue([[tagsJSON class] isSubclassOfClass:[NSArray class]], @"Jive not converted");
    STAssertEquals([tagsJSON count], (NSUInteger)1, @"Jive dictionary had the wrong number of entries");
    STAssertEqualObjects([tagsJSON objectAtIndex:0], tag, @"Wrong value");
    
    NSDictionary *creatorJSON = [JSON objectForKey:@"creator"];
    
    STAssertTrue([[creatorJSON class] isSubclassOfClass:[NSDictionary class]], @"Jive not converted");
    STAssertEquals([creatorJSON count], (NSUInteger)1, @"Jive dictionary had the wrong number of entries");
    STAssertEqualObjects([creatorJSON objectForKey:@"displayName"], creator.displayName, @"Wrong value");
}

- (void)testTaskToJSON_alternate {
    JivePerson *creator = [[JivePerson alloc] init];
    NSString *tag = @"concise";
    
    creator.displayName = @"Maud";
    [self.group setValue:creator forKey:@"creator"];
    self.group.groupType = @"PRIVATE";
    [self.group setValue:[NSNumber numberWithInt:102] forKey:@"memberCount"];
    [self.group setValue:[NSArray arrayWithObject:tag] forKey:@"tags"];
    
    NSDictionary *JSON = [self.group toJSONDictionary];
    
    STAssertTrue([[JSON class] isSubclassOfClass:[NSDictionary class]], @"Generated JSON has the wrong class");
    STAssertEquals([JSON count], (NSUInteger)5, @"Initial dictionary had the wrong number of entries");
    STAssertEqualObjects([JSON objectForKey:@"type"], self.group.type, @"Wrong type");
    STAssertEqualObjects([JSON objectForKey:@"groupType"], self.group.groupType, @"Wrong groupType");
    STAssertEqualObjects([JSON objectForKey:@"memberCount"], self.group.memberCount, @"Wrong memberCount");
    
    NSArray *tagsJSON = [JSON objectForKey:@"tags"];
    
    STAssertTrue([[tagsJSON class] isSubclassOfClass:[NSArray class]], @"Jive not converted");
    STAssertEquals([tagsJSON count], (NSUInteger)1, @"Jive dictionary had the wrong number of entries");
    STAssertEqualObjects([tagsJSON objectAtIndex:0], tag, @"Wrong value");
    
    NSDictionary *creatorJSON = [JSON objectForKey:@"creator"];
    
    STAssertTrue([[creatorJSON class] isSubclassOfClass:[NSDictionary class]], @"Jive not converted");
    STAssertEquals([creatorJSON count], (NSUInteger)1, @"Jive dictionary had the wrong number of entries");
    STAssertEqualObjects([creatorJSON objectForKey:@"displayName"], creator.displayName, @"Wrong value");
}

- (void)testPostParsing {
    JivePerson *creator = [[JivePerson alloc] init];
    NSString *tag = @"wordy";
    
    creator.displayName = @"Harold";
    [self.group setValue:creator forKey:@"creator"];
    self.group.groupType = @"OPEN";
    [self.group setValue:[NSNumber numberWithInt:1] forKey:@"memberCount"];
    [self.group setValue:[NSArray arrayWithObject:tag] forKey:@"tags"];
    
    id JSON = [self.group toJSONDictionary];
    JiveGroup *newPlace = [JiveGroup instanceFromJSON:JSON];
    
    STAssertTrue([[newPlace class] isSubclassOfClass:[self.group class]], @"Wrong item class");
    STAssertEqualObjects(newPlace.type, self.group.type, @"Wrong type");
    STAssertEqualObjects(newPlace.groupType, self.group.groupType, @"Wrong groupType");
    STAssertEqualObjects(newPlace.memberCount, self.group.memberCount, @"Wrong memberCount");
    STAssertEquals([newPlace.tags count], [self.group.tags count], @"Wrong number of tags");
    STAssertEqualObjects([newPlace.tags objectAtIndex:0], tag, @"Wrong tag");
    STAssertEqualObjects(newPlace.creator.displayName, creator.displayName, @"Wrong creator displayName");
}

- (void)testPostParsingAlternate {
    JivePerson *creator = [[JivePerson alloc] init];
    NSString *tag = @"concise";
    
    creator.displayName = @"Maud";
    [self.group setValue:creator forKey:@"creator"];
    self.group.groupType = @"PRIVATE";
    [self.group setValue:[NSNumber numberWithInt:102] forKey:@"memberCount"];
    [self.group setValue:[NSArray arrayWithObject:tag] forKey:@"tags"];
    
    id JSON = [self.group toJSONDictionary];
    JiveGroup *newPlace = [JiveGroup instanceFromJSON:JSON];
    
    STAssertTrue([[newPlace class] isSubclassOfClass:[self.group class]], @"Wrong item class");
    STAssertEqualObjects(newPlace.type, self.group.type, @"Wrong type");
    STAssertEqualObjects(newPlace.groupType, self.group.groupType, @"Wrong groupType");
    STAssertEqualObjects(newPlace.memberCount, self.group.memberCount, @"Wrong memberCount");
    STAssertEquals([newPlace.tags count], [self.group.tags count], @"Wrong number of tags");
    STAssertEqualObjects([newPlace.tags objectAtIndex:0], tag, @"Wrong tag");
    STAssertEqualObjects(newPlace.creator.displayName, creator.displayName, @"Wrong creator displayName");
}

@end
