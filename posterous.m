//
//  posterous.m
//  imPOSTr
//
//  Created by Wess Cope on 10/27/09.
//  Copyright 2009 Wattz. All rights reserved.
//

#import "posterous.h"


@implementation Posterous
@synthesize email, passwd;
@synthesize urlString, params, data;
@synthesize xmlKeys, xmlVals, xmlDict;
@synthesize currentElement, tmpElement;

-(id)init
{
	self = [super init];
	
	xmlDict = [[NSMutableDictionary alloc] init];
	
	return self;
}

-(id)initWithEmail:(NSString *)e andPassword:(NSString *)p
{
	email = e;
	passwd = p;
	
	return [self init];
}

-(void)httpQueryData:(NSDictionary *)p
{
	NSString *requestString = @"";
	
	for(NSString *item in p)
	{
		requestString = [requestString stringByAppendingFormat:@"%@=%@&", item, [p objectForKey:item]];
	}
	
	//[requestString stringByTrimmingCharactersInSet:[NSCharacterSet symbolCharacterSet]];	
	NSLog(@"*** REQUEST STRING: %@", requestString);
	self.data = [[NSString stringWithFormat:@"%@", requestString] dataUsingEncoding:NSUTF8StringEncoding];
}

-(id)getSites
{
	/*
	 params:
	 - none
	 */
	self.urlString = @"http://posterous.com/api/getsites";	
	
	NSLog(@"getSites: %@", [self makeRequest]);
	return [self makeRequest];
}


-(id)readPosts:(NSDictionary *)p
{
	/*
	 params:
	 - site_id
	 - hostname
	 - num_posts
	 - page
	 - tag
	 */
	self.urlString = @"http://posterous.com/api/readposts";
	[self httpQueryData:p];
	
	return [self makeRequest];
}

-(id)getPost:(NSDictionary *)p
{
	/*
	 params:
	 - id
	 */
	self.urlString = @"http://posterous.com/api/getpost";	
	[self httpQueryData:p];

	return [self makeRequest];
}

-(id)newPost:(NSDictionary *)p
{
	NSLog(@"in newPost");

	/*
	 params:
	 - site_id
	 - media
	 - title
	 - body
	 - autopost
	 - private
	 - date
	 - tags
	 - source
	 - sourceLink
	 */
	self.urlString = @"http://posterous.com/api/newpost";
	[self httpQueryData:p];

	return [self makeRequest];
}

-(id)newComment:(NSDictionary *)p
{
	/*
	 params:
	 - post_id
	 - comment
	 */
	self.urlString = @"http://posterous.com/api/newcomment";
	[self httpQueryData:p];

	return [self makeRequest];
}

-(NSString *) auth
{
	//NSString *email = @"wcope@me.com";
	//NSString *passwd = @"12qwaszx";
	
	NSString *authStr = [NSString stringWithFormat:@"%@:%@", self.email, self.passwd];
	NSData *authData = [authStr dataUsingEncoding:NSASCIIStringEncoding];
	NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData base64EncodingWithLineLength:80]];
	
	return authValue;
}

-(id) makeRequest
{
	//NSString *urlString = @"http://posterous.com/api/newpost";
	NSURL *url = [[NSURL alloc] initWithString:self.urlString];
	NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:url];
	
	[req setHTTPMethod:@"POST"];
	
	[req setHTTPBody:self.data];			
	
	[req addValue:[self auth] forHTTPHeaderField:@"Authorization"];
	
	NSHTTPURLResponse *urlResponse = nil;
	NSError *error = [[NSError alloc] init];
	NSData *responseData = [NSURLConnection sendSynchronousRequest:req returningResponse:&urlResponse error:&error];
	
	//NSLog(@"Response Data: %@", responseData);
	
	NSString *result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	
	//NSLog(@"Response Code: %d", [urlResponse statusCode]);
	/*
	if([urlResponse statusCode] >= 200 && [urlResponse statusCode] < 300)
		NSLog(@"Response: %@", result);
	*/
	
	BOOL success;
	NSXMLParser *responseParser = [[NSXMLParser alloc] initWithData:responseData];
	//[responseParser setDelegate:self];
	[responseParser setShouldResolveExternalEntities:YES];
	success = [responseParser parse];

	if (success)
		NSLog(@"Response Dict: %@", xmlDict);

	[url release];
	[req release];
	
	
	//exit(0);
	
	return result;
	[result release];	

}

/* Parser Delegates */
-(void) parser:(NSXMLParser *)parser 
		didStartElement:(NSString *)elementName 
		namespaceURI:(NSString *)namespaceURI 
		qualifiedName:(NSString *)qName 
		attributes:(NSDictionary *)attributeDict
{
	currentElement = elementName;
	//NSLog(@"Current Element: %@", self.currentElement);
	//[self.xmlKeys addObject:elementName];
	/*
	NSLog(@"elementName: %@", elementName);
	NSLog(@"namespaceURI: %@", namespaceURI);
	NSLog(@"qName: %@", qName);
	NSLog(@"attributeDict: ", attributeDict);
	NSLog(@"\n");
	*/
}

-(void) parser:(NSXMLParser *)parser 
		didEndElement:(NSString *)elementName 
		namespaceURI:(NSString *)namespaceURI 
		qualifiedName:(NSString *)qName
{
	//NSLog(@"element name again: %@", elementName);
}

-(void) parser:(NSXMLParser *)parser 
		foundCharacters:(NSString *)string
{
	if (self.currentElement != self.tmpElement) 
	{
		[xmlDict setObject:string forKey:currentElement];
		//NSLog(@"Element: %@ - Value: %@", self.currentElement, string);
		tmpElement = currentElement;
	}
}


-(void)dealloc
{
	[email release];
	[passwd release];
	[urlString release];
	[params release];
	[data release];
	[xmlKeys release];
	[xmlVals release];
	[xmlDict release];
	[currentElement release];
	
	[super dealloc];
}
@end
