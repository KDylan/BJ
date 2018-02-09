//
//  EdgeGTResultModel.h
//  gd_port
//
//  Created by UEdge on 2017/11/2.
//  Copyright © 2017年 UEdge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EdgeGTMessageModel.h"
@interface EdgeGTResultModel : NSObject

@property (assign , nonatomic) BOOL success;
/**用户模型 */
@property (strong, nonatomic) EdgeGTMessageModel *MESSAGE;

/**ERROR_CODE*/
@property(nonatomic,copy)NSString *ERROR_CODE;


@end


/*
 payloadMsg:{
 "MESSAGE": {
 "content": " 珠海华南联合石油1:\r\n 您好!\r\n 港口经营许可证办理流程（从事船舶污染物接收经营）完成，请及时处理!\r\n ",
 "title": "港口经营许可证办理流程（从事船舶污染物接收经营）完成提示",
 "data": "",
 "type": "1",//判断1类型打开页面
 "url": "http://192.168.0.147:8080/NEWGDPORT/weixin/views/page/guidePage.jsp"
 },
 "ERROR_CODE": "0"
 }
 */
