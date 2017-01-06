@interface CKPreferredServiceManager : NSObject
+(id)sharedPreferredServiceManager;
-(bool)_isiMessageAvailable;
-(BOOL)availabilityForAddress:(id)arg1 onService:(id)arg2 checkWithServer:(bool)arg3 ;
@end

@interface IMService : NSObject
+(id)iMessageService;
@end

@interface CKComposition : NSObject
-(id)initWithText:(id)arg1 subject:(id)arg2 ;
@end

@interface CKTranscriptController : NSObject
-(void)sendMessage:(id)arg1;
@end

@interface IMAccountController : NSObject
+(id)sharedInstance;
-(id)__ck_bestAccountForAddress:(id)arg1 ;
@end

@interface IMAccount : NSObject
-(id)imHandleWithID:(id)arg1 ;
@end

@interface CKConversationList : NSObject
+(id)sharedConversationList;
-(id)conversationForHandles:(id)arg1 create:(bool)arg2 ;
@end

@interface CKConversation : NSObject
-(id)newMessageWithComposition:(id)arg1 addToConversation:(bool)arg2 ;
-(void)sendMessage:(id)arg1 onService:(id)arg2 newComposition:(bool)arg3 ;
@end
