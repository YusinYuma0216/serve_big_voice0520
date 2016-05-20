//
//  ViewController.swift
//  test_home
//
//  Created by Yuma Yamamoto on 2016/02/12.
//  Copyright © 2016年 Yuma Yamamoto. All rights reserved.
//


import UIKit
import AVFoundation
import MediaPlayer



class RecordingViewController: UIViewController,AVAudioRecorderDelegate {
    //appDelegate宣言
    @IBOutlet weak var timelabel: UILabel!
    let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    //    @IBOutlet var label: UILabel!
    var count: Float = 03.00
    var timer: NSTimer = NSTimer()
    
    
    //audio系宣言
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    var recordingSession: AVAudioSession!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target:self, selector: Selector("onUpdate"), userInfo:nil,repeats:true)
        
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] (allowed: Bool) -> Void in
                dispatch_async(dispatch_get_main_queue()) {
                    if allowed {
                        //録音成功
                    } else {
                        // 録音準備失敗
                    }
                }
            }
        } catch {
            // 録音準備失敗
        }
        //録音開始
    }
    
    
    
    //録音開始
    func startRecording() {
        //保存情報
        let audioFilename = getDocumentsDirectory().stringByAppendingPathComponent("recording.m4a")
        
        let audioURL = NSURL(fileURLWithPath: audioFilename)
        //各種設定(気にしない)
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000.0,
            AVNumberOfChannelsKey: 1 as NSNumber,
            AVEncoderAudioQualityKey: AVAudioQuality.High.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(URL: audioURL, settings: settings)
            //音量測定をできるようにしておく
            audioRecorder.meteringEnabled = true
            audioRecorder.delegate = self
            audioRecorder.record()
            
        } catch {
            //録音失敗
            finishRecording(false)
        }
    }
    
    func getDocumentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    
    //レコード終了
    func finishRecording(success: Bool) {
        //平均音量取得
        audioRecorder.updateMeters()
        NSLog("録音音量は%f", audioRecorder.averagePowerForChannel(0))   //必ず0にする！！
        appDelegate.volume = audioRecorder.averagePowerForChannel(0)
        //録音ストップ
        audioRecorder.stop()
        audioRecorder = nil
        
        
    }
    
    //結果表示ボタンタップ時
    func resultTapped(){
        let targetViewController = self.storyboard!.instantiateViewControllerWithIdentifier( "result" )
        self.presentViewController( targetViewController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func onUpdate() {
        
        count = count - 0.01
        
        if count == 0 {
            self.performSegueWithIdentifier("toNext", sender: nil)
        }
        
        timelabel.text = String(format: "%.2f",count)
    }
    
    
}