//
//  Pomodoro.swift
//  PomoNow
//
//  Created by Megabits on 15/9/16.
//  Copyright (c) 2015年 ScrewBox. All rights reserved.
//

import Foundation
import AVFoundation

class pomodoro : NSObject{
    
    private let defaults = NSUserDefaults.standardUserDefaults()
    
    private var session = AVAudioSession.sharedInstance()
    var soundPlayer:AVAudioPlayer?
    
    var pomoMode = 0
    
    var pomoTime = 1500 { didSet {
        setDefaults ("pomo.pomoTime",value: pomoTime)
        updateDisplay()
        } }
    var breakTime = 300 { didSet {
        setDefaults ("pomo.breakTime",value: breakTime)
        updateDisplay()
        } }
    var longBreakTime = 1500 { didSet {
        setDefaults ("pomo.longBreakTime",value: longBreakTime)
        updateDisplay()
        } }
    
    var nowTime = 0
    var localCount = 0
    
    var process:Float = 0
    var timerLabel = "00:00"
    var timerLabelMin = "0"
    var timerLabelSec = "0"
    var timerLabelHour = "0"
    
    var longBreakEnable = false { //是否开启连续计时
        didSet{
            setDefaults ("pomo.longBreakEnable",value: longBreakEnable)
            if !longBreakEnable {
                localCount = 0
                stop()
            }
        }
    }
    
    var enableTimerSound = true { didSet { setDefaults ("pomo.enableTimerSound",value: enableTimerSound)}}
    var enableAlarmSound = true { didSet { setDefaults ("pomo.enableAlarmSound",value: enableAlarmSound)}}

    var longBreakCount = 4 { didSet { setDefaults ("pomo.longBreakCount",value: longBreakCount) } } //几个循环后进入长休息
    
    private var timer: NSTimer?
    private var isDebug = false
    
    override init() {
        super.init()
        if getDefaults("pomo.pomoTime") != nil {  //存储设置
            pomoTime = getDefaults("pomo.pomoTime") as? Int ?? 1500
            breakTime = getDefaults("pomo.breakTime") as? Int ?? 300
            longBreakTime = getDefaults("pomo.longBreakTime") as? Int ?? 1500
            longBreakCount = getDefaults("pomo.longBreakCount") as? Int ?? 4
            longBreakEnable = getDefaults("pomo.longBreakEnable") as? Bool ?? false
            enableTimerSound = getDefaults("pomo.enableTimerSound") as? Bool ?? true
            enableAlarmSound = getDefaults("pomo.enableAlarmSound") as? Bool ?? true
        } else {
            setDefaults ("pomo.pomoTime",value: pomoTime)
            setDefaults ("pomo.breakTime",value: breakTime)
            setDefaults ("pomo.longBreakTime",value: longBreakTime)
            setDefaults ("pomo.longBreakCount",value: longBreakCount)
            setDefaults ("pomo.longBreakEnable",value: longBreakEnable)
            setDefaults ("pomo.enableTimerSound",value: enableTimerSound)
            setDefaults ("pomo.enableAlarmSound",value: enableAlarmSound)
        }
        
        updateDisplay()
        
        //声音后台播放
        do {try session.setCategory(AVAudioSessionCategoryPlayback,withOptions:AVAudioSessionCategoryOptions.MixWithOthers)} catch _ { }
        do {try session.setActive(true)} catch _ { }
        
//        isDebug = true //调试模式
    }
    
    func updateTimer(timer:NSTimer) { //确定计时状态和调整时间
        if nowTime <= 0{
            stopTimer()
            if pomoMode == 1 {
                if longBreakEnable {
                    if localCount == longBreakCount - 1 {
                        pomoMode = 3
                        nowTime = longBreakTime
                        print("Pomo Over")
                        playSound(0)
                        longBreakStart()
                    } else {
                        pomoMode++
                        nowTime = breakTime
                        print("Pomo Over")
                        playSound(0)
                        breakStart()
                    }
                } else {
                    pomoMode++
                    nowTime = breakTime
                    print("Pomo Over")
                    playSound(0)
                    breakStart()
                }
            } else if pomoMode == 2 {
                if longBreakEnable {
                    localCount++
                    pomoMode = 0
                    start()
                } else {
                    pomoMode = 0
                }
                print("Break Over")
                playSound(0)
            } else if pomoMode == 3 {
                pomoMode = 0
                localCount = 0
                print("Long Break Over")
                start()
                playSound(0)
            }
        } else {
            if soundPlayer?.playing != true {
                playSound(2)
            }
            if isDebug {
                nowTime -= 100
            } else {
                nowTime--
            }
        }
        updateDisplay()
    }
    
    private func updateDisplay() {
        //生成百分比形式的进度
        switch pomoMode {
        case 1:
            process = Float(nowTime) / Float(pomoTime) * 100
        case 2:
            process = Float(nowTime) / Float(breakTime) * 100
        case 3:
            process = Float(nowTime) / Float(longBreakTime) * 100
        default:
            process = 0
        }
        //生成当前时间的文本表示
        var nowUse = 0
        if pomoMode == 0 {
            nowUse = pomoTime
        } else {
            nowUse = nowTime
        }
        var minute = "\((nowUse - (nowUse % 60)) / 60)"
        var second = "\(nowUse % 60)"
        if nowUse % 60 < 10 {
            second = "0" + second
        }
        if (nowUse - (nowUse % 60)) / 60 < 10 {
            minute = "0" + minute
        }
        if Int(minute) > 60 {
            var hour = "\((Int(minute)! - (Int(minute)! % 60)) / 60)"
            minute = "\(Int(minute)! % 60)"
            if Int(hour) < 10 {
                hour = "0" + hour
            }
            
            timerLabel = hour + ":" + minute
        } else {
            timerLabel = minute + ":" + second
        }
    }
    
    func getStringOfTime(select:Int) -> Int{ //输出想要获得的时间的文本表示
        var resultCount = 0
        var nowUse = 0
        switch select {
        case 0:nowUse = pomoTime
        case 1:nowUse = breakTime
        case 2:nowUse = longBreakTime
        default:nowUse = pomoTime
        }
        var minute = "\((nowUse - (nowUse % 60)) / 60)"
        var second = "\(nowUse % 60)"
        timerLabelSec = second
        resultCount++
        if nowUse % 60 < 10 {
            second = "0" + second
        }
        timerLabelMin = minute
        if nowUse >= 60 {
            resultCount++
        }
        if (nowUse - (nowUse % 60)) / 60 < 10 {
            minute = "0" + minute
        }
        if Int(minute) > 60 {
            var hour = "\((Int(minute)! - (Int(minute)! % 60)) / 60)"
            minute = "\(Int(minute)! % 60)"
            timerLabelMin = minute
            timerLabelHour = hour
            resultCount++
            if Int(hour) < 10 {
                hour = "0" + hour
            }
            
        }
        return resultCount
    }
    
    func start() {
        if pomoMode == 0 {
            pomoMode = 1
            nowTime = pomoTime
            print("PomoTime: \(pomoTime) BreakTime:\(breakTime)")
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTimer:", userInfo: nil, repeats: true)
        }
    }
    
    private func breakStart() {
        if withTask{
            for i in 0...task.count - 1 {
                if task[i][3] == "1" {
                    if Int(task[i][2]) < 100 {
                        task[i][2] = String(Int(task[i][2])! + 1)
                    }
                }
            }
        }
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTimer:", userInfo: nil, repeats: true)
    }
    
    private func longBreakStart() {
        if withTask{
            for i in 0...task.count - 1 {
                if task[i][3] == "1" {
                    if Int(task[i][2]) < 100 {
                        task[i][2] = String(Int(task[i][2])! + 1)
                    }
                }
            }
        }
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTimer:", userInfo: nil, repeats: true)
    }
    
    func stop() {
        if pomoMode != 0 {
            playSound(0)
        }
        stopTimer()
        pomoMode = 0
        nowTime = 0
        localCount = 0
        updateDisplay()
    }
    
    private func getDefaults (key: String) -> AnyObject? {
        if key != "" {
            return defaults.objectForKey(key)
        } else {
            return nil
        }
    }
    
    private func setDefaults (key: String,value: AnyObject) {
        if key != "" {
            defaults.setObject(value,forKey: key)
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        process = 0
    }
    
    func playSound(soundIndex: Int) {
        let startSoundPath = NSBundle.mainBundle().pathForResource("Start", ofType: "mp3")
        let stopSoundPath = NSBundle.mainBundle().pathForResource("Stop", ofType: "mp3")
        let pomoingSoundPath = NSBundle.mainBundle().pathForResource("Pomoing", ofType: "mp3")
        
        let startSoundUrl = NSURL(fileURLWithPath: startSoundPath!)
        let stopSoundUrl = NSURL(fileURLWithPath: stopSoundPath!)
        let pomoingSoundUrl = NSURL(fileURLWithPath: pomoingSoundPath!)
        
        switch soundIndex {
        case 0:
            stopSound()
            if enableAlarmSound {
                do {soundPlayer = try AVAudioPlayer(contentsOfURL: stopSoundUrl)} catch _ { }
                soundPlayer!.numberOfLoops = 0
                soundPlayer!.volume = 1
                soundPlayer!.prepareToPlay()
                soundPlayer!.play()
            }
        case 1:
            stopSound()
            if enableAlarmSound {
                do {soundPlayer = try AVAudioPlayer(contentsOfURL: startSoundUrl)} catch _ { }
                soundPlayer!.numberOfLoops = -1
                soundPlayer!.volume = 1
                soundPlayer!.prepareToPlay()
                soundPlayer!.play()
            }
        case 2:
            stopSound()
            if enableTimerSound {
                do {soundPlayer = try AVAudioPlayer(contentsOfURL: pomoingSoundUrl)} catch _ { }
                soundPlayer!.numberOfLoops = -1
                soundPlayer!.volume = 0.2
                soundPlayer!.prepareToPlay()
                soundPlayer!.play() 
            }

        default:
            if soundPlayer != nil {
                soundPlayer!.stop()
            }
        }
    }
    func stopSound() {
        if soundPlayer != nil {
            soundPlayer!.stop()
        }
    }
}

//  Defaults name space :
//      pomo.pomoTime
//          .breakTime
//          .longBreakTime