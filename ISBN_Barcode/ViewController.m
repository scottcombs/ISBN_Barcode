//
//  ViewController.m
//  ISBN_Barcode
//
//  Created by Scott Combs on 09/09/18.
//  Copyright © 2018 Scott Combs. All rights reserved.
//

#import "ViewController.h"
#import "BarcodeView.h"

@implementation ViewController
@synthesize structure;
@synthesize lCode;
@synthesize gCode;
@synthesize rCode;
@synthesize estructure;

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    structure = @{
        @0:@"LLLLLLRRRRRR",
        @1:@"LLGLGGRRRRRR",
        @2:@"LLGGLGRRRRRR",
        @3:@"LLGGGLRRRRRR",
        @4:@"LGLLGGRRRRRR",
        @5:@"LGGLLGRRRRRR",
        @6:@"LGGGLLRRRRRR",
        @7:@"LGLGLGRRRRRR",
        @8:@"LGLGGLRRRRRR",
        @9:@"LGGLGLRRRRRR"
    };
    
    lCode = @{
        @0:@"0001101",
        @1:@"0011001",
        @2:@"0010011",
        @3:@"0111101",
        @4:@"0100011",
        @5:@"0110001",
        @6:@"0101111",
        @7:@"0111011",
        @8:@"0110111",
        @9:@"0001011"
    };
    
    gCode = @{
        @0:@"0100111",
        @1:@"0110011",
        @2:@"0011011",
        @3:@"0100001",
        @4:@"0011101",
        @5:@"0111001",
        @6:@"0000101",
        @7:@"0010001",
        @8:@"0001001",
        @9:@"0010111"
    };
    
    rCode = @{
        @0:@"1110010",
        @1:@"1100110",
        @2:@"1101100",
        @3:@"1000010",
        @4:@"1011100",
        @5:@"1001110",
        @6:@"1010000",
        @7:@"1000100",
        @8:@"1001000",
        @9:@"1110100"
    };
    
    estructure = @{
        @0:@"GGLLL",
        @1:@"GLGLL",
        @2:@"GLLGL",
        @3:@"GLLLG",
        @4:@"LGGLL",
        @5:@"LLGGL",
        @6:@"LLLGG",
        @7:@"LGLGL",
        @8:@"LGLLG",
        @9:@"LLGLG"
    };
    
    /**/
    NSURL *upcean72URL = [[NSBundle mainBundle] URLForResource:@"UpcEan72" withExtension:@"otf"];
    assert(upcean72URL);
    CFErrorRef error = NULL;
    if (!CTFontManagerRegisterFontsForURL((__bridge CFURLRef)upcean72URL, kCTFontManagerScopeProcess, &error)){
        CFShow(error);
        abort();
    }
    
    NSURL *ocrbURL = [[NSBundle mainBundle] URLForResource:@"OCRB" withExtension:@"otf"];
    assert(ocrbURL);
    error = NULL;
    if (!CTFontManagerRegisterFontsForURL((__bridge CFURLRef)ocrbURL, kCTFontManagerScopeProcess, &error)){
        CFShow(error);
        abort();
    }
     /**/
    
    // Load the default barcode in view
    [self onMap:self];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (NSString*)mapToFont:(NSString*)isbnString {
    NSString* isbn = [isbnString stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSInteger iStructure = [[isbn substringWithRange:NSMakeRange(0, 1)] integerValue];
    NSString* mapString = (NSString*)[self.structure objectForKey:[NSNumber numberWithInteger: iStructure]];
    
    unichar _fchar = (unichar)([isbn characterAtIndex:0]+61);
    NSString* firstChar = [NSString stringWithCharacters:&_fchar length:1];
    unichar _c33 = (unichar)33;
    NSString* char33 = [NSString stringWithCharacters:&_c33 length:1];
    unichar _c108 = (unichar)108;
    NSString* char108 = [NSString stringWithCharacters:&_c108 length:1];
    
    NSString* rtn = [NSString stringWithString:firstChar];
    NSString* iStr = [isbn substringFromIndex:1];
    
    rtn = [rtn stringByAppendingString:char33];
    
    for (NSUInteger i = 0; i < [iStr length]; i++) {
        if (i == 6) {
            unichar _c34 = (unichar)34;
            NSString* char34 = [NSString stringWithCharacters:&_c34 length:1];
            rtn = [rtn stringByAppendingString:char34];
        }
        unichar iStrChar = [iStr characterAtIndex:i];
        switch ([mapString characterAtIndex:i]) {
            case 'L': {
                //Map offset 57 - 48
                unichar t = iStrChar + 9;
                NSString* ts = [NSString stringWithCharacters:&t length:1];
                rtn = [rtn stringByAppendingString:ts];
                break;
            }
            case 'G': {
                //Map offset 67 - 48
                unichar t = iStrChar + 19;
                NSString* ts = [NSString stringWithCharacters:&t length:1];
                rtn = [rtn stringByAppendingString:ts];
                break;
            }
            default:{
                //'R' Map offset 77 - 48
                unichar t = iStrChar + 29;
                NSString* ts = [NSString stringWithCharacters:&t length:1];
                rtn = [rtn stringByAppendingString:ts];
                break;
            }
        }
    }
    rtn = [rtn stringByAppendingString:char33];
    rtn = [rtn stringByAppendingString:char108];
    
    return rtn;
}

- (NSString*)priceString:(NSString*)str {
    NSString* rtn = @"#";
    __unused NSInteger weights[3][5] = {{3,9,3,9,3},
        {0,0,0,0,0},
        {0,0,0,0,0}};
    
    if (str.length > 5) {
        return @"";
    }
    
    NSInteger sum = 0;
    
    for (NSInteger i = 0; i < 5; i++) {
        weights[1][i] = [str characterAtIndex:i];
        weights[2][i] = weights[0][i] * weights[1][i];
        sum += weights[2][i];
    }
    
    NSInteger iStructure = sum % 10;
    __unused NSString* mapStr = (NSString*)[estructure objectForKey:[NSNumber numberWithInteger:iStructure]];
    
    for (NSInteger i = 0; i < str.length; i++) {
        unichar iStrChar = [str characterAtIndex:i];
        
        switch ([mapStr characterAtIndex:i]) {
            case 'L':{
                //L-Code Map offset 37 - 48
                unichar t = iStrChar - 11;
                NSString* ts = [NSString stringWithCharacters:&t length:1];
                rtn = [rtn stringByAppendingString:ts];
                break;
            }
            default:{
                //'G' G-Code Map offset 47 - 48
                unichar t = iStrChar - 1;
                NSString* ts = [NSString stringWithCharacters:&t length:1];
                rtn = [rtn stringByAppendingString:ts];
                break;
            }
        }
        
        if(i < 4){
            unichar t = (unichar)36;
            NSString* ts = [NSString stringWithCharacters:&t length:1];
            rtn = [rtn stringByAppendingString:ts];
        }
    }
    return rtn;
}

- (IBAction)onMap:(id)sender {
    NSString* ean13String = self.ean13TextField.stringValue;
    NSString* isbnString = self.isbnTextField.stringValue;
    NSString* returnString = [self mapToFont:ean13String];
    NSString* price = self.price5TextField.stringValue;
    NSString* priceStr = [self priceString:price];
    returnString = [returnString stringByAppendingString:priceStr];
    if (self.whiteSpaceButton.state == NSOnState) {
        returnString = [returnString stringByAppendingString:@"x"];
    }
    if (self.triangleButton.state == NSOnState) {
        returnString = [returnString stringByAppendingString:@"w"];
    }
    
    //NSLog(@"%@", [NSString stringWithFormat:@"Input: %@ | Output: %@", ean13String, returnString]);
    self.barcodeView.barcode = [NSString stringWithString:returnString];
    self.barcodeView.isbn = [NSString stringWithFormat:@"ISBN %@", isbnString];
    //NSLog(@"%@", [NSString stringWithFormat:@"barcode: %@", self.barcodeView.barcode]);
    [self.barcodeView setNeedsDisplay:YES];
}

- (IBAction)onPrintBarcode:(id)sender{
    [self onMap:self];
    [self.barcodeView print:nil];
}

- (IBAction)saveDocument:(id)sender{
    // Set the default name for the file and show the panel.
    NSSavePanel* panel = [NSSavePanel savePanel];
    [panel setNameFieldStringValue:[NSString stringWithFormat:@"%@.pdf", self.barcodeView.isbn]];
    [panel beginSheetModalForWindow:self.view.window completionHandler:^(NSInteger result){
        if (result == NSModalResponseOK)
        {
            NSURL*  theFile = [panel URL];
            
            // Write the contents in the new format.
            [self onMap:self];
            NSData* data = [self.barcodeView dataWithPDFInsideRect:self.barcodeView.bounds];
            NSData* pdfNSData = [[NSData alloc]initWithData:data];
            [pdfNSData writeToURL:theFile atomically:YES];
        }
    }];
    
}

- (IBAction)onChange:(id)sender {
    [self onMap:sender];
}


@end
