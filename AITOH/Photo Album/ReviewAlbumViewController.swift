//
//  ReviewAlbumViewController.swift
//  AITOH
//
//  Created by Jerry Kwok on 27/3/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ReviewAlbumViewController: UIViewController {

    var items:[YPMediaItem]!
    var selectedImage: [SelectedPhoto] = []
    @IBOutlet weak var process: UIProgressView!
    let time: Float = 4.0
    var ct: Float = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        process.transform = process.transform.scaledBy(x: 1, y: 1)
        process.setProgress(0.0, animated: false)
        process.isHidden = true
        for item in items{
           switch item {
           case .photo(let photo):
            let photo = SelectedPhoto(image: photo.image, location: "", address:"",lat: 0, long: 0)
            selectedImage.append(photo)
           case .video(let video):
               print(video)
           }
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(btnSaveClick))
        }
        print(items.count)
        // Do any additional setup after loading the view.
    }
    
    @objc func btnSaveClick(){
        /*
         import AWSS3
         import AWSCore
         
         let accessKey = "..."
         let secretKey = "..."
         let credentialsProvider = AWSStaticCredentialsProvider(accessKey: accessKey, secretKey: secretKey)
         let configuration = AWSServiceConfiguration(region: AWSRegionType.usEast1, credentialsProvider: credentialsProvider)
         AWSServiceManager.default().defaultServiceConfiguration = configuration
         
         let url = ...URL to your file...
         let remoteName = "Name of uploaded file"
         let S3BucketName = "Name of your bucket on Amazon S3"
         let uploadRequest = AWSS3TransferManagerUploadRequest()!
         uploadRequest.body = url
         uploadRequest.key = remoteName
         uploadRequest.bucket = S3BucketName
         uploadRequest.contentType = "image/jpeg"
         uploadRequest.acl = .publicRead
        
         let transferManager = AWSS3TransferManager.default()
         transferManager?.upload(uploadRequest).continue({ (task: AWSTask) -> Any? in
           if let error = task.error {
             print("Upload failed with error: (\(error.localizedDescription))")
           }
           if let exception = task.exception {
             print("Upload failed with exception (\(exception))")
           }
           if task.result != nil {
             let url = AWSS3.default().configuration.endpoint.url
             let publicURL = url?.appendingPathComponent(uploadRequest.bucket!).appendingPathComponent(uploadRequest.key!)
             print("Uploaded to:\(publicURL)")
           }
           return nil
         })
         
         
         AF.request
         
         
         
         
         */
        
        
        print("Save button")
        process.isHidden = false
        process.setProgress(ct, animated: true)
         perform(#selector(performAction), with: nil, afterDelay: 1.0)
        
    }
    
    @objc func performAction(){
        ct = ct + 1.0
        process.progress = ct/time
        if ct < time{
            perform(#selector(performAction), with: nil, afterDelay: 1.0)
        }else{
            self.navigationController?.popViewController(animated: true)
            ct = 0.0
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ReviewAlbumViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row > 0){
            let photo = selectedImage[indexPath.row - 1]
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewAlbumCell") as! ReviewAlbumCell
            cell.initCommit(photo: photo)
            cell.navigationController = self.navigationController
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewAlbumTitleCell") as! ReviewAlbumTitleCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row > 0){
            return 299
        }else{
            return 77
        }
        
    }
    
    
}



