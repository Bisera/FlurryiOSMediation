//
//  ViewController.m
//  appspot-ios-sample
//
//  Created by Anthony Watkins on 8/3/12.
//  Copyright (c) 2012 Flurry. All rights reserved.
//

#import "ViewController.h"
#import "FlurryAds.h"

@interface ViewController ()
@property (nonatomic, retain) UIView *flurryContainer;
@property (nonatomic, retain) NSArray *testAdSpaces;

@property (nonatomic, retain) IBOutlet UIPickerView *adTypePicker;
@property (nonatomic, retain) IBOutlet UIButton     *showAd;
@property (nonatomic, retain) IBOutlet UIButton     *removeAd;
@property (nonatomic, retain) IBOutlet UILabel      *statusLbl;

@end

@implementation ViewController

@synthesize adTypePicker;
@synthesize showAd;
@synthesize removeAd;
@synthesize statusLbl;
@synthesize flurryContainer;
@synthesize testAdSpaces;

-(void) dealloc
{
    [showAd release];
    [removeAd release];
    [statusLbl release];
    [adTypePicker release];
    [testAdSpaces release];
    [flurryContainer release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.testAdSpaces = @[@"MediatedBannerBottom", @"MediatedTakeover"];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.adTypePicker = nil;
}

-(void) viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma UI Component handlers

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    return self.testAdSpaces.count;
}

- (NSString *)pickerView:(UIPickerView *)thePickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component {
    
    return [self.testAdSpaces objectAtIndex:row];
}

-(IBAction) removeAdClickedButton:(id)sender {
    NSUInteger adTypeIx  = [self.adTypePicker selectedRowInComponent:0];
    NSString *adSpace = [self.testAdSpaces objectAtIndex:adTypeIx];
    
    [FlurryAds removeAdFromSpace:adSpace];
    self.statusLbl.text = @"Ad Removed";
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [FlurryAds setAdDelegate:self];
    
    //use flurryContainer to custom postion the ad space if needed
    CGRect theRect = CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 50);
    self.flurryContainer = [[[UIView alloc] initWithFrame:theRect] autorelease];
    
    [self.view addSubview:self.flurryContainer];
    
}

-(IBAction) showAdClickedButton:(id)sender {
    
    // Get ad space selection
    NSUInteger adTypeIx  = [self.adTypePicker selectedRowInComponent:0];
    NSString *adSpace = [self.testAdSpaces objectAtIndex:adTypeIx];
    
    FlurryAdSize defaultAdSize = [adSpace rangeOfString:@"Takeover"].length != 0 ? FULLSCREEN : BANNER_BOTTOM;
    
    if ([FlurryAds adReadyForSpace:adSpace]) {
        [FlurryAds displayAdForSpace:adSpace onView:self.flurryContainer];
        self.statusLbl.text = @"Dispaly Ad Success";
    }
    else {
        // Load the ad
        self.statusLbl.textColor = [UIColor redColor];
        self.statusLbl.text = @"Fetching Ads";
        [FlurryAds fetchAdForSpace:adSpace frame:self.flurryContainer.frame size:defaultAdSize];
    }
}

#pragma mark AppSpotDelegate methods

- (UIViewController *)appSpotRootViewController { return self; }

- (void)spaceDidReceiveAd:(NSString *)adSpace {
    NSLog(@"=========== Ad Space [%@] Did Receive Ad ================ ", adSpace);
    self.statusLbl.textColor = [UIColor greenColor];
    self.statusLbl.text = @"Successfully Fetched Ads";
    
}

- (void)spaceDidFailToReceiveAd:(NSString *)adSpace error:(NSError *)error {
    NSLog(@"=========== Ad Space [%@] Did Fail to Receive Ad with error [%@] ================ ", adSpace, error);
    self.statusLbl.textColor = [UIColor redColor];
    self.statusLbl.text = @"No Ads are Currently Available";
}

- (void) videoDidFinish:(NSString *)adSpace{
    NSLog(@"=========== Ad Space [%@] Video Did Finish  ================ ", adSpace);
}

- (BOOL) spaceShouldDisplay:(NSString*)adSpace interstitial:(BOOL)interstitial {
    NSLog(@"=========== Ad Space [%@] Should Display Ad for interstitial [%d] ================ ", adSpace, interstitial);
    return YES;
}

- (void)spaceWillDismiss:(NSString *)adSpace interstitial:(BOOL)interstitial {
    NSLog(@"=========== Ad Space [%@] Will Dismiss for interstitial [%d] ================ ", adSpace, interstitial);
}

- (void)spaceDidDismiss:(NSString *)adSpace interstitial:(BOOL)interstitial {
    NSLog(@"=========== Ad Space [%@] Did Dismiss for interstitial [%d] ================ ", adSpace, interstitial);
}

- (void)spaceWillLeaveApplication:(NSString *)adSpace {
    NSLog(@"=========== Ad Space [%@] Will Leave Application ================ ", adSpace);
}

- (void) spaceDidFailToRender:(NSString *) adSpace error:(NSError *)error {
    NSLog(@"=========== Ad Space [%@] Did Fail to Render with error [%@] ================ ", adSpace, error);
}

- (void) spaceDidReceiveClick:(NSString *)adSpace {
    NSLog(@"=========== Ad Space [%@] Did Receive Click ================ ", adSpace);
}

- (void)spaceWillExpand:(NSString *)adSpace {
    NSLog(@"=========== Ad Space [%@] Will Expand ================ ", adSpace);
}

- (void)spaceDidCollapse:(NSString *)adSpace {
    NSLog(@"=========== Ad Space [%@] Did Collapse ================ ", adSpace);
}


- (UIView *)appSpotParentView { return self.view; }
- (BOOL)appSpotTestMode { return NO; }
- (BOOL)appSpotAccelerometerEnabled { return NO; }

#pragma mark - API Keys for mediated networks -

- (NSString *)appSpotMillennialAppKey { return @"130627"; } //this is APID for BANNER placement ad window
- (NSString *)appSpotMillennialInterstitalAppKey { return @"130628"; } //this is APID for INTERSTITIAL placement ad window

- (NSString *)appSpotInMobiAppKey { return @"1773cf7ef60c424b94c8e4e016650153"; }
- (NSString *)appSpotAdMobPublisherID { return @"a152002e31bc8ed"; }

- (NSString *)appSpotMobclixApplicationID { return @"A140D3C4-707A-4C1C-9784-2F4485168323"; }
- (NSString *)appSpotGreystripeApplicationID { return @"633ce696-fe00-11e2-be0e-157075c8b431"; }



@end
