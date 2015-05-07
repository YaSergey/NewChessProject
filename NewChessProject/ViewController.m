//
//  ViewController.m
//  NewChessProject
//
//  Created by Sergey Yasnetsky on 01.05.15.
//  Copyright (c) 2015 Sergey Yasnetsky. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, weak) UIView *someView;
@property (nonatomic, weak) UIImageView *whiteView;

@property (nonatomic, weak) UIImageView *blackView;
@property (nonatomic, weak) UIView *imageView;

@property (nonatomic, assign) CGPoint differencePoint;
@property (readonly, copy) NSString *bundlePath;
@property (nonatomic, strong) NSMutableArray * nameFiguriesArray;

@end


@implementation ViewController

- (void)viewDidLoad {
    
    [self addFiguriesToBoard];

    const NSInteger maxNumberLine = 8;
    
    NSInteger numberOfLine = 0;
    NSInteger x = 0;
    NSInteger y = 0;
    NSInteger widthSquare = (self.view.bounds.size.height/maxNumberLine);
 
//    NSInteger heightSquare = (self.view.bounds.size.width/ maxNumberLine);

//    NSLog(@"self.view.bounds.size.height %@", self.view.bounds.size.height);
//    CGPoint pointBlack; pointBlack.x = x; pointBlack.y = y;
//    CGSize size; size.width = widthSquare; size.height = widthSquare;
    
//    UIImageView * boardWhiteView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, widthSquare*7, widthSquare*7)];
//    boardWhiteView.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.6];
//    self.imageView = boardWhiteView;
//    [self.view addSubview:boardWhiteView];
    
//    NSInteger widthSquare1 = (boardWhiteView.bounds.size.height/maxNumberLine);

//    CGPoint pointWhite; pointWhite.x = x + size.width; pointWhite.y = y + size.height;
//        CGSize size; sizeWhite.width = 150; sizeWhite.height = 150;
//
    // UIImageView * boardBlackView = [[UIImageView alloc] initWithFrame:CGRectMake(pointWhite.x, pointWhite.y, size.width, size.height)];
    //     boardBlackView.backgroundColor = [UIColor blackColor];
  
    
    for (NSInteger i =0; i<maxNumberLine; i++) {
        for (NSInteger j= 0 ; j<maxNumberLine; j=j+2) {
            
            if (numberOfLine % 2) {
                x = widthSquare * j + widthSquare;
                y = widthSquare * numberOfLine;
            } else {
                x = widthSquare * j;
                y = widthSquare * numberOfLine;
            }
            UIImageView * boardBlackView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, widthSquare, widthSquare)];
            boardBlackView.backgroundColor = [UIColor blackColor];
            self.imageView =  boardBlackView;
            [self.view addSubview: boardBlackView];
            
            if (numberOfLine == 2) {
                
                [self addFiguriesToBoard];
            }

        }
        numberOfLine ++;
    }

//UIImageView * whiteView = [[UIImageView alloc] initWithFrame:CGRectMake(10,200,100,100)];
//    whiteView.backgroundColor = [UIColor lightGrayColor];
//    self.whiteView.multipleTouchEnabled = YES;
//    self.imageView = whiteView;
//    [self.view addSubview:whiteView];
//    [self.view addSubview:boardView];

    
// одинарный клик
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    
    tapGesture.numberOfTapsRequired = 1;
//    tapGesture.numberOfTouchesRequired = 2;

//    [boardWhiteView addGestureRecognizer:tapGesture];

//двойной клик
    UITapGestureRecognizer * doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    
    doubleTapGesture.numberOfTapsRequired = 2;
    
//    [boardWhiteView addGestureRecognizer:doubleTapGesture];
    [tapGesture requireGestureRecognizerToFail:doubleTapGesture];
    
// долгое нажатие
    UILongPressGestureRecognizer * longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];

    longPress.minimumPressDuration = 5.0f;
    
//    [boardWhiteView addGestureRecognizer:longPress];

    UISwipeGestureRecognizer * swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionDown;
    
//    [boardWhiteView addGestureRecognizer:swipeGesture];
    
    
   /*
    UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(100, 150, 200, 30)];
    
    UILabel * textLabel = [[UILabel alloc] initWithFrame:CGRectMake(150,300,200, 30)];
    
    UITextField * textField_1 = [[UITextField alloc] initWithFrame:CGRectMake(100, 250, 200, 30)];
    
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField_1.borderStyle = UITextBorderStyleLine;
    
    
    [self.view addSubview:textField];
    [self.view addSubview:textField_1];
    */
    
    [super viewDidLoad];
    
}

- (void) handleTap:  (UITapGestureRecognizer *) tapGesture {
    NSLog(@"handleTap");
}


- (void) handleDoubleTap:  (UITapGestureRecognizer *) tapGesture {
    NSLog(@"handleDoubleTap");
}


- (void) longPress: (UILongPressGestureRecognizer *) longPress {
    NSLog(@"longPress");
}

- (void) swipe: (UISwipeGestureRecognizer *) swipeGesture {
    if (swipeGesture.direction == UISwipeGestureRecognizerDirectionDown) {
        NSLog(@"swipe down");

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch * touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    
    UIView* someAnotherView = [self.view hitTest:point withEvent:event];
    
    if (![someAnotherView isEqual:self.view]) {
        self.someView = someAnotherView;
        
        [self.view bringSubviewToFront:self.someView];
        
        UITouch * touch = [touches anyObject];
        CGPoint point = [touch locationInView:self.someView];
        
        self.differencePoint = CGPointMake(CGRectGetMidX(self.someView.bounds)-point.x, CGRectGetMidY(self.someView.bounds)-point.y);
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.someView.transform = CGAffineTransformMakeScale(1.3f, 1.3f);
            self.someView.alpha = 0.5;
        }];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if (self.someView) {
        UITouch * touch = [touches anyObject];
        CGPoint point = [touch locationInView:self.view];

        CGPoint mainPoint = CGPointMake(point.x + self.differencePoint.x, point.y + self.differencePoint.y);
        
        self.someView.center = mainPoint;
    
    }
    
//    UITouch * touch = [touches anyObject];
//    CGPoint pointMoved = [touch locationInView:self.view];
//    
//    NSLog(@"touchesMoved %@", touch);

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.someView.transform = CGAffineTransformIdentity;
        self.someView.alpha = 1.0;
    }];
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    
}

#pragma mark - figuries

- (void) addFiguriesToBoard {
    
    NSMutableArray * figuriesArray = [NSMutableArray array];
    NSMutableArray * nameFiguriesArray = [NSMutableArray array];
    NSFileManager * manager = [NSFileManager new];
    NSBundle * bungle = [NSBundle mainBundle];
    NSDirectoryEnumerator * enumerator = [manager enumeratorAtPath:[bungle bundlePath]];
    
    NSLog(@"enumerator %@", enumerator);
    
    for (NSString * figuriesName in enumerator) {
        if ([figuriesName hasSuffix:@".jpg"] || [figuriesName hasSuffix:@".png"] || [figuriesName hasSuffix:@".jpeg"])
            
        {
            [nameFiguriesArray addObject:figuriesName];
        }
    }
    
    NSLog(@"nameFiguriesArray %@", nameFiguriesArray);
    
    
    for (NSString * imageFiguriesNames in nameFiguriesArray) {
        
        UIImage * image = [UIImage imageNamed:imageFiguriesNames];
        [figuriesArray addObject:image];
        
    }
    
    NSLog(@"imagesArray %@", figuriesArray);
    
    for (int i = 0; i < figuriesArray.count; i++) {
        
        UIView * figureView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 80, 80)];
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:figureView.bounds];
          
        imageView.image = [figuriesArray objectAtIndex:i];
        [figureView addSubview:imageView];
        [self.view addSubview:figureView];
        
    }
}





@end
