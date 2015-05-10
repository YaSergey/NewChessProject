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
@property (nonatomic, weak) UIImageView *boardWhiteView;

@property (nonatomic, weak) UIImageView *blackView;
@property (nonatomic, weak) UIView *imageView;
@property (nonatomic, assign) NSInteger widthSquare1;
@property (nonatomic, assign) NSInteger boardX;
@property (nonatomic, assign) NSInteger boardY;

@property (nonatomic, assign) NSInteger boardWidht;
@property (nonatomic, assign) NSInteger boardHeight;


@property (nonatomic, assign) CGPoint differencePoint;
@property (readonly, copy) NSString *bundlePath;
@property (nonatomic, strong) NSMutableArray * nameFiguriesArray;
@property (nonatomic, strong) NSMutableArray * imagesArrayBlackPawn;

//@property (nonatomic, strong) NSInteger * widthSquare1;


@end


const NSInteger maxNumberLine = 8;


@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    

    [self makeChessBoard];

    [self addFiguriesToBoard];
    

    
/*    NSInteger heightSquare = (self.view.bounds.size.width/ maxNumberLine);

    NSLog(@"self.view.bounds.size.height %@", self.view.bounds.size.height);
    CGPoint pointBlack; pointBlack.x = x; pointBlack.y = y;
    CGSize size; size.width = widthSquare; size.height = widthSquare;
    
    UIImageView * boardWhiteView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, widthSquare*7, widthSquare*7)];
    boardWhiteView.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.6];
    self.imageView = boardWhiteView;
    [self.view addSubview:boardWhiteView];
    
 NSInteger widthSquare1 = (boardWhiteView.bounds.size.height/maxNumberLine);

    CGPoint pointWhite; pointWhite.x = x + size.width; pointWhite.y = y + size.height;
        CGSize size; sizeWhite.width = 150; sizeWhite.height = 150;

     UIImageView * boardBlackView = [[UIImageView alloc] initWithFrame:CGRectMake(pointWhite.x, pointWhite.y, size.width, size.height)];
         boardBlackView.backgroundColor = [UIColor blackColor];
 */
    
}

- (void) makeChessBoard { // метод отрисовки шахматной доски

    NSInteger numberOfLine = 0;
    NSInteger x = 0;
    NSInteger y = 0;
    NSInteger widthSquare = (self.view.bounds.size.height/maxNumberLine);
    NSInteger lineNumber;
    NSInteger numberSignPoint = 0;
    NSInteger letterSign = 0;
    
// опеределение координат и шахматной доски
   
    self.boardX = self.view.frame.size.width/2 - self.view.bounds.size.width/2;
    self.boardY = self.view.frame.size.height/2 - self.view.bounds.size.height/2;
   
// опеределение размера и переменных шахматной доски

    self.boardWidht = self.view.bounds.size.width - self.boardX*10;
    self.boardHeight = self.view.bounds.size.height - self.boardY*10;
    
    UIImageView * boardContur = [[UIImageView alloc] initWithFrame:CGRectMake(50, 50, 700, 700)];
    boardContur.backgroundColor = [UIColor darkGrayColor];
    self.imageView = boardContur;
    [self.view addSubview: boardContur];
    
    
UIImageView * boardWhiteView = [[UIImageView alloc] initWithFrame:CGRectMake(boardContur.frame.size.width/2 - boardContur.frame.size.width/2.25, boardContur.frame.size.height/2 - boardContur.frame.size.height/2.25, boardContur.frame.size.width*0.9, boardContur.frame.size.height*0.9)];
    
        boardWhiteView.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.6];
        
        self.imageView = boardWhiteView;
        [boardContur addSubview:boardWhiteView];
        
        self.widthSquare1 = (boardWhiteView.bounds.size.height/maxNumberLine);
        
// цикл создания черных клеток доски
        
        for (NSInteger i =0; i<maxNumberLine; i++) {
            for (NSInteger j= 0 ; j<maxNumberLine; j=j+2) {
                
                if (numberOfLine % 2) {
                    y = self.widthSquare1 * j + self.widthSquare1;
                    x = self.widthSquare1 * numberOfLine;
                } else {
                    y = self.widthSquare1 * j;
                    x = self.widthSquare1 * numberOfLine;
                }
                UIImageView * boardBlackView = [[UIImageView alloc] initWithFrame:CGRectMake(x+3, y+3, self.widthSquare1, self.widthSquare1)];
                boardBlackView.backgroundColor = [UIColor blackColor];
                self.imageView =  boardBlackView;
                
                [boardWhiteView addSubview: boardBlackView];
            
            }

            numberOfLine ++;

            NSLog(@"numberOfLine %ld" , (long)numberOfLine);

//нумерация шахматных линий от 1 до 8
            
            UILabel * textLineNumber = [[UILabel alloc] initWithFrame:CGRectMake(15, 70+numberSignPoint, 20, 20)];
            textLineNumber.text = [NSString stringWithFormat:@"%li", (long)numberOfLine];
            textLineNumber.textColor = [UIColor redColor];
            [boardContur addSubview:textLineNumber];
            
            numberSignPoint = numberSignPoint + self.widthSquare1;
 
//буквенные обозначения шахматных линий от A до F
            UILabel * textLetterSign = [[UILabel alloc] initWithFrame:CGRectMake(70+letterSign, 15, 20, 20)];
            textLetterSign.text = [NSString stringWithFormat: @"%li", (long)numberOfLine];
            textLetterSign.textColor = [UIColor redColor];
            [boardContur addSubview:textLetterSign];
            letterSign =letterSign + self.widthSquare1;
    }

    
    
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

- (void) figuriesNamesArray {
   
    NSMutableArray * imagesArrayBlackPawn = [[NSMutableArray alloc] init];
    
    NSMutableArray * figuriesNamesArr = [[NSMutableArray alloc]init];

    NSString * stringFiguriesName = @"Bishop,King,Knight,Pawn,Queen,Rook";

    NSString * stringFiguriesPlace = @"100,120,300,400,600";

    for (int i = 0, m = 0; i < imagesArrayBlackPawn.count; i++) {
        
//        int j = KONST_j;
//        int k = KONST_i;
        
//        UIView * figureView = [[UIView alloc] initWithFrame:CGRectMake(k+m, k+j , j, j)];
//        UIImageView * imageView = [[UIImageView alloc]initWithFrame:figureView.bounds];
//        m = m+j;
//        
//        imageView.image = [imagesArrayBlackPawn objectAtIndex:i];
//        [figureView addSubview:imageView];
//        [self.view addSubview:figureView];
    }
    
    
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

// добавление фигур на доску.


- (void) addFiguriesToBoard {
    
    NSMutableArray * figuriesArray = [NSMutableArray array];
    NSMutableArray * nameFiguriesArray = [NSMutableArray array];
    NSFileManager * manager = [NSFileManager new];
    NSBundle * bungle = [NSBundle mainBundle];
    NSDirectoryEnumerator * enumerator = [manager enumeratorAtPath:[bungle bundlePath]];

//    NSInteger * figuriesSize = [self  widthSquare1];
//    NSInteger figuriesSize = (self.boardWhiteView.bounds.size.height/maxNumberLine);
    
    NSLog(@"enumerator %@", enumerator);
    
    for (NSString * figuriesName in enumerator) {
        if ([figuriesName hasSuffix:@".jpg"] || [figuriesName hasSuffix:@".png"] || [figuriesName hasSuffix:@".jpeg"])
            
        {
            [nameFiguriesArray addObject:figuriesName];
        }
    }
    
//    NSLog(@"nameFiguriesArray %@", nameFiguriesArray);
    
    
    for (NSString * imageFiguriesNames in nameFiguriesArray) {
        
        UIImage * image = [UIImage imageNamed:imageFiguriesNames];
        [figuriesArray addObject:image];
        
    }

//    NSLog(@"imagesArray %@", figuriesArray);
    
    for (int i = 0; i < figuriesArray.count; i++) {
        
        UIView * figureView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, self.widthSquare1*0.7, self.widthSquare1*0.7)];
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:figureView.bounds];
          
        imageView.image = [figuriesArray objectAtIndex:i];
        [figureView addSubview:imageView];
        [self.view addSubview:figureView];
        
    }
}





@end
