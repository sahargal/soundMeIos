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
    var meUsers:[GMSMarker]!
    var users:[User]!
    var id = 0
    override func viewDidLoad() {
        super.viewDidLoad()
   
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        print(UserManger.Instance.users)
        meUsers = [GMSMarker]()
        users = UserManger.Instance.users

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
        let loginUser = UserManger.Instance.loginUser
        view = mapView
        // Creates a marker in the center of the map.
        let meMarker = GMSMarker()
        meMarker.position = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
        meMarker.title = loginUser.name
        meMarker.icon = UIImage(named: "iconPinMe")
        meMarker.snippet = String(loginUser.id)
        meMarker.map = mapView
        
        
        
        for user in users{
            let markers = GMSMarker()
            markers.position = CLLocationCoordinate2D(latitude: user.location.latitude, longitude: user.location.longitude)
            markers.title = user.name
            markers.icon = UIImage(named: "iconPinOthers")
            markers.snippet = String(user.id)
            
            meUsers.append(markers)
            
        }

        for newMarker in meUsers{
            newMarker.map = mapView
        }

    }
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        didMoveToNext()
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        let infoWindow = CustomView(frame: CGRect(x: 0, y: 0, width: 232, height: 124))
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(MapViewController.didMoveToNext))
        infoWindow.list_song.addGestureRecognizer(tapGesture)
        tapGesture.numberOfTapsRequired = 1
        
        let tapGestureAdd = UITapGestureRecognizer(target: self, action: #selector(MapViewController.addUser))
        infoWindow.addProfile.addGestureRecognizer(tapGestureAdd)
        tapGestureAdd.numberOfTapsRequired = 1
        infoWindow.name.text = marker.title
        
        id = Int(marker.snippet!)!
        return infoWindow
    }
    
    
    
    var userToList:User!

    func addUser(){
        
    }
    
    func didMoveToNext(){
        for user in users{
            if user.id == id{
                userToList = user
            }
        }
        performSegue(withIdentifier: "moveDetial", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moveDetial"{
            if let listSongForUserViewController = segue.destination as? ListSongForUserViewController {
                listSongForUserViewController.user = userToList
            }
        }
    }
}
