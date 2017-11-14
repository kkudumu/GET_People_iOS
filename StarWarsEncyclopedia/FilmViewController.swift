//
//  FilmViewControllerTableViewController.swift
//  StarWarsEncyclopedia
//
//  Created by Kioja Kudumu on 11/13/17.
//  Copyright © 2017 Kioja Kudumu. All rights reserved.
//

import UIKit

class FilmViewController: UITableViewController {
    @IBOutlet weak var filmTableView: UITableView!
    
    var fetchedTitle = [Title]()
    // Hardcoded data for now
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseData()
        
        filmTableView.dataSource = self
        
    }
    
    func parseData() {
        
        StarWarsModel.getAllFilms(completionHandler: {
            data, response, error in
            
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    
                    if let results = jsonResult["results"] as? NSArray {
                        //[results][0][films]

                        for eachFetchedTitle in results {
                            let eachTitle = eachFetchedTitle as! [String: Any]
                            let title = eachTitle["title"] as! String
                            
                            print(title)
                            
                            self.fetchedTitle.append(Title(title: title))
                        }
                        self.filmTableView.reloadData()
                        
                    }
                    
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                }
            } catch {
                print(error)
            }
            
        })

    }
    
    class Title {
        var title: String
        
        init(title: String) {
            self.title = title
        }
    }
    
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // if we return - sections we won't have any sections to put our rows in
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the count of people in our data array
        return fetchedTitle.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create a generic cell
        let cell = UITableViewCell()
        
        // set the default cell label to the corresponding element in the people array
        cell.textLabel?.text = fetchedTitle[indexPath.row].title
        
        // return the cell so that it can be rendered
        return cell
    }
}



