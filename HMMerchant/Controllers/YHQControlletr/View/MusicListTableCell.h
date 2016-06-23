

#import <UIKit/UIKit.h>


@interface MusicListTableCell : UITableViewCell

@property (strong, nonatomic)  UILabel *name;

@property (strong, nonatomic)  UIImageView *img;

@property (strong, nonatomic)  UILabel *desc;

@property (nonatomic, strong) NSDictionary *sessionDic;

-(void)setDownData:(NSDictionary *)DownData;
@end
