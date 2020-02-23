//
//  ProfileStoryCell.swift
//  AITOH
//
//  Created by Jerry Kwok on 23/2/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit

class ProfileStoryCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var subtitile: UILabel!
    @IBOutlet weak var desc: UITextView!
    @IBOutlet weak var img: UIImageView!
    
    func setup(story: Story){
        self.icon.image = story.icon
        self.username.text = story.username
        subtitile.text = story.time + " in " + story.location
        desc.text = story.desc
        img.image = story.img
    }
}
