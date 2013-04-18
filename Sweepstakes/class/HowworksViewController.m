//
//  HowworksViewController.m
//  Sweepstakes
//
//  Created by macmini3 on 21/02/13.
//  Copyright (c) 2013 peerbits@gmail.com. All rights reserved.
//

#import "HowworksViewController.h"

@interface HowworksViewController ()

@end

@implementation HowworksViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    for( UIView *view in _pageone.subviews)
    {
        if([view isKindOfClass:[UILabel class]] && view.tag == 100  )
        {
            [(UILabel *)view setFont:[UIFont fontWithName:@"Calibri-Bold" size:18]];
            
        }
        if([view isKindOfClass:[UILabel class]] && view.tag == 200  )
        {
           [(UILabel *)view setFont: [UIFont fontWithName:@"Calibri" size:16]];
            
        }
    }
    for( UIView *view in _pagetwo.subviews)
    {
        if([view isKindOfClass:[UILabel class]] && view.tag == 100  )
        {
            [(UILabel *)view setFont:[UIFont fontWithName:@"Calibri-Bold" size:18]];
            
        }
        if([view isKindOfClass:[UILabel class]] && view.tag == 200  )
        {
            [(UILabel *)view setFont: [UIFont fontWithName:@"Calibri" size:15]];
            
        }
    }
    for( UIView *view in _pagethree.subviews)
    {
        if([view isKindOfClass:[UILabel class]] && view.tag == 100  )
        {
            [(UILabel *)view setFont:[UIFont fontWithName:@"Calibri-Bold" size:18]];
            
        }
        if([view isKindOfClass:[UILabel class]] && view.tag == 200  )
        {
            [(UILabel *)view setFont: [UIFont fontWithName:@"Calibri" size:16]];
            
        }
    }
    for( UIView *view in _pagefour.subviews)
    {
        if([view isKindOfClass:[UILabel class]] && view.tag == 100  )
        {
            [(UILabel *)view setFont:[UIFont fontWithName:@"Calibri-Bold" size:18]];
            
        }
        if([view isKindOfClass:[UILabel class]] && view.tag == 200  )
        {
            [(UILabel *)view setFont: [UIFont fontWithName:@"Calibri" size:15]];
            
        }
    }


    
    
    pageControlBeingUsed = NO;
    _prevbtn.hidden = YES;
    NSArray *pages = [NSArray arrayWithObjects:_pageone, _pagetwo, _pagethree,_pagefour, nil];
	for (int i = 0; i < pages.count; i++) {
		CGRect frame;
		frame.origin.x = _scrollview.frame.size.width * i;
		frame.origin.y = 0;
		frame.size = _scrollview.frame.size;
		[[pages objectAtIndex:i] setFrame:frame];
		[_scrollview addSubview:[pages objectAtIndex:i]];
		
	}
	
	_scrollview.contentSize = CGSizeMake(_scrollview.frame.size.width * pages.count, _scrollview.frame.size.height);
	
	_pagecontroller.currentPage = 0;
	_pagecontroller.numberOfPages = pages.count;
    // Do any additional setup after loading the view from its nib.
    UISwipeGestureRecognizer *recognizer;
    
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight | UISwipeGestureRecognizerDirectionLeft)];
    [[self view] addGestureRecognizer:recognizer];
    [recognizer addTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer release];
}

- (void)viewWillAppear:(BOOL)animated {
    DELEGATE.nCurrentListItem = CURRENT_LIST_ITEM_HOW_IT_WORKS;
}

-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer {
    if(recognizer.direction == UISwipeGestureRecognizerDirectionRight)
    {
        //click code on top left button
        //[_backbtn setImage:[UIImage imageNamed:@"update04.png"] forState:UIControlStateNormal];
        [DELEGATE.menuController showLeftController:YES];
    }
    else
    {
        
    }
    NSLog(@"Swipe received.");
}
- (void)scrollViewDidScroll:(UIScrollView *)sender {
	if (!pageControlBeingUsed) {
		// Switch the indicator when more than 50% of the previous/next page is visible
		CGFloat pageWidth = _scrollview.frame.size.width;
		int page = floor((_scrollview.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
		_pagecontroller.currentPage = page;
        if (page == 0) {
            _prevbtn.hidden = YES;
            _nextbtn.hidden = NO;
        }
        if (page == 1) {
             _prevbtn.hidden = NO;
            _nextbtn.hidden = NO;
        }
        if (page == 2) {
            _prevbtn.hidden = NO;
            _nextbtn.hidden = NO;
        }

        if (page == 3) {
            _prevbtn.hidden = NO;
            _nextbtn.hidden = YES;
        }
	}
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
	pageControlBeingUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	pageControlBeingUsed = NO;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)close:(id)sender {
    [DELEGATE.menuController showLeftController:YES];
    
}

- (void)dealloc {
    [_nextbtn release];
    [_prevbtn release];
    [_pagecontroller release];
    [_pageone release];
    [_pagetwo release];
    [_pagethree release];
    [_pagefour release];
    [_scrollview release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setNextbtn:nil];
    [self setPrevbtn:nil];
    [self setPagecontroller:nil];
    [self setPageone:nil];
    [self setPagetwo:nil];
    [self setPagethree:nil];
    [self setPagefour:nil];
    [self setScrollview:nil];
    [super viewDidUnload];
}
- (IBAction)goprevious:(id)sender {
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = _scrollview.frame.size.width;
    int page = floor((_scrollview.contentOffset.x - pageWidth / 2) / pageWidth) - 1;
    _pagecontroller.currentPage = page+1;
    	
    CGRect frame;
	frame.origin.x = _scrollview.frame.size.width * _pagecontroller.currentPage;
	frame.origin.y = 0;
	frame.size = _scrollview.frame.size;
	[_scrollview scrollRectToVisible:frame animated:YES];
}

- (IBAction)gonext:(id)sender {
   
		// Switch the indicator when more than 50% of the previous/next page is visible
		CGFloat pageWidth = _scrollview.frame.size.width;
		int page = floor((_scrollview.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
		_pagecontroller.currentPage = page+1;
        	
    CGRect frame;
	frame.origin.x = _scrollview.frame.size.width * _pagecontroller.currentPage;
	frame.origin.y = 0;
	frame.size = _scrollview.frame.size;
	[_scrollview scrollRectToVisible:frame animated:YES];


}

- (IBAction)pagechange:(id)sender {
    // Update the scroll view to the appropriate page
	CGRect frame;
	frame.origin.x = _scrollview.frame.size.width * _pagecontroller.currentPage;
	frame.origin.y = 0;
	frame.size = _scrollview.frame.size;
	[_scrollview scrollRectToVisible:frame animated:YES];
    
	
	// Keep track of when scrolls happen in response to the page control
	// value changing. If we don't do this, a noticeable "flashing" occurs
	// as the the scroll delegate will temporarily switch back the page
	// number.
	pageControlBeingUsed = YES;
}
@end
