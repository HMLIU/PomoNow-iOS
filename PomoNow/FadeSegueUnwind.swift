//
//  FadeSegueUnwind.swift
//  PomoNow
//
//  Created by Megabits on 15/7/13.
//  Copyright © 2015年 ScrewBox. All rights reserved.
//

import UIKit

class FadeSegueUnwind: UIStoryboardSegue {
 
    override func perform() {
        // Assign the source and destination views to local variables.
        let secondVCView = self.sourceViewController.view as UIView!
        let firstVCView = self.destinationViewController.view as UIView!
        
        let window = UIApplication.sharedApplication().keyWindow
        window?.insertSubview(firstVCView, aboveSubview: secondVCView)
        
        firstVCView.alpha = 0
        // Animate the transition.
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            firstVCView.alpha = 1
            }) { (Finished) -> Void in
                self.sourceViewController.dismissViewControllerAnimated(false, completion: nil)
        }
    }
    
}
