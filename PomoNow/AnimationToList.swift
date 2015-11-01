//
//  MagicMoveTransion.swift
//  PomoNow
//
//  Created by Megabits on 15/7/13.
//  Copyright © 2015年 ScrewBox. All rights reserved.
//

import UIKit

class AnimationToList: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        //获取动画的源控制器和目标控制器
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! PomodoroViewController
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! PomoListViewController
        let container = transitionContext.containerView()
        
        let snap = fromVC.TimerView.snapshotViewAfterScreenUpdates(false)
        snap.frame = container!.convertRect(fromVC.TimerView.frame, fromView: fromVC.TimerViewContainer)
        
        let snapRound = fromVC.round.snapshotViewAfterScreenUpdates(false)
        snapRound.frame = container!.convertRect(fromVC.round.frame, fromView: fromVC.view)
        
        fromVC.TimerView.hidden = true
        
        toVC.view.frame = transitionContext.finalFrameForViewController(toVC)
        toVC.view.alpha = 0
        snapRound.alpha = 0
        

        //代理管理以下view
        container!.addSubview(snap)
        container!.addSubview(snapRound)
        container!.addSubview(toVC.view)
        
        UIView.animateWithDuration(0.1, delay:0,options:UIViewAnimationOptions.TransitionNone,  animations: { () -> Void in
            fromVC.taskLabel.alpha = 0
            fromVC.readme.alpha = 0
            }) { (finish: Bool) -> Void in
                fromVC.round.hidden = true
                snapRound.alpha = 1
        }
        
        UIView.animateWithDuration(0.25, delay:0.1,options:UIViewAnimationOptions.CurveEaseInOut,  animations: { () -> Void in
            toVC.view.layoutIfNeeded()
            toVC.view.setNeedsDisplay()
            snapRound.frame = toVC.round.frame
            snap.frame = toVC.TimerView.frame
            }) { (finish: Bool) -> Void in
        }
        
        UIView.animateWithDuration(0.25, delay:0.8,options:UIViewAnimationOptions.TransitionNone,  animations: { () -> Void in
            snap.alpha = 0
            }) { (finish: Bool) -> Void in
        }
        UIView.animateWithDuration(0.15, delay:0.35,options:UIViewAnimationOptions.TransitionNone,  animations: { () -> Void in
            snapRound.alpha = 0
            toVC.view.alpha = 1
            }) { (finish: Bool) -> Void in
            //让系统管理 navigation
            fromVC.TimerView.hidden = false
            fromVC.round.hidden = false
            fromVC.taskLabel.alpha = 1
            fromVC.readme.alpha = 1
            snap.removeFromSuperview()
            snapRound.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
        
    }
}