//
//  ShareExtension.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 5/28/21.
//

import Foundation
import Firebase
import AudioToolbox

class ShareFunctionHelper : NSObject {
    
    static func handleShareTap(feeder : [String : Any], passedView : UIView, completion : @escaping(_ passingView : UIActivityViewController)->()) {
        
        let imageGrabber : UIImageView = UIImageView()
        
        var imageActivityItem : UIImage?
        
        var videoActivityItem : NSURL?
        
        var activityViewController : UIActivityViewController?
        
        if feeder["is_video"] as? Bool == true {
            
            if let url = NSURL(string: feeder["video_url"] as? String ?? "nil") {
                
                videoActivityItem = url
                
                activityViewController = UIActivityViewController(
                    activityItems: [videoActivityItem as Any], applicationActivities: nil)
                
                // This lines is for the popover you need to show in iPad
                activityViewController?.popoverPresentationController?.sourceView = (passedView)
                
                // This line remove the arrow of the popover to show in iPad
                activityViewController?.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.any
                activityViewController?.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
                
                // Anything you want to exclude
                activityViewController?.excludedActivityTypes = [
                    UIActivity.ActivityType.print,
                    UIActivity.ActivityType.saveToCameraRoll,
                    UIActivity.ActivityType.addToReadingList,
                    UIActivity.ActivityType.postToVimeo,
                    UIActivity.ActivityType.postToTencentWeibo
                ]
                
                if let activity = activityViewController {
                    completion(activity)
                }
            }
            
        } else {
            
            if let url = feeder["image_url"] as? String {
                
                imageGrabber.loadImageGeneralUse(url)
                
                imageActivityItem = imageGrabber.image
                
                activityViewController = UIActivityViewController(
                    activityItems: [imageActivityItem as Any], applicationActivities: nil)
                
                // This lines is for the popover you need to show in iPad
                activityViewController?.popoverPresentationController?.sourceView = (passedView)
                
                // This line remove the arrow of the popover to show in iPad
                activityViewController?.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.any
                activityViewController?.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
                
                // Anything you want to exclude
                activityViewController?.excludedActivityTypes = [
                    UIActivity.ActivityType.postToWeibo,
                    UIActivity.ActivityType.print,
                    UIActivity.ActivityType.assignToContact,
                    UIActivity.ActivityType.addToReadingList,
                    UIActivity.ActivityType.postToFlickr,
                    UIActivity.ActivityType.postToVimeo,
                    UIActivity.ActivityType.postToTencentWeibo
                ]
                
                if let activity = activityViewController {
                    completion(activity)
                    
                }
            }
        }
    }
}
