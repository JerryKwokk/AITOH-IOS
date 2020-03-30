//
//  ReviewAlbumCell.swift
//  AITOH
//
//  Created by Jerry Kwok on 27/3/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit
import LocationPicker

protocol ReviewAlbumCellDelegate {
    func pickLocation( selectedPhoto:inout SelectedPhoto)
}

class ReviewAlbumCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var location: UILabel!
    var selectedPhoto:SelectedPhoto?
    var delegate:ReviewAlbumCellDelegate?
    var navigationController:UINavigationController!
    func initCommit(photo: SelectedPhoto){
        selectedPhoto = photo
        img.image = photo.image
        if photo.location == "" && photo.address == "" || photo.lat == 0 && photo.long == 0 {
            location.isHidden = true
        }else{
            if(photo.location != ""){
                location.text = photo.location
            }else{
                location.text = photo.address
            }
        }
    }
    @IBAction func addLocationClick(_ sender: Any) {
        /*let group = DispatchGroup()
        var location: Location!
        group.enter()
        DispatchQueue.main.async {
            self.delegate?.pickLocation(selectedPhoto: &(self.selectedPhoto)!)
           
            group.leave()
        }
        group.notify(queue: .main) {
            if(self.selectedPhoto.location != ""){
                self.location.text = self.selectedPhoto.location
            }
        }*/
        
         let locationPicker = LocationPickerViewController()
        
         locationPicker.showCurrentLocationButton = true // default: true

         // default: navigation bar's `barTintColor` or `UIColor.white`
         locationPicker.currentLocationButtonBackground = .blue

         // ignored if initial location is given, shows that location instead
         locationPicker.showCurrentLocationInitially = true // default: true

         locationPicker.mapType = .standard // default: .Hybrid

         // for searching, see `MKLocalSearchRequest`'s `region` property
         locationPicker.useCurrentLocationAsHint = true // default: false

         locationPicker.searchBarPlaceholder = "Search places" // default: "Search or enter an address"

         locationPicker.searchHistoryLabel = "Previously searched" // default: "Search History"

         // optional region distance to be used for creation region when user selects place from search results
         locationPicker.resultRegionDistance = 500 // default: 600
        // let locations:Location?
         locationPicker.completion = { locationP in
            self.selectedPhoto!.location = String(locationP!.title!)
            self.selectedPhoto!.address = String(locationP!.address)
            self.selectedPhoto!.lat = Double(locationP!.coordinate.latitude)
            self.selectedPhoto!.long = Double(locationP!.coordinate.longitude)
            print(Double(locationP!.coordinate.longitude))
            print(self.selectedPhoto!.address)
            print(self.selectedPhoto!.location)
            print(String(locationP!.title!))
            print(String(locationP!.address))
            print(self.selectedPhoto)
            
            if(self.selectedPhoto!.location != ""){
                print("true")
                self.location.text = self.selectedPhoto?.location
                self.location.isHidden = false
                print(self.location.text)
            }else{
                print("false")
                self.location.text = self.selectedPhoto?.address
                self.location.isHidden = false
            }
         }
         
         
         self.navigationController?.pushViewController(locationPicker, animated: true)

    }
}
