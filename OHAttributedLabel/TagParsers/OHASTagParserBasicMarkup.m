//
//  OHASTagParserMarkdown.m
//  OHAttributedLabel
//
//  Created by Olivier Halligon on 27/09/12.
//  Copyright (c) 2012 AliSoftware. All rights reserved.
//

#import "OHASTagParserBasicMarkup.h"
#import "NSAttributedString+Attributes.h"

@implementation OHASTagParserBasicMarkup

+(NSDictionary*)tagMappings
{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            
            ^NSAttributedString*(NSAttributedString* str, NSTextCheckingResult* match) {
                NSRange textRange = [match rangeAtIndex:1];
                NSMutableAttributedString* foundString = [[str attributedSubstringFromRange:textRange] mutableCopy];
                [foundString setTextBold:YES range:NSMakeRange(0,textRange.length)];
                return [foundString autorelease];
            }, @"\\*(.*?)\\*",
            
            ^NSAttributedString*(NSAttributedString* str, NSTextCheckingResult* match) {
                NSRange textRange = [match rangeAtIndex:1];
                NSMutableAttributedString* foundString = [[str attributedSubstringFromRange:textRange] mutableCopy];
                [foundString setTextIsUnderlined:YES];
                return [foundString autorelease];
            }, @"_(.*?)_",
            
            ^NSAttributedString*(NSAttributedString* str, NSTextCheckingResult* match) {
                NSRange textRange = [match rangeAtIndex:1];
                NSMutableAttributedString* foundString = [[str attributedSubstringFromRange:textRange] mutableCopy];
                CTFontRef font = [str fontAtIndex:textRange.location effectiveRange:NULL];
                [foundString setFontName:@"Courier" size:CTFontGetSize(font)];
                return [foundString autorelease];
            }, @"`(.*?)`",
            
            ^NSAttributedString*(NSAttributedString* str, NSTextCheckingResult* match) {
                NSString* colorName = [str attributedSubstringFromRange:[match rangeAtIndex:1]].string;
                UIColor* color = UIColorFromString(colorName);
                NSRange textRange = [match rangeAtIndex:2];
                NSMutableAttributedString* foundString = [[str attributedSubstringFromRange:textRange] mutableCopy];
                [foundString setTextColor:color];
                return [foundString autorelease];
            }, @"\\{(.*?)\\|(.*?)\\}",
            
            nil];
}

@end
