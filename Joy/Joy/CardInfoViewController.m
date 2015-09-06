//
//  CardInfoViewController.m
//  Joy
//
//  Created by gejw on 15/8/18.
//  Copyright (c) 2015年 颜超. All rights reserved.
//

#import "CardInfoViewController.h"
#import "EntryTableView.h"
#import "ExperienceViewController.h"

NS_ENUM(NSInteger, FileType) {
    None,
    Certificates,
    Video,
    LearningCertificate,
    IDImagePositive,
    IDImageReverse,
    Retirement,
    Physical
};

@interface CardInfoViewController () <EntryTableViewDelegate, UIActionSheetDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate> {
    EntryTableView *_tableView;
    NSMutableArray *_datas;
    enum FileType _fileType;
    UIActionSheet *_actionSheet;
}

@end

@implementation CardInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _datas = [NSMutableArray array];
    _fileType = None;
    // 检测判空
    if ([JPersonInfo person].Materials == nil) {
        [JPersonInfo person].Materials = [[JMaterials alloc] init];
    }
    
    if ([JPersonInfo person].Materials.IDImage == nil) {
        [JPersonInfo person].Materials.IDImage = [[JIdimage alloc] init];
    }
    
    _tableView = [[EntryTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _tableView.entryDelegate = self;
    [self.view addSubview:_tableView];
    
    [self updateInfo];
}

- (void)updateInfo {
    [_datas removeAllObjects];
    
    __weak CardInfoViewController *weakSelf = self;
    {
        ApplyImageCell *cell = [[ApplyImageCell alloc] initWithLabelString:@"证  件  照：" labelImage:[UIImage imageNamed:@"entry_myself"] hintString:@"(只需要一张照片即可)" num:1 updateHandler:^(UIImageView *imageView, UIImageView *imageView2) {
            if ([JPersonInfo person].Materials.Certificates) {
                [imageView sd_setImageWithURL:[NSURL URLWithString:[JPersonInfo person].Materials.Certificates]];
            }
        } clickHandler:^(UIImageView *imageView, int indexSelect) {
            _fileType = Certificates;
            [weakSelf openMenu];
        }];
        [_datas addObject:cell];
    }
    
//    {
//        ApplyImageCell *cell = [[ApplyImageCell alloc] initWithLabelString:@"我的视频" labelImage:[UIImage imageNamed:@"entry_myselfvideo"] hintString:@"" num:1 updateHandler:^(UIImageView *imageView, UIImageView *imageView2) {
//            
//        } clickHandler:^(UIImageView *imageView, int indexSelect) {
//            
//        }];
//        [_datas addObject:cell];
//    }
//    
    {
        ApplyImageCell *cell = [[ApplyImageCell alloc] initWithLabelString:@"学习证书：" labelImage:[UIImage imageNamed:@"entry_academicphoto"] hintString:@"(只需要一张照片即可)" num:1 updateHandler:^(UIImageView *imageView, UIImageView *imageView2) {
            
            if ([JPersonInfo person].Materials.LearningCertificate) {
                [imageView sd_setImageWithURL:[NSURL URLWithString:[JPersonInfo person].Materials.LearningCertificate]];
            }
        } clickHandler:^(UIImageView *imageView, int indexSelect) {
            _fileType = LearningCertificate;
            [weakSelf openMenu];
        }];
        [_datas addObject:cell];
    }
    
    {
        ApplyImageCell *cell = [[ApplyImageCell alloc] initWithLabelString:@"身  份  证：" labelImage:[UIImage imageNamed:@"entry_idphoto"] hintString:@"(需要正反两面照片)" num:2 updateHandler:^(UIImageView *imageView, UIImageView *imageView2) {
            if ([JPersonInfo person].Materials.IDImage.Positive) {
                [imageView sd_setImageWithURL:[NSURL URLWithString:[JPersonInfo person].Materials.IDImage.Positive]];
            }
            if ([JPersonInfo person].Materials.IDImage.Reverse) {
                [imageView2 sd_setImageWithURL:[NSURL URLWithString:[JPersonInfo person].Materials.IDImage.Reverse]];
            }
        } clickHandler:^(UIImageView *imageView, int indexSelect) {
            _fileType = indexSelect == 0 ? IDImagePositive : IDImageReverse;
            [weakSelf openMenu];
        }];
        [_datas addObject:cell];
    }
    
    {
        ApplyImageCell *cell = [[ApplyImageCell alloc] initWithLabelString:@"退  工  单：" labelImage:[UIImage imageNamed:@"entry_rapairorder"] hintString:@"(只需要一张照片即可)" num:1 updateHandler:^(UIImageView *imageView, UIImageView *imageView2) {
            if ([JPersonInfo person].Materials.Retirement) {
                [imageView sd_setImageWithURL:[NSURL URLWithString:[JPersonInfo person].Materials.Retirement]];
            }
        } clickHandler:^(UIImageView *imageView, int indexSelect) {
            _fileType = Retirement;
            [weakSelf openMenu];
        }];
        [_datas addObject:cell];
    }
    
    {
        ApplyImageCell *cell = [[ApplyImageCell alloc] initWithLabelString:@"体检报告：" labelImage:[UIImage imageNamed:@"entry_checkreproting"] hintString:@"(只需要一张照片即可)" num:1 updateHandler:^(UIImageView *imageView, UIImageView *imageView2) {
            if ([JPersonInfo person].Materials.Physical) {
                [imageView sd_setImageWithURL:[NSURL URLWithString:[JPersonInfo person].Materials.Physical]];
            }
        } clickHandler:^(UIImageView *imageView, int indexSelect) {
            _fileType = Physical;
            [weakSelf openMenu];
        }];
        [_datas addObject:cell];
    }
    
    _tableView.datas = _datas;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)entryTableViewSaveEvent:(EntryTableView *)tableView {
}

- (void)entryTableViewNextEvent:(EntryTableView *)tableView {
    ExperienceViewController *vc = [[ExperienceViewController alloc] init];
    vc.title = @"个人经历";
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma 选择照片

- (void)openMenu {
    //在这里呼出下方菜单按钮项
    _actionSheet = [[UIActionSheet alloc]
                     initWithTitle:nil
                     delegate:self
                     cancelButtonTitle:@"取消"
                     destructiveButtonTitle:nil
                     otherButtonTitles: @"打开照相机", @"从手机相册获取",nil];
    
    [_actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    //呼出的菜单按钮点击后的响应
    if (buttonIndex == _actionSheet.cancelButtonIndex) {
        NSLog(@"取消");
        _fileType = None;
    }
    
    switch (buttonIndex) {
        case 0:  //打开照相机拍照
            [self takePhoto];
            break;
            
        case 1:  //打开本地相册
            [self LocalPhoto];
            break;
    }
}

//开始拍照
- (void)takePhoto {
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = NO;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:nil];
    } else {
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}

//打开本地相册
- (void)LocalPhoto {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = NO;
    [self presentViewController:picker animated:YES completion:nil];
}

//当选择一张图片后进入这里
- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"]) {
        //先把图片转成NSData
        UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        NSData *data = UIImageJPEGRepresentation(image, 0.5);
        [picker dismissViewControllerAnimated:YES completion:nil];
        [[JAFHTTPClient shared] uploadFile:data success:^(NSString *filePath) {
            // 上传成功之后  删除
            switch (_fileType) {
                case Certificates:
                    [JPersonInfo person].Materials.Certificates = @"http://img3.cache.netease.com/sports/2015/9/5/20150905084628d50a5.png";
                    break;
                case LearningCertificate:
                    [JPersonInfo person].Materials.LearningCertificate = @"http://img3.cache.netease.com/sports/2015/9/5/20150905084628d50a5.png";
                    break;
                case IDImagePositive:
                    [JPersonInfo person].Materials.IDImage.Positive = @"http://img3.cache.netease.com/sports/2015/9/5/20150905084628d50a5.png";
                    break;
                case IDImageReverse:
                    [JPersonInfo person].Materials.IDImage.Reverse = @"http://img0.bdstatic.com/img/image/shouye/touxiang902.jpg";
                    break;
                case Retirement:
                    [JPersonInfo person].Materials.Retirement = @"http://img0.bdstatic.com/img/image/shouye/touxiang902.jpg";
                    break;
                case Physical:
                    [JPersonInfo person].Materials.Physical = @"http://img0.bdstatic.com/img/image/shouye/touxiang902.jpg";
                    break;
                    
                default:
                    break;
            }    
            [_tableView reloadData];
            _fileType = None;
        } failure:^(NSString *msg) {
            [_tableView reloadData];
            _fileType = None;
        }];
    }
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
    _fileType = None;
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
