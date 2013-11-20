//
//  JivePlatformVersion.m
//  jive-ios-sdk
//
//  Created by Orson Bushnell on 4/10/13.
//
//    Copyright 2013 Jive Software Inc.
//    Licensed under the Apache License, Version 2.0 (the "License");
//    you may not use this file except in compliance with the License.
//    You may obtain a copy of the License at
//    http://www.apache.org/licenses/LICENSE-2.0
//
//    Unless required by applicable law or agreed to in writing, software
//    distributed under the License is distributed on an "AS IS" BASIS,
//    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//    See the License for the specific language governing permissions and
//    limitations under the License.
//

#import "JivePlatformVersion.h"
#import "JiveObject_internal.h"
#import "JiveCoreVersion.h"
#import <JiveCommon/NSString+JVCommonAdditions.h>

struct JivePlatformVersionAttributes const JivePlatformVersionAttributes = {
	.major = @"major",
	.minor = @"minor",
	.maintenance = @"maintenance",
	.build = @"build",
	.releaseID = @"releaseID",
	.coreURI = @"coreURI",
    .ssoEnabled = @"ssoEnabled",
    .sdk = @"sdk"
};

static NSString * const JiveVersionKey = @"jiveVersion";
static NSString * const JiveCoreVersionsKey = @"jiveCoreVersions";

typedef NS_ENUM(NSInteger, JiveVersionString) {
    JiveVersionStringVersionComponents = 0,
    JiveVersionStringReleaseID
};

typedef NS_ENUM(NSInteger, JiveVersionComponents) {
    JiveVersionComponentsMajor = 0,
    JiveVersionComponentsMinor,
    JiveVersionComponentsMaintenance,
    JiveVersionComponentsBuild
};

struct JVSemanticVersion {
    NSUInteger majorVersion;
    NSUInteger minorVersion;
    NSUInteger maintenanceVersion;
};
typedef struct JVSemanticVersion JVSemanticVersion;

static inline JVSemanticVersion JVSemanticVersionMake(NSUInteger majorVersion,
                                                      NSUInteger minorVersion,
                                                      NSUInteger maintenanceVersion) {
    JVSemanticVersion semanticVersion;
    semanticVersion.majorVersion = majorVersion;
    semanticVersion.minorVersion = minorVersion;
    semanticVersion.maintenanceVersion = maintenanceVersion;
    return semanticVersion;
}

@implementation JivePlatformVersion

@synthesize ssoEnabled;

- (void)parseVersion:(NSString *)versionString {
    NSArray *components = [versionString componentsSeparatedByString:@" "];
    
    if ([components count] == 2)
        [self setValue:components[JiveVersionStringReleaseID] forKey:JivePlatformVersionAttributes.releaseID];
    
    components = [components[JiveVersionStringVersionComponents] componentsSeparatedByString:@"."];
    [self setValue:@([components[JiveVersionComponentsMajor] integerValue])
            forKey:JivePlatformVersionAttributes.major];
    [self setValue:@([components[JiveVersionComponentsMinor] integerValue])
            forKey:JivePlatformVersionAttributes.minor];
    if ([components count] > JiveVersionComponentsMaintenance) {
        [self setValue:@([components[JiveVersionComponentsMaintenance] integerValue])
                forKey:JivePlatformVersionAttributes.maintenance];
        if ([components count] > JiveVersionComponentsBuild)
            [self setValue:@([components[JiveVersionComponentsBuild] integerValue])
                    forKey:JivePlatformVersionAttributes.build];
    }
}

+ (JivePlatformVersion*) instanceFromJSON:(NSDictionary*) JSON {
    JivePlatformVersion *instance = [JivePlatformVersion new];
    NSInteger requiredElementsFound = 0;
    
    for (NSString *key in JSON) {
        if ([JiveVersionKey isEqualToString:key]) {
            [instance parseVersion:JSON[key]];
            ++requiredElementsFound;
        }
        else if ([JiveCoreVersionsKey isEqualToString:key]) {
            NSArray *coreURIs = [JiveCoreVersion instancesFromJSONList:JSON[key]];
            
            [instance setValue:coreURIs forKey:JivePlatformVersionAttributes.coreURI];
            ++requiredElementsFound;
        }
        else
            [instance deserializeKey:key fromJSON:JSON];
    }
    
    return requiredElementsFound == 2 ? instance : nil;
}

- (NSString *)sdk {
    return // The following include is generated by the build server
#include "JiveiOSSDKVersion.h"
    ;
}

#pragma mark - Version checks

/** Version checks rely on both the semantic version of the platform or the release ID of the platform. For example, cloud platform development for Jive 7 will
 use the semantic version of 7.0.0 during development. However, release IDs will also be assigned to the platform version, e.g. 7c3 for Samurai. For on-prem
 and hosted platforms a simple check on the semantic version will be enough.
 
 In order to specify feature support, for example, for development in Samurai that will also be ported to 6.0.3, you would need to check for the semantic version
 6.0.3 and also for the release IDs for Samurai and above.
 */

- (BOOL)supportsFeatureAvailableWithSemanticVersion:(JVSemanticVersion)version {
    return [self supportsFeatureAvailableWithMajorVersion:version.majorVersion
                                                minorVersion:version.minorVersion
                                          maintenanceVersion:version.maintenanceVersion];
}

- (BOOL)supportsFeatureAvailableWithMajorVersion:(NSUInteger)majorVersion
                                       minorVersion:(NSUInteger)minorVersion
                                 maintenanceVersion:(NSUInteger)maintenanceVersion {
    BOOL supported = YES;
    
    // confirm the semantic version is supported
    if (majorVersion > [self.major unsignedIntegerValue]) {
        supported = NO;
    } else if (majorVersion == [self.major unsignedIntegerValue]) {
        if (minorVersion > [self.minor unsignedIntegerValue]) {
            supported = NO;
        } else if (minorVersion == [self.minor unsignedIntegerValue]) {
            if (maintenanceVersion > [self.maintenance unsignedIntegerValue]) {
                supported = NO;
            }
        }
    }
    return supported;
}

#pragma mark - Public API

- (BOOL)supportsDraftPostCreation {
    JVSemanticVersion supportedJiveVersion = JVSemanticVersionMake(6, 0, 3);
    return [self supportsFeatureAvailableWithSemanticVersion:supportedJiveVersion];
}

- (BOOL)supportsDraftPostContentFilter {
    JVSemanticVersion supportedJiveVersion = JVSemanticVersionMake(6, 0, 3);
    return [self supportsFeatureAvailableWithSemanticVersion:supportedJiveVersion];
}

- (BOOL)supportsExplicitSSO {
    // https://jira.jivesoftware.com/browse/JIVE-21305
    JVSemanticVersion supportedJiveVersion = JVSemanticVersionMake(6, 0, 2);
    return [self supportsFeatureAvailableWithSemanticVersion:supportedJiveVersion];
}

- (BOOL)supportsFollowing {
    JVSemanticVersion supportedJiveVersion = JVSemanticVersionMake(7, 0, 0);
    return [self supportsFeatureAvailableWithSemanticVersion:supportedJiveVersion];
}

- (BOOL)supportsStatusUpdateInPlace {
    JVSemanticVersion supportedJiveVersion = JVSemanticVersionMake(7, 0, 0);
    return [self supportsFeatureAvailableWithSemanticVersion:supportedJiveVersion];
}

- (BOOL)supportsBookmarkInboxEntries {
    JVSemanticVersion supportedJiveVersion = JVSemanticVersionMake(6, 0, 3);
    return [self supportsFeatureAvailableWithSemanticVersion:supportedJiveVersion];
}

- (BOOL)supportsCorrectAndHelpfulReplies {
    JVSemanticVersion supportedJiveVersion = JVSemanticVersionMake(7, 0, 0);
    return [self supportsFeatureAvailableWithSemanticVersion:supportedJiveVersion];
}

- (BOOL)supportsStructuredOutcomes {
    JVSemanticVersion supportedJiveVersion = JVSemanticVersionMake(7, 0, 0);
    return [self supportsFeatureAvailableWithSemanticVersion:supportedJiveVersion];
}

- (BOOL)supportsExplicitCorrectAnswerAPI {
    JVSemanticVersion supportedJiveVersion = JVSemanticVersionMake(6, 0, 3);
    return [self supportsFeatureAvailableWithSemanticVersion:supportedJiveVersion];
}

- (BOOL)supportsDiscussionLikesInActivityObjects {
    JVSemanticVersion supportedJiveVersion = JVSemanticVersionMake(6, 0, 3);
    return [self supportsFeatureAvailableWithSemanticVersion:supportedJiveVersion];
}

- (BOOL)supportsInboxTypeFiltering {
    JVSemanticVersion supportedJiveVersion = JVSemanticVersionMake(7, 0, 0);
    return [self supportsFeatureAvailableWithSemanticVersion:supportedJiveVersion];
}

- (BOOL)supportsCommentAndReplyPermissions {
    JVSemanticVersion supportedJiveVersion = JVSemanticVersionMake(7, 0, 0);
    return [self supportsFeatureAvailableWithSemanticVersion:supportedJiveVersion];
    
}

- (BOOL)supportedIPhoneVersion {
    JVSemanticVersion supportedJiveVersion = JVSemanticVersionMake(6, 0, 3);
    return [self supportsFeatureAvailableWithSemanticVersion:supportedJiveVersion];
}

@end
