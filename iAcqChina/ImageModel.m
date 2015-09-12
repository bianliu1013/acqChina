//
//  ImageModel.m
//  iAcqChina
//
//  Created by Dental Equipment on 1/1/15.
//  Copyright (c) 2015 iAcqChina. All rights reserved.
//

#import "ImageModel.h"

#import "FMDatabase.h"
#import "FMDB.h"
#import "FMResultSet.h"

#import "MacroUtils.h"

#define USING_LOCAL_IMAGE   1


/////////////////////////////////////////////////////////////////////
@interface ImageUnit()
{
}

@end

@implementation ImageUnit

// @synthesize title=_title;
// @synthesize date=_date;
// @synthesize image_data=_image_data;
// @synthesize tooth_id=_tooth_id;
// @synthesize owner=_owner; 

@end


/////////////////////////////////////////////////////////////////////
@interface ImageModel()
{
    //FMDatabase *db;
}

@property (nonatomic, retain) NSString * dbPath;
@end



@implementation ImageModel

@synthesize urls=_urls;
@synthesize title=_title;
@synthesize date=_date;
@synthesize dbPath;

static NSString * const DB_FILE_NAME  = @"db_test.sqlite";

static NSString * const s_CreateTableSql = @"CREATE TABLE 'ImageSet' ('uuid' VARCHAR(30), 'date' VARCHAR(30), 'title' VARCHAR(30), 'url' VARCHAR(255), 'owner' VARCHAR(255), 'tooth_id' VARCHAR(255), 'image_data' blob, 'tooth_id_group' INTEGER)";
static NSString * const s_InsertSql      = @"insert into ImageSet (uuid, date, title, url, owner, tooth_id, image_data, tooth_id_group) values(?, ?, ?, ?, ?, ?, ?, ?) ";
static NSString * const s_SelectAllSql   = @"select * from ImageSet";
static NSString * const s_deleteAllSql   = @"delete from ImageSet";


// ----------------------------------------------------------------------------------------------
#pragma mark - base
// should be called after alloc
- (void) InitDataBase
{
    // Do any additional setup after loading the view, typically from a nib.
    NSString * doc = PATH_OF_DOCUMENT;
    NSString * path = [doc stringByAppendingPathComponent:DB_FILE_NAME];
    self.dbPath = path;
    
    [self createTables];
}


- (void)createTables
{
    debugMethod();
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:self.dbPath] == NO) {
        // create it
        //[db executeUpdate:@"CREATE TABLE Member (Name text, Age integer, Sex integer,Height integer, Weight integer, Photo blob)"];
        FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
        if ([db open]) {
            //NSString * sql = @"CREATE TABLE 'ImageSet' ('date' VARCHAR(30), 'title' VARCHAR(30), 'url' VARCHAR(255), 'owner' VARCHAR(255), 'tooth_id' VARCHAR(255), 'image_data' blob)";
            BOOL res = [db executeUpdate:s_CreateTableSql];
            if (!res) {
                debugLog(@"error when creating db table");
            } else {
                debugLog(@"succ to creating db table");
            }
            [db close];
        } else {
            debugLog(@"error when open db");
        }
    }
    else{
        FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
        if ([db open]) {
            //NSString * sql = @"CREATE TABLE 'ImageSet' ('date' VARCHAR(30), 'title' VARCHAR(30), 'url' VARCHAR(255), 'owner' VARCHAR(255), 'tooth_id' VARCHAR(255), 'image_data' blob)";
            BOOL res = [db executeUpdate:s_CreateTableSql];
            if (!res) {
                debugLog(@"error when creating db table");
            } else {
                debugLog(@"succ to creating db table");
            }
            [db close];
        } else {
            debugLog(@"error when open db");
        }
    }
}


- (void)insertData
{
    static int idx = 1;
    
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {

        for (int index = 0; index < 9; index++)
        {
            
            NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
            [dateFormatter1 setDateFormat:@"yyyy-MM-dd 00:00:00"];
            //NSString *currentDateStr1 = [dateFormatter1 stringFromDate:[NSDate date]];
            //UIImage *image = [UIImage imageNamed:[_urls[index]]];
            
            UIImage *image          = [UIImage imageNamed:_urls[index]];
            NSString *title         = [NSString stringWithFormat:@"{0,%ld}",(long)index+1];
            NSString *date          = [NSString stringWithFormat:@"tangqiao%d", idx++];
            NSString *url           = @"test";
            NSString *onwer         = @"peter";
            NSString *tooth_id      = @"1";
            NSData   *image_data    =  UIImageJPEGRepresentation(image, 0.8);
            NSString *uuid          = [[NSUUID UUID] UUIDString];
            int  tooth_id_group     = 0;
            
            BOOL res = [db executeUpdate:s_InsertSql, uuid, date, title, url, onwer, tooth_id, image_data, tooth_id_group];
            if (!res) {
                debugLog(@"error to insert data");
            } else {
                debugLog(@"succ to insert data");
            }
        }
        
        [db close];
    }
}


- (void)queryData
{
    debugMethod();
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        NSString * sql = @"select * from user";
        FMResultSet * rs = [db executeQuery:sql];
        while ([rs next]) {
            int userId = [rs intForColumn:@"id"];
            NSString * name = [rs stringForColumn:@"name"];
            NSString * pass = [rs stringForColumn:@"password"];
            debugLog(@"user id = %d, name = %@, pass = %@", userId, name, pass);
        }
        [db close];
    }
}


- (NSInteger) imageCount
{
    NSInteger count = -1;
    NSString *existsSql = [NSString stringWithFormat:@"select count(title) as countNum from ImageSet"];
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        FMResultSet *rs = [db executeQuery:existsSql];
        if ([rs next]) {
            count = [rs intForColumn:@"countNum"];
            NSLog(@"The table count: %li", count);
            [rs close];
            [db close];
            return count;
        }
        [rs close];
        [db close];
    }
    return 0;
}



- (NSString*) imageTitle:(NSInteger)index
{
    debugMethod();
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        //NSString * sql = @"select * from ImageSet";
        FMResultSet * rs = [db executeQuery:s_SelectAllSql];
        int i = 0;
        while ([rs next]) {
            NSString * title = [rs stringForColumn:@"title"];
            if (i++ == index) {
                [rs close];
                [db close];
                return title;
            }
        }
        [rs close];
        [db close];
    }
    return nil;
}


- (NSString*) imageDate:(NSInteger)index
{
    debugMethod();
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        //NSString * sql = @"select * from ImageSet";
        FMResultSet * rs = [db executeQuery:s_SelectAllSql];
        int i= 0;
        while ([rs next]) {
            NSString * date = [rs stringForColumn:@"date"];
            if (i++ == index) {
                [rs close];
                [db close];
                return date;
            }
        }
        [rs close];
        [db close];
    }
    return nil;
}


- (UIImage*)  imageData:  (NSInteger) index
{
    debugMethod();
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        //NSString * sql = @"select * from ImageSet";
        FMResultSet * rs = [db executeQuery:s_SelectAllSql];
        int i= 0;
        while ([rs next]) {
            if (i++ == index) {
                NSData * image_data = [rs dataForColumn:@"image_data"];
                UIImage *image = [UIImage imageWithData: image_data];
                [rs close];
                [db close];
                return image;
            }
        }
        [rs close];
        [db close];
    }
    return nil;
}


#if 0
- (ImageUnit*) imageUnit: (NSInteger) index
{
    debugMethod();
    ImageUnit* image_unit = [ImageUnit alloc];
    
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        //NSString * sql = @"select * from ImageSet";
        FMResultSet * rs = [db executeQuery:s_SelectAllSql];
        int i= 0;
        while ([rs next]) {
            if (i++ == index) {
                NSData * image_data = [rs dataForColumn:@"image_data"];
                UIImage *image = [UIImage imageWithData: image_data];
                
                image_unit.date = [rs stringForColumn:@"date"];
                image_unit.title = [rs stringForColumn:@"title"];
                image_unit.image_data = image;
                [rs close];
                [db close];
                return image_unit;
            }
        }
        [rs close];
        [db close];
    }
    return nil;
}
#endif


- (void) fillImageUnit:(ImageUnit *)image_unit 
                withRs:(FMResultSet *)rs
{
    NSData * image_data = [rs dataForColumn:@"image_data"];
    UIImage *image = [UIImage imageWithData: image_data];
    //ImageUnit* image_unit = [ImageUnit alloc];
    image_unit.uuid = [rs stringForColumn:@"uuid"];
    image_unit.date = [rs stringForColumn:@"date"];
    image_unit.title = [rs stringForColumn:@"title"];
    image_unit.image_data = image;
    image_unit.tooth_id = [rs stringForColumn:@"tooth_id"];
    image_unit.owner = [rs stringForColumn:@"owner"];
    image_unit.tooth_id_group = [rs intForColumn: @"tooth_id_group"];
}


// ----------------------------------------------------------------------------------------------
#pragma mark - query
- (void) QueryImageUnitAll:(NSMutableArray*)imageUnitArray
 {
    debugMethod();
    
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        FMResultSet * rs = [db executeQuery:s_SelectAllSql];
         while ([rs next]) {
            //NSData * image_data = [rs dataForColumn:@"image_data"];
            //UIImage *image = [UIImage imageWithData: image_data];
             
            ImageUnit* image_unit = [ImageUnit alloc];
//            image_unit.uuid = [rs stringForColumn:@"uuid"];
//            image_unit.date = [rs stringForColumn:@"date"];
//            image_unit.title = [rs stringForColumn:@"title"];
//            image_unit.image_data = image;
//            image_unit.tooth_id = [rs stringForColumn:@"tooth_id"];
//            image_unit.owner = [rs stringForColumn:@"owner"];
//            image_unit.tooth_id_group = [rs intForColumn: @"tooth_id_group"];
             
             [self fillImageUnit:image_unit withRs:rs];
            
            [imageUnitArray addObject:image_unit];
        }
        [rs close];
        [db close];
    }
 }


- (void) QueryImageUnitArrayByOwner:(NSString*)owner 
                    withReturnArray:(NSMutableArray*)imageUnitArray
{
    debugMethod();
    
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        NSString * sql = @"select * from ImageSet where owner=?";
        FMResultSet * rs = [db executeQuery:sql, owner];
        while ([rs next]) {
            ImageUnit* image_unit = [ImageUnit alloc];
            [self fillImageUnit:image_unit withRs:rs];
            [imageUnitArray addObject:image_unit];
        }
        [rs close];
        [db close];
    }
}


- (void) QueryUserNameArray: (NSMutableArray*)userNameArray
{
    debugMethod();
    
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        NSString * sql = @"select distinct owner from ImageSet";
        FMResultSet * rs = [db executeQuery:sql];
        while ([rs next]) {
            NSString *owner_name = [rs stringForColumn:@"owner"];
            [userNameArray addObject:owner_name];
        }
        [rs close];
        [db close];
    }
}



- (void) QueryDateArray: (NSString*)patient_name 
            withReturnArray:(NSMutableArray*)DateArray
{
     debugMethod();
    
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        NSString   *sql = nil;
        FMResultSet *rs = nil;
        if (nil == patient_name) {
            sql = @"select distinct date from ImageSet";
            rs = [db executeQuery:sql];
        }
        else {
            sql = @"select distinct date from ImageSet where owner=?";
            rs = [db executeQuery:sql, patient_name];
        }

        while ([rs next]) {
            NSString *date_section = [rs stringForColumn:@"date"];
            [DateArray addObject:date_section];
        }
        [rs close];
        [db close];
    }     
}



- (void) QueryImageUnitArrayByToothId:(NSString*)tooth_id 
                      withPatientName:(NSString*)patient_name 
                      withReturnArray:(NSMutableArray*)imageUnitArray
{
    debugMethod();
    
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        NSString   *sql = nil;
        FMResultSet *rs = nil;
        if (nil != patient_name) {
            sql = @"select * from ImageSet where tooth_id=? and owner=?";
            rs = [db executeQuery:sql, tooth_id, patient_name];
        }
        else {
            sql = @"select * from ImageSet where tooth_id=?";
            rs = [db executeQuery:sql, tooth_id];
        }

        while ([rs next]) {
             ImageUnit* image_unit = [ImageUnit alloc];
             [self fillImageUnit:image_unit withRs:rs];
             [imageUnitArray addObject:image_unit];
         }
        [rs close];
        [db close];
    }
}



- (void) QueryImageUnitArrayByDate:(NSString*) date
                   withPatientName:(NSString*)patient_name
                   withReturnArray:(NSMutableArray*)imageUnitArray
{
    debugMethod();
    
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        NSString   *sql = nil;
        FMResultSet *rs = nil;
        if (nil != patient_name) {
            sql = @"select * from ImageSet where date=? and owner=?";
            rs = [db executeQuery:sql, date, patient_name];
        }
        else {
            sql = @"select * from ImageSet where date=?";
            rs = [db executeQuery:sql, date];
        }

        while ([rs next]) {
            ImageUnit* image_unit = [ImageUnit alloc];
            [self fillImageUnit:image_unit withRs:rs];
            [imageUnitArray addObject:image_unit];
        }
        [rs close];
        [db close];
    }
}


- (void) QueryImageUnitArrayByDateYM:(NSString*)date_ym  
                     withPatientName:(NSString*)patient_name 
                     withReturnArray:(NSMutableArray*)imageUnitArray
{
    debugMethod();
    
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        NSString    *sql = nil;
        FMResultSet *rs = nil;
        if (nil != patient_name) {
            sql = @"select * from ImageSet where substr(date,1,7)=? and owner=?";
            rs = [db executeQuery:sql, date_ym, patient_name];
        }
        else {
            sql = @"select * from ImageSet where substr(date,1,7)=?";
            rs = [db executeQuery:sql, date_ym];
        }

        while ([rs next]) {
            ImageUnit* image_unit = [ImageUnit alloc];
            [self fillImageUnit:image_unit withRs:rs];
            [imageUnitArray addObject:image_unit];
        }
        [rs close];
        [db close];
    }
}



- (void) QueryFirstImageUnitByDate:(NSString*)date 
                   withPatientName:(NSString*)patient_name 
               withReturnImageUnit:(ImageUnit*)imageUnit
{
    debugMethod();
    
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        NSString    *sql = nil;
        FMResultSet *rs = nil;
        if (nil != patient_name) {
            sql = @"select * from ImageSet where date=? and onwer=?";
            rs = [db executeQuery:sql, date, patient_name];
            
            if ([rs next]) {
                [self fillImageUnit:imageUnit withRs:rs];
            }
        }
        else {
            sql = @"select * from ImageSet where date=?";
            rs = [db executeQuery:sql, date];
            
            if ([rs next]) {
                [self fillImageUnit:imageUnit withRs:rs];
            }
        }


        [rs close];
        [db close];
    }  
}


- (void) QueryImageUnitArrayByUuid:(NSString*)uuid
                   withPatientName:(NSString*)patient_name
                   withReturnArray:(NSMutableArray*)imageUnitArray
{
    debugMethod();
    
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        NSString   *sql = nil;
        FMResultSet *rs = nil;
        if (nil != patient_name) {
            sql = @"select * from ImageSet where uuid=? and onwer=?";
            rs = [db executeQuery:sql, uuid, patient_name];
        }
        else {
            sql = @"select * from ImageSet where uuid=?";
            rs = [db executeQuery:sql, uuid];
        }

        while ([rs next]) {
            ImageUnit* image_unit = [ImageUnit alloc];
            [self fillImageUnit:image_unit withRs:rs];
            [imageUnitArray addObject:image_unit];
        }
        [rs close];
        [db close];
    }
}


- (void) QueryImageUnitArrayByToothIdGroup:(NSInteger)tooth_id_group
                           withPatientName:(NSString*)patient_name
                           withReturnArray:(NSMutableArray*)imageUnitArray
{
    debugMethod();
    
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        NSString   *sql = nil;
        FMResultSet *rs = nil;
        if (nil != patient_name) {
            sql = @"select * from ImageSet where tooth_id_group=? and onwer=?";
            rs = [db executeQuery:sql, tooth_id_group, patient_name];
        }
        else {
            sql = @"select * from ImageSet where tooth_id_group=?";
            rs = [db executeQuery:sql, tooth_id_group];
        }

        while ([rs next]) {
            ImageUnit* image_unit = [ImageUnit alloc];
            [self fillImageUnit:image_unit withRs:rs];
            [imageUnitArray addObject:image_unit];
        }
        [rs close];
        [db close];
    }
}


#if 0

-(NSString *)databaseFilePath
{
    NSArray *filePath
    = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [filePath objectAtIndex:0];
    
    NSString *dbFilePath = [documentPath stringByAppendingPathComponent:@"db.sqlite"];
    NSLog(@"%@",dbFilePath);
    return dbFilePath;
}

-(void)creatDatabase
{
    NSLog(@"creatDatabase");
    db = [FMDatabase databaseWithPath:[self databaseFilePath]];
}

#endif




#if 0
-(void) InsertImage:(NSString*)uuid andDate:(NSString*)date andTitle:(NSString*)title andImage:(UIImage*)image andToothId:(NSInteger)toothId  andUrl:(NSString *)url andToothIdGroup:(NSInteger)tooth_id_group
{
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {

        NSString *onwer         = @"peter";
        NSString *tooth_id      = @"1";
        NSData   *image_data    =  UIImageJPEGRepresentation(image, 0.8);
        
        BOOL res = [db executeUpdate:s_InsertSql, uuid, date, title, url, onwer, toothId, image_data, tooth_id_group];
        if (!res) {
            debugLog(@"error to insert data");
        } else {
            debugLog(@"succ to insert data");
        }
    }
    
    [db close];
}
#endif

/*
 //修改数据
 NSString *updateTable=@"update zhaochao set username=? where username=?";
 NSArray  *updateParams=@[@"admin",@"zhaochao"];
 // [db execSql:updateTable parmas:updateParams dataBaseName:@"zhaochao.sqlite"];
 
 //删除数据
 NSString *deleteTable=@"delete from zhaochao where username=?";
 NSArray   *deleteParams=@[@"aa"];
 // [db execSql:deleteTable parmas:deleteParams dataBaseName:@"zhaochao.sqlite"];
 
 //查询数据
 NSString *selectTable=@"select username,userPasswd from zhaochao where userPasswd=?";
 NSString *selectParam=@[@"bb"];
 NSArray *result=[db selectSql:selectTable parmas:selectParam dataBaseName:@"zhaochao.sqlite"];
 for (int i=0; i<result.count; i++)="" {="" nsmutabledictionary="" *arr="[result" objectatindex:i];="" nslog(@"%@",arr);="" }="" <="" pre=""><br>
 <br>
 */

-(void) RemoveImage:(NSString*) title
{
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        NSString * sql = @"delete from ImageSet where title=?";
        BOOL res = [db executeUpdate:sql, title];
        if (!res) {
            debugLog(@"error to remove data");
        } else {
            debugLog(@"succ to remove data");
        }
    }
    
    [db close];
}


-(void) RemoveImageByUuid:(NSString*) uuid
{
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        NSString * sql = @"delete from ImageSet where uuid=?";
        BOOL res = [db executeUpdate:sql, uuid];
        if (!res) {
            debugLog(@"error to remove data");
        } else {
            debugLog(@"succ to remove data");
            [db commit];
        }
    }
    
    [db close];
}


-(void) InsertImage:(ImageUnit*)imageUnit
{
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {

        NSData   *image_data    =  UIImageJPEGRepresentation(imageUnit.image_data, 0.8);
        BOOL res = [db executeUpdate:s_InsertSql,
                    imageUnit.uuid,
                    imageUnit.date,
                    imageUnit.title,
                    imageUnit.url,
                    imageUnit.owner,
                    imageUnit.tooth_id,
                    image_data,
                    imageUnit.tooth_id_group];
        if (!res) {
            debugLog(@"error to insert data");
        } else {
            debugLog(@"succ to insert data");
        }
    }
    
    [db close];
}


- (void)clearAllImages
{
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        //NSString * sql = @"delete from ImageSet";
        
        BOOL res = [db executeUpdate:s_deleteAllSql];
        if (!res) {
            debugLog(@"error to delete db data");
        } else {
            debugLog(@"succ to deleta db data");
        }
        [db close];
    }
}


- (void) prepareImagesForTest
{
#if 0
    if (nil == _urls) {
        _urls = [NSMutableArray array];
    }
    if (nil == _title) {
        _title = [NSMutableArray array];
    }
    if (nil == _date) {
        _date = [NSMutableArray array];
    }
    
    if (USING_LOCAL_IMAGE) {
        for (int i = 0; i < 9; i++) {
            NSString *title = [NSString stringWithFormat:@"%ld",(long)i+1];
            [_urls addObject:title];
        }
    }
    else{
        // 0.图片链接
        [_urls addObject: @"http://ww4.sinaimg.cn/thumbnail/7f8c1087gw1e9g06pc68ug20ag05y4qq.gif"];
        [_urls addObject: @"http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr0nly5j20pf0gygo6.jpg"];
        [_urls addObject: @"http://ww4.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr1d0vyj20pf0gytcj.jpg"];
        [_urls addObject: @"http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr1xydcj20gy0o9q6s.jpg"];
        [_urls addObject: @"http://ww2.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr2n1jjj20gy0o9tcc.jpg"];
        [_urls addObject: @"http://ww2.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr39ht9j20gy0o6q74.jpg"];
        [_urls addObject: @"http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr3xvtlj20gy0obadv.jpg"];
        [_urls addObject: @"http://ww4.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr4nndfj20gy0o9q6i.jpg"];
        [_urls addObject: @"http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr57tn9j20gy0obn0f.jpg"];
    }
    
    
    for (int index = 0; index < 9; index++)
    {
        NSString *title = [NSString stringWithFormat:@"{0,%ld}",(long)index+1];
        
        NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
        [dateFormatter1 setDateFormat:@"yyyy-MM-dd 00:00:00"];
        NSString *currentDateStr1 = [dateFormatter1 stringFromDate:[NSDate date]];
        
        if (i > 5) {
            NSTimeInterval secondsPerDay1 = 24*60*60;
            NSDate *now = [NSDate date];
            NSDate *yesterDay = [now addTimeInterval:-secondsPerDay1];
            currentDateStr1 = [dateFormatter stringFromDate:yesterDay]
        }
        [_title addObject:title];
        [_date addObject:currentDateStr1];
    }
    
    
    [self insertData];
#endif
    
    [self clearAllImages];
    
    for (int index = 0; index < 9; index++)
    {
        ImageUnit* imageUnit = [ImageUnit alloc];
        

        NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
        [dateFormatter1 setDateFormat:@"yyyy-MM-dd 00:00:00"];
        imageUnit.date = [dateFormatter1 stringFromDate:[NSDate date]];
        imageUnit.url  = [NSString stringWithFormat:@"{0,%ld}",(long)index+1];
        imageUnit.uuid = [[NSUUID UUID] UUIDString];

        if (index < 5) {
            imageUnit.tooth_id = @"1";
            imageUnit.owner = @"peter";
        } else {
            imageUnit.tooth_id = @"2";
            imageUnit.owner = @"max";
        }
        
        imageUnit.title = [NSString stringWithFormat:@"#%@-%@", imageUnit.tooth_id,
            imageUnit.owner];
        
        
        if (index > 5) {
            NSTimeInterval secondsPerDay1 = 24*60*60*10;
            NSDate *now = [NSDate date];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd 00:00:00"];
            NSDate *yesterDay = [now addTimeInterval:-secondsPerDay1];
            imageUnit.date = [dateFormatter stringFromDate:yesterDay];
        }

        
        NSString* image_name = [NSString stringWithFormat:@"%ld",(long)index+1];
        imageUnit.image_data = [UIImage imageNamed:image_name];
        imageUnit.tooth_id_group = 0;

        [self InsertImage:imageUnit];
    }
}

@end
