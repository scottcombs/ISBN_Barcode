//
//  ViewController.h
//  ISBN_Barcode
//
//  Created by Scott Combs on 09/09/18.
//  Copyright © 2018 Scott Combs. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class BarcodeView;

@interface ViewController : NSViewController
@property (weak) IBOutlet NSTextField *ean13TextField;
@property (weak) IBOutlet NSTextField *price5TextField;
@property (weak) IBOutlet NSButton *whiteSpaceButton;
@property (weak) IBOutlet NSButton *triangleButton;
@property (weak) IBOutlet BarcodeView *barcodeView;
@property (readwrite, retain) NSDictionary *structure;
@property (readwrite, retain) NSDictionary *lCode;
@property (readwrite, retain) NSDictionary *gCode;
@property (readwrite, retain) NSDictionary *rCode;
@property (readwrite, retain) NSDictionary *estructure;
@property (weak) IBOutlet NSTextField *isbnTextField;

- (NSString*)mapToFont:(NSString*)isbnString;
- (NSString*)priceString:(NSString*)str;
- (IBAction)onPrintBarcode:(id)sender;
- (IBAction)saveDocument:(id)sender;

@end

