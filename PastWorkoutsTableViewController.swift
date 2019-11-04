//
//  PastWorkoutsTableViewController.swift
//  Crossfit
//
//  Created by Ana Klabjan on 4/25/19.
//  Copyright © 2019 Ana Klabjan. All rights reserved.
//

import UIKit
import SafariServices
import Firebase

class PastWorkoutsTableViewController: UITableViewController
{
    
    override func viewDidLoad() {
        self.clearsSelectionOnViewWillAppear = false
        tableView.register(UINib(nibName: "CrossfitTableViewCell", bundle: nil), forCellReuseIdentifier: "CrossfitCell")
        view.backgroundColor = .black
        
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CrossfitCell", for:indexPath) as! CrossfitTableViewCell
        let lift = pastWorkouts[indexPath.row]
        cell.nameLabel.text = lift.name
        cell.lengthLabel.text = lift.date
        cell.showsReorderControl = true
        if (indexPath.row % 2 == 0) { cell.backgroundColor = UIColor(red: 1, green: 0.498, blue: 0, alpha: 1.0)}
        else {cell.backgroundColor = UIColor(red: 1, green: 0.6118, blue: 0.2275, alpha: 1.0)}
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pastWorkouts.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let workout = pastWorkouts[indexPath.row]
        let viewController = WodDetailViewController()
        viewController.workout = workout
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}
