//
//  MDBaseModuleView.m
//  MDReactPageKit
//
//  Created by lizitao on 2018/2/1.
//

#import "MDBaseModuleView.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "MDBaseModuleViewDelegate.h"

@interface MDBaseModuleView ()<MDBaseModuleViewDelegate>
@end

@implementation MDBaseModuleView

- (instancetype)initWithBoard:(ReactiveBlackBoard *)blackBoard
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        _heightSignal = [RACSubject subject];
        _blackBoard = blackBoard;
    }
    return self;
}

- (BOOL)isModuleNeedFixed
{
    return NO;
}

- (BOOL)isModuleNeedFixedToTop
{
    return NO;
}

- (BOOL)isModuleNeedFixedToBottom
{
    return NO;
}

- (void)setModuleIndex:(NSUInteger)moduleIndex
{
    _moduleIndex = moduleIndex;
    @weakify(self);
    [[[[RACObserve(self, height) distinctUntilChanged] skip:1] deliverOnMainThread] subscribeNext:^(id x) {
        @strongify(self);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.heightSignal sendNext:[NSNumber numberWithInteger:moduleIndex]];
        });
    }];
}

/***须子类重写***/
- (void)loadModuleSubViews
{
}

/***须子类重写***/
- (void)loadModuleData:(id)model
{
}

/***须子类重写***/
- (void)layoutModuleWidth:(CGFloat)width
{ 
}

/***子类重写***/
- (void)moduleWillAppear
{
}

/***子类重写***/
- (void)moduleDidAppear
{
}

/***子类重写***/
- (void)moduleWillDisappear
{
}

@end
