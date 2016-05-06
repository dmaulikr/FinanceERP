//
//  ZYForeclosureHouseModel.h
//  FinanceERP
//
//  Created by zhangyu on 16/5/5.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZYForeinfos;
@interface ZYForeclosureHouseModel : NSObject
/**
 *  业务来源
 */
@property (nonatomic, assign, readonly) NSInteger business_source;

@property (nonatomic, assign) NSInteger business_source_no;

/**
 *  内外单
 */
@property (nonatomic, assign, readonly) NSInteger inner_or_out;

/**
 *  交易 非交易
 */
@property (nonatomic, assign, readonly) NSInteger business_category;

/**
 *  贷款方式
 */
@property (nonatomic, assign, readonly) NSInteger payment_type;

/**
 *  收费方式
 */
@property (nonatomic, assign, readonly) NSInteger charges_type;


@property (nonatomic, assign) double evaluation_price;

@property (nonatomic, copy) NSString *customer_address;

@property (nonatomic, assign) double cost_money;

@property (nonatomic, assign) NSInteger guarantee_id;

@property (nonatomic, copy) NSString *payment_account;

@property (nonatomic, copy) NSString *loan_person;

@property (nonatomic, copy) NSString *supervise_account;

@property (nonatomic, copy) NSString *buyer_phone;

@property (nonatomic, assign) NSInteger accumulation_fund_bank;

@property (nonatomic, assign) NSInteger fore_status;

@property (nonatomic, copy) NSString *sign_date;

@property (nonatomic, copy) NSString *payment_name;

@property (nonatomic, copy) NSString *buyer_card_no;

@property (nonatomic, assign) NSInteger old_owed_amount;

@property (nonatomic, assign) NSInteger project_id;

@property (nonatomic, copy) NSString *buyer_address;

@property (nonatomic, copy) NSString *third_borrower_address;

@property (nonatomic, strong) NSArray<ZYForeinfos *> *foreInfos;

@property (nonatomic, copy) NSString *seller_phone;

@property (nonatomic, assign) NSInteger supervise_department;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *buyer_name;

@property (nonatomic, copy) NSString *seller_name;

@property (nonatomic, assign) double old_loan_money;

@property (nonatomic, assign) double poundage;

@property (nonatomic, assign) double rece_money;

@property (nonatomic, copy) NSString *cert_num;

@property (nonatomic, assign) double charges_subsidized;

@property (nonatomic, copy) NSString *contactPhone;

@property (nonatomic, copy) NSString *notarization_date;

@property (nonatomic, copy) NSString *business_contacts;

@property (nonatomic, copy) NSString *rece_date;

@property (nonatomic, copy) NSString *old_loan_phone;

@property (nonatomic, assign) double guarantee_fee;

@property (nonatomic, copy) NSString *seller_card_no;

@property (nonatomic, assign) NSInteger customer_id;

@property (nonatomic, copy) NSString *fore_account;

@property (nonatomic, copy) NSString *old_loan_time;

@property (nonatomic, assign) NSInteger old_loan_bank;

@property (nonatomic, copy) NSString *old_loan_person;

@property (nonatomic, assign) double dept_money;

@property (nonatomic, assign) NSInteger foreclosure_id;

@property (nonatomic, copy) NSString *third_borrower_card;

@property (nonatomic, copy) NSString *specialCase;

@property (nonatomic, assign) double loan_money;

@property (nonatomic, assign) NSInteger loan_days;

@property (nonatomic, copy) NSString *handleDate;

@property (nonatomic, assign) NSInteger new_loan_bank;

@property (nonatomic, copy) NSString *remark;

@property (nonatomic, assign) double funds_money;

@property (nonatomic, copy) NSString *contactPerson;

@property (nonatomic, assign) NSInteger create_id;

@property (nonatomic, copy) NSString *other_source;

@property (nonatomic, copy) NSString *customer_name;

@property (nonatomic, copy) NSString *house_property_card;

@property (nonatomic, copy) NSString *seller_address;

@property (nonatomic, assign) double new_loan_money;

@property (nonatomic, assign) double accumulation_fund_money;

@property (nonatomic, assign) NSInteger property_id;

@property (nonatomic, copy) NSString *contacts_phone;

@property (nonatomic, copy) NSString *house_area;

@property (nonatomic, assign) double fore_rate;

@property (nonatomic, copy) NSString *house_name;

@property (nonatomic, copy) NSString *loan_phone;

@property (nonatomic, copy) NSString *customer_phone;

@property (nonatomic, copy) NSString *third_borrower_phone;

@property (nonatomic, assign) double tranasction_money;

@property (nonatomic, copy) NSString *third_borrower;

@end

@interface ZYForeinfos : NSObject

@property (nonatomic, assign) NSInteger fore_id;

@property (nonatomic, assign) NSInteger copy_number;

@property (nonatomic, copy) NSString *remark;

@property (nonatomic, copy) NSString *fore_info_name;

@property (nonatomic, assign) NSInteger original_number;

@property (nonatomic, assign) NSInteger project_id;

@property (nonatomic, assign) NSInteger pid;

@end
