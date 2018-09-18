//
//  BarcodeView.h
//  ISBN_Barcode
//
//  Created by Scott Combs on 09/09/18.
//  Copyright © 2018 Scott Combs. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>

@interface BarcodeView : NSView

@property (readwrite, retain) NSString *barcode;
@property (readwrite, retain) NSString *isbn;

- (NSString*)mapToName:(NSString *)inChar;
@end
