#import "Tweak.h"

%hook SMSApplication

//fuck mrc
//usage:
//  cycript -p MobileSMS
//  [UIApp sendIMessage:@"123456789" message:@"Happy the sheep year" checkWithServer:YES]

%new
- (void)sendIMessage:(NSString*)address message:(NSString*)message checkWithServer:(BOOL)checkServer {
  int result = [[NSClassFromString(@"CKPreferredServiceManager") sharedPreferredServiceManager]
        availabilityForAddress:address onService:[NSClassFromString(@"IMService") iMessageService] checkWithServer:checkServer];
  if (result == 0) {
    NSLog(@"address %@ does not support iMessage service", address);
    return;
  } else if (result == 1) {
    IMAccount* account = [[NSClassFromString(@"IMAccountController") sharedInstance] __ck_bestAccountForAddress:address];
    id handle = [account imHandleWithID: address];
    CKConversation* conversation = [[NSClassFromString(@"CKConversationList") sharedConversationList] conversationForHandles:[NSArray arrayWithObject:handle] create:true];
    CKComposition* composition = [[NSClassFromString(@"CKComposition") alloc] initWithText:[[NSAttributedString alloc] initWithString:message] subject:@""];
    id message = [conversation newMessageWithComposition:composition addToConversation:true];
    [conversation sendMessage:message onService: [NSClassFromString(@"IMService") iMessageService] newComposition:true];
  } else if (checkServer && result == -1) {
    %log;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      NSMethodSignature * mySignature = [NSMutableArray instanceMethodSignatureForSelector:@selector(sendIMessage:message:checkWithServer:)];
      NSInvocation * invocation = [NSInvocation invocationWithMethodSignature:mySignature];
      [invocation setTarget:[UIApplication sharedApplication]];
      [invocation setSelector:@selector(sendIMessage:message:checkWithServer:)];
      NSString* addr = [address copy];
      NSString* msg = [message copy];
      BOOL check = checkServer;
      [invocation setArgument:&addr atIndex:2];
      [invocation setArgument:&msg atIndex:3];
      [invocation setArgument:&check atIndex:4];
      [invocation invoke];
      %log;
    });
  }
}

%end
