//
//  CategoryViewController.swift
//  Todoey-Realm
//
//  Created by tetsuta matsuyama on 2023/03/06.
//

import UIKit

class Category {
    var name = ""
}

class CategoryViewController: UITableViewController {

    var categories = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            self.categories.append(newCategory)

            let indexPath = IndexPath(row: self.categories.count - 1, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .fade)
        }

        [cancelAction, addAction].forEach { alert.addAction($0) }
        present(alert, animated: true, completion: nil)
    }
    
    
}
 

extension CategoryViewController {
    
    // MARK: - TableView DataSource & Delegate Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let category = categories[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = category.name
        cell.contentConfiguration = content

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    /*
    // MARK: - Navigation Transitions

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
