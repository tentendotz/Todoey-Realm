//
//  CategoryViewController.swift
//  Todoey-Realm
//
//  Created by tetsuta matsuyama on 2023/03/06.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {

    let realm = try! Realm()
    var categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
        
        guard let navBar = navigationController?.navigationBar else { fatalError("Navigation controller does not exist.") }
        navBar.prefersLargeTitles = true
        navBar.tintColor = UIColor.white
        
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = UIColor.systemPurple
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        var textField = UITextField()
        alert.addTextField { field in
            field.placeholder = "Create New Category"
            textField = field
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        let addAction = UIAlertAction(title: "Add", style: .default) { action in
            let newCategory = Category()
            newCategory.name = textField.text!
            self.save(category: newCategory)
        }

        [cancelAction, addAction].forEach { alert.addAction($0) }
        present(alert, animated: true)
    }
    
    
    //MARK: - Data Manipulation Methods
    
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving category, \(error)")
        }
        
        guard let categories else { return }
        let indexPath = IndexPath(row: categories.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .fade)
    }
    
    func loadCategories() {
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
}
 

extension CategoryViewController {
    
    // MARK: - TableView DataSource & Delegate Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let category = categories?[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = category?.name ?? "No Categories Added Yet."
        cell.contentConfiguration = content

        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Destructive") { action, view, completionHandler in
            guard let categoryForDeletion = self.categories?[indexPath.row] else {
                completionHandler(false)
                return
            }
            do {
                try self.realm.write {
                    self.realm.delete(categoryForDeletion)
                    self.tableView.deleteRows(at: [indexPath], with: .fade)
                    completionHandler(true)
                }
            } catch {
                print("Error deleting category, \(error)")
                completionHandler(false)
            }
        }
        deleteAction.image = UIImage(systemName: "trash")
        let swipeConfig = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeConfig
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    // MARK: - Navigation Transitions

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToItems" {
            let destinationVC = segue.destination as! TodoListViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.selectedCategory = categories?[indexPath.row]
            }
        }
    }
}
