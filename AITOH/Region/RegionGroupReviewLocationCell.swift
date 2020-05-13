//
//  RegionGroupReviewLocationCell.swift
//  AITOH
//
//  Created by Jerry Kwok on 13/5/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit


class RegionGroupReviewLocationCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var locations: [Location]!
    var selectedLocation: [RegionGroupLocationCell]! = []
    @IBOutlet weak var collectionView: UICollectionView!

    
    
    func loadLocation(locations: [Location]){
        self.locations = locations
        collectionView.reloadData()
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let location = locations[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RegionGroupLocationCell", for: indexPath)as! RegionGroupLocationCell
        cell.initElement(location: location)
        selectedLocation.append(cell)
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("click")
        let cell = selectedLocation[indexPath.row]
        if cell.btnSelected {
            cell.btnSelected = false
        }else{
            cell.btnSelected = true
        }
        cell.checkSelected()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let locationName = locations[indexPath.row].place
        var cellSize = CGSize()
        let textFont = UIFont.systemFont(ofSize: 17)
        let textMaxSize = CGSize(width: 240, height: CGFloat(MAXFLOAT))
        let textLabelSize = self.textSize(text:locationName , font: textFont, maxSize: textMaxSize)
        cellSize.width = textLabelSize.width + 90
        cellSize.height = 1000.0
        return cellSize
    }
    
    func textSize(text : String , font : UIFont , maxSize : CGSize) -> CGSize{
        return text.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font : font], context: nil).size
    }

}
