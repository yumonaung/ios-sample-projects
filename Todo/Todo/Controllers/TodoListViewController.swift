//
//  ViewController.swift
//  Todo
//
// Created by Yu Mon Aung on 2021/02/24.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class TodoListViewController: SwipeTableViewController,UISearchBarDelegate{

    @IBOutlet weak var searchBar: UISearchBar!
    var todoItems : Results<Item>?
    let realm = try! Realm()
    var selectedCategory : Category?{
        didSet{
            loadItems()
        }
    }

    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }

    override func viewWillAppear(_ animated: Bool) {
        if let colourHex = selectedCategory?.colour {
            
            title = selectedCategory!.name
            guard let navBar = navigationController?.navigationBar else {
                fatalError("Navigation Controller does not exist.")
            }
            
            if let navBarColor = UIColor(hexString: colourHex) {
            navBar.backgroundColor = navBarColor
            navBar.tintColor = ContrastColorOf(navBarColor, returnFlat: true)
            searchBar.barTintColor = navBarColor
                navBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: ContrastColorOf(navBarColor, returnFlat: true)]
            }
            
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }

    // Provide a cell object for each row.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // Fetch a cell of the appropriate type.
     
        let cell = super.tableView(tableView,cellForRowAt: indexPath)
        if let item = todoItems?[indexPath.row]{
            
            // Configure the cell’s contents.
            cell.textLabel?.text = item.title
            
            if let colour = UIColor(hexString: selectedCategory!.colour)?.darken(byPercentage:
                                                    CGFloat(indexPath.row)/CGFloat(todoItems!.count)
        )
            {
                cell.backgroundColor = colour
                cell.textLabel?.textColor = ContrastColorOf(colour, returnFlat: true)
                
            }
            
            cell.accessoryType = item.done ? .checkmark: .none
        }else{
            cell.textLabel?.text = "No items Added"
        }
       
       return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = todoItems?[indexPath.row]{
            do {
                try realm.write({
                    
                  //  realm.delete(item)
                    item.done = !item.done
                })
            } catch  {
                print("Error saving done status,\(error)")
            }
        }
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new todo item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            do{
            if let currentCategory =  self.selectedCategory{
                try self.realm.write{let newItem = Item()
                newItem.title = textField.text!
                newItem.dateCreated = Date()
                newItem.done = false
                currentCategory.items.append(newItem)
                }
            }
            }catch{
                print("Error saving new items \(error)")
            }
            
            self.tableView.reloadData()
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
   func loadItems()  {
    
    todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
        tableView.reloadData()
        
    }
    
    //MARK: - Search Bar Method
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
           
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
                
            }
           
        }
    }
    
    override func updateModel(at indexPath: IndexPath) {
        if let itemForDeletion = self.todoItems?[indexPath.row]{
         
         do {
             try self.realm.write{
                 self.realm.delete(itemForDeletion)
             }
          } catch  {
             print("Item delete error \(error)")
          }
            //tableView.reloadData()
         }
    }
}

