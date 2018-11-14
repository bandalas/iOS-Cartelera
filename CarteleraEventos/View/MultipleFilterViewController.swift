//
//  MultipleFilterViewController.swift
//  CarteleraEventos
//
//  Created by Karla Robledo Bandala on 11/12/18.
//  Copyright © 2018 ESCAMA. All rights reserved.
//

import UIKit

class MultipleFilterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, protocoloModificarFavorito, UISearchBarDelegate, protocolImplementLoadingScreen
{
    
    func modificaFavorito(fav: Bool, ide: Int) {
        
    }
    
    @IBOutlet weak var filteredTable: UITableView!
    
    var filteredEvents = [Evento]()
    
    var categoryFilters:Set<String> = []
    var campusFilters:Set<String> = []
    
    var newCategoryFilter: String?
    var newCampusFilter: String?
    var dateFilter: String?
    
    var loadingScreen: LoadingScreen = LoadingScreen()
    let activityView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    var hasFetchedData: Bool = false {
        didSet {
            loadingScreen.stopLoadingScreen(view: self.view, activityView: activityView)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadingScreen.launchLoadingScreen(view: self.view, activityView: activityView)
        performSearch()
        setTitle()
    }
    
    private func performSearch()
    {
        let dictionaryFilter = makeFilterMap()
        if dictionaryFilter.count > 0 {
            
            let API = APIManager.sharedInstance
            API.getEventosByFilter(filterData: dictionaryFilter) { (arrEventos) in
                self.filteredEvents = arrEventos
                
                if let date = self.dateFilter
                {
                    let byDate = EventsByDate(events: self.filteredEvents)
                    var results = [Evento]()
                    switch date{
                    case Filter.DATE_FILTER_ARRAY[0]:
                        results = byDate.getTodaysEvents()
                    case Filter.DATE_FILTER_ARRAY[1]:
                        results = byDate.getWeeksEvents()
                    case Filter.DATE_FILTER_ARRAY[2]:
                        results = byDate.getMonthsEvents()
                    default:
                        print()
                    }
                    self.filteredEvents = results
                }
                self.filteredTable.reloadData()
                self.hasFetchedData = true
            }
        }
        
        
    }
    
    // MARK: - Table Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return filteredEvents.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 167.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as! CustomTableViewCell
        
        cell.name.text = filteredEvents[indexPath.row].name
        cell.name.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.name.numberOfLines = 0
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "es_MX")
        cell.startDate.text = dateFormatter.string(from: filteredEvents[indexPath.row].startDate)
        cell.startTime.text = filteredEvents[indexPath.row].startTime
        cell.foto.image = filteredEvents[indexPath.row].foto
        
        return cell
    }
    
    
    // MARK: - API Functions
    private func makeFilterMap() -> [String: [String]]
    {
        
        var result = [String: [String]]()
        if categoryFilters.count != 0
        {
            var existingItems = result[Filter.FILTER_TYPE_ONE] ?? [String]()
            for el in categoryFilters
            {
                existingItems.append(el)
            }
            result[Filter.FILTER_TYPE_ONE] = existingItems
        }
        if campusFilters.count != 0
        {
            var existingItems = result[Filter.FILTER_TYPE_TWO] ?? [String]()
            for el in campusFilters
            {
                existingItems.append(el)
            }
            result[Filter.FILTER_TYPE_TWO] = existingItems
        }
        
        if let tempFilter = self.newCategoryFilter
        {
            var existingItems = result[Filter.FILTER_TYPE_ONE] ?? [String]()
            existingItems.append(tempFilter)
            result[Filter.FILTER_TYPE_ONE] = existingItems
        }
        
        if let tempFilter = self.newCampusFilter
        {
            var existingItems = result[Filter.FILTER_TYPE_TWO] ?? [String]()
            existingItems.append(tempFilter)
            result[Filter.FILTER_TYPE_TWO] = existingItems
        }
        
        return result
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "detail")
        {
            let vistaDetalle = segue.destination as! DetalleViewController
            let indexPath = filteredTable.indexPathForSelectedRow!
            vistaDetalle.eveTemp = filteredEvents[indexPath.row]
            filteredTable.deselectRow(at: indexPath, animated: true)
            vistaDetalle.delegado = self
        }
        
    }
    
    private func setTitle()
    {
        if let categoryF = newCategoryFilter
        {
            navigationItem.title = categoryF
        }
        if let campusF = newCampusFilter
        {
            navigationItem.title = campusF
        }
        if let dateF = dateFilter
        {
            navigationItem.title = dateF
        }
    }

}
