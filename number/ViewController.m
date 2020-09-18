//
//  ViewController.m
//  number
//
//  Created by tomyhzhou on 2020/9/11.
//  Copyright © 2020 tomyhzhou. All rights reserved.
//

#import "ViewController.h"
#import "contact.h"

NSString *const NOTIFICATIONFORIMAGEPATH = @"imagePathNotification";


//typedef contact contact;

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
{
//    BOOL _sfafasdfas;
    NSMutableArray *_contacts;
    UITableView *_tableView;
//    NSString *_imagePath
//    UIImage *_image1 = [UIImage imageWithContentsOfFile:imagePath];
//    UIImage *_image2 = [UIImage imageNamed:@"download.jpg"];
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
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void) initData{
    
    _contacts = [[NSMutableArray alloc] init];
    contact *con1 = [[contact alloc] initWithName:@"Tom" andPhoneNumber:@"18715852616" andAvatar:[UIImage imageNamed:@"download.jpg"]]; // 动态的初始化方式
    contact *con2 = [[contact alloc] initWithName:@"Bob" andPhoneNumber:@"18777777777" andAvatar:[UIImage imageNamed:@"download.jpg"]];
    _contacts = [NSMutableArray arrayWithObjects: con1, con2, nil];
    for(int i = 0; i< 10; i++)
    {
        NSString *name = @"Tom";
        name = [name stringByAppendingString:[NSString stringWithFormat:@"%d", i]];
        contact *con = [[contact alloc] initWithName:name andPhoneNumber:[@"1877777777" stringByAppendingString:[NSString stringWithFormat:@"%d", i]] andAvatar:[UIImage imageNamed:@"download.jpg"]];
        [_contacts addObject:con];
    }
    
    
    //静态的话不用先alloc一个空间
    
//    _imagePath = = [[NSBundle mainBundle] pathForResource:@"download" ofType:@"jpg"];
//    _image1
//
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *) tableView{
    NSLog(@"计算分组数");
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section{
    NSLog(@"计算每组(组%li)行数",[_contacts count]);
    //contact =_contacts[section];
    return [_contacts count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSIndexPath是一个结构体，记录了组和行信息
    static NSString *CellIdentifier =  @"UITableViewCell";
    NSLog(@"生成单元格(行%li)",indexPath.row);
    //KCContactGroup *group=_contacts[indexPath.section];
    contact *con = _contacts[indexPath.row];
    UITableViewCell *cell = nil;
//    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];//
    cell = [_tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.imageView.image = con.avatar;
        cell.textLabel.text= con.name;
        cell.detailTextLabel.text=con.phoneNumber;
    }
    //image

    
    
    
//    cell.imageView.image = image1;
//    CGSize itemSize = CGSizeMake(40, 40);
//    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
//    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
//    [cell.imageView.image drawInRect:imageRect];
//    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//
    NSLog(@"cell info%@",cell);
//    cell.textLabel.text=con.name;
//    NSLog(@"%@",con.phoneNumber);
//    cell.detailTextLabel.text=con.phoneNumber;  //无法显示 电话号码
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    contact *con = _contacts[indexPath.row];
//    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"System Info" message:con.name delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
//    alert.alertViewStyle=UIAlertViewStylePlainTextInput; //设置窗口内容样式
//    UITextField *textField= [alert textFieldAtIndex:0]; //取得文本框
//    textField.text=con.phoneNumber; //设置文本框内容
//    [alert show]; //显示窗口
    
    // 需要 将 con 这个对象传入到新的这个界面中，并允许修改
    
    ModificationViewController *detailModification = [[ModificationViewController alloc]init];
    detailModification.delegate = self;
    detailModification.conTempCopy = con;
    detailModification.indexPath = indexPath;
    //observer
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeContact:) name:@"change" object:nil];
    

  
    [self presentViewController:detailModification animated:YES completion:nil];
    

//    dispatch_async(<#dispatch_queue_t  _Nonnull queue#>, <#^(void)block#>)
    
    
//    [self.navigationController pushViewController:detailModification animated:NO];
}

- (void) changeContactWithBloc:(NSIndexPath *)indexPath andVC:(ModificationViewController *) detailModification {
//        todo block
//        传值多次操作的时候刷新存在问题
//        __weak typeof(self)weakSelf = self;
        detailModification.block = ^(contact *con){
        // 通过回调将传进来的字符串赋值给label
        _contacts[indexPath.row] = con;
        [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationFade];
        NSLog(@"name: %@", con.name);
        NSLog(@"Phone Number: %@", con.phoneNumber);
        NSLog(@"Avatar: %@", con.avatar);
        };
}
- (void)changeContact:(NSNotification *)sender{
    NSIndexPath *path =sender.userInfo[@"path"];
    contact* con = _contacts[path.row];
    con.name =sender.userInfo[@"name"];
    con.phoneNumber = sender.userInfo[@"phoneNumber"];
    con.avatar = [UIImage imageWithContentsOfFile: sender.userInfo[NOTIFICATIONFORIMAGEPATH]];
//    con.avatar = _contacts[path.row].avatar;
    _contacts[path.row] = con;
    [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:path,nil] withRowAnimation:UITableViewRowAnimationFade];
}

//-(NSNumber *)sectionIndexTitlesForTableView:(UITableView *)tableView{
//    NSLog(@"生成组索引");
//    NSNumber *someNumber = [NSNumber numberWithInt:_contacts.count];
//    int counter = 0;
//    return someNumber;
//}

-(void) selectedIndexPath:(NSIndexPath *)indexPathSelected changedCon:(contact *)con{
    _contacts[indexPathSelected.row] = con;
//    _contacts[indexPathSelected.row].phoneNumber = con.phoneNumber;
//    _contacts[indexPathSelected.row].avatar = con.avatar;
    NSLog(@"name: %@", con.name);
    NSLog(@"Phone Number: %@", con.phoneNumber);
    NSLog(@"Avatar: %@", con.avatar);
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPathSelected,nil] withRowAnimation:UITableViewRowAnimationFade];
    
}
//没有反应？
/*
-(CGFloat) tableView:(UITableView *) tableView heightForRowAtIndexPath:(NSIndexPath *) indexPath{
    return 100;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 40;
}
 
 */


@end
