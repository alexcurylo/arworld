//
//  PlacesVC.swift
//  ARWorld
//
//  Created by Alex Curylo on 10/14/17.
//  Copyright © 2017 Trollwerks Inc. All rights reserved.
//

import UIKit

final class PlacesVC: UITableViewController {
    
    private let places = ["ATMs",
                          "Banks",
                          "Coffee Shops",
                          "Gas Stations",
                          "Hospitals",
                          "Hotels",
                          "Movie Theaters",
                          "Restaurants",
                          ]

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selected = tableView.indexPathForSelectedRow,
             let destination = segue.destination as? WorldVC else {
            return
        }
        
        destination.title = places[selected.row]
    }
}

// MARK: - UITableViewDataSource
extension PlacesVC {

    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = self.places[indexPath.row]
        return cell
    }
}
