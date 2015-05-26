//
//  ViewController.m
//  SSZipArchive
//
//  Created by Cuppi on 15/5/26.
//  Copyright (c) 2015年 cuppi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <SSZipArchiveDelegate>
{
    UIImageView *_imageView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imageView = [[UIImageView alloc]init];
    [self.view addSubview:_imageView];
    //  _imageView.backgroundColor = [UIColor redColor];
    _imageView.frame = CGRectMake(0, 0, 320, 568);
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    NSString *sourcePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"zipManagerTest.zip"];
    NSString *targetPath = [[(NSArray *)NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject] stringByAppendingPathComponent:@"zipManagerTestRelease"];
    // Do any additional setup after loading the view, typically from a nib.
    
    if([[NSFileManager defaultManager] fileExistsAtPath:sourcePath])
    {
        [SSZipArchive unzipFileAtPath:sourcePath toDestination:targetPath delegate:self];
    }
    else
    {
    }
    
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)zipArchiveDidUnzipArchiveAtPath:(NSString *)path zipInfo:(unz_global_info)zipInfo unzippedPath:(NSString *)unzippedPath
{
    NSLog(@"path%@",path);
    NSLog(@"unzippedPath %@", unzippedPath);
    NSString *imageString = [[unzippedPath  stringByAppendingPathComponent:@"zipManagerTest"]stringByAppendingPathComponent:@"testImage.jpg"];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:imageString])
    {
        NSLog(@"图片存在");
        _imageView.image = [UIImage imageWithContentsOfFile:imageString];
        NSLog(@"%@",_imageView.image);
    }
    NSLog(@"size_comment %lu",zipInfo.size_comment);
    NSLog(@"number_entry %lu", zipInfo.number_entry);
    
}
@end
