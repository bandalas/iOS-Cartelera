//
//  FilterViewController.swift
//  CarteleraEventos
//
//  Created by Karla Robledo Bandala on 11/3/18.
//  Copyright © 2018 ESCAMA. All rights reserved.
//

import UIKit


class FilterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,
                            protocoloModificarFavorito, UISearchBarDelegate
{
    func modificaFavorito(fav: Bool, ide: Int) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBOutlet weak var filteredTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var filterBttn: UIButton!
    
    @IBAction func cancelButton(_ sender: UIButton) {
        
    }
    var filteredEvents = [Evento]()
    
    var categoryFilters:Set<String> = []
    var campusFilters:Set<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchBar.delegate = self
        print("!!RIP!!\(categoryFilters.count)")
        performSearch()
    }
    
    private func performSearch()
    {
        let dictionaryFilter = makeFilterMap()
        let API = APIManager.sharedInstance
        API.getEventosByFilter(filterData: dictionaryFilter) { (arrEventos) in
            self.filteredEvents = arrEventos
            self.filteredTable.reloadData()
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
        for el in categoryFilters{
            print(el)
        }
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
        if (sender as! UIButton) == filterBttn {
            let filterView = segue.destination as! FilterSearchCollectionViewController
            //appliedFilters.append(filterData)
            filterView.appliedCampusFilters = self.campusFilters
            filterView.appliedCategoriesFilters = self.categoryFilters
        }
        
    }
    
}
