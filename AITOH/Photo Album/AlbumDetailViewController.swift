//
//  AlbumDetailViewController.swift
//  AITOH
//
//  Created by Jerry Kwok on 19/2/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit
import Alamofire

class AlbumDetailViewController: UIViewController {
    var album:Album!
    var photos: [AlbumPhoto] = []
    @IBOutlet weak var mainPhoto: UIImageView!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var photoTitle: UILabel!
    @IBOutlet weak var collect: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photos = createArray()
        loadUI()
        // Do any additional setup after loading the view.
    }
    
    func loadUI(){
        mainPhoto.image = album.bgImage
        photoTitle.text = album.title
        subtitle.text = String(album.count) + " items, update " + album.create_date
        let rightBarButton = UIBarButtonItem(image: UIImage(named: "baseline_landscape_black_18dp-1"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(AlbumDetailViewController.mapModeClick))
        self.navigationItem.rightBarButtonItem = rightBarButton

        
        
    }
    
    @objc func mapModeClick(_ sender:UIBarButtonItem!)
    {
         let vc = storyboard?.instantiateViewController(identifier: "MapModeViewController") as? MapModeViewController
         self.navigationController?.pushViewController(vc!, animated: true)
    }

    
    
    func createArray() -> [AlbumPhoto]{
        /*
         
         
         AF.request
         
         */
        if album.id == "4"{
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            let result = formatter.string(from: date)
            let photo1 = AlbumPhoto(id: "1", imagePath: "null", image: UIImage(named: "Google.jpg")!, create_date: result)
            let photo2 = AlbumPhoto(id: "2", imagePath: "null", image: UIImage(named: "JP.jpg")!, create_date: result)
            return [photo1, photo2]
        }else{
            let photo1 = AlbumPhoto(id: "1", imagePath: "null", image: UIImage(named: "photo1.png")!, create_date: "12-01-2020")
            let photo2 = AlbumPhoto(id: "2", imagePath: "null", image: UIImage(named: "photo2.png")!, create_date: "12-01-2020")
            let photo3 = AlbumPhoto(id: "3", imagePath: "null", image: UIImage(named: "photo3.png")!, create_date: "12-01-2020")
            let photo4 = AlbumPhoto(id: "4", imagePath: "null", image: UIImage(named: "photo4.png")!, create_date: "12-01-2020")
            let photo5 = AlbumPhoto(id: "5", imagePath: "null", image: UIImage(named: "photo5.png")!, create_date: "12-01-2020")
            let photo6 = AlbumPhoto(id: "6", imagePath: "null", image: UIImage(named: "photo6.png")!, create_date: "12-01-2020")
            let photo7 = AlbumPhoto(id: "7", imagePath: "null", image: UIImage(named: "photo7.png")!, create_date: "12-01-2020")
            let photo8 = AlbumPhoto(id: "8", imagePath: "null", image: UIImage(named: "photo8.png")!, create_date: "12-01-2020")
            let photo9 = AlbumPhoto(id: "9", imagePath: "null", image: UIImage(named: "photo10.png")!, create_date: "12-01-2020")
            return [photo1, photo2, photo3, photo4, photo5, photo6, photo7, photo8, photo9]
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

extension AlbumDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         print("setArray")
        let photo = photos[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        cell.setAlbumPhoto(albumPhoto: photo)
        
        return cell
    }
    
}

extension AlbumDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 135, height: 135)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
}
