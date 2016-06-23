

#import <UIKit/UIKit.h>
@class XLVideoItem;

@interface XLVideoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;
@property (weak, nonatomic) IBOutlet UILabel *videoTitle;

@property (nonatomic, strong) XLVideoItem *videoItem;

+ (XLVideoCell *)videoCellWithTableView:(UITableView *)tableview;

@end
