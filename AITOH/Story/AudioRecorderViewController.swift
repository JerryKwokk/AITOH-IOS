//
//  AudioRecorderViewController.swift
//  AudioRecorderViewControllerExample
//
//  Created by Ben Dodson on 19/10/2015.
//  Copyright © 2015 Dodo Apps. All rights reserved.
//
import UIKit
import AVFoundation
import Alamofire
import Speech

protocol AudioRecorderViewControllerDelegate: class {
    func audioRecorderViewControllerDismissed(withFileURL fileURL: NSURL?)
}

class AudioRecorderViewController: UINavigationController {
    
    internal let childViewController = AudioRecorderChildViewController()
    weak var audioRecorderDelegate: AudioRecorderViewControllerDelegate?
    
    @IBOutlet weak var textView: UITextView!
    var statusBarStyle: UIStatusBarStyle = .default
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        childViewController.audioRecorderDelegate = audioRecorderDelegate
        viewControllers = [childViewController]
        
        navigationBar.barTintColor = UIColor.black
        navigationBar.tintColor = UIColor.white
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        
    }
        
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        statusBarStyle = UIApplication.shared.statusBarStyle
        self.preferredStatusBarStyle
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.setStatusBarStyle(statusBarStyle, animated: animated)
    }
    
    
    // MARK: - AudioRecorderChildViewController
    
    internal class AudioRecorderChildViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
        
        var saveButton: UIBarButtonItem!
        @IBOutlet weak var timeLabel: UILabel!
        @IBOutlet weak var recordButton: UIButton!
        @IBOutlet weak var recordButtonContainer: UIView!
        @IBOutlet weak var playButton: UIButton!
        @IBOutlet weak var textView:UITextView!
        
        weak var audioRecorderDelegate: AudioRecorderViewControllerDelegate?
        
        var timeTimer: Timer?
        var milliseconds: Int = 0
        
        var recorder: AVAudioRecorder!
        var player: AVAudioPlayer?
        var outputURL: NSURL
        
        var lang: String = "en-US"
           var SpeechRecognitionTask: SFSpeechRecognitionTask?
           var RecognitionRequest: SFSpeechAudioBufferRecognitionRequest?
           var AudioEngine = AVAudioEngine()
           var SpeechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))
        
        init() {
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
            let outputPath = documentsPath.appendingPathComponent("\(NSUUID().uuidString).m4a")
            outputURL = NSURL(fileURLWithPath: outputPath)
            super.init(nibName: "AudioRecorderViewController", bundle: nil)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func viewDidLoad() {
            //title = "Audio"
            
            edgesForExtendedLayout = .all
            
            saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(AudioRecorderChildViewController.saveAudio))
            navigationItem.rightBarButtonItem = saveButton
            saveButton.isEnabled = false
            
            let settings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 44100,
                AVNumberOfChannelsKey: 2,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            
            try! recorder = AVAudioRecorder(url: outputURL as URL, settings: settings)
            recorder.delegate = self
            recorder.prepareToRecord()
            
            recordButton.layer.cornerRadius = 4
            recordButtonContainer.layer.cornerRadius = 25
            recordButtonContainer.layer.borderColor = UIColor.white.cgColor
            recordButtonContainer.layer.borderWidth = 3
            
            // Speech to Text Section
            recordButton.isEnabled = false
            SpeechRecognizer?.delegate = self as? SFSpeechRecognizerDelegate
            SpeechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: lang))
            SFSpeechRecognizer.requestAuthorization { (authStatus) in
                
                var isButtonEnabled = false
                
                switch authStatus {
                case .authorized:
                    isButtonEnabled = true
                    
                case .restricted:
                    isButtonEnabled = false
                    print("Restricted")
                    
                case .notDetermined:
                    isButtonEnabled = false
                    print("notdetermined")
                    
                case .denied:
                    isButtonEnabled = false
                    print("Access denied")
                    
                @unknown default: break
                    // ...
                }
                
                OperationQueue.main.addOperation() {
                    self.recordButton.isEnabled = isButtonEnabled
                }
            }
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            
            do {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playAndRecord)
                try AVAudioSession.sharedInstance().setActive(true)
            }
            catch let error as NSError {
                NSLog("Error: \(error)")
            }
            
            NotificationCenter.default.addObserver(self, selector: #selector(stopRecording(sender:)), name: UIApplication.didEnterBackgroundNotification, object: nil)
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            NotificationCenter.default.removeObserver(self)
        }
        
        @objc func dismiss(_ sender: Any) {
            cleanup()
            audioRecorderDelegate?.audioRecorderViewControllerDismissed(withFileURL: nil)
        }
        
        @objc func saveAudio(_ sender: Any) {
            cleanup()
            print("save")
            print(outputURL)
            audioRecorderDelegate?.audioRecorderViewControllerDismissed(withFileURL: outputURL)
            UserDefaults.standard.set(outputURL, forKey: "audio")
        }
        
        @IBAction func toggleRecord(_ sender: Any) {
            timeTimer?.invalidate()
            
            if recorder.isRecording {
                recorder.stop()
            } else {

                milliseconds = 0
                timeLabel.text = "00:00.00"
                timeTimer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(updateTimeLabel(timer:)), userInfo: nil, repeats: true)
                recorder.deleteRecording()
                
                SpeechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: lang))
                if AudioEngine.isRunning {
                    self.AudioEngine.stop()
                    self.RecognitionRequest?.endAudio()
                    print("engine close")
                } else {
                    print("Go to speech")
                    startSpeechRecording()
                }

                
                
                recorder.record()
            }
            
            updateControls()

        }
        
        @IBAction func play(_ sender: Any) {
            if let player = player {
                player.stop()
                self.player = nil
                updateControls()
                return
            }
            
            do {
                try player = AVAudioPlayer(contentsOf: outputURL as URL)
            }
            catch let error as NSError {
                NSLog("error: \(error)")
            }
            
            player?.delegate = self
            player?.play()
            
            updateControls()
        }
        
        @objc func stopRecording(sender: AnyObject) {
            if recorder.isRecording {
                toggleRecord(sender)
            }
        }
        
        func cleanup() {
            timeTimer?.invalidate()
            if recorder.isRecording {
                recorder.stop()
                recorder.deleteRecording()
            }
            if let player = player {
                player.stop()
                self.player = nil
            }
        }
        
        func startSpeechRecording() {
            print("call start SpeechRecording")
            // Cancel the previous task if it's running.
            if SpeechRecognitionTask != nil {
                SpeechRecognitionTask?.cancel()
                SpeechRecognitionTask = nil
            }
            
            RecognitionRequest = SFSpeechAudioBufferRecognitionRequest()
            
            let inputNode = AudioEngine.inputNode
            
            guard let RecognitionRequest = RecognitionRequest else {
                fatalError("Error in Recognition")
            }
            
            RecognitionRequest.shouldReportPartialResults = true
            
            SpeechRecognitionTask = SpeechRecognizer?.recognitionTask(with: RecognitionRequest, resultHandler: { (result, error) in
                
                var FinalResult = false
                
                if result != nil {
                    print(result)
                    FinalResult = (result?.isFinal)!
                }
                
                if error != nil || FinalResult {
                    self.RecognitionRequest = nil
                    self.SpeechRecognitionTask = nil
                    self.AudioEngine.stop()
                    inputNode.removeTap(onBus: 0)
                    self.recordButton.isEnabled = true
                    
                }
            })
            
            let recordingFormat = inputNode.outputFormat(forBus: 0)
            inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
                self.RecognitionRequest?.append(buffer)
            }
            
            AudioEngine.prepare()
            
            do {
                try AudioEngine.start()
            } catch {
                print("AudioEngine didn't initialize")
            }
        }
        
        func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
            if available {
                recordButton.isEnabled = true
            } else {
                recordButton.isEnabled = false
            }
        }
        
        func updateControls() {
            UIView.animate(withDuration: 0.2) { () -> Void in
                self.recordButton.transform = self.recorder.isRecording ? CGAffineTransform(scaleX: 0.5, y: 0.5) : CGAffineTransform(scaleX: 1, y: 1)
            }
            
            if let _ = player {
                playButton.setImage(UIImage(named: "StopButton"), for: .normal)
                recordButton.isEnabled = false
                recordButtonContainer.alpha = 0.25
            } else {
                playButton.setImage(UIImage(named: "PlayButton"), for: .normal)
                recordButton.isEnabled = true
                recordButtonContainer.alpha = 1
            }
            
            playButton.isEnabled = !recorder.isRecording
            playButton.alpha = recorder.isRecording ? 0.25 : 1
            saveButton.isEnabled = !recorder.isRecording
        }
        
        // MARK: - Time Label
        
        @objc func updateTimeLabel(timer: Timer) {
            milliseconds += 1
            let milli = (milliseconds % 60) + 39
            let sec = (milliseconds / 60) % 60
            let min = milliseconds / 3600
            timeLabel.text = NSString(format: "%02d:%02d.%02d", min, sec, milli) as String
        }
        
        // MARK: - Playback Delegate
        
        func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
            self.player = nil
            updateControls()
        }
    }
}
