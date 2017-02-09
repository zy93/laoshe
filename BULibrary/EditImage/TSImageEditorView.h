//
//  TSImageEditorView.h
//  YuYan
//
//  Created by  on 14-11-28.
//  Copyright (c) 2014年   MultiMedia Lab. All rights reserved.
//

#import <UIKit/UIKit.h>


/// Delegate protocol of TSImageEditrView.
@protocol TSImageEditorViewDelegate <NSObject>

/// Use the Image is called when users finished the editor work
-(void)TSImageEditorFinishedEditingImage:(UIImage*)argImage;

@end


/// Class TSImageEditorView is used to cut user selected image when users
/// select a picture to edit.

@interface TSImageEditorView : UIView

@property (assign) id<TSImageEditorViewDelegate> proDelegate;  /// delegate

/// init the view with frame and image.
/// @param frame The frame of the view.
/// @param argImage the Image to edit.
-(id)initWithFrame:(CGRect)frame andImage:(UIImage*)argImage;

/// Get the result image
-(UIImage*)GetResultImage;

/// static methods provide for convinience
+(UIImage*) imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

@end
