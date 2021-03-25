//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Yu Mon Aung on 2021/02/23.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController{

    let realm = try! Realm()
    var categories : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        loadCategories()
        
    }
    override func viewWillAppear(_ animated: Bool) {
       
            guard let navBar = navigationController?.navigationBar else {
                fatalError("Navigation Controller does not exist.")
            }
            
       navBar.backgroundColor = UIColor(hexString: "1D9BF6")
           
        }
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
       let action = UIAlertAction(title: "Add category", style: .default) { (action) in
            
            let newCatgory = Category()
            newCatgory.name = textField.text!
            newCatgory.colour = UIColor.randomFlat().hexValue()
            self.saveCategory(category: newCatgory)
        }
        
        // textfield added in alert controller
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
           textField = alertTextField
        }
 
        // add action  to alert controller
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil) //display alert
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    func saveCategory(category : Category)  {
        do {
            try realm.write({
                realm.add(category)
            })
        } catch  {
            print("Category saving error \(error)")
        }
        tableView.reloadData()
    }
    
 func loadCategories()  {
        
 categories = realm.objects(Category.self)
      
        tableView.reloadData()
 
    }
    
    // Provide a cell object for each row.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView,cellForRowAt: indexPath)
        cell.textLabel!.text = categories?[indexPath.row].name ?? "No Category Added yet"
       
        let color  = categories?[indexPath.row].colour ?? UIColor.randomFlat().hexValue()
        cell.backgroundColor = UIColor(hexString: color)
        cell.textLabel?.textColor = ContrastColorOf(UIColor(hexString: color)!, returnFlat: true)
       return cell
    }
    
    override func updateModel(at indexPath: IndexPath) {
        if let categoryForDeletion = self.categories?[indexPath.row]{
         
         do {
             try self.realm.write{
                 self.realm.delete(categoryForDeletion)
             }
          } catch  {
             print("Category delete error \(error)")
          }
            //tableView.reloadData()
         }
        
    }
}

