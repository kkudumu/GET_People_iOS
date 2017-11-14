//
//  ViewController.swift
//  StarWarsEncyclopedia
//
//  Created by Kioja Kudumu on 11/13/17.
//  Copyright © 2017 Kioja Kudumu. All rights reserved.
//

import UIKit
class PeopleViewController: UITableViewController {
    @IBOutlet weak var peopleTableView: UITableView!
    
    var fetchedName = [Name]()
    // Hardcoded data for now

    override func viewDidLoad() {
        super.viewDidLoad()
        parseData()
        
        peopleTableView.dataSource = self
        
    }
    
    func parseData() {
        
        let url = URL(string: "http://swapi.co/api/people/")
        
    
    // create a URLSession to handle the request tasks
    let session = URLSession.shared
    
    // create a "data task" to make the request and run completion handler
    let task = session.dataTask(with: url!, completionHandler: {
        data, response, error in
        
        do {
            if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                
                if let results = jsonResult["results"] as? NSArray {
                   
                    
                    for eachFetchedName in results {
                        let eachName = eachFetchedName as! [String: Any]
                        let name = eachName["name"] as! String
                        
                        self.fetchedName.append(Name(name: name))
                    }
                    self.peopleTableView.reloadData()

                }
            }
        } catch {
            print(error)
        }
        
    })
    // execute the task and then wait for the response
    // to run the completion handler. This is async!
    task.resume()
}
    
    class Name {
        var name: String
        
        init(name: String) {
            self.name = name
        }
    }
    

    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // if we return - sections we won't have any sections to put our rows in
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the count of people in our data array
        return fetchedName.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create a generic cell
        let cell = UITableViewCell()
        
        // set the default cell label to the corresponding element in the people array
        cell.textLabel?.text = fetchedName[indexPath.row].name
        
        // return the cell so that it can be rendered
        return cell
    }
}


