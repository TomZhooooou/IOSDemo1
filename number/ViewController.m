//
//  ViewController.m
//  number
//
//  Created by tomyhzhou on 2020/9/11.
//  Copyright © 2020 tomyhzhou. All rights reserved.
//

#import "ViewController.h"
#import "contact.h"
#import "ModificationViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
{
//    BOOL _sfafasdfas;
    NSMutableArray *_contacts;
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad]; //super作用？
//    NSLog(@"======");
//    // Do any additional setup after loading the view.
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//    label.text = @"123";
//    [self.view addSubview:label];
//
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    imageView.backgroundColor = [UIColor blueColor];
//
//    [self.view addSubview:imageView];
    
    //    UIButton *button;
    //    UITextField *textField;
    
    // 定义 tableview
    [self initData];
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    
    
}

-(void) initData{
    
    _contacts = [[NSMutableArray alloc] init];
    contact *con1 = [[contact alloc] initWithName:@"Tom" andPhoneNumber:@"18715852616" andAvatar:[UIImage imageNamed:@"down.jpg"]]; // 动态的初始化方式
    contact *con2 = [[contact alloc] initWithName:@"Bob" andPhoneNumber:@"18777777777" andAvatar:[UIImage imageNamed:@"down.jpg"]];
    //静态的话不用先alloc一个空间
    _contacts = [NSMutableArray arrayWithObjects:con1, con2, nil];
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *) tableView{
    NSLog(@"计算分组数");
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section{
    NSLog(@"计算每组(组%li)行数",(long)section);
    //contact =_contacts[section];
    return _contacts.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSIndexPath是一个结构体，记录了组和行信息
    NSLog(@"生成单元格(行%li)",indexPath.row);
    //KCContactGroup *group=_contacts[indexPath.section];
    contact *con = _contacts[indexPath.row];
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    
    
    //image
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"download" ofType:@"jpg"];
    UIImage *image1 = [UIImage imageWithContentsOfFile:imagePath];
    UIImage *image2 = [UIImage imageNamed:@"download.jpg"];
    cell.imageView.image = image1;
    CGSize itemSize = CGSizeMake(40, 40);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    cell.textLabel.text=con.name;
    NSLog(@"%@",con.phoneNumber);
    cell.detailTextLabel.text=con.phoneNumber;  //无法显示 电话号码
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    contact *con = _contacts[indexPath.row];
//    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"System Info" message:con.name delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
//    alert.alertViewStyle=UIAlertViewStylePlainTextInput; //设置窗口内容样式
//    UITextField *textField= [alert textFieldAtIndex:0]; //取得文本框
//    textField.text=con.phoneNumber; //设置文本框内容
//    [alert show]; //显示窗口
    
    // 需要 将 con 这个对象传入到新的这个界面中，并允许修改
    
    ModificationViewController *detailModification = [[ModificationViewController alloc]init];
    [self presentViewController:detailModification animated:YES completion:nil];
    
    [self.navigationController pushViewController:detailModification animated:NO];
}


//-(NSNumber *)sectionIndexTitlesForTableView:(UITableView *)tableView{
//    NSLog(@"生成组索引");
//    NSNumber *someNumber = [NSNumber numberWithInt:_contacts.count];
//    int counter = 0;
//    return someNumber;
//}


//没有反应？
/*
-(CGFloat) tableView:(UITableView *) tableView heightForRowAtIndexPath:(NSIndexPath *) indexPath{
    return 100;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 40;
}
 
 */


- (IBAction)addAction:(id)sender {
    
}

@end
