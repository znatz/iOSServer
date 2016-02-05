//
//  MyHTTPConnection.h
//  CocoaHTTPServerSample
//
//  Created by 趙自然 on 2/6/16.
//  Copyright © 2016 趙自然. All rights reserved.
//

#ifndef MyHTTPConnection_h
#define MyHTTPConnection_h


#endif /* MyHTTPConnection_h */

#import "HTTPConnection.h"

@class MultipartFormDataParser;

@interface MyHTTPConnection : HTTPConnection  {
    MultipartFormDataParser*        parser;
    NSFileHandle*					storeFile;
    
    NSMutableArray*					uploadedFiles;
}

@end