//
//  MapaViewController.swift
//  CarteleraEventos
//
//  Created by Itzel Mosso on 17/10/18.
//  Copyright © 2018 ESCAMA. All rights reserved.
//

import UIKit
import GoogleMaps
import MapKit
import CoreLocation


class MapaViewController: UIViewController, CLLocationManagerDelegate {
    
    struct Locations {
        var latitude: Double
        var longitude: Double
    }
    
    var arrEventos = [Evento]()
    var arrLocations = [Locations]()
    
    //@IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var iMapView: MKMapView!
    
    
    let locationsManager = CLLocationManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationsManager.delegate = self
        locationsManager.desiredAccuracy = kCLLocationAccuracyBest
        locationsManager.requestWhenInUseAuthorization()
        locationsManager.startUpdatingLocation()
        
        
        /*let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer: lpgr)))
        self.iMapView.addGestureRecognizer(lpgr)*/
        
        let API = APIManager.sharedInstance
        
        API.getEventos { (arrEventos) in
            self.arrEventos = arrEventos
            GlobalVar.arrEventsGlobal = arrEventos
        }
        for event in arrEventos{
            //arrLocations.append(event.campus.we)
        }
        
        func drawPins(locations: [String]) {
            
            for place in 0...locations.count-1{
                //let position = CLLocationCoordinate2D(latitude: , longitude: <#T##CLLocationDegrees#>)
            }
            /*
            for i in 0...locations.count - 1 {
                
                let position = CLLocationCoordinate2D(latitude: locations[i].latitude, longitude: locations[i].longitude)
                let marker = GMSMarker(position: position)
                
                switch i {
                case 0:
                    marker.icon = UIImage(named: "origin.png")
                    break
                case locations.count - 1:
                    marker.icon = UIImage(named: "destination.png")
                    break
                default:
                    marker.icon = UIImage(named: "intermediate.png")
                    break
                }
                
                marker.title = locations[i].name
                marker.map = googleMaps
            }*/
        }
        /*
        let camera = GMSCameraPosition.camera(withLatitude: 25.651120,  longitude: -100.289641, zoom: 15.0)
        mapView.camera = camera
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 25.651120, longitude: -100.289641)
        marker.title = "ITESM - MTY"
        marker.snippet = "Mexico"
        marker.map = mapView*/
    }
    
    // MARK: - Localization methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.iMapView.setRegion(region, animated: true)
        self.locationsManager.stopUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Errors: " + error.localizedDescription)
    }
    
    func handleLongPress(gestureRecognizer: UIGestureRecognizer){
        if gestureRecognizer.state == .began{
            let puntoTap = gestureRecognizer.location(in: self.iMapView)
            let coordMapa = self.iMapView.convert(puntoTap, toCoordinateFrom: self.iMapView)
            let annot = MKPointAnnotation()
            annot.coordinate = coordMapa
            iMapView.addAnnotation(annot)
        }
    }
    
    
    //Method for placing a marker in a dessired address
    /*
     let geoCoder = CLGeocoder()
    func geocodeAddressString(_ addressString: String, in region: CLRegion?, completionHandler: @escaping CLGeocodeCompletionHandler){
        let placemarks
    }*/

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
