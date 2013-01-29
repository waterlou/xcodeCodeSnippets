# AFNetworking
### dddAFNetworkingHTTPRequest
General AFNetworking request

        NSURL *url = [NSURL URLWithString:<#URL String#>];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
            
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
            [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            // response success, operation.responseString
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                // response failed
            }];
            [operation start];

# GCD
### dddGCDAsyncToSync
Use dispatch_semaphore to wait for an async task to finish

            dispatch_semaphore_t sema = dispatch_semaphore_create(0);
            /* signal when a async task finished */
            dispatch_semaphore_signal(sema);
            /* place wait after the block to wait for the signal */
            dispatch_semaphore_wait(se, DISPATCH_TIME_FOREVER);

### dddGCDCreateQueue
create a GCD queue

        - (dispatch_queue_t) <#function name#>
        {
            static dispatch_queue_t queue = nil;
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                queue = dispatch_queue_create(<#label#>,<#DISPATCH_QUEUE_SERIAL or DISPATCH_QUEUE_CONCURRENT#>);
            });
            return queue;
        }

### dddGCDDispatchAfter
scheduled block

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, <#seconds#> * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            <#code here#>
            });
        

### dddGCDDispatchGlobalQueue
Dispatch global queue

                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    <#code here#>
                });

### dddGCDDispatchMain
Dispatch main queue

                dispatch_async(dispatch_get_main_queue(),^ {
                    <#code here#>
                });

# NSNotificationCenter
### dddNotificationObserve
Observe an notification

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(<#selector#>) name:<#notification name#> object:nil];

### dddNotificationPost
Post notification to notification center

         [[NSNotificationCenter defaultCenter] postNotificationName:<#notifcation name#> object:nil];
        

### dddNotificationRemove
Remove notification from notification center

         [[NSNotificationCenter defaultCenter] removeObserver:self name:<#notification name#> object:nil];
        

# NSObject
### dddNSObjectDefaultCenter
singleton object of a class

        + (<#class name#>*) defaultCenter
        {
            static __object *defaultCenter = nil;
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                defaultCenter = [[<#class name#> alloc] init];
            });
            return defaultCenter;
        }
        

### dddNSObjectDefaultCenterOldMethod
NSObject defaultCenter - old method

        static WTNotificationCenter *__defaultCenter = nil;
        
        +(id) defaultCenter {
            @synchronized ([WTNotificationCenter class]) {
                if (__defaultCenter==nil) {
                    __defaultCenter = [[WTNotificationCenter alloc] init];
                }
            }
            return __defaultCenter;
        }

### dddNSObjectObserveValueForKeyPath
template for observeValueForKeyPath

        - (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
        {
            // Add static context variable
            // static void *yourContext = &yourContext;
        
            if (context == <#yourContext#>)
            {
                <#code here#>
            }
            else {
                [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
            }
        }
        

# UIView
### dddUIViewInit
UIView Init for both frame and coder

        - (void) setupSelf
        {
            
        }
        
        - (id)initWithFrame:(CGRect)frame
        {
            self = [super initWithFrame:frame];
            if (self) {
                // Initialization code
                [self setupSelf];
            }
            return self;
        }
        
        - (id)initWithCoder:(NSCoder *)aDecoder
        {
            self = [super initWithCoder: aDecoder];
            if (self) {
                // Initialization code
                [self setupSelf];
            }
            return self;
        }

### dddUIViewTouches
UIView touches implementations

        - (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
        {
            UITouch *touch = [touches anyObject];
            CGPoint point = [touch locationInView: self];
        }
        
        - (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
        {
            UITouch *touch = [touches anyObject];
            CGPoint point = [touch locationInView: self];
        }
        
        - (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
        {
        }
        
        - (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
        {
        }

# WTDataRecord
### dddDataRecordImp
Template of the implementation of a WTDataRecord class

        @dynamic <#field name#>;
        
        IMP_ACTIVE_RECORD_SCHEMA
        
        + (NSDictionary*) schema {
            return @{
                     <#field name#>  : @{ kWTDataSchemaKeyType: kWTDataSchemaTypeString }, kWTDataSchemaKeyIndex: @YES },kWTDataSchemaKeyDefault: <#default value#> }
                     };
        }
