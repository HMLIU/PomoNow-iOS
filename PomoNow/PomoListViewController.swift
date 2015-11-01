//
//  PomoListViewController.swift
//  PomoNow
//
//  Created by Megabits on 15/9/28.
//  Copyright © 2015年 ScrewBox. All rights reserved.
//

import UIKit

class PomoListViewController: UIViewController , UINavigationControllerDelegate{
    
    @IBOutlet weak var TimerView: CProgressView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var round: UIImageView!
    @IBOutlet weak var addOneLabel: UILabel!
    @IBAction func pop(sender: UITapGestureRecognizer) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func toSettings(sender: AnyObject) {
        self.performSegueWithIdentifier("toSettings", sender: self)
    }
    
    @IBOutlet weak var uiView: UIView!
    
    
    var timer: NSTimer?
    
    var process: Float { //进度条
        get {
            return TimerView.valueProgress / 67 * 100
        }
        set {
            TimerView.valueProgress = newValue / 100 * 67
            updateUI()
        }
    }
    
    private func updateUI() {
        TimerView.setNeedsDisplay()
        timeLabel.text = pomodoroClass.timerLabel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        process = pomodoroClass.process
        updateUI()
        timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "getNowtime:", userInfo: nil, repeats: true)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.delegate = self
    }
    
    func getNowtime(timer:NSTimer) {  //同步时间
        process = pomodoroClass.process
    }
    
    @IBAction func returnFromSegueActions(sender: UIStoryboardSegue){
        
    }
    
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == UINavigationControllerOperation.Pop {
            return AnimationFromList()
        } else {
            return nil
        }
    }
    
    //NSUserDefaults
    private let defaults = NSUserDefaults.standardUserDefaults()
    func getDefaults (key: String) -> AnyObject? {
        if key != "" {
            return defaults.objectForKey(key)
        } else {
            return nil
        }
    }
    
    func setDefaults (key: String,value: AnyObject) {
        if key != "" {
            defaults.setObject(value,forKey: key)
        }
    }
}