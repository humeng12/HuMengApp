

#import "XLVideoCell.h"
#import "XLVideoItem.h"

@interface XLVideoCell ()

@end

@implementation XLVideoCell

+ (XLVideoCell *)videoCellWithTableView:(UITableView *)tableview {
    static NSString *ID = @"XLVideoCell";
    XLVideoCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"XLVideoCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)setVideoItem:(XLVideoItem *)videoItem {
    _videoItem = videoItem;
    self.videoTitle.text = videoItem.title;
    [self.videoImageView sd_setImageWithURL:[NSURL URLWithString:videoItem.cover]];
}


@end
