//
//  IPZInfiniteImagePageControl.m
//  IPZInfiniteImagePageControl
//
//  Created by 刘宁 on 15/12/30.
//  Copyright © 2015年 ipaynow. All rights reserved.
//

#import "IPZInfiniteImagePageControl.h"

@interface IPZInfiniteImagePageControl ()<UIScrollViewDelegate>

@end

@implementation IPZInfiniteImagePageControl
{
    __weak UIScrollView     *_sv;
    __weak UIPageControl *_pageControl;
    __weak UIView              *_containerView;
    CGFloat            _viewWidth;
    CGFloat            _viewHeight;
    
    NSArray           *_imageNames;
    NSInteger        _currentIndex;
    
    __weak UIImageView *_firstImageView;
    __weak UIImageView *_secondImageView;
    __weak UIImageView *_thirdImageView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(IPZInfiniteImagePageControl *)initWithFrame:(CGRect)frame andImageArrar:(NSArray *)imageNames{
    self=[super initWithFrame:frame];
    _viewWidth=CGRectGetWidth(frame);
    _viewHeight=CGRectGetHeight(frame);
    _imageNames=imageNames;
    
    [self initScrollView];
    
    [self initImageView];
    
    [self initPageView];
    
    return self;
}

- (void)initScrollView{
    UIScrollView *sv=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, _viewWidth, _viewHeight)];
    sv.contentSize=CGSizeMake(_viewWidth*3, _viewHeight);
    sv.showsHorizontalScrollIndicator=false;
    sv.showsVerticalScrollIndicator=false;
    sv.pagingEnabled=true;
    sv.delegate=self;
    [self addSubview:sv];
    _sv=sv;
    
    UIView *containerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _viewWidth*3, _viewHeight)];
    [sv addSubview:containerView];
    _containerView=containerView;
}

- (void)initPageView{
    UIPageControl *page=[[UIPageControl alloc]initWithFrame:CGRectMake(0, _viewHeight-20, _viewWidth, 20)];
    page.numberOfPages=_imageNames.count;
    page.currentPage=0;
    _currentIndex=0;
    [self addSubview:page];
    _pageControl=page;
}

- (void)initImageView{
    NSInteger imageCount=_imageNames.count;
    for (int i=0; i<3; i++) {
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(i*_viewWidth, 0, _viewWidth, _viewHeight)];
        imageView.image=[UIImage imageNamed:_imageNames[(i-1+imageCount)%imageCount]];
        imageView.tag=(i+1)*100;
        [_containerView addSubview:imageView];
    }
    [_sv scrollRectToVisible:CGRectMake(_viewWidth, 0, _viewWidth, _viewHeight) animated:true];
}

#pragma mark -
#pragma mark UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    // switch the indicator when more than 50% of the previous/next page is visible
    CGFloat offsetX=scrollView.contentOffset.x;
    if (offsetX<_viewWidth/2) {
        [self moveToLeft];
    }else if (offsetX>_viewWidth*1.5){
        [self moveToRight];
    }else{
        [scrollView scrollRectToVisible:CGRectMake(_viewWidth, 0, _viewWidth, _viewHeight) animated:true];
    }
}

- (void)moveToRight{
    NSInteger currentPage=_pageControl.currentPage;
    if (currentPage==_imageNames.count-1 ) {
        _pageControl.currentPage=0;
    }else{
        _pageControl.currentPage+=1;
    }
    
    for (int i=1; i<4; i++) {
        UIImageView *imageView=[_containerView viewWithTag:i*100];
        CGPoint center = [_containerView convertPoint:imageView.center toView:_sv];
        if(i==1){
            imageView.tag=400;
            center.x +=2*_viewWidth;
        }else{
            imageView.tag-=100;
            center.x -=_viewWidth;
        }
        imageView.center = [_sv convertPoint:center toView:_containerView];
    }
    
    UIImageView *thirdImageView=[_containerView viewWithTag:400];
    thirdImageView.tag=300;
    thirdImageView.image=[UIImage imageNamed:_imageNames[(_pageControl.currentPage+1)%_imageNames.count]];
    
    _sv.contentOffset=CGPointMake(_viewWidth, 0);
}

- (void)moveToLeft{
    NSInteger currentPage=_pageControl.currentPage;
    if (currentPage==0) {
        _pageControl.currentPage=_imageNames.count;
    }else{
        _pageControl.currentPage-=1;
    }
    
    for (int i=3; i>0; i--) {
        UIImageView *imageView=[_containerView viewWithTag:i*100];
        imageView.tag+=100;
        
        CGPoint center = [_containerView convertPoint:imageView.center toView:_sv];
        if(i==3){
            center.x -=2*_viewWidth;
        }else{
            center.x +=_viewWidth;
        }
        imageView.center = [_sv convertPoint:center toView:_containerView];
    }
    
    UIImageView *thirdImageView=[_containerView viewWithTag:400];
    thirdImageView.tag=100;
    NSInteger imageCount=_imageNames.count;
    thirdImageView.image=[UIImage imageNamed:_imageNames[(_pageControl.currentPage-1+imageCount)%imageCount]];
    _sv.contentOffset=CGPointMake(_viewWidth, 0);
}

@end
