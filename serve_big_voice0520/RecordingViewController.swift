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
    
    //ボタン宣言
    var recordButton: UIButton!
    var playButton: UIButton!
    var toResultButton: UIButton!

    var power : Float!
    
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
                        print("録音成功")
                        self.startRecording()
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
    
    func createButtons(){
        //再生ボタン生成
        //結果表示ボタン生成
        toResultButton = UIButton()
        toResultButton.frame = CGRectMake(self.view.bounds.width/4, self.view.bounds.height/2, self.view.bounds.width/2, 80)
        toResultButton.backgroundColor = UIColor.blueColor()
        toResultButton.setTitle("Tap to Result", forState: .Normal)
        toResultButton.titleLabel?.font = UIFont.systemFontOfSize(20)
        toResultButton.addTarget(self, action: "resultTapped", forControlEvents: .TouchUpInside)
        view.addSubview(toResultButton)
    }

    
    //録音開始
    func startRecording() {
        print("録音開始")
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
        power = audioRecorder.averagePowerForChannel(0)
        NSLog("録音音量は%f", audioRecorder.averagePowerForChannel(0))   //必ず0にする！！
        appDelegate.volume = audioRecorder.averagePowerForChannel(0)
        //録音ストップ
        audioRecorder.stop()
        audioRecorder = nil
        
        
    }
    
    //結果表示ボタンタップ時
    func resultTapped(){
        self.performSegueWithIdentifier("toResult", sender: nil)
//        let targetViewController = self.storyboard!.instantiateViewControllerWithIdentifier( "toResult" )
//        self.presentViewController( targetViewController, animated: true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let nextVC: ExpressionViewController = (segue.destinationViewController as? ExpressionViewController)!
        nextVC.score = power
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func onUpdate() {
        
        count = count - 0.01
        
        if count <= 00.01 {
            
            timer.invalidate()
            
            finishRecording(true)

            createButtons()
//            self.performSegueWithIdentifier("toRanking", sender: nil)
        }
        
        timelabel.text = String(format: "%.2f",count)
    }
    
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(false)
        }
        
    }
    
    

    
    
}