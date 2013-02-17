# AFNetworking
### dddAFNetworkingCacheStorageAllowed
Code block allow to override cache policy to store to disk

        [operation setCacheResponseBlock:^NSCachedURLResponse *(NSURLConnection *connection, NSCachedURLResponse *cachedResponse) {
            return [[NSCachedURLResponse alloc] initWithResponse:cachedResponse.response data:cachedResponse.data userInfo:cachedResponse.userInfo storagePolicy:NSURLCacheStorageAllowed];
        }];

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
        //[operationQueue addOperation:operation];  // or using operation queue
        

### dddAFNetworkingImageRequest
Request an image

        NSURL *url = [NSURL URLWithString:<#URL String#>];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        operation = [AFImageRequestOperation imageRequestOperationWithRequest:request success:^(NSImage *image) {
            <#code here#>
        }];
        
        [operation start];
        //[operationQueue addOperation:operation];  // or using operation queue
        
        

### dddAFNetworkingJSONRequest
JSON AFNetworking request

        NSURL *url = [NSURL URLWithString:<#URL String#>];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            // NSString *status = [JSON valueForKeyPath:@"status"];
            <#code here#>
        } failure:^(NSURLRequest *request , NSURLResponse *response , NSError *error , id JSON) {
            // response failed
        }];
        [operation start];
        //[operationQueue addOperation:operation];  // or using operation queue

### dddAFNetworkingKissXMLRequest
AFNetworking XML Request direct to an object

        NSURL *url = [NSURL URLWithString:￼];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        AFKissXMLRequestOperation *operation = [AFKissXMLRequestOperation XMLDocumentRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, DDXMLDocument *XMLDocument) {
            // NSLog(@"XMLDocument: %@", XMLDocument);
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, DDXMLDocument *XMLDocument) {
            // response failed
        }];
        [operation start];
        //[operationQueue addOperation:operation];  // or using operation queue
        
        

### dddAFNetworkingMultipartForm
Multipart from upload with process report

        NSURL *url = [NSURL URLWithString:￼];
        AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
        NSMutableURLRequest *request = [httpClient multipartFormRequestWithMethod:@"POST" path:￼ parameters:nil constructingBodyWithBlock: ^(id <AFMultipartFormData>formData) {
            //NSData *imageData = UIImageJPEGRepresentation([UIImage imageNamed:@"avatar.jpg"], 0.5);
            //[formData appendPartWithFileData:imageData name:@"avatar" fileName:@"avatar.jpg" mimeType:@"image/jpeg"];
        }];
        
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
            NSLog(@"Sent %lld of %lld bytes", totalBytesWritten, totalBytesExpectedToWrite);
        }];
        [httpClient enqueueHTTPRequestOperation:operation];
        

### dddAFNetworkingSimpleXMLRequest
Request XML and convert to NSDictionary/NSOBject directly

        NSURL *url = [NSURL URLWithString:<#URL String#>];
                NSURLRequest *request = [NSURLRequest requestWithURL:url];        
                AFSimpleXMLRequestOperation *operation = [AFSimpleXMLRequestOperation simpleXMLRequestOperationWithRequest:request forceArrayNodes:nil success:^(AFSimpleXMLRequestOperation *operation, NSDictionary *result) {
                    <#code here#>
                } failure:^(AFSimpleXMLRequestOperation *operation, NSError *error) {
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

### dddGCDBackgroundTask
Code block to perform background multitasking, will check for the device multitasking supports

        if ([[UIDevice currentDevice] respondsToSelector:@selector(isMultitaskingSupported)]) { //Check if our iOS version supports multitasking I.E iOS 4
            if ([[UIDevice currentDevice] isMultitaskingSupported]) { //Check if device supports mulitasking
                __block UIBackgroundTaskIdentifier background_task; //Create a task object
                background_task = [application beginBackgroundTaskWithExpirationHandler: ^ {
                    //We can add some code here before OS kill this task
                    [application endBackgroundTask: background_task]; //Tell the system that we are done with the tasks
                    background_task = UIBackgroundTaskInvalid; //Set the task to be invalid
                    //System will be shutting down the app at any point in time now
                }];
                //Background tasks require you to use async tasks
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    //Perform your tasks that your application requires
                    ￼
                    [application endBackgroundTask: background_task]; //End the task so the system knows that you are done with what you need to perform
                    background_task = UIBackgroundTaskInvalid; //Invalidate the background_task
                });
            }
        }
        

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
            ￼
        });

### dddGCDDispatchMain
Dispatch main queue

        dispatch_async(dispatch_get_main_queue(),^ {
            <# code here #>
        });

### dddGCDWeakSelf
prepare weak self to prevent cyclic lock

        __weak __typeof(&*self)weakSelf = self;

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
            static <#class name#> *defaultCenter = nil;
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
        

# NSOperationQueue
### dddNSOperationQueueCreate
Create Shared Queue

        + (NSOperationQueue *) <#sharedOperationQueue#> {
            static NSOperationQueue *sharedOperationQueue = nil;
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                sharedOperationQueue = [[NSOperationQueue alloc] init];
                [sharedOperationQueue setMaxConcurrentOperationCount:<#max concurrent#>];
            });    
            return sharedOperationQueue;
        }

# UIGestureRecognizer
### dddUIGestureRecognizerDoubleTap
Create a double tap gesture

        UITapGestureRecognizer *doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                              initWithTarget:￼ action:@selector(￼)];
        doubleTapGestureRecognizer.numberOfTapsRequired = 2;
        [self addGestureRecognizer:doubleTapGestureRecognizer];
        

### dddUIGestureRecognizerSingleTap
Create Single Tap Gesture

        // add double tap to zoom in and zoom out options
        UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                              initWithTarget:￼ action:@selector(￼)];
        singleTapGestureRecognizer.numberOfTapsRequired = 1;
        [self.view addGestureRecognizer:singleTapGestureRecognizer];
        

# UIImage
### dddUIImageDrawOnContext
Get UIImage by draw on graphics context

        UIGraphicsBeginImageContextWithOptions(<#rect#>, NO, [UIScreen mainScreen].scale);
            //[color setFill];
            //CGContextFillRect(UIGraphicsGetCurrentContext(), rect);
        	UIImage *ret = UIGraphicsGetImageFromCurrentImageContext();
        	UIGraphicsEndImageContext();
        

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

# UIViewController
### dddUIViewControllerRotation
Template for implmenting UIViewController rotation

        #pragma mark rotation
        
        - (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
            return YES;
            //return UIInterfaceOrientationIsPortrait(toInterfaceOrientation);
        }
        
        #pragma mark iOS 6 rotation
        
        - (BOOL) shouldAutorotate{
            return YES;
        }
        
        - (NSUInteger) supportedInterfaceOrientations{
            return UIInterfaceOrientationMaskAll;
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

