

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



@interface Utility : NSObject

FOUNDATION_EXPORT NSString *const CacheManagerDidDownloadImage;

+(BOOL)isDeviceHeightOfThreePointFiveInches;

+(BOOL)isValidEmail:(NSString *)checkString;

+(BOOL)isInternetAvailable;

+(void)showAlertForInternetConnectivity;

+(void)showAlertForEmptyTextField;

+(void)showAlertForSomeWentWrong;

+(BOOL)isIOSVerionigGreaterAndEqualTo7;

+ (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)newSize;

+(UIImage *)compressImage:(UIImage *)image;

+(void)showAlertRegistration;

+(NSString *)encodeToBase64String:(UIImage *)image;

+(NSString *)getUDID;


+(void)removeImage:(NSString*)fileName;


+(UIImage *)getImageFromPath :(NSString *)strImageName;

+(NSString *)getDateStringFromTimeStamp:(NSString *)timestamp;

+(void)showAlertCustom :(NSString *)strAlrt;

+(NSString *)getNewDateStringFromTimeStamp:(NSString *)timestamp;

+(NSString *)dateFormater :(NSString *)dateStr;

+ (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize image:(UIImage*)sourceImage;

+ (UIImage*)imageWithImage:(UIImage *)image convertToWidth:(float)width;

+ (UIColor *)colorFromHexString:(NSString *)hexString;

+ (UIImage*)resizeImage:(UIImage*)image withWidth:(int)width withHeight:(int)height;

+(UIImage*)imageWithImageForResize: (UIImage*) sourceImage scaledToWidth: (float) i_width;

+(NSString *)getCurrentdateAndTime;
+ (NSString *)calculateDuration:(NSDate *)oldTime secondDate:(NSDate *)currentTime;

+(NSDate *)convertStringDateToNSDate :(NSString *)dateString;

+ (UIImage*)imageByCombiningImage:(UIImage*)firstImage withImage:(UIImage*)secondImage;
+(NSString*)retrivePostTime:(NSDate *)userPostDate;

+(NSString *)convertIntoJson :(NSArray *)response;

+(NSDictionary *)convertJsonIntoDictonary:(NSString *)string;

+ (void)writeStringToFile:(NSString*)aString;

+ (NSString*)readStringFromFile;

+ (NSString*)readStringFromFileForCategoryFile: (NSString *)cat_id;

+ (void)writeStringToFileForCategoryFile:(NSString*)aString :(NSString *)cat_id;

+(NSString *)convertIntoJsonForCatFile :(NSDictionary *)response;
@end
