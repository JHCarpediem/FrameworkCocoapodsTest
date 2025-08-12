//
//  TDD_ArtiListModel.h
//  AD200
//
//  Created by 何可人 on 2022/5/12.
//

#import "TDD_ArtiModelBase.h"

#define DF_ID_SHARE  (0x60010012)

NS_ASSUME_NONNULL_BEGIN

typedef enum
{
    ITEM_NO_CHECKBOX             = 0,    // 默认值，每行前面没有复选框，Show为非阻塞
    ITEM_WITH_CHECKBOX_SINGLE    = 1,    // 每行前面有复选框，但是所有复选框是互斥的，只能选中1行，Show为非阻塞
    ITEM_WITH_CHECKBOX_MULTI     = 2,    // 每行前面有复选框，复选框均可以多选，Show为非阻塞
}eListViewType;

typedef enum
{
    // 默认态，任意一行可以被选中
    ITEM_SELECT_DEFAULT         = 0,    // 默认值，用户可以选择哪一行（触摸/点击选择），相应行被选中状态

    // 所有行都不能被选中（UI用户）
    ITEM_SELECT_DISABLED        = 1,    // UI用户不可以选择任何一行（触摸/点击选择），选中由接口
                                        // SetDefaultSelectedRow控制选中
                                        // 点击任意一行，触摸失灵的效果
}eListSelectType;

typedef enum
{
    SCREEN_TYPE_FIRST_ROW = 0,    // 当前屏第一行
    SCREEN_TYPE_LAST_ROW  = 1,    // 当前屏最后一行
}eScreenRowType;

@interface ArtiListItemModel : NSObject

@property (nonatomic, strong) NSMutableArray * vctItems;

@property (nonatomic, assign) BOOL isGroup; //是否以组的形式显示

@property (nonatomic, strong) NSString * strGroupName; //组名或提示
@property (nonatomic, assign) BOOL bIsHighLight; //是否高亮
@property (nonatomic, assign) NSInteger index; //item的index,tips、group为-1

@property (nonatomic, assign) uint16_t eHighLighColorType;// 高亮颜色 0 默认 1灰色
///headModel高度
@property (nonatomic, assign) CGFloat headHeight;
@property (nonatomic, assign) CGFloat maxHeight;
@end

@interface TDD_ArtiListModel : TDD_ArtiModelBase

@property (nonatomic, strong) NSArray * vctColWidth; //列表各列的宽度

@property (nonatomic, assign) eListViewType listViewType; //列表类型

@property (nonatomic, strong) NSArray * vctHeadNames; //列表各列的名称集合

@property (nonatomic, assign) BOOL bIsBlock; //设置界面的阻塞状态

@property (nonatomic, assign) BOOL isLockFirstRow; //是否冻结首行

@property (nonatomic, assign) BOOL isShowHeader; //是否显示头

@property (nonatomic, strong) NSArray * vctImagePathArr; //图片路径

@property (nonatomic, assign) uint32_t uColImageIndex; //显示图片列

@property (nonatomic, assign) BOOL isShowImage; //是否显示图片

@property (nonatomic, assign) int32_t selectedRow;// 选中行，离开页面后要改为-1

@property (nonatomic, strong) NSMutableArray<ArtiListItemModel *> * itemArr;//包括tips group item

@property (nonatomic, assign) int32_t itemCount;//纯Item数量

@property (nonatomic, strong) NSMutableSet * boxSelectSet; //复选框数组

@property (nonatomic, strong) NSString * strTopTips; //头部提示

@property (nonatomic, strong) NSString * strBottomTips; //低部提示

@property (nonatomic, strong) NSString * IMMOStrPicturePath; //IMMO 图片地址

@property (nonatomic, strong) NSString * IMMOStrPictureTips; //IMMO 图片提示

@property (nonatomic, assign) uint16_t IMMOUAlignType; //IMMO 图片提示位置

@property (nonatomic, strong) NSString * strTitleTopTips; //头部提示
@property (nonatomic, assign) uint16_t uAlignType; //title提示位置

@property (nonatomic, assign) uint16_t eFontSize; //title文字大小

@property (nonatomic, assign) uint16_t eBoldType; //title文字字重

@property (nonatomic, assign) uint32_t scrollToIndex;//滚动位置
@property (nonatomic, assign) uint32_t scrollRowType;//滚动Type

@property (nonatomic, strong) NSString * strShareTitle; // 分享标题
@property (nonatomic, strong) NSString * strShareContent; // 分享内容
@property (nonatomic, assign) BOOL showTimer; // 展示时钟

@property (nonatomic, assign) eListSelectType listSelectType;//可选中模式

/**********************************************************
*    功  能：初始化列表控件，同时设置标题文本，设置列表类型
*
*    参  数：strTitle    标题文本
*             Type        列表类型
*
*    返回值：true 初始化成功 false 初始化失败
**********************************************************/
+ (BOOL)InitTitleWithId:(uint32_t)ID strTitle:(NSString *)strTitle Type:(eListViewType)Type;


/**********************************************************
*    功  能：设置列表列宽比
*    参  数：vctColWidth 列表各列的宽度
*    返回值：无
*
*     说  明：vctColWidth的大小为列数
*            例如vctColWidth共有2个元素，即列数为2
*             vctColWidth各元素的总和为100
**********************************************************/
+ (void)SetColWidthWithId:(uint32_t)ID vctColWidth:(NSArray *)vctColWidth;


/**********************************************************
*    功  能：设置列表头，该行锁定状态
*    参  数：vctHeadNames 列表各列的名称集合
*    返回值：无
**********************************************************/
+ (void)SetHeadsWithId:(uint32_t)ID vctHeadNames:(NSArray *)vctHeadNames;

/**********************************************************
*    功  能：在界面顶部设置表格的文本提示
*
*    参  数：strTips   对应的文本提示
*
*    返回值：无
*
*    说  明：如果没有设置（没有调用此接口），则不显示提示
**********************************************************/
+ (void)SetTipsOnTopWithId:(uint32_t)ID strTips:(NSString *)strTips;

/**********************************************************
*    功  能：在界面底部设置表格的文本提示
*
*    参  数：strTips   对应的文本提示
*
*    返回值：无
*
*    说  明：如果没有设置（没有调用此接口），则不显示提示
**********************************************************/
+ (void)SetTipsOnBottomWithId:(uint32_t)ID strTips:(NSString *)strTips;

/**********************************************************
*    功  能：设置界面的阻塞状态
*    参  数：bIsBlock=true 该界面为阻塞的
*            bIsBlock=false 该界面为非阻塞的
*    返回值：无
**********************************************************/
+ (void)SetBlockStatusWithId:(uint32_t)ID bIsBlock:(BOOL)bIsBlock;


/**********************************************************
*    功  能：添加分组，组为一列，相当于合并了单元格（整行）
*
*    参  数：strGroupName 组名
*
*    返回值：无
**********************************************************/
+ (void)AddGroupWithId:(uint32_t)ID strGroupName:(NSString *)strGroupName;


/**********************************************************
*    功  能：添加数据项, 默认该行不高亮显示
*
*    参  数：vctItems 数据项集合
*
*            bIsHighLight=true   高亮显示该行
*            bIsHighLight=false  不高亮显示该行
*
*    返回值：无
**********************************************************/
+ (void)AddItemWithId:(uint32_t)ID vctItems:(NSArray *)vctItems bIsHighLight:(BOOL)bIsHighLight;


/**********************************************************
*    功  能：添加数据项名称
*    参  数：strItem 数据项名称
*    返回值：无
**********************************************************/
+ (void)AddItemWithId:(uint32_t)ID strItem:(NSString *)strItem;


/**********************************************************
*    功  能：设置列表指定位置的值
*    参  数：uRowIndex 列表行标
*            uColIndex 列表列标
*            strValue   指定位置需要设置的值
*    返回值：无
**********************************************************/
+ (void)SetItemWithId:(uint32_t)ID uRowIndex:(uint32_t)uRowIndex uColIndex:(uint32_t)uColIndex strValue:(NSString *)strValue;


/***************************************************************************
*    功  能：在指定某一列插入图片，图片格式为png
*
*    参  数：uColIndex        List 列标
*                           指定此列显示图片，那此列的所有行将不能显示文本
*
*            vctPath        指定列上显示的各行图片路径
*                           vctPath的大小为总行数
*                           如果小于总行数，最后缺少的行的图片为空
*                           如果vctPath指定行的路径串为非法路径（空串或文件
*                           不存在），此行此列的图片为空
*
*                           图片路径格式为： 绝对路径（全路径）
*
*    返回值：无
*
*    使用场景：需要用到小的图标（图片）来指示每一行的状态
*
***************************************************************************/
+ (void)SetItemPictureWithId:(uint32_t)ID uColIndex:(uint32_t)uColIndex vctPath:(NSArray *)vctPath;


/**********************************************************
*    功  能：设置指定的行需要高亮显示，同时高亮显示行不能被选中
*    参  数：uRowIndex 指定需要高亮显示的行号
*    返回值：无
*            注意：显示高亮显示行与选中行的颜色不一致
**********************************************************/
+ (void)SetRowHighLightWithId:(uint32_t)ID uRowIndex:(uint32_t)uRowIndex;


/**********************************************************
*    功  能：设置第一行是锁定状态，类似Excel表格的“冻结首行”
*
*    参  数：无
*
*    返回值：无
*
*    注  意：首行和列表头(Head)是不一样的
*            如果设置了列表头，SetHeads
*            并且锁定了首行，SetLockFirstRow
*            会有类似冻结了2行的效果
*
*            列表头 和 SetLockFirstRow的首行 底纹 应该有区别的效果
**********************************************************/
+ (void)SetLockFirstRowWithId:(uint32_t)ID;


/*******************************************************************
*    功  能：设置默认选中的行
*
*    参  数：uRowIndex 默认选中行的行，以最后一次设置为准
*
*    返回值：无
*
*    注 意：此接口针对 ITEM_NO_CHECKBOX 类型的列表框， 如果是“复选
*           框”(ITEM_WITH_CHECKBOX_SINGLE和ITEM_WITH_CHECKBOX_MULTI)
*           类型，请用SetCheckBoxStatus接口
*********************************************************************/
+ (void)SetDefaultSelectedRowWithId:(uint32_t)ID uRowIndex:(uint32_t)uRowIndex;


/**********************************************************
*    功  能：设置复选框默认选中状态
*
*    参  数：uRowIndex 行序号，bChecked 是否选中
*
*    返回值：无
*
*    说 明： 如果没有调用此接口，所有行默认状态都为未选中
**********************************************************/
+ (void)SetCheckBoxStatusWithId:(uint32_t)ID uRowIndex:(uint32_t)uRowIndex bChecked:(BOOL)bChecked;


/**********************************************************
*    功  能：获取选中的行号
*
*             即：list类型为ITEM_NO_CHECKBOX时，调用此接口可以
*                获取选中的行号
*
*    参  数：无
*    返回值：选中的行号
**********************************************************/
+ (uint16_t)GetSelectedRowWithId:(uint32_t)ID;


/**********************************************************
*    功  能：获取选中的行号，适用于复选框情况
*
*            即：list类型为ITEM_WITH_CHECKBOX_SINGLE或
*                者ITEM_WITH_CHECKBOX_MULTI
*
*    参  数：无
*    返回值：选中的行号
*            如果大小为0，表示没有选中任何一项
**********************************************************/
+ (NSArray *)GetSelectedRowExWithId:(uint32_t)ID;

/***************************************************************************
*    功  能：在list左边增加一个图片，list半屏靠右显示，增加的图片半屏靠左显示
*
*    参  数：strPicturePath 指定显示的图片路径
*                           如果strPicturePath指定图片路径串为非法路径（空串
*                           或文件不存在），返回失败
*
*            strPictureTips 图片显示的文本提示
*
*            uAlignType     文本提示显示在图片的哪个部位
*                           DT_RIGHT_TOP，文本提示显示在图片的右上角
*                           DT_LEFT_TOP， 文本提示显示在图片的左上角
*
*    返回值：无
*
*    注  意：SetLeftLayoutPicture不能和SetItemPicture一起使用，即调用了
*            SetLeftLayoutPicture后，再调用SetItemPicture无效
*
*    使用场景：防盗芯片识别
*
***************************************************************************/
+ (BOOL)SetLeftLayoutPictureWithId:(uint32_t)ID strPicturePath:(NSString *)strPicturePath strPictureTips:(NSString *)strPictureTips uAlignType:(uint16_t)uAlignType;

@end

NS_ASSUME_NONNULL_END
