//
//  BASMagazineViewController.m
//  chatdietolog
//
//  Created by Lena on 04.06.15.
//  Copyright (c) 2015 BestAppStudio. All rights reserved.
//

#import "BASMagazineViewController.h"

@interface BASMagazineViewController ()

@end

@implementation BASMagazineViewController

- (void)viewDidLoad {
    TheApp;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:app.tabView];
    app.tabView.delegate = self;
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
