//
//  MapaViewController.swift
//  CarteleraEventos
//
//  Created by Itzel Mosso on 17/10/18.
//  Copyright © 2018 ESCAMA. All rights reserved.
//
import UIKit
import MapKit
import CoreLocation
import CoreData


class MapaViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, protocoloModificarFavorito {
    
    var arrEventos = [Evento]()
    var index = 0
    
    @IBOutlet weak var iMapView: MKMapView!
    
    let locationsManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let API = APIManager.sharedInstance
        API.getEventos { (events) in
            self.arrEventos = events
        }
        self.arrEventos = GlobalVar.arrEventsGlobal
        checkLocationServices()
        drawPins()
    }
    
    func setupLocationManager(){
        locationsManager.delegate = self
        locationsManager.desiredAccuracy = kCLLocationAccuracyBest
        //locationsManager.requestWhenInUseAuthorization()
        //locationsManager.startUpdatingLocation()
    }
    
    func centerViewOnUserLocation(){
        if let location = locationsManager.location?.coordinate{
            let region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            iMapView.setRegion(region, animated: true)
        }
    }
    
    func checkLocationServices(){
        if CLLocationManager.locationServicesEnabled(){
            setupLocationManager()
            checkLocationAuthorization()
        }
    }
    
    func checkLocationAuthorization(){
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            iMapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationsManager.startUpdatingLocation()
            break
        case .notDetermined:
            locationsManager.requestWhenInUseAuthorization()
            break
        default:
            break
        }
    }
    
    // MARK: - Localization methods
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.iMapView.setRegion(region, animated: true)
        self.locationsManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Errors: " + error.localizedDescription)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil
        }
        if #available(iOS 11.0, *) {
            let pin = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "marker")
            pin.canShowCallout = true
            pin.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            return pin
        } else {
            return nil
        }
        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl){
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let detailView = sb.instantiateViewController(withIdentifier: "Detalle") as! DetalleViewController
        for i in 0...arrEventos.count-1{
            if view.annotation?.title == arrEventos[i].name{
                detailView.eveTemp = arrEventos[i]
                detailView.eveName = arrEventos[i].name
                detailView.delegado = self
            }
        }
        present(detailView,animated: true,completion: nil)
    }
    
    
    //search for all events in map
    func drawPins(){
        
        //Remove all previous annotations
        let annotations = self.iMapView.annotations
        self.iMapView.removeAnnotations(annotations)
        
        for i in 0...arrEventos.count-1 {
            
            let annotation = MKPointAnnotation()
            annotation.title = self.arrEventos[i].name
            annotation.subtitle = self.arrEventos[i].campus
            annotation.coordinate = CLLocationCoordinate2DMake(self.arrEventos[i].latitude!, self.arrEventos[i].longitude!)
            iMapView.addAnnotation(annotation)
            iMapView.delegate = self
        }
    }
    
    // Funcion que se encarga de agregar o eliminar los favoritos de la base de datos
    func modificaFavorito(fav: Bool, ide: Int) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<EventosFavoritos>(entityName: "EvenFavoritos")
        
        let predicado = NSPredicate(format: "(ident = %@)", String(ide))
        fetchRequest.predicate = predicado
        
        var resultados : [EventosFavoritos]!
        
        do {
            resultados = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print ("Error al leer \(error) \(error.userInfo)")
        }
        
        if (resultados.count == 0 && fav)
        {
            //Guardarlo
            let favEv = EventosFavoritos(context: managedContext)
            managedContext
            favEv.setValue(ide, forKey: "ident")
        }
        else if (resultados.count > 0 && !fav)
        {
            //Quitarlo
            managedContext.delete(resultados[0])
        }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Error \(error) \(error.userInfo)")
        }
    }
}
