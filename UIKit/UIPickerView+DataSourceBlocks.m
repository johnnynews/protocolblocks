//
// ProtocolBlocks: UIKit/UIPickerView+DataSourceBlocks.m
// http://protocolblocks.org/
//
// Copyright 2011 Constantin Rack, VIGOS AG. All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification, are
// permitted provided that the following conditions are met:
//
//    1. Redistributions of source code must retain the above copyright notice, this list of
//       conditions and the following disclaimer.
//
//    2. Redistributions in binary form must reproduce the above copyright notice, this list
//       of conditions and the following disclaimer in the documentation and/or other materials
//       provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY CONSTANTIN RACK ``AS IS'' AND ANY EXPRESS OR IMPLIED
// WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
// FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL CONSTANTIN RACK OR
// CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
// ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
// NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
// ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "UIPickerView+DataSourceBlocks.h"
#import <objc/runtime.h>

static NSString* UIPickerViewDataSourceBlocksKey = @"UIPickerViewDataSourceBlocksKey";

@implementation UIPickerView (DataSourceBlocks)

-(id)datasourceblocks {
    UIPickerViewDataSourceBlocks* dataSource = [[[UIPickerViewDataSourceBlocks alloc] init] autorelease];
    objc_setAssociatedObject (self, &UIPickerViewDataSourceBlocksKey, dataSource, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.dataSource = dataSource;
    return self;
}

-(void)setNumberOfComponentsInPickerViewBlock:(UIPickerViewNumberOfComponentsInPickerViewBlock)block {
    [((UIPickerViewDataSourceBlocks*)self.dataSource) setNumberOfComponentsInPickerViewBlock:block];
}

-(void)setNumberOfRowsInComponentBlock:(UIPickerViewNumberOfRowsInComponentBlock)block {
    [((UIPickerViewDataSourceBlocks*)self.dataSource) setNumberOfRowsInComponentBlock:block];
}

@end

@implementation UIPickerViewDataSourceBlocks

@synthesize numberOfComponentsInPickerViewBlock = _numberOfComponentsInPickerViewBlock;
@synthesize numberOfRowsInComponentBlock = _numberOfRowsInComponentBlock;

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView  {
    UIPickerViewNumberOfComponentsInPickerViewBlock block = [self.numberOfComponentsInPickerViewBlock copy];
    NSInteger result = block(pickerView);
    [block release];
    return result;
}

-(NSInteger)pickerView:(UIPickerView*)pickerView numberOfRowsInComponent:(NSInteger)component  {
    UIPickerViewNumberOfRowsInComponentBlock block = [self.numberOfRowsInComponentBlock copy];
    NSInteger result = block(pickerView, component);
    [block release];
    return result;
}


@end
