//
//  NavigationController.swift
//  PomoNow
//
//  Created by Megabits on 15/10/3.
//  Copyright © 2015年 ScrewBox. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    override func segueForUnwindingToViewController(toViewController: UIViewController, fromViewController: UIViewController, identifier: String?) -> UIStoryboardSegue { //动画作为NC的subview可以防止其被忽略
        if let id = identifier{
            if id == "backToList" {
                let unwindSegue = FadeSegueUnwind(identifier: id, source: fromViewController, destination: toViewController, performHandler: { () -> Void in
                    
                })
                return unwindSegue
            }
        }
        
        return super.segueForUnwindingToViewController(toViewController, fromViewController: fromViewController, identifier: identifier)!
    }
}
