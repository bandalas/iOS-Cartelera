//
//  MapaViewController.swift
//  CarteleraEventos
//
//  Created by Itzel Mosso on 17/10/18.
//  Copyright © 2018 ESCAMA. All rights reserved.
//

import UIKit
import GoogleMaps

class MapaViewController: UIViewController {
    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let camera = GMSCameraPosition.camera(withLatitude: 25.651120,  longitude: -100.289641, zoom: 15.0)
        mapView.camera = camera
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 25.651120, longitude: -100.289641)
        marker.title = "ITESM - MTY"
        marker.snippet = "Mexico"
        marker.map = mapView
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
