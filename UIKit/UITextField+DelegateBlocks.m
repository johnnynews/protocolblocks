//
// protocolblocks: UIKit/UITextField+DelegateBlocks.m
// http://protocolblocks.org/
//
// Copyright (C) 2011 by Constantin Rack, VIGOS AG.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "UITextField+DelegateBlocks.h"
#import <objc/runtime.h>

static NSString* UITextFieldDelegateBlocksKey = @"UITextFieldDelegateBlocksKey";

@implementation UITextField (DelegateBlocks)

-(id)delegateblocks {
    UITextFieldDelegateBlocks* delegate = [[[UITextFieldDelegateBlocks alloc] init] autorelease];
    objc_setAssociatedObject (self, &UITextFieldDelegateBlocksKey, delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.delegate = delegate;
    return self;
}

-(void)setShouldChangeCharactersInRangeBlock:(UITextFieldShouldChangeCharactersInRangeBlock)block {
    [((UITextFieldDelegateBlocks*)self.delegate) setShouldChangeCharactersInRangeBlock:block];
}

-(void)setDidBeginEditingBlock:(UITextFieldDidBeginEditingBlock)block {
    [((UITextFieldDelegateBlocks*)self.delegate) setDidBeginEditingBlock:block];
}

-(void)setDidEndEditingBlock:(UITextFieldDidEndEditingBlock)block {
    [((UITextFieldDelegateBlocks*)self.delegate) setDidEndEditingBlock:block];
}

-(void)setShouldBeginEditingBlock:(UITextFieldShouldBeginEditingBlock)block {
    [((UITextFieldDelegateBlocks*)self.delegate) setShouldBeginEditingBlock:block];
}

-(void)setShouldClearBlock:(UITextFieldShouldClearBlock)block {
    [((UITextFieldDelegateBlocks*)self.delegate) setShouldClearBlock:block];
}

-(void)setShouldEndEditingBlock:(UITextFieldShouldEndEditingBlock)block {
    [((UITextFieldDelegateBlocks*)self.delegate) setShouldEndEditingBlock:block];
}

-(void)setShouldReturnBlock:(UITextFieldShouldReturnBlock)block {
    [((UITextFieldDelegateBlocks*)self.delegate) setShouldReturnBlock:block];
}

@end

@implementation UITextFieldDelegateBlocks

@synthesize shouldChangeCharactersInRangeBlock = _shouldChangeCharactersInRangeBlock;
@synthesize didBeginEditingBlock = _didBeginEditingBlock;
@synthesize didEndEditingBlock = _didEndEditingBlock;
@synthesize shouldBeginEditingBlock = _shouldBeginEditingBlock;
@synthesize shouldClearBlock = _shouldClearBlock;
@synthesize shouldEndEditingBlock = _shouldEndEditingBlock;
@synthesize shouldReturnBlock = _shouldReturnBlock;

-(BOOL)textfield:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string  {
    UITextFieldShouldChangeCharactersInRangeBlock block = [self.shouldChangeCharactersInRangeBlock copy];
    BOOL result = block(textField, range, string);
    [block release];
    return result;
}

-(void)textFieldDidBeginEditing:(UITextField*)textField  {
    UITextFieldDidBeginEditingBlock block = [self.didBeginEditingBlock copy];
    block(textField);
    [block release];
}

-(void)textFieldDidEndEditing:(UITextField*)textField  {
    UITextFieldDidEndEditingBlock block = [self.didEndEditingBlock copy];
    block(textField);
    [block release];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField*)textField  {
    UITextFieldShouldBeginEditingBlock block = [self.shouldBeginEditingBlock copy];
    BOOL result = block(textField);
    [block release];
    return result;
}

-(BOOL)textFieldShouldClear:(UITextField*)textField  {
    UITextFieldShouldClearBlock block = [self.shouldClearBlock copy];
    BOOL result = block(textField);
    [block release];
    return result;
}

-(BOOL)textFieldShouldEndEditing:(UITextField*)textField  {
    UITextFieldShouldEndEditingBlock block = [self.shouldEndEditingBlock copy];
    BOOL result = block(textField);
    [block release];
    return result;
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField  {
    UITextFieldShouldReturnBlock block = [self.shouldReturnBlock copy];
    BOOL result = block(textField);
    [block release];
    return result;
}

@end

