

#import <Foundation/Foundation.h>

@interface MusicPartnerDownloadEntity : NSObject

// 下载的地址
@property (nonatomic , strong) NSString *downLoadUrlString;

// 附加字段
@property (nonatomic , strong) NSDictionary *extra;

@end
