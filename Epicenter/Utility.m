
#import "Utility.h"

#import "Reachability.h"
#define MENU_FILE_NAME   @"MenuData/my_menu.txt"
#define MENU_PRESENT     @"menu_present"
@implementation Utility

NSString *const CacheManagerDidDownloadImage =@"CacheManagerDidDownloadImage";
+(BOOL)isDeviceHeightOfThreePointFiveInches
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;
    
    if(screenHeight == 480)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}




+(BOOL)isValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}


+(void)showAlertForInternetConnectivity
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"No Internet Connectivity!" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alert show];
    
}
+(void)showAlertForEmptyTextField{
   
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Please Fill The Entry!" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alert show];

}

+(void)showAlertForSomeWentWrong
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Something went wrong! \nplease try again.!" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alert show];

}
+(void)showAlertRegistration
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Registration Successfull" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alert show];
    
}
+(void)showAlertCustom :(NSString *)strAlrt
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:strAlrt message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alert show];
    
}


+(BOOL)isInternetAvailable
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    
    if(networkStatus == NotReachable)
        return NO;
    else
        return YES;
    
    return YES;
    
}

+(BOOL)isIOSVerionigGreaterAndEqualTo7
{
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
        return YES;
    
    return NO;
}

+ (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)newSize {
    
    float width = newSize.width;
    float height = newSize.height;
    
    UIGraphicsBeginImageContext(newSize);
    CGRect rect = CGRectMake(0, 0, width, height);
    
    float widthRatio = image.size.width / width;
    float heightRatio = image.size.height / height;
    float divisor = widthRatio > heightRatio ? widthRatio : heightRatio;
    
    width = image.size.width / divisor;
    height = image.size.height / divisor;
    
    rect.size.width  = width;
    rect.size.height = height;
    
    //indent in case of width or height difference
    float offset = (width - height) / 2;
    if (offset > 0) {
        rect.origin.y = offset;
    }
    else {
        rect.origin.x = -offset;
    }
    
    [image drawInRect: rect];
    
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return smallImage;
    
}
+(UIImage *)compressImage:(UIImage *)image{
    float actualHeight = image.size.height;
    float actualWidth = image.size.width;
    float maxHeight = 600.0;
    float maxWidth = 800.0;
    float imgRatio = actualWidth/actualHeight;
    float maxRatio = maxWidth/maxHeight;
    float compressionQuality = 0.5;//50 percent compression
    
    if (actualHeight > maxHeight || actualWidth > maxWidth){
        if(imgRatio < maxRatio){
            //adjust width according to maxHeight
            imgRatio = maxHeight / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = maxHeight;
        }
        else if(imgRatio > maxRatio){
            //adjust height according to maxWidth
            imgRatio = maxWidth / actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = maxWidth;
        }
        else{
            actualHeight = maxHeight;
            actualWidth = maxWidth;
        }
    }
    
    CGRect rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    NSData *imageData = UIImageJPEGRepresentation(img, compressionQuality);
    UIGraphicsEndImageContext();
    
    return [UIImage imageWithData:imageData];
}

+(NSString *)encodeToBase64String:(UIImage *)image {
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

+(NSString *)getUDID{
NSString* uniqueIdentifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString]; // IOS 6+
NSLog(@"UDID:: %@", uniqueIdentifier);
    return uniqueIdentifier;
}

- (UIImage *)resizeImage:(UIImage *)image
             withQuality:(CGInterpolationQuality)quality
                    rate:(CGFloat)rate
{
    UIImage *resized = nil;
    CGFloat width = image.size.width * rate;
    CGFloat height = image.size.height * rate;
    
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, quality);
    [image drawInRect:CGRectMake(0, 0, width, height)];
    resized = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resized;
}
+ (void)removeImage:(NSString*)fileName {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *docPath = [NSSearchPathForDirectoriesInDomains (NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath=[NSString stringWithFormat:@"%@/%@",docPath,fileName];
    
    NSError *error = nil;
    if(![fileManager removeItemAtPath: filePath error:&error]) {
        NSLog(@"Delete failed:%@", error);
    } else {
        NSLog(@"image removed: %@", filePath);
    }
}

+(UIImage *)getImageFromPath :(NSString *)strImageName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory

    NSString *filePath = [documentsPath stringByAppendingPathComponent:strImageName]; //Add the file name
    
    NSData *pngData1 = [NSData dataWithContentsOfFile:filePath];
    UIImage *image   = [UIImage imageWithData:pngData1];
    return image;
}
+(NSString *)getDateStringFromTimeStamp:(NSString *)timestamp
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:(timestamp.doubleValue/1000.0)];
    NSLog(@"%@", date);
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:@"HH:mm a"] ;
    NSLog(@"result: %@", [dateFormatter stringFromDate:date]) ;
    return [dateFormatter stringFromDate:date];
}
+(NSString *)getNewDateStringFromTimeStamp:(NSString *)timestamp
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:(timestamp.doubleValue/1000.0)];
    NSLog(@"%@", date);
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:@"dd MMM yyyy HH:mm "] ;
    NSLog(@"result: %@", [dateFormatter stringFromDate:date]) ;
    return [dateFormatter stringFromDate:date];
}

+(NSString *)dateFormater :(NSString *)dateStr
{
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormat dateFromString:[dateStr substringToIndex:10]];
    
    NSDate *endDate = [NSDate date];
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay
                                                        fromDate:date
                                                          toDate:endDate
                                                         options:0];
    
    
    long difference = components.day;
    
    NSString *datesDifferenceText = [NSString stringWithFormat:@"%ld d",difference];
    
    
    
    if(difference < 31)
    {
        if(difference == 1)
        {
            datesDifferenceText = [NSString stringWithFormat:@"%ld d",difference];
        }
        else if(difference == 0)
        {
            datesDifferenceText = @"Today";
            
        }
        else
        {
            datesDifferenceText = [NSString stringWithFormat:@"%ld d",difference];
        }
        
    }
    
    else
    {
        if(difference > 31)
        {
            difference = difference / 31;
            
            if(difference > 1)
                datesDifferenceText = [NSString stringWithFormat:@"%ld m",difference];
            else
                datesDifferenceText = [NSString stringWithFormat:@"%ld m",difference];
        }
        else if(difference > 12)
        {
            difference = difference/12;
            
            if(difference > 1)
                datesDifferenceText = [NSString stringWithFormat:@"%ld y",difference];
            else
                datesDifferenceText = [NSString stringWithFormat:@"%ld y",difference];
        }
    }
    
    return datesDifferenceText;
}



//+(NSString *)dateFormater :(NSString *)dateStr
//{
//    
//    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//    [dateFormat setDateFormat:@"yyyy-MM-dd"];
//    NSDate *date = [dateFormat dateFromString:[dateStr substringToIndex:10]];
//    
//    NSDate *endDate = [NSDate date];
//    
//    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    NSDateComponents *components = [gregorianCalendar components:NSDayCalendarUnit
//                                                        fromDate:date
//                                                          toDate:endDate
//                                                         options:0];
//    
//    
//    long difference = components.day;
//    
//    NSString *datesDifferenceText = [NSString stringWithFormat:@"%ld days ago",difference];
//    
//    
//    
//    if(difference < 31)
//    {
//        if(difference == 1)
//        {
//            datesDifferenceText = [NSString stringWithFormat:@"%ld day ago",difference];
//        }
//        else if(difference == 0)
//        {
//            datesDifferenceText = @"Today";
//            
//        }
//        else
//        {
//            datesDifferenceText = [NSString stringWithFormat:@"%ld days ago",difference];
//        }
//        
//    }
//    
//    else
//    {
//        if(difference > 31)
//        {
//            difference = difference / 31;
//            
//            if(difference > 1)
//                datesDifferenceText = [NSString stringWithFormat:@"%ld months ago",difference];
//            else
//                datesDifferenceText = [NSString stringWithFormat:@"%ld month ago",difference];
//        }
//        else if(difference > 12)
//        {
//            difference = difference/12;
//            
//            if(difference > 1)
//                datesDifferenceText = [NSString stringWithFormat:@"%ld years ago",difference];
//            else
//                datesDifferenceText = [NSString stringWithFormat:@"%ld year ago",difference];
//        }
//    }
//    
//    return datesDifferenceText;
//}

+ (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize image:(UIImage*)sourceImage
{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
        {
            scaleFactor = widthFactor; // scale to fit height
        }
        else
        {
            scaleFactor = heightFactor; // scale to fit width
        }
        
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
        {
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
        }
    }
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil)
    {
        //NSLog(@"could not scale image");
    }
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    
    return newImage;
}

+(UIImage*)imageWithImageForResize: (UIImage*) sourceImage scaledToWidth: (float) i_width
{
    float oldWidth = sourceImage.size.width;
    float scaleFactor = i_width / oldWidth;
    
    float newHeight = sourceImage.size.height * scaleFactor;
    float newWidth = oldWidth * scaleFactor;
    
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage*)imageWithImage:(UIImage *)image convertToWidth:(float)width {
    float ratio = image.size.width / width;
    float height = image.size.height / ratio;
    CGSize size = CGSizeMake(width, height);
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage * newimage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimage;
}

+ (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

+ (UIImage*)resizeImage:(UIImage*)image withWidth:(int)width withHeight:(int)height
{
    CGSize newSize = CGSizeMake(width, height);
    float widthRatio = newSize.width/image.size.width;
    float heightRatio = newSize.height/image.size.height;
    
    if(widthRatio > heightRatio)
    {
        newSize=CGSizeMake(image.size.width*heightRatio,image.size.height*heightRatio);
    }
    else
    {
        newSize=CGSizeMake(image.size.width*widthRatio,image.size.height*widthRatio);
    }
    
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

+(NSString *)getCurrentdateAndTime{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSLog(@"%@",[dateFormatter stringFromDate:[NSDate date]]);
    NSString *strTime = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:[NSDate date]]];
    return strTime;
}

+ (NSString *)calculateDuration:(NSDate *)oldTime secondDate:(NSDate *)currentTime
{
    
    
    NSDate *date1 = oldTime;
    NSDate *date2 = currentTime;
    
    NSTimeInterval secondsBetween = [date2 timeIntervalSinceDate:date1];
    
 //   int hh = secondsBetween / (60*60);
    double rem = fmod(secondsBetween, (60*60));
   // int mm = rem / 60;
    rem = fmod(rem, 60);
    int ss = rem;
    
    NSString *str = [NSString stringWithFormat:@"%02d",ss];
    
    return str;
}
+(NSDate *)convertStringDateToNSDate :(NSString *)dateString{

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // this is imporant - we set our input date format to match our input string
    // if format doesn't match you'll get nil from your string, so be careful
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSDate *dateFromString = [[NSDate alloc] init];
    // voila!
    dateFromString = [dateFormatter dateFromString:dateString];
    return dateFromString;
}
+ (UIImage*)imageByCombiningImage:(UIImage*)firstImage withImage:(UIImage*)secondImage {
    UIImage *image = nil;
    
    CGSize newImageSize = CGSizeMake(MAX(firstImage.size.width, secondImage.size.width), MAX(firstImage.size.height, secondImage.size.height));
    if (&UIGraphicsBeginImageContextWithOptions != NULL) {
        UIGraphicsBeginImageContextWithOptions(newImageSize, NO, [[UIScreen mainScreen] scale]);
    } else {
        UIGraphicsBeginImageContext(newImageSize);
    }
    [firstImage drawAtPoint:CGPointMake(roundf((newImageSize.width-firstImage.size.width)/2),
                                        roundf((newImageSize.height-firstImage.size.height)/2))];
    [secondImage drawAtPoint:CGPointMake(roundf((newImageSize.width-secondImage.size.width)/2),
                                         roundf((newImageSize.height-secondImage.size.height)/2))];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+(NSString*)retrivePostTime:(NSDate *)userPostDate{
    
//    NSDateFormatter *df = [[NSDateFormatter alloc] init];
//    [df setDateFormat:@"eee MMM dd HH:mm:ss ZZZZ yyyy"];
//    NSDate *userPostDate = [df dateFromString:postDate];
//    
    
    NSDate *currentDate = [NSDate date];
    NSTimeInterval distanceBetweenDates = [currentDate timeIntervalSinceDate:userPostDate];
    
    NSTimeInterval theTimeInterval = distanceBetweenDates;
    
    // Get the system calendar
    NSCalendar *sysCalendar = [NSCalendar currentCalendar];
    
    // Create the NSDates
    NSDate *date1 = [[NSDate alloc] init];
    NSDate *date2 = [[NSDate alloc] initWithTimeInterval:theTimeInterval sinceDate:date1];
    
    // Get conversion to months, days, hours, minutes
    unsigned int unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSSecondCalendarUnit;
    
    NSDateComponents *conversionInfo = [sysCalendar components:unitFlags fromDate:date1  toDate:date2  options:0];
    
    NSString *returnDate;
    if ([conversionInfo month] > 0) {
        returnDate = [NSString stringWithFormat:@"%ldmth ago",(long)[conversionInfo month]];
    }else if ([conversionInfo day] > 0){
        returnDate = [NSString stringWithFormat:@"%ldd ago",(long)[conversionInfo day]];
    }else if ([conversionInfo hour]>0){
        returnDate = [NSString stringWithFormat:@"%ldh ago",(long)[conversionInfo hour]];
    }else if ([conversionInfo minute]>0){
        returnDate = [NSString stringWithFormat:@"%ldm ago",(long)[conversionInfo minute]];
    }else{
        returnDate = [NSString stringWithFormat:@"%lds ago",(long)[conversionInfo second]];
    }
    return returnDate;
}



+(NSString *)convertIntoJson :(NSArray *)response{
    NSError * err;
    NSMutableDictionary *postDict = [[NSMutableDictionary alloc]init];
    [postDict setValue:response forKey:MENU_PRESENT];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:postDict options:0 error:&err];
    
    // Checking the format
    NSString * myString =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    
    return myString;
}

+(NSDictionary *)convertJsonIntoDictonary:(NSString *)string{
    NSError * err;
    NSDictionary * response = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:[string dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&err];
    
    return response;
}

+(NSString *)convertIntoJsonForCatFile :(NSDictionary *)response{
    NSError * err;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:response options:0 error:&err];
    
    // Checking the format
    NSString * myString =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    
    return myString;
}

+ (void)writeStringToFile:(NSString*)aString {
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"/MenuData"];
    NSError *error;
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])//Check
        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error];
    
    // Build the path, and create if needed.
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileName = MENU_FILE_NAME;
    NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:fileAtPath]) {
        [[NSFileManager defaultManager] createFileAtPath:fileAtPath contents:nil attributes:nil];
    }
    NSLog(@"%@",fileAtPath);
    // The main act...
    [[aString dataUsingEncoding:NSUTF8StringEncoding] writeToFile:fileAtPath atomically:NO];
}
+ (NSString*)readStringFromFile {
    
    // Build the path...
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileName = MENU_FILE_NAME;
    NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
    
    // The main act...
    return [[NSString alloc] initWithData:[NSData dataWithContentsOfFile:fileAtPath] encoding:NSUTF8StringEncoding];
}


+ (void)writeStringToFileForCategoryFile:(NSString*)aString :(NSString *)cat_id {
    
    // Build the path, and create if needed.
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileAtPath = [filePath stringByAppendingPathComponent:cat_id];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:fileAtPath]) {
        [[NSFileManager defaultManager] createFileAtPath:fileAtPath contents:nil attributes:nil];
    }
    
    // The main act...
    [[aString dataUsingEncoding:NSUTF8StringEncoding] writeToFile:fileAtPath atomically:NO];
}
+ (NSString*)readStringFromFileForCategoryFile: (NSString *)cat_id {
    
    // Build the path...
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileName = cat_id;
    
    NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
    
    // The main act...
    return [[NSString alloc] initWithData:[NSData dataWithContentsOfFile:fileAtPath] encoding:NSUTF8StringEncoding];
}



@end
