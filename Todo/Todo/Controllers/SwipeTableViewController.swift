//
//  SwipeTableViewController.swift
//  Todo
//
//  Created by Yu Mon Aung on 2021/02/24.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipeTableViewController: UITableViewController,SwipeTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80
        tableView.separatorStyle = .none
    }
        
      //Table View Data Source Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Fetch a cell of the appropriate type.
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
       
         
        // Configure the cell’s contents.
         //cell.textLabel!.text = categories?[indexPath.row].name ?? "No Category Added yet"
         cell.delegate = self
         
        return cell    }
        
        func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
            guard orientation == .right else { return nil }

            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
                
                print("Delete Cell")
                
                self.updateModel(at: indexPath)
              
                
            }

            // customize the action appearance
            deleteAction.image = UIImage(named: "delete-icon")

            return [deleteAction]
        }

        func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
              var options = SwipeOptions()
              options.expansionStyle = .destructive
              
              return options
          }
    

    func updateModel(at indexPath : IndexPath)  {
            
    }
}
