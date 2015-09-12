//
//  ImageModel.h
//  iAcqChina
//
//  Created by Dental Equipment on 1/1/15.
//  Copyright (c) 2015 iAcqChina. All rights reserved.
//

#import <Foundation/Foundation.h>



/// Table ImageSet
// 1. date
// 2. title
// 3. url
// 4. owner (patient name)
// 5. tooth_id
// 6. image_data


// ----------------------------------------------------------------------
@interface ImageUnit : NSObject
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *tooth_id;
@property (strong, nonatomic) NSString *owner;
@property (strong, nonatomic) UIImage  *image_data;
@property (strong, nonatomic) NSString *uuid;
@property NSInteger	tooth_id_group; // 0-up left, 1-up right, 2-down left, 3-down right, 4-buccal up, 5-buccal down,
@end





// ----------------------------------------------------------------------
@interface ImageModel : NSObject

@property (strong, nonatomic) NSMutableArray *urls;
@property (strong, nonatomic) NSMutableArray *title;
@property (strong, nonatomic) NSMutableArray *date;


// should be called after alloc
- (void) InitDataBase;

- (void) prepareImagesForTest;
- (NSInteger) imageCount;
//- (NSString*) imageUrl:   (NSInteger) index;
- (NSString*) imageTitle: (NSInteger) index;
- (NSString*) imageDate:  (NSInteger) index;
- (UIImage*)  imageData:  (NSInteger) index;

//-------------------------------------------------------------------------------------------------
// query interface


- (void) QueryImageUnitAll:(NSMutableArray*)imageUnitArray;


// owner
- (void) QueryImageUnitArrayByOwner:(NSString*)owner 	
					withReturnArray:(NSMutableArray*)imageUnitArray;


// user name
- (void) QueryUserNameArray:(NSMutableArray*)userNameArray;


// query date
- (void) QueryDateArray:(NSString*)patient_name 
		withReturnArray:(NSMutableArray*)DateArray;




// tooth id
- (void) QueryImageUnitArrayByToothId:(NSString*)tooth_id 	
					  withPatientName:(NSString*)patient_name 
					  withReturnArray:(NSMutableArray*)imageUnitArray;


//----------------------------------------------------------------------------
// date

- (void) QueryImageUnitArrayByDate:(NSString*)date 	
				   withPatientName:(NSString*)patient_name
				   withReturnArray:(NSMutableArray*)imageUnitArray;

- (void) QueryImageUnitArrayByDateYM:(NSString*)date_ym  
				     withPatientName:(NSString*)patient_name 	
				     withReturnArray:(NSMutableArray*)imageUnitArray;

-(void) QueryFirstImageUnitByDate:(NSString*)date
                   withPatientName:(NSString*)patient_name
               withReturnImageUnit:(ImageUnit*)imageUnit;



// uuid
- (void) QueryImageUnitArrayByUuid:(NSString*)uuid 
				   withPatientName:(NSString*)patient_name 		
				   withReturnArray:(NSMutableArray*)imageUnitArray;



// tooth id group
- (void) QueryImageUnitArrayByToothIdGroup:(NSInteger)tooth_id_group 
						   withPatientName:(NSString*)patient_name
						   withReturnArray:(NSMutableArray*)imageUnitArray;




#if 0
-(void) InsertImage:(NSString*)uuid
			andDate:(NSString*)date
           andTitle:(NSString*)title
           andImage:(UIImage*)image
         andToothId:(NSInteger)toothId
             andUrl:(NSString *)url
    andToothIdGroup:(NSInteger)tooth_id_group;
#endif


-(void) InsertImage:(ImageUnit*)imageUnit;


-(void) RemoveImage:(NSString*) title;
-(void) RemoveImageByUuid:(NSString*) uuid;
@end
