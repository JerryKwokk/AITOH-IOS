//
//  RegionGroupDhdTopTableViewCell.swift
//  AITOH
//
//  Created by Jerry Kwok on 8/4/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit

class RegionGroupDhdTopTableViewCell: UITableViewCell,  UICollectionViewDelegate, UICollectionViewDataSource {
    var hotRegionGroup:[RegionGroup]?
    var region:Region?
    var viewcontroller:UIViewController?
    @IBOutlet weak var collectionView: UICollectionView!
    
    func loadHotRegion(hotRegionGroup: [RegionGroup]){
        self.hotRegionGroup = hotRegionGroup
        collectionView.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hotRegionGroup!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("load model indr" + String(indexPath.row))
        let regionGroup = hotRegionGroup![indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HotRegionGroupCell", for: indexPath)as! HotRegionGroupCell
        print(hotRegionGroup!.count)
        if(indexPath.row == hotRegionGroup!.count - 1){
            cell.initLast()
         }else{
            cell.initElement(region: regionGroup)
         }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        print(hotRegionGroup!.count)
        if(indexPath.row == hotRegionGroup!.count - 1){
            let storyboard = UIStoryboard(name: "Region", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "RegionGroupSearchViewController") as! RegionGroupSearchViewController
            vc.regionId = region?.id
            let transition = CATransition()
            transition.duration = 0.5
            vc.modalPresentationStyle = .fullScreen
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromLeft
            transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
            viewcontroller!.view.window!.layer.add(transition, forKey: kCATransition)
            viewcontroller!.present(vc, animated: false, completion: nil)
        }else{
            let storyboard = UIStoryboard(name: "Region", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "GroupViewController") as! GroupViewController
            vc.regionGroup = hotRegionGroup![indexPath.row]
            let transition = CATransition()
            transition.duration = 0.5
            vc.modalPresentationStyle = .fullScreen
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromLeft
            transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
            viewcontroller!.view.window!.layer.add(transition, forKey: kCATransition)
            viewcontroller!.present(vc, animated: false, completion: nil)
            
        }
    }

}

