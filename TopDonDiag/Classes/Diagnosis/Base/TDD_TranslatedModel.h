//
//  TDD_TranslatedModel.h
//  TopDonDiag
//
//  Created by AppTopdon on 2023/8/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TDD_TranslatedModel : NSObject
@property (nonatomic,strong) NSString *unTranslatedStr; //未翻译字符串
@property (nonatomic,strong) NSString *translatedStr; //已翻译字符串
@property (nonatomic, assign) BOOL isTranslated;//是否已翻译
@end

NS_ASSUME_NONNULL_END
