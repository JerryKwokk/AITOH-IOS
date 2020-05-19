//
//  ProfileStoryVoiceCell.swift
//  AITOH
//
//  Created by Jerry Kwok on 10/4/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

protocol VideoCellDelegates {
    func btnClickPlay()
}


class ProfileStoryVoiceCell: UITableViewCell {

    var audioPlayer = AVAudioPlayer()
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var subtitile: UILabel!
    @IBOutlet weak var desc: UITextView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var btnPlayClick: UIButton!
    // var viewController: UIViewController!
    var delegate: VideoCellDelegates?
    func setup(story: Story){
        icon.round()
        icon.layer.borderWidth = 3
        self.icon.image = story.icon
        self.username.text = story.username
        if(story.location == ""){
            subtitile.text = story.time
            
        }else{
            subtitile.text = story.time + " in " + story.location
        }
        desc.text = story.desc
        img.image = story.img
        img.layer.masksToBounds = true
        img.layer.borderWidth = 1
        img.layer.borderColor = UIColor.darkGray.cgColor

    }

    
    @IBAction func btnPlayClick(_ sender: Any) {
        print("clic")
        delegate?.btnClickPlay()
       /* print("click")
        if let path = Bundle.main.path(forResource: "video", ofType: "mp4"){
            let video = AVPlayer(url: URL(fileURLWithPath: path))
            let videoPlayer = AVPlayerViewController()
            videoPlayer.player = video
            
            viewController.present(videoPlayer, animated: true, completion: video.play)
        }
 */
        
    }
    
    

}
