//
//  MapViewController.swift
//  SoundMe
//
//  Created by dror gal on 06/09/2016.
//  Copyright © 2016 dror gal. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController,CLLocationManagerDelegate,GMSMapViewDelegate {
    var locationManager:CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        let longitude = locationManager.location?.coordinate.longitude
        let latitude = locationManager.location?.coordinate.latitude
        print(latitude,longitude)
        let camera = GMSCameraPosition.camera(withLatitude: latitude!, longitude: longitude!, zoom: 18)
        
        let mapView = GMSMapView.map(withFrame: CGRect.infinite, camera: camera)
        mapView.delegate = self
        
        mapView.isMyLocationEnabled = false
        
        view = mapView
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
        marker.title = "Dror"
        marker.icon = UIImage(named: "soundMeIcon")
        marker.snippet = ""
        marker.map = mapView
        
        let marker1 = GMSMarker()
        marker1.position = CLLocationCoordinate2D(latitude: 32.823535, longitude: 34.960456)
        marker1.title = "Dror"
        marker1.icon = UIImage(named: "soundUserIcon")
        marker1.snippet = ""
        marker1.map = mapView
        
        let marker2 = GMSMarker()
        marker2.position = CLLocationCoordinate2D(latitude: 32.823200, longitude: 34.960198)
        marker2.title = "Dror"
        marker2.icon = UIImage(named: "soundUserIcon")
        marker2.snippet = ""
        marker2.map = mapView
    }
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        didMoveToNext()
    }
//    func mapView(_ mapView: GMSMapView!, markerInfoWindow marker: GMSMarker!) -> UIView! {
//        
//        let infoWindow = CustomView(frame: CGRect(x: 0, y: 0, width: 196, height: 123))
//        infoWindow.isUserInteractionEnabled = false
//        let tapGesture = UILongPressGestureRecognizer(target: self, action: #selector(MapViewController.didMoveToNext))
//        tapGesture.numberOfTapsRequired = 1
//        infoWindow.drory.addGestureRecognizer(tapGesture)
//        
//        //infoWindow.label.text = "\(marker.position.latitude) \(marker.position.longitude)"
//        return infoWindow
//    }
    
    func didMoveToNext(){
        performSegue(withIdentifier: "moveDetial", sender: self)
    }
}
