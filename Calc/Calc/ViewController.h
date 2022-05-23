//
//  ViewController.h
//  Calc
//
//  Created by Matheus Lenke on 20/05/22.
//

#import <UIKit/UIKit.h>

typedef enum { PLUS, MINUS, MULTIPLY, DIVIDE } CalculatorOperation;

@interface ViewController : UIViewController {
    IBOutlet UITextField *display;
    NSString *storage;
    CalculatorOperation operation;
}
-(IBAction)button1;
-(IBAction)button2;
-(IBAction)button3;
-(IBAction)button4;
-(IBAction)button5;
-(IBAction)button6;
-(IBAction)button7;
-(IBAction)button8;
-(IBAction)button9;
-(IBAction)button0;

-(IBAction)plusButton;
-(IBAction)minusButton;
-(IBAction)multiplyButton;
-(IBAction)divideButton;

-(IBAction)buttonEquals;
-(IBAction)buttonClear;

-(IBAction) goToDetails;

@end

