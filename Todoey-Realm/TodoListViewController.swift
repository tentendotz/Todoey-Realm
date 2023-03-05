//
//  TodoListViewController.swift
//  Todoey-Realm
//
//  Created by tetsuta matsuyama on 2023/03/04.
//

import UIKit

class TodoListViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = UIColor.systemPurple
        searchBar.barTintColor = UIColor.systemPurple
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        
        guard let navBar = navigationController?.navigationBar else { fatalError("Navigation controller does not exist.") }
        navBar.tintColor = UIColor.white
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {

    }
    
}

