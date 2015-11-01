//
//  TagSelectViewController.swift
//  PomoNow
//
//  Created by Megabits on 15/10/18.
//  Copyright © 2015年 ScrewBox. All rights reserved.
//

import UIKit

var taskString = ""
var selectTag = 0
class TagSelectView: UIView, UITextFieldDelegate {
    
    var select:[Bool] = [true,false,false,false,false]
    @IBOutlet weak var task: UITextField! {
        didSet{
            task.delegate = self
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder() //释放键盘
        return true
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        NSNotificationCenter.defaultCenter().removeObserver(self)
        return true
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "didChange:",
            name: UITextFieldTextDidChangeNotification,
            object: nil) //为文字改变添加监视
        return true
    }
    
    func didChange(notification: NSNotification) {
        taskString = task.text ?? ""
    }
    
    @IBOutlet weak var tagA: UIView!
    @IBOutlet weak var tagB: UIView!
    @IBOutlet weak var tagC: UIView!
    @IBOutlet weak var tagD: UIView!
    @IBOutlet weak var tagE: UIView!
    @IBAction func selectA(sender: AnyObject) {
        selectedTag = 0
    }
    @IBAction func selectB(sender: AnyObject) {
        selectedTag = 1
    }
    @IBAction func selectC(sender: AnyObject) {
        selectedTag = 2
    }
    @IBAction func selectD(sender: AnyObject) {
        selectedTag = 3
    }
    @IBAction func selectE(sender: AnyObject) {
        selectedTag = 4
    }
    
    var selectedTag = 0{
        didSet {
            for i in 0...4 {
                select[i] = false
            }
            select[selectedTag] = true
            updateUI()
            selectTag = selectedTag
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        taskString = ""
        selectTag = 0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "TagSelectView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    func updateUI() { //单选控制器状态刷新
        tagA.hidden = !select[0]
        tagB.hidden = !select[1]
        tagC.hidden = !select[2]
        tagD.hidden = !select[3]
        tagE.hidden = !select[4]
    }

}
