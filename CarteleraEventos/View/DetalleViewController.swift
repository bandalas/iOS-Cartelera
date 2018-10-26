//
//  DetalleViewController.swift
//  CarteleraEventos
//
//  Created by Esteban Arocha Ortuño on 3/14/18.
//  Copyright © 2018 ESCAMA. All rights reserved.
//

import UIKit
import EventKit
import GoogleAPIClientForREST
import GoogleSignIn

protocol protocoloModificarFavorito{
    func modificaFavorito(fav: Bool, ide: Int )
}

// Todas las funciones y atributos de UX
extension UIView {
    func createGradientLayer() {
        let colorTop =  UIColor.red.cgColor
        let colorBottom = UIColor(red: 142.0/255.0, green: 14.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [colorTop, colorBottom]
        self.layer.addSublayer(gradientLayer)
    }
    
    public func layoutSublayers(of layer: CALayer) {
        layer.frame = self.bounds
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    }
    
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowRadius = 4
        
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

class DetalleViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {
    
    var eveTemp : Evento!
    var eveName : String!
    var delegado : protocoloModificarFavorito!
    @IBOutlet weak var foto: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbLugar: UILabel!
    @IBOutlet weak var lbFecha: UILabel!
    @IBOutlet weak var lbHora: UILabel!
    @IBOutlet weak var btFav: UIButton!
    @IBOutlet weak var lbContactName: UILabel!
    
    @IBOutlet weak var lbContactEmail: UILabel!
    @IBOutlet weak var lbContactPhone: UILabel!
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var titlesView: UIView!
    
    @IBOutlet weak var lbCategory: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var btCalendarioView: UIView!
    @IBOutlet weak var lbDescription: UITextView!
    
    @IBOutlet weak var imgPetFriendly: UIImageView!
    @IBOutlet weak var lbPetFriendly: UILabel!
    
    @IBOutlet weak var lbCalendario: UIButton!
    private let scopes = [kGTLRAuthScopeCalendar]
    
    private let service = GTLRCalendarService()
    let signInButton = GIDSignInButton()
    let output = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scrollView.contentSize = mainView.frame.size
        
        foto.image = eveTemp.foto
        lbName.text = eveTemp.name
        lbLugar.text = eveTemp.location
        let dateFormatter = DateFormatter()
        let format = DateFormatter.dateFormat(
            fromTemplate: "dMMMMYYYY", options:0, locale:NSLocale(localeIdentifier: "es_ES") as Locale)
        dateFormatter.dateFormat = format
        lbFecha.text = dateFormatter.string(from: eveTemp.startDate);
        lbHora.text = eveTemp.startTime
        
        lbContactName.text = eveTemp.contactName
        lbContactPhone.text = eveTemp.contactPhone
        lbContactEmail.text = eveTemp.contactEmail
        lbCategory.text = eveTemp.category
        lbDescription.text = eveTemp.description
        lbDescription.layer.borderWidth = 1
        lbDescription.layer.borderColor = UIColor(red: 229.0/255.0, green: 229.0/255.0, blue: 229.0/255.0, alpha: 1.0).cgColor
        lbDescription.textContainerInset = UIEdgeInsetsMake(8,5,8,5)
        lbDescription.layer.cornerRadius = 5
        lbDescription.clipsToBounds = true
        
        // Configure Google Sign-in.
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().scopes = scopes
        GIDSignIn.sharedInstance().signInSilently()
        
        
        // Show favorite button according to favorite status
        if (eveTemp.favorites)
        {
            btFav.setImage(#imageLiteral(resourceName: "star-red-fill"), for: .normal)
        }
        else
        {
            btFav.setImage(#imageLiteral(resourceName: "star-red-outline"), for: .normal)
        }

        lbName.lineBreakMode = NSLineBreakMode.byWordWrapping
        lbName.numberOfLines = 0
        
        card.dropShadow()
        
        btCalendarioView.dropShadow()
        btCalendarioView.layer.cornerRadius = 5
        btCalendarioView.clipsToBounds = true
        
        if eveTemp.petFriendly == 0 {
            imgPetFriendly.image = nil
            lbPetFriendly.isHidden = true
        }
        else {
            imgPetFriendly.image = #imageLiteral(resourceName: "pet-white")
            lbPetFriendly.isHidden = false
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        foto.layer.borderWidth = 5
        foto.layer.masksToBounds = false
        foto.layer.borderColor = UIColor.white.cgColor
        foto.layer.cornerRadius = foto.frame.height/2
        foto.clipsToBounds = true
        titlesView.createGradientLayer()
        titlesView.layer.layoutSublayers()
        foto.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        
        // Bringing main elements to front otherwise they render in the back
        titlesView.bringSubview(toFront: card)
        lbName.layer.zPosition = 2
        foto.layer.zPosition = 2
        lbCategory.layer.zPosition = 2
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: - Modifica evento favorito
    
    @IBAction func modificaFavButton(_ sender: Any) {
        if (eveTemp.favorites)
        {
            delegado.modificaFavorito(fav: false, ide: eveTemp.id)
            eveTemp.favorites = false
            btFav.setImage(#imageLiteral(resourceName: "star-red-outline"), for: .normal)
        }
        else
        {
            delegado.modificaFavorito(fav: true, ide: eveTemp.id)
            eveTemp.favorites = true
            btFav.setImage(#imageLiteral(resourceName: "star-red-fill"), for: .normal)
        }        
    }
    
    //MARK: - IOS Calendar
    
    @IBAction func guardarEventoIOS(_ sender: Any) {
        let eventStore = EKEventStore()
        
        eventStore.requestAccess(to: .event, completion: { (granted, error) in
            if (granted) && (error == nil) {
                let event = EKEvent(eventStore: eventStore)
                event.title = self.eveTemp.name
                event.startDate = self.eveTemp.startDate
                event.endDate = self.eveTemp.startDate
                event.notes = "Evento Cool"
                event.calendar = eventStore.defaultCalendarForNewEvents
                do {
                    try eventStore.save(event, span: .thisEvent)
                    let alertController = UIAlertController(title: "¡Evento Agendado!", message:
                        "El evento ha sido guardado en el calendario de tu iPhone.", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                } catch let error as NSError {
                    print("error : \(error)")
                    return
                }
                
                
            } else {
                print("error : \(String(describing: error))")
            }
        })
        
    }
    
    func addEventToCalendar(title: String, description: String?, startDate: Date, endDate: Date, completion: ((_ success: Bool, _ error: NSError?) -> Void)? = nil) {
        let eventStore = EKEventStore()
        
        eventStore.requestAccess(to: .event, completion: { (granted, error) in
            if (granted) && (error == nil) {
                let event = EKEvent(eventStore: eventStore)
                event.title = title
                event.startDate = startDate
                event.endDate = endDate
                event.notes = description
                event.calendar = eventStore.defaultCalendarForNewEvents
                do {
                    try eventStore.save(event, span: .thisEvent)
                } catch let e as NSError {
                    completion?(false, e)
                    return
                }
                completion?(true, nil)
            } else {
                completion?(false, error as NSError?)
            }
        })
    }
    
    //MARK: - Google Calendar
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            let alertController = UIAlertController(title: "Error", message:
                "No se ha podido iniciar sesión", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
            self.service.authorizer = nil
        } else {
            self.signInButton.isHidden = true
            self.service.authorizer = user.authentication.fetcherAuthorizer()
        }
    }

    @IBAction func guardarGoogle(_ sender: UIButton?) {
        if GIDSignIn.sharedInstance().hasAuthInKeychain() {
            let newEvent: GTLRCalendar_Event = GTLRCalendar_Event()
            
            newEvent.summary = (self.eveTemp.name)
            let startDateTime: GTLRDateTime = GTLRDateTime(date: self.eveTemp.startDate)
            let startEventDateTime: GTLRCalendar_EventDateTime = GTLRCalendar_EventDateTime()
            startEventDateTime.dateTime = startDateTime
            newEvent.start = startEventDateTime
            print(newEvent.start!)
            
            let endDateTime: GTLRDateTime = GTLRDateTime(date: self.eveTemp.startDate, offsetMinutes: 60)
            let endEventDateTime: GTLRCalendar_EventDateTime = GTLRCalendar_EventDateTime()
            endEventDateTime.dateTime = endDateTime
            newEvent.end = endEventDateTime
            
            let query =
                GTLRCalendarQuery_EventsInsert.query(withObject: newEvent, calendarId:"primary")
            query.fields = "id";
            self.service.executeQuery(
                query,
                completionHandler: {(_ callbackTicket:GTLRServiceTicket,
                    _  event:GTLRCalendar_Event,
                    _ callbackError: Error?) -> Void in}
                    as? GTLRServiceCompletionHandler
            )
            let alertController = UIAlertController(title: "¡Evento Agendado!", message:
                "El evento ha sido guardado en el calendario de Google.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "Error", message:
                "No se ha podido guardar el evento ya que no se ha iniciado sesión con Google. Inicie sesión y vuelva a intentar.", preferredStyle: UIAlertControllerStyle.alert)
           alertController.addAction(UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.default,handler: nil))
            alertController.addAction(UIAlertAction(title: "Iniciar sesión", style: UIAlertActionStyle.default,handler: {_ in self.btnSignInPressed()}))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    
    func btnSignInPressed() {
        GIDSignIn.sharedInstance().signIn()
    }
    
    //MARK: - Compartir en aplicaciones
    
    @IBAction func shareNative(_ sender: Any) {
        let activityVC = UIActivityViewController(activityItems: [self.eveTemp.foto as Any], applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
    }
    
    //MARK: - Menú calendarios
    
    @IBAction func btCalendarsMenu(_ sender: Any) {
        // 1
        let optionMenu = UIAlertController(title: nil, message: "Escoge el calendario al que se desea guardar el evento", preferredStyle: .actionSheet)
        
        // 2
        let calendarioIOS = UIAlertAction(title: "Calendario Apple", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.guardarEventoIOS(sender)
        })
        let canlendarioGoogle = UIAlertAction(title: "Google Calendar", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.guardarGoogle(sender as! UIButton)
        })
        
        //
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Canceled")
        })
        
        
        // 4
        optionMenu.addAction(calendarioIOS)
        optionMenu.addAction(canlendarioGoogle)
        optionMenu.addAction(cancelAction)
        
        // 5
        self.present(optionMenu, animated: true, completion: nil)
    }
    
}
    
    
    
    

