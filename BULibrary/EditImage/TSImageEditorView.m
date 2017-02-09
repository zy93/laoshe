//
//  TSImageEditorView.m
//  YuYan
//
//  Created by  on 14-11-28.
//  Copyright (c) 2014年   MultiMedia Lab. All rights reserved.
//

#import "TSImageEditorView.h"

@interface TSImageEditorView()<UIScrollViewDelegate>
{
    UIScrollView* m_pScrollView; // the scroll view to place image view which is used to scroll , zoom in and zoom out
    UIImageView* m_pImageView; // The main image view
    CGSize m_originalSize;     // store the original size
    CGSize m_imageSize;        // store image size
    UIImage* m_pResultImage;   // store the result image
    id<TSImageEditorViewDelegate> m_pDelegate;  // the delegate member
}
@end

@implementation TSImageEditorView

@synthesize proDelegate = m_pDelegate;

-(id)initWithFrame:(CGRect)frame andImage:(UIImage*)argImage
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor blackColor];
        m_imageSize = argImage.size;
        CGFloat fImageW = argImage.size.width;
        CGFloat fImageH = argImage.size.height;
        CGFloat dWidth, dHeight;
        CGFloat scale;
        if(fImageW/fImageH >= frame.size.width/frame.size.height)
        {
            dWidth = frame.size.width;
            dHeight = frame.size.width*fImageH/fImageW;
            scale = fImageW/dWidth;
        }
        else
        {
            dHeight = frame.size.height;
            dWidth = frame.size.height*fImageW/fImageH;
            scale = fImageH/dHeight;
        }
        
        m_pScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.width)];
        m_pScrollView.center = CGPointMake(frame.size.width/2, frame.size.height/2);
        m_pScrollView.delegate = self;
        m_pScrollView.clipsToBounds = NO;
        m_pScrollView.bounces = YES;
        m_pScrollView.showsHorizontalScrollIndicator = NO;
        m_pScrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:m_pScrollView];
        [m_pScrollView release];
        
        m_pImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, dWidth, dHeight)];
        [m_pImageView setImage:argImage];
        [m_pScrollView addSubview:m_pImageView];
        [m_pImageView release];
        
        [self CreateWallRectCover];
        
        
        CGFloat minimalScale = 1.0;
        if(dWidth<m_pScrollView.frame.size.width  || dHeight < m_pScrollView.frame.size.height)
        {
            minimalScale = m_pScrollView.frame.size.width/dWidth;
            CGFloat scale1 =m_pScrollView.frame.size.height/dHeight;
            if(minimalScale < scale1)
                minimalScale = scale1;
        }
        
        if(scale < minimalScale)
            scale = minimalScale+0.2;
        
        m_pImageView.center = CGPointMake(dWidth/2, dHeight/2);
        
        m_originalSize = CGSizeMake(dWidth, dHeight);
        m_pScrollView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        m_pScrollView.contentSize = m_originalSize;
        m_pScrollView.contentOffset = CGPointMake((dWidth-m_pScrollView.frame.size.width)/2, (dHeight-m_pScrollView.frame.size.height)/2);
        m_pScrollView.minimumZoomScale = minimalScale;
        m_pScrollView.maximumZoomScale = scale;
        [m_pScrollView setZoomScale:minimalScale];
        
        UIButton* pCancelButton = [[UIButton alloc] initWithFrame:CGRectMake(5, self.bounds.size.height-50, 50, 40)];
        [pCancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [pCancelButton addTarget:self action:@selector(Cancel) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:pCancelButton];
        [pCancelButton release];
        
        UIButton* pChooseButton = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.size.width-60, self.bounds.size.height-50, 50, 40)];
        [pChooseButton setTitle:@"选择" forState:UIControlStateNormal];
        [pChooseButton addTarget:self action:@selector(Choose) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:pChooseButton];
        [pChooseButton release];
    }
    return self;
}

-(void)dealloc
{
    [super dealloc];
}

#pragma mark - private methods

-(void)CreateWallRectCover
{
    float fSize = self.frame.size.width;
    m_pScrollView.frame = CGRectMake(0, 0,fSize,fSize);
    
    UIView* pRectView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,fSize, fSize)];
    pRectView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    [self addSubview:pRectView];
    pRectView.layer.borderColor = [UIColor blackColor].CGColor;
    pRectView.layer.borderWidth = 1;
    pRectView.userInteractionEnabled = NO;
    
    [pRectView release];
}

#pragma mark - public methods

-(UIImage*) GetResultImage
{
    return m_pResultImage;
}

-(void)Cancel
{
    [self removeFromSuperview];
}

-(void)Choose
{
    //CGFloat scale = [m_pScrollView zoomScale];
    //CGPoint offset = m_pScrollView.contentOffset;
    NSLog(@"ImageView frame is %@", NSStringFromCGRect(m_pImageView.frame));
    CGFloat fImageW = m_imageSize.width;
    //CGFloat fImageH = m_imageSize.height;
    
    CGFloat scale = fImageW/m_pImageView.frame.size.width;
    
    CGFloat x = m_pScrollView.contentOffset.x*scale;
    CGFloat y = m_pScrollView.contentOffset.y*scale;
    CGFloat fWidth = m_pScrollView.frame.size.width*scale;
    CGFloat fHeight = m_pScrollView.frame.size.height*scale;
    CGRect rect = CGRectMake(x, y, fWidth, fHeight);
    
    m_pResultImage = [TSImageEditorView imageOfRect:rect inImage:m_pImageView.image];
    m_pResultImage = [TSImageEditorView imageWithImage:m_pResultImage scaledToSize:CGSizeMake(m_pScrollView.frame.size.width*2,m_pScrollView.frame.size.height*2)];
    
    if(m_pDelegate != nil && [m_pDelegate respondsToSelector:@selector(TSImageEditorFinishedEditingImage:)])
    {
        [m_pDelegate TSImageEditorFinishedEditingImage:m_pResultImage];
    }
    
    [self removeFromSuperview];

    
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize
{
    if (image.size.width<newSize.width)
    {
        return image;
    }
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


#pragma mark UIScrollView Delegats

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return m_pImageView;
}


#pragma mark -- static methods
+(UIImage*)Get640PixImageFromImage:(UIImage*)argImage andRect:(CGRect)rect
{
    UIImage*  pResultImage = [TSImageEditorView imageOfRect:rect inImage:argImage];
    pResultImage = [TSImageEditorView imageWithImage:pResultImage scaledToSize:CGSizeMake(640,640)];
    return pResultImage;
}

+(UIImage*) imageOfRect:(CGRect)rect inImage:(UIImage*)argImage
{
    CGFloat x = rect.origin.x;
    CGFloat y = rect.origin.y;
    CGFloat fWidth = rect.size.width;
    CGFloat fHeight = rect.size.height;
    CGFloat fImageW = argImage.size.width;
    CGFloat fImageH = argImage.size.height;
    UIImageOrientation photoOrientation = argImage.imageOrientation;
    //NSLog("the image orientation is %@", m_pImage.imageOrientation);
    if(photoOrientation == UIImageOrientationUp )
    {
        rect = CGRectMake(x, y, fWidth, fHeight);
    }
    else if(photoOrientation == UIImageOrientationDown)
    {
        rect = CGRectMake(fImageW-x-fWidth, fImageH-y-fHeight, fWidth, fHeight);
    }
    else if(photoOrientation == UIImageOrientationLeft )
    {
        rect = CGRectMake(fImageH-y-fHeight,x,fHeight, fWidth);
    }
    else if(photoOrientation == UIImageOrientationRight)
    {
        rect = CGRectMake(y,fImageW-x-fWidth,fHeight, fWidth);
    }
    CGImageRef imageRef = CGImageCreateWithImageInRect(argImage.CGImage, rect);
    
    UIImage*  pResultImage = [UIImage imageWithCGImage:imageRef  scale:1.0f orientation:photoOrientation];
    NSLog(@"outputImage = %@",NSStringFromCGSize(pResultImage.size));
    CGImageRelease(imageRef);
    return pResultImage;
}


+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize
{
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    
    if (image.size.width<newSize.width)
    {
        return image;
    }
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+(UIImage*)Get640PixImageFromImageOfCenterBigestRect:(UIImage *)argImage
{
    CGFloat dScale = argImage.size.height/[UIScreen mainScreen].bounds.size.height;
    CGRect rectPhoto = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width);
    CGRect rect = CGRectMake(argImage.size.width/2 - rectPhoto.size.width/2*dScale,
                      argImage.size.height/2 - rectPhoto.size.height/2*dScale,
                      rectPhoto.size.width*dScale,
                      rectPhoto.size.height*dScale);
    UIImage* pImage = [TSImageEditorView Get640PixImageFromImage:argImage andRect:rect];
    return pImage;
}



@end
