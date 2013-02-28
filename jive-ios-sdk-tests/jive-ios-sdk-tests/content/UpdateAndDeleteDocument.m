//
//  UpdateAndDeleteDocument.m
//  jive-ios-sdk-tests
//
//  Created by Shivkumar Krishnan on 2/8/13.
//  Copyright (c) 2013 Jive Software. All rights reserved.
//


#import "JiveTestCase.h"
#import "JVUtilities.h"


@interface UpdateAndDeleteDocument: JiveTestCase

@end

@implementation UpdateAndDeleteDocument

- (void) testUpdateAndDeleteDocument {
    JiveDocument *post = [[JiveDocument alloc] init];
    __block JiveContent* testDoc = nil;
    __block JiveContent* updatedDoc = nil;
    
    NSString* docSubj = [NSString stringWithFormat:@"Update and Delete Doc Test From SDK- %d", (arc4random() % 1500000)];
    
    post.subject = docSubj;
    post.content = [[JiveContentBody alloc] init];
    post.content.type = @"text/html";
    post.content.text = @"<body><p>This is a test of the new doc creation from iPad SDK.</p></body>";
    
    [self waitForTimeout:^(dispatch_block_t finishBlock) {
        [jive1 createContent:post withOptions:nil onComplete:^(JiveContent *newPost) {
            STAssertEqualObjects([newPost class], [JiveDocument class], @"Wrong content created");
            
            testDoc = newPost;
            
            finishBlock();
        } onError:^(NSError *error) {
            STFail([error localizedDescription]);
            finishBlock();
        }];
    }];
    
    STAssertEqualObjects(testDoc.subject, post.subject, @"Unexpected person: %@", [testDoc toJSONDictionary]);
    
    
    JiveResourceEntry* resourceEntryForNewDocAfterCreation = [testDoc.resources objectForKey:@"self"];
    NSString* contentURL1 = [resourceEntryForNewDocAfterCreation.ref absoluteString];
    
    NSURL* authorURL = [[NSURL alloc] initWithString:@"http://tiedhouse-yeti1.eng.jiveland.com/api/core/v3/people/3497"];
    
    
    __block NSArray *contentsResults = nil;
    
    JiveContentRequestOptions* jiveContentRequestOptions = [[JiveContentRequestOptions alloc] init];
    
    [jiveContentRequestOptions addAuthor:authorURL];
    
    
    [self waitForTimeout:^(dispatch_block_t finishBlock2) {
        [jive1 contents:jiveContentRequestOptions onComplete:^(NSArray* results) {
            contentsResults = results;
            finishBlock2();
        } onError:^(NSError *error) {
            STFail([error localizedDescription]);
            finishBlock2();
        }];
    }];
    
    BOOL found = FALSE;
    JiveContent* testContentObj = nil;
    
    for (JiveContent* contentObj in contentsResults) {
        
        if ([contentObj isKindOfClass:[JiveDocument class]])
        {
            JiveDocument* aDoc= ((JiveDocument*)(contentObj));
           
            if ([aDoc.subject isEqualToString:docSubj])
            {
                found = true;
                testContentObj = contentObj;
                break;
            }
        }
        
    }
    
    if (!found)
    {
        STFail(@"Document was not created successfully.");
    }
    
     #ifdef TABDEV405
         
     // Update Document Bug: TABDEV-405

     
     NSLog(@"Now updating the doc");
    
    
    // Now, Update the Document
    testDoc.subject = [docSubj stringByAppendingString:@" with updated subject"];
    
    JiveMinorCommentRequestOptions* jiveMinorCommentRequestOptions =
       [[JiveMinorCommentRequestOptions alloc] init];
    
    jiveMinorCommentRequestOptions.minor = true;
    
    [self waitForTimeout:^(dispatch_block_t finishBlock2) {
        [jive1 updateContent:testDoc withOptions:jiveMinorCommentRequestOptions onComplete:^(JiveContent* results) {
            updatedDoc = results;
            finishBlock2();
        } onError:^(NSError *error) {
            STFail([error localizedDescription]);
            finishBlock2();
        }];
    }];
    
    STAssertEqualObjects(updatedDoc.subject, testDoc.subject, @"Expected Subject of doc to be updated to new value");
    
    NSLog(@"Updated the doc successfully");
    
   #endif
    
    
    
    
    [self waitForTimeout:^(dispatch_block_t finishBlock3) {
        [jive1 deleteContent:testDoc onComplete:^(void) {
            finishBlock3();
        } onError:^(NSError *error) {
            STFail([error localizedDescription]);
            finishBlock3();
        }];
    }];
        
    jiveContentRequestOptions = [[JiveContentRequestOptions alloc] init];
    [jiveContentRequestOptions addAuthor:authorURL];
    
    
    [self waitForTimeout:^(dispatch_block_t finishBlock4) {
        [jive1 contents:jiveContentRequestOptions onComplete:^(NSArray* results) {
            contentsResults = results;
            finishBlock4();
        } onError:^(NSError *error) {
            STFail([error localizedDescription]);
            finishBlock4();
        }];
    }];
    
    JiveContent* docFromSearchAfterUpdating = nil;
    found = FALSE;
    
    for (JiveContent* contentObj in contentsResults) {
        
        if ([contentObj isKindOfClass:[JiveDocument class]])
        {
            JiveDocument* aDoc= ((JiveDocument*)(contentObj));
            
            if ([aDoc.subject isEqualToString:updatedDoc.subject])
            {
                found = true;
                docFromSearchAfterUpdating = aDoc;
                break;
            }
        }
    }
    
    NSString* contentURL2 = nil;
    
    
    if (found) {
      JiveResourceEntry *resourceEntryForUpdatedDocAfterSearch = [docFromSearchAfterUpdating.resources objectForKey:@"self"];
      contentURL2 = [resourceEntryForUpdatedDocAfterSearch.ref absoluteString];
    }
    
    if (found)
    {
        STFail(@"Document was not deleted successfully.");
    }
    
    if (found && [contentURL2 isEqualToString:contentURL1])
    {
        STFail(@"Document was not deleted successfully.");
    }
    
}

@end