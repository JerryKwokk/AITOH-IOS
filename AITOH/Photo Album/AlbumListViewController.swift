//
//  AlbumListViewController.swift
//  AITOH
//
//  Created by Jerry Kwok on 19/2/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit

class AlbumListViewController: UIViewController {

    var config = YPImagePickerConfiguration()
    var albums: [Album] = []
    var time = 0
    @IBOutlet weak var tableView: UITableView!
    lazy var refeshControl: UIRefreshControl = {
        let refeshControl = UIRefreshControl()
        refeshControl.tintColor = .gray
        refeshControl.addTarget(self, action: #selector(requestData), for: .valueChanged)
        return refeshControl
    }()
    override func viewDidLoad() {
        tableView.refreshControl = refeshControl
        super.viewDidLoad()
        print("load")
        albums = createArray()
        print(albums.count)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func requestData(){
        print("refesh data")
        let refeshDead = DispatchTime.now() + .milliseconds(1100)
        DispatchQueue.main.asyncAfter(deadline: refeshDead){
            self.refeshControl.endRefreshing()
            if(self.time == 0){
                self.updateAF()
                self.time+=1
            }
            self.tableView.reloadData()
        }
    }
    
    func createArray() -> [Album]{
        let album1 = Album(id: "1", title: "Osaka", bgImage: UIImage(named: "album1.png")!, imagePath: "test" , count: 9, create_date: "7 Jan 2020")
        let album2 = Album(id: "2", title: "Cat", bgImage: UIImage(named: "album0.png")!, imagePath: "test" , count: 20, create_date: "23 Dec 2020")
        print("creat Array")
        for a in albums{
            print(a.id)
        }
        
        return [album1, album2]
        
    }
    
    func updateAF(){
        /*
         AF.request()
         
         
         */
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        let newAlbum = Album(id: "4", title: "New Album", bgImage: UIImage(named: "Google")!, imagePath: "", count: 2, create_date: formatter.string(from: date))
        albums.insert(newAlbum, at: 0)
    }
    @IBAction func btnCancelClick(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion:nil)
    }
    
    @IBAction func NewAlbumClick(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Story", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "ReviewAlbumViewController") as? ReviewAlbumViewController
        config.isScrollToChangeModesEnabled = true
        config.library.isSquareByDefault = false
        config.onlySquareImagesFromCamera = false
        config.usesFrontCamera = true
        config.showsPhotoFilters = false
        config.showsVideoTrimmer = true
        config.shouldSaveNewPicturesToAlbum = true
        config.albumName = "DefaultYPImagePickerAlbumName"
        config.startOnScreen = YPPickerScreen.photo
        config.screens = [.library]
        config.showsCrop = .none
        config.targetImageSize = YPImageSize.original
        config.overlayView = UIView()
        config.hidesStatusBar = false
        config.hidesBottomBar = true
        config.library.maxNumberOfItems = 20
        config.preferredStatusBarStyle = UIStatusBarStyle.darkContent
        config.maxCameraZoomFactor = 1.0
        config.library.skipSelectionsGallery = true
        
        let picker = YPImagePicker(configuration: config)
        picker.didFinishPicking { [unowned picker] items, cancelled in
            vc?.items = items
            picker.dismiss(animated: true, completion: nil)
            
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        present(picker, animated: true, completion: nil)
        // Do any additional setup after loading the view.
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

extension AlbumListViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("setArray")
        let album = albums[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell") as! AlbumCell
        cell.setAlbum(album: album)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let vc = storyboard?.instantiateViewController(identifier: "AlbumDetailViewController") as? AlbumDetailViewController
        vc?.album = albums[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    

    

}
