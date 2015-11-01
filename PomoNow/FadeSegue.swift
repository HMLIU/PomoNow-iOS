//
//  FadeSegue.swift
//  PomoNow
//
//  Created by Megabits on 15/7/13.
//  Copyright © 2015年 ScrewBox. All rights reserved.
//

import UIKit

class FadeSegue: UIStoryboardSegue {
   
    override func perform() {
        // Assign the source and destination views to local variables.
        let firstVCView = self.sourceViewController.view as UIView!
        let secondVCView = self.destinationViewController.view as UIView!
        
        let window = UIApplication.sharedApplication().keyWindow
        window?.insertSubview(secondVCView, aboveSubview: firstVCView)
        
        secondVCView.alpha = 0
        // Animate the transition.
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            secondVCView.alpha = 1
            }) { (Finished) -> Void in
                self.sourceViewController.presentViewController(self.destinationViewController as UIViewController,
                    animated: false,
                    completion: nil)
        }
    }
    
}
