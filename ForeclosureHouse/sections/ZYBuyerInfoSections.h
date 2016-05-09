//
//  ZYBuyerInfoSections.h
//  
//
//  Created by zhangyu on 16/5/9.
//
//

#import "ZYSections.h"
#import "ZYForeclosureHouseViewModel.h"

@interface ZYBuyerInfoSections : ZYSections
- (void)blendModel:(ZYForeclosureHouseViewModel*)model;
@property(nonatomic,strong)NSString *error;

@property(nonatomic,assign)BOOL edit;
@end
