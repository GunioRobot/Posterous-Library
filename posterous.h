//
//  posterous.h
//  imPOSTr
//
//  Created by Wess Cope on 10/27/09.
//  Copyright 2009 Wattz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSData+Base64.h"

@interface Posterous : NSObject {

	NSString *email;
	NSString *passwd;
	NSString *urlString;
	
	NSMutableDictionary *params;
	NSData *data;
	
	NSMutableArray *xmlKeys;
	NSMutableArray *xmlVals;
	
	NSMutableDictionary *xmlDict;
	NSString *currentElement;
	NSString *tmpElement;
}

@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *passwd;
@property (nonatomic, retain) NSString *urlString;
@property (nonatomic, retain) NSMutableDictionary *params;
@property (nonatomic, retain) NSData *data;
@property (nonatomic, retain) NSMutableArray *xmlKeys;
@property (nonatomic, retain) NSMutableArray *xmlVals;
@property (nonatomic, retain) NSMutableDictionary *xmlDict;
@property (nonatomic, retain) NSString *currentElement;
@property (nonatomic, retain) NSString *tmpElement;

-(id)init;
-(id)initWithEmail:(NSString *)email andPassword:(NSString *)passwd;
-(id)getSites;
-(id)readPosts:(NSDictionary *)p;
-(id)getPost:(NSDictionary *)p;
-(id)newPost:(NSDictionary *)p;
-(id)newComment:(NSDictionary *)p;
-(NSString *) auth;
-(id) makeRequest;
@end
