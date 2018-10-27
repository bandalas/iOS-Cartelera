//
//  FirstViewController.swift
//  CarteleraEventos
//
//  Created by Esteban Arocha Ortuño on 3/13/18.
//  Copyright © 2018 ESCAMA. All rights reserved.
//

import UIKit
import CoreData

struct GlobalVar {
    static var arrEventsGlobal = [Evento]()
    static var arrTagsGlobal = [Category]()
}

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, protocoloModificarFavorito {
    
    // Function que se encarga de agregar o eliminar los favoritos de la base de datos
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
    
    //Busca el id de los eventos favoritos dentro de la base de datos y lo guarda en el arreglo arrIndFav
    func buscaFavoritos()
    {
        arrIndFav.removeAll()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<EventosFavoritos>(entityName: "EvenFavoritos")
        
        let predicado = NSPredicate(format: "(ident > 0)")
        fetchRequest.predicate = predicado
        
        var resultados : [EventosFavoritos]!
        
        do {
            resultados = try managedContext.fetch(fetchRequest)
            for res in resultados
            {
                arrIndFav.append(Int(res.ident))
            }
        } catch let error as NSError {
            print ("Error al leer \(error) \(error.userInfo)")
        }
        
    }
    
    @IBOutlet weak var eventosTableView: UITableView!
    
    var arrEventos = [Evento]()
    var arrIndFav = [Int]()
    var indSelected = 0
    var arrTags = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let API = APIManager.sharedInstance
        API.getEventos { (arrEventos) in
            self.arrEventos = arrEventos
            GlobalVar.arrEventsGlobal = arrEventos
            self.eventosTableView.reloadData()
        }
        
        self.arrEventos = GlobalVar.arrEventsGlobal
        
        
        GlobalVar.arrTagsGlobal = arrTags
        
        
        // Agrega el estatus de favorito a los eventos
        buscaFavoritos()
        for eve in GlobalVar.arrEventsGlobal
        {
            if (arrIndFav.contains(eve.id))
            {
                eve.favorites = true
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Una sección es utilizada por el título de la aplicación y la otra para desplegar los eventos.
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //Sección del nombre
        if (section == 0)
        {
            return 1
        }
        //Sección de los eventos
        return arrEventos.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if (indexPath.section == 0) {
            
            return 100.0
        }
        
        return 167.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Celda del título de la aplicación
        if (indexPath.section == 0)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellTitle")! as! CustomTableViewCell
            return cell
        }
        
        //Celda de los eventos
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as! CustomTableViewCell
       
        cell.name.text = arrEventos[indexPath.row].name
        cell.name.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.name.numberOfLines = 0
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "es_MX")
        cell.startDate.text = dateFormatter.string(from: arrEventos[indexPath.row].startDate)
        cell.startTime.text = arrEventos[indexPath.row].startTime
        cell.foto.image = arrEventos[indexPath.row].foto
        
        return cell
    }
    
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "mostrar")
        {
            let vistaDetalle = segue.destination as! DetalleViewController
            let indexPath = eventosTableView.indexPathForSelectedRow!
            vistaDetalle.eveTemp = arrEventos[indexPath.row]
            eventosTableView.deselectRow(at: indexPath, animated: true)
            vistaDetalle.delegado = self
            indSelected = indexPath.row
        }        
    }
    
    @IBAction func unwindDetalle(for segue: UIStoryboardSegue, sender: Any?){
        GlobalVar.arrEventsGlobal = arrEventos
    }
    @IBAction func unwindInfo(for segue: UIStoryboardSegue, sender: Any?){
    }
    
}
