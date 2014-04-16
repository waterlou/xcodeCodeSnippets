# AFNetworking
### dddAFNetworking2
AFNetworking 2 code snippet

        NSURL *url = [NSURL URLWithString:<#URL String#>];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        //operation.responseSerializer = [AFSimpleXMLResponseSerializer serializer];
        //operation.responseSerializer = [AFJSONResponseSerializer serializer];
        //operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, NSDictionary *result) {
            <# success code #>
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (error.code==NSURLErrorCancelled) {
                return; // manual cancel
            }
            <# failure code #>
        }];
        [operation start];
        //[_operationQueue addOperation:operation];
        

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
            if (error.code==NSURLErrorCancelled) {
                return; // manual cancel
            }
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
        
        

### dddAFNetworkingJSONFileUpload
Upload image with JSON data

            NSData *imageToUpload = UIImageJPEGRepresentation([UIImage imageNamed:@"test.jpg"], 90);
        AFHTTPClient *client= [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:<#URL String#>]];
            
            NSMutableURLRequest *request = [client multipartFormRequestWithMethod:@"POST" path:@"/api/upload" parameters:nil constructingBodyWithBlock: ^(id <AFMultipartFormData>formData) {
                [formData appendPartWithFileData: imageToUpload name:@"file" fileName:@"temp.jpeg" mimeType:@"image/jpeg"];
            }];
            
            AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                // NSString *status = [JSON valueForKeyPath:@"status"];
                NSLog(@"success: %@", JSON);
            } failure:^(NSURLRequest *request , NSURLResponse *response , NSError *error , id JSON) {
                if (error.code==NSURLErrorCancelled) {
                    return; // manual cancel
                }
                // response failed
                NSInteger statusCode = [[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode];
                NSLog(@"error: %d >> %@", statusCode, error);
            }];
            
            [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
                CGFloat progress = ((CGFloat)totalBytesWritten) / totalBytesExpectedToWrite;
                NSLog(@"%f uploaded", progress);
            }];
            
            [operation start];

### dddAFNetworkingJSONPostForm
Post JSON data

        NSURL *url = [NSURL URLWithString:<#URL String#>];
            AFHTTPClient* client = [[AFHTTPClient alloc] initWithBaseURL:url];
        NSDictionary* parameters = @{<#Post Dict#>};
            NSMutableURLRequest * request = [client requestWithMethod:@"POST" path:@"/api/users/login" parameters:parameters];
            AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                // NSString *status = [JSON valueForKeyPath:@"status"];
                NSLog(@"success: %@", JSON);
                
            } failure:^(NSURLRequest *request , NSURLResponse *response , NSError *error , id JSON) {
                if (error.code==NSURLErrorCancelled) {
                    return; // manual cancel
                }
                // response failed
                NSInteger statusCode = [[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode];
                NSLog(@"error: %d >> %@", statusCode, error);
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
            if (error.code==NSURLErrorCancelled) {
                return; // manual cancel
            }
            // response failed
        }];
        [operation start];
        //[operationQueue addOperation:operation];  // or using operation queue

### dddAFNetworkingKissXMLRequest
AFNetworking XML Request direct to an object

        NSURL *url = [NSURL URLWithString:<#URL String#>￼];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        AFKissXMLRequestOperation *operation = [AFKissXMLRequestOperation XMLDocumentRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, DDXMLDocument *XMLDocument) {
            // NSLog(@"XMLDocument: %@", XMLDocument);
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, DDXMLDocument *XMLDocument) {
            if (error.code==NSURLErrorCancelled) {
                return; // manual cancel
            }
            // response failed
        }];
        [operation start];
        //[operationQueue addOperation:operation];  // or using operation queue
        
        

### dddAFNetworkingMultipartForm
Multipart form upload with process report

        NSURL *url = [NSURL URLWithString:￼<#URL String#>];
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
                    if (error.code==NSURLErrorCancelled) {
                        return; // manual cancel
                    }
                    // response failed
                }];
                [operation start];
        

# Directive
### dddDirectiveMinDeploymentTarget
Block code referring to deployment target

        #if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_6_0
        // compile this code only when this project support OS 5.x
        <#code here#>
        #endif

### dddDirectiveiPhoneOSVersionMaxAllowed
Block code according to SDK version

        #if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_6_0
        // compile this code only when using SDK 6.0 or above
        <#code here#>
        #endif
        

# Enumeration
### dddEnumNSEnum
Enumeration Declaration NS_ENUM

        typedef NS_ENUM(NSInteger, <#enum name#>) {
            <#enum value 1#>,
            <#enum value 2#>
        };

### dddEnumNSOptions
Enumeration Declaration NS_OPTIONS

        typedef NS_OPTIONS(NSUInteger, <#option name#>) {
            <#option 1#> = 1 << 0,
            <#option 2#> = 1 << 1
        };

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

### dddGCDStrongSelf
convert weakSelf back to strongSelf

            __strong __typeof(self)strongSelf = self;
        

### dddGCDWeakSelf
prepare weak self to prevent cyclic lock

        __weak __typeof(self)weakSelf = self;

# NSFoundationVersionNumber
### dddNSFoundationVersionNumber
iOS version checking

            if (NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_6_1) {
                // Load resources for iOS 6.1 or earlier
            } else {
                // Load resources for iOS 7 or later
            }
        

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
                if (![change[NSKeyValueChangeNewKey] isEqual:change[NSKeyValueChangeOldKey]])
                {
                    <#code here#>
                }
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

# TBDstoryboard
### undefined
TBDstoryboard

        	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:[AppDelegate storyboardName] bundle:nil];
        	AboutViewController *about = [storyboard instantiateViewControllerWithIdentifier:ABOUT_IDENTIFIER];
        

# UIControl
### dddUIControlTouchesEvents
UIControl touches implementation

        - (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
        {
            // YES if the receiver is set to respond continuously or set to respond when a touch is dragged; otherwise NO.
            return YES;
        }
        - (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
        {
            return YES;
        }
        - (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
        {
            
        }
        - (void)cancelTrackingWithEvent:(UIEvent *)event
        {
            
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
        

# UIKit
### dddUIKitIpadOnly
iPad Only

        #if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_3_2
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            <#ipad code here#>
        }
        else {
            <#iphone code here#>
        }
        #endif

# UIView
### dddUIViewControllerNoExtendedLayout
By default iOS 7 will extend layout to top and bottom bar, add this in viewDidLoad to suppress this

            // prevent ios7 extent to the tabbar and nav bar
            if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
                self.edgesForExtendedLayout = UIRectEdgeNone;
        

### dddUIViewInit
UIView Init for both frame and coder

        - (void) setupSelf
        {
            
        }
        
        - (instancetype)initWithFrame:(CGRect)frame
        {
            self = [super initWithFrame:frame];
            if (self) {
                // Initialization code
                [self setupSelf];
            }
            return self;
        }
        
        - (instancetype)initWithCoder:(NSCoder *)aDecoder
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
        
        #if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_6_0
        
        - (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
            return YES;
            //return UIInterfaceOrientationIsPortrait(toInterfaceOrientation);
        }
        
        #endif
        
        #if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_6_0
        
        - (BOOL) shouldAutorotate{
            return YES;
        }
        
        - (NSUInteger) supportedInterfaceOrientations{
            return UIInterfaceOrientationMaskAll;
        }
        
        -(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
        {
            return UIInterfaceOrientationPortrait;
        }
        
        #endif

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

