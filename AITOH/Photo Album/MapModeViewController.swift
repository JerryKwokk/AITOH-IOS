//
//  MapModeViewController.swift
//  AITOH
//
//  Created by Jerry Kwok on 20/2/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit
import GoogleMaps
class MapModeViewController: UIViewController {
    var photoAblum: [PhotoPlace] = []
    @IBOutlet weak var mapView: GMSMapView!
    override func viewDidLoad() {
           super.viewDidLoad()
        GMSServices.provideAPIKey("AIzaSyAimlTXyfphlB_CrEn2eD4dPVICemeoIYk")
        photoAblum = createArray()
        let camera = GMSCameraPosition.camera(withLatitude: 34.765323, longitude: 135.618578, zoom: 10.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView

        // Creates a marker in the center of the map.
        for photo in photoAblum {
            let state_marker = GMSMarker()
            state_marker.position = CLLocationCoordinate2D(latitude: photo.lat, longitude: photo.long)
            state_marker.title = photo.name
            state_marker.snippet = "Hey, this is \(photo.name)"
            state_marker.icon = self.imageWithImage(image: photo.img, scaledToSize: CGSize(width: 60.0, height: 60.0))
            state_marker.map = mapView
        }
        
       }
    
    func createArray() -> [PhotoPlace]{
        let photo3 = PhotoPlace(name: "photo2", lat: 35.0102811, long: 135.6953785, imgPath: "null", img: UIImage(named: "mapMode3")!)
        let photo5 = PhotoPlace(name: "photo5", lat: 34.6854299, long: 135.505975, imgPath: "null", img: UIImage(named: "mapMode5")!)
        let photo6 = PhotoPlace(name: "photo6", lat: 34.971436, long: 135.7579726, imgPath: "null", img: UIImage(named: "mapMode6")!)
        let photo8 = PhotoPlace(name: "photo8", lat: 34.755312, long: 135.577622, imgPath: "null", img: UIImage(named: "mapMode8")!)
        let photo9 = PhotoPlace(name: "photo9", lat: 34.675425, long: 135.4901239, imgPath: "null", img: UIImage(named: "mapMode9")!)
        
        return [photo3, photo5, photo6, photo8, photo9]
    }
    
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
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
