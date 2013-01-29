# NSObject

### dddDefaultCenter

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
	
# NSNotification

### dddNotificationObserve

Observe an notification

	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(<#selector#>) name:<#notification name#> object:nil];
	
### dddNotificationPost

Post notification to notification center

	 [[NSNotificationCenter defaultCenter] postNotificationName:<#notifcation name #> object:nil];

### dddNotificationRemove

Remove notification from notification center

	  [[NSNotificationCenter defaultCenter] removeObserver:self name:<#notification name#> object:nil];


# GCD

### dddASyncToSync
Use dispatch_semaphore to wait for an async task to finish

    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    /* signal when a async task finished */
    dispatch_semaphore_signal(sema);
    /* place wait after the block to wait for the signal */
    dispatch_semaphore_wait(se, DISPATCH_TIME_FOREVER);

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


# WTDataRecord (Private class)

### dddDataRecordImp
Template of the implementation of a WTDataRecord class

	@dynamic <#field name#>;
	
	IMP_ACTIVE_RECORD_SCHEMA
	
	+ (NSDictionary*) schema {
	    return @{
	             <#field name#>  : @{ kWTDataSchemaKeyType: kWTDataSchemaTypeString }, kWTDataSchemaKeyIndex: @YES },kWTDataSchemaKeyDefault: <#default value#> }
	             };
	}