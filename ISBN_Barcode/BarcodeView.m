//
//  BarcodeView.m
//  ISBN_Barcode
//
//  Created by Scott Combs on 09/09/18.
//  Copyright © 2018 Scott Combs. All rights reserved.
//

#import "BarcodeView.h"

@implementation BarcodeView
@synthesize barcode;
@synthesize isbn;

- (NSString*)mapToName:(NSString *)inChar{
    switch ([inChar characterAtIndex:0]) {
        case '!':{
            return @"exclam";
            break;
        }
        case '"':{
            return @"quotedbl";
            break;
        }
        case '#':{
            return @"numbersign";
            break;
        }
        case '$':{
            return @"dollar";
            break;
        }
        case '%':{
            return @"percent";
            break;
        }
        case '&':{
            return @"ampersand";
            break;
        }
        case '\'':{
            return @"quotesingle";
            break;
        }
        case '(':{
            return @"parenleft";
            break;
        }
        case ')':{
            return @"parenright";
            break;
        }
        case '*':{
            return @"asterisk";
            break;
        }
        case '+':{
            return @"plus";
            break;
        }
        case ',':{
            return @"comma";
            break;
        }
        case '-':{
            return @"hyphen";
            break;
        }
        case '.':{
            return @"period";
            break;
        }
        case '/':{
            return @"slash";
            break;
        }
        case ':':{
            return @"colon";
            break;
        }
        case ';':{
            return @"semicolon";
            break;
        }
        case '<':{
            return @"less";
            break;
        }
        case '=':{
            return @"equal";
            break;
        }
        case '>':{
            return @"greater";
            break;
        }
        case '?':{
            return @"question";
            break;
        }
        case '@':{
            return @"at";
            break;
        }
        case '[':{
            return @"bracketleft";
            break;
        }
        case '\\':{
            return @"backslash";
            break;
        }
        case ']':{
            return @"bracketright";
            break;
        }
        case '^':{
            return @"asciicircum";
            break;
        }
        case '_':{
            return @"underscore";
            break;
        }
        case '`':{
            return @"grave";
            break;
        }
        case '0':{
            return @"zero";
            break;
        }
        case '1':{
            return @"one";
            break;
        }
        case '2':{
            return @"two";
            break;
        }
        case '3':{
            return @"three";
            break;
        }
        case '4':{
            return @"four";
            break;
        }
        case '5':{
            return @"five";
            break;
        }
        case '6':{
            return @"six";
            break;
        }
        case '7':{
            return @"seven";
            break;
        }
        case '8':{
            return @"eight";
            break;
        }
        case '9':{
            return @"nine";
            break;
        }
        case ' ':{
            return @"space";
            break;
        }
        default:
            return inChar;
            break;
    }
    
    return @"";
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
   
    if (self.barcode.length > 0) {
        
        /************ EMBEDDING FONT NOT USED *******************/
//        NSFont* upcEan72 = [NSFont fontWithName:@"UpcEan72" size:72.0];
//        NSDictionary* attributes = [NSDictionary dictionaryWithObjectsAndKeys:
//                                    upcEan72, kCTFontAttributeName, nil];
//        [self.barcode drawAtPoint:NSMakePoint(10.0, 10.0) withAttributes:attributes];
//
//        NSFont* ocrb9 = [NSFont fontWithName:@"OCRB" size:9.0];
//        attributes = [NSDictionary dictionaryWithObjectsAndKeys:
//                                    ocrb9, kCTFontAttributeName, nil];
//        [self.isbn drawAtPoint:NSMakePoint(18.0, 85.0) withAttributes:attributes];
        
        /************* CONVERT FONT TO OUTLINES **********/
        // Get the fonts
        NSFont* upcEan72font = [NSFont fontWithName:@"UpcEan72" size:72.0];
        NSFont* ocrbFont = [NSFont fontWithName:@"OCRB" size:9.0];
        
        // Get a Bezier path
        NSBezierPath* glyphPath = [NSBezierPath bezierPath];

        [glyphPath moveToPoint: NSMakePoint(10.0, 10.0)];
        // Build glyph array of the barcode
        NSUInteger stringCount = [barcode length];
        NSGlyph* glyphs = (NSGlyph*)malloc(sizeof(NSGlyph)*stringCount);
        for(int stringIndex = 0; stringIndex < stringCount; stringIndex++){
            NSString* singleCharacter = [barcode substringWithRange: NSMakeRange(stringIndex, 1)];
            NSString* charName = [self mapToName:singleCharacter];
            
            glyphs[stringIndex] = [upcEan72font glyphWithName: charName];
            //NSLog(@"Barcode: %@ | Char: %@ | Glyph: %ul", barcode, singleCharacter, glyphs[stringIndex]);
        }
        
        // Add glyphs to path
        [glyphPath appendBezierPathWithGlyphs: glyphs count: stringCount inFont: upcEan72font];
       
        free(glyphs);
        [glyphPath moveToPoint:NSMakePoint(19.0, 82.0)];
        
        // Build glyph array of isbn string
        stringCount = [self.isbn length];
        glyphs = (NSGlyph*)malloc(sizeof(NSGlyph)*stringCount);
        for(int stringIndex = 0; stringIndex < stringCount; stringIndex++){
            NSString* singleCharacter = [self.isbn substringWithRange: NSMakeRange(stringIndex, 1)];
            NSString* charName = [self mapToName:singleCharacter];
            glyphs[stringIndex] = [ocrbFont glyphWithName: charName];
            //NSLog(@"Barcode: %@ | Char: %@ | Glyph: %ul", barcode, singleCharacter, glyphs[stringIndex]);
        }
        
        // Add glyphs to path
        [glyphPath appendBezierPathWithGlyphs: glyphs count: stringCount inFont: ocrbFont];
        
        free(glyphs);
        
        // Set the color to black
        [[NSColor blackColor] set];
        [glyphPath fill];
    
    }
}


@end
