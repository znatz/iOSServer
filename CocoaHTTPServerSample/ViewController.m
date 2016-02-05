//
//  ViewController.m
//  CocoaHTTPServerSample
//
//  Created by 趙自然 on 2/5/16.
//  Copyright © 2016 趙自然. All rights reserved.
//

#import "ViewController.h"
#include "ifaddrs.h"
#include <arpa/inet.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *IPAddress;
@end

@implementation ViewController




- (NSString *)getIPAddress {
    
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    
                }
                
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _IPAddress.text = [self getIPAddress];
    
    NSString* documentRoot = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"web"];
    NSString* uploadDirPath = [documentRoot stringByAppendingPathComponent:@"upload"];
    _LogPath.text = uploadDirPath;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
