

#import "MusicListTableCell.h"

@implementation MusicListTableCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
     self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

     if(self)
     {
          [self addSomeView];
     }

     return self;
}

- (void)awakeFromNib {
     // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
     [super setSelected:selected animated:animated];

     // Configure the view for the selected state
}


-(void)addSomeView
{
     self.img = [[UIImageView alloc] initWithFrame:CGRectMake(10,10,screenWidth-20,150)];
     [self.contentView addSubview:self.img];


     self.name = [[UILabel alloc] initWithFrame:CGRectMake(10,self.img.bottom+5,200,20)];
     [self.contentView addSubview:self.name];


     self.desc = [[UILabel alloc] initWithFrame:CGRectMake(10,self.name.bottom,screenWidth-20,50)];
     self.desc.font = [UIFont systemFontOfSize:14];
     self.desc.numberOfLines = 0;
     self.desc.textColor = [UIColor grayColor];
     [self.contentView addSubview:self.desc];
}


-(void)setDownData:(NSDictionary *)DownData
{
     _sessionDic = DownData;

    _name.text = [_sessionDic objectForKey:@"name"];
    _desc.text = [_sessionDic objectForKey:@"desc"];
    _img.image = [UIImage imageNamed:[_sessionDic objectForKey:@"imgName"]];
}

@end
