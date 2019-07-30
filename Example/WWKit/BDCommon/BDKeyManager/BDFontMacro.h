//
//  BDFontMacro.h
//  BusinessDataPlatform
//
//  Created by 吴振振 on 2019/3/7.
//  Copyright © 2019 donghui lv. All rights reserved.
//

#ifndef BDFontMacro_h
#define BDFontMacro_h

#import "BDHorizonResource.h"

#define FONT_SYS(a)            [UIFont systemFontOfSize:a]
#define FONT_SYSBOLD(a)        [UIFont boldSystemFontOfSize:a]

#define FONT_PFSC(a)            [UIFont fontWithName:@"PingFang SC" size:(a)]
#define FONT_PFSC_Ultralight(a) [UIFont fontWithName:@"PingFangSC-Ultralight" size:(a)]
#define FONT_PFSC_Regular(a)    [UIFont fontWithName:@"PingFangSC-Regular" size:(a)]
#define FONT_PFSC_Thin(a)       [UIFont fontWithName:@"PingFangSC-Thin" size:(a)]
#define FONT_PFSC_Light(a)      [UIFont fontWithName:@"PingFangSC-Light" size:(a)]
#define FONT_PFSC_Semibold(a)   [UIFont fontWithName:@"PingFangSC-Semibold" size:(a)]
#define FONT_PFSC_Medium(a)     [UIFont fontWithName:@"PingFangSC-Medium" size:(a)]
#define FONT_PFSC_Bold(a)       [UIFont fontWithName:@"PingFangSC-Bold" size:(a)]

#define FONT_BoldHT(sizeH) [UIFont fontWithName:@"Helvetica-Bold" size:sizeH]

#define BD_ImageNamed(imageName) [BDHorizonResource imageNamed:imageName]

#define BD_ArrowImage_Mini(up) [BDHorizonResource imageNamed:(up ? @"bd_arrow_up" : @"bd_arrow_down")]

#define BD_ArrowImage(up) [BDHorizonResource imageNamed:(up ? @"bd_arrow_up_mini" : @"bd_arrow_down_mini")]

#endif /* BDFontMacro_h */
