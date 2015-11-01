//
//  AnimationFromList.swift
//  PomoNow
//
//  Created by Megabits on 15/10/2.
//  Copyright © 2015年 ScrewBox. All rights reserved.
//

import UIKit

class AnimationFromList: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        //获取动画的源控制器和目标控制器
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! PomoListViewController
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! PomodoroViewController
        let container = transitionContext.containerView()
        

        
        let snap = fromVC.TimerView.snapshotViewAfterScreenUpdates(false)
        snap.frame = container!.convertRect(fromVC.TimerView.frame, fromView: fromVC.view)
        
        let snapRound = fromVC.round.snapshotViewAfterScreenUpdates(false)
        snapRound.frame = container!.convertRect(fromVC.round.frame, fromView: fromVC.view)
        
        fromVC.TimerView.hidden = true
        snapRound.alpha = 0
        
        toVC.view.frame = transitionContext.finalFrameForViewController(toVC)
        toVC.view.alpha = 0
        
        //代理管理以下view
        container!.addSubview(snap)
        container!.addSubview(snapRound)
        container!.addSubview(toVC.view)
        
        UIView.animateWithDuration(0.1, delay:0,options:UIViewAnimationOptions.TransitionNone,  animations: { () -> Void in
            fromVC.uiView.alpha = 0
            }) { (finish: Bool) -> Void in
                fromVC.round.hidden = true
                snapRound.alpha = 1
                toVC.timeLabel.text = pomodoroClass.timerLabel
                if withTask {
                    for i in 0...task.count - 1 {
                        if task[i][3] == "1" {
                            toVC.taskLabel.text = task[i][1]
                        }
                    }
                } else {
                    toVC.taskLabel.text = NSLocalizedString("Start with a task", comment: "Start with a task")
                }
        }
        
        UIView.animateWithDuration(0.25, delay:0.1,options:UIViewAnimationOptions.CurveEaseInOut,  animations: { () -> Void in
            toVC.view.layoutIfNeeded()
            toVC.view.setNeedsDisplay()
            snapRound.frame = toVC.round.frame
            snap.frame = container!.convertRect(toVC.TimerView.frame, fromView: toVC.TimerViewContainer)
            }) { (finish: Bool) -> Void in
        }
        
        UIView.animateWithDuration(0.1, delay:0.4,options:UIViewAnimationOptions.TransitionNone,  animations: { () -> Void in
            snapRound.alpha = 0
            snap.alpha = 0
            }) { (finish: Bool) -> Void in
        }
        
        UIView.animateWithDuration(0.05, delay:0.35,options:UIViewAnimationOptions.TransitionNone,  animations: { () -> Void in
            toVC.view.alpha = 1
            }) { (finish: Bool) -> Void in
                snap.removeFromSuperview()
                snapRound.removeFromSuperview()
                transitionContext.completeTransition(true)
        }
        
    }
}