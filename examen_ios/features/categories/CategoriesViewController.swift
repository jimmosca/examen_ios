//
//  CategoriesViewController.swift
//  examen_ios
//
//  Created by Jaime Casado Aparicio on 26/2/20.
//  Copyright © 2020 Jaime Casado Aparicio. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class CategoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    let db = Firestore.firestore()
    var categories: Array<Category> = []
    
    @IBOutlet weak var cTableView: UITableView!
    
    @IBAction func addPressed(_ sender: AnyObject){
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Add New Category", message: nil, preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.placeholder = "Add a New Category"
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            print("Text field: \(textField?.text)")
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure(tableView: cTableView)
        fetchAllCategories()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let tableViewCell = sender as? UITableViewCell,
            let indexPath = cTableView.indexPath(for: tableViewCell) else {
                return
        }
        
        let categorySelected = self.categories[indexPath.row]
        /*nIndice = indexPath.row
        if let destinationViewController = segue.destination as? NutrientDetailViewController{
            // Especificas que esta clase es el delegate del DetailView
            destinationViewController.delegate = self
            destinationViewController.set(nutrientData: nutrientSelected)
        }*/
    }
    
    func fetchAllCategories(){
        var categories: Array<Category> = []
        db.collection("categories").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                print("\n\tSHOWING ALL DOCUMENTS \n")
                for document in querySnapshot!.documents {
                    guard let nombre = document.data()["nombre"] as? String, let items = document.data()["items"] as? Array<String> else{return}
                    categories.append(Category(nombre: nombre, items: items))
                    print("\(document.documentID) => \(document.data())")
                }
                print("\n")
            }
            DispatchQueue.main.async {
                self.categories = categories
                self.cTableView.reloadData()
            }
        }
        
        
        
    }
    
    private func configure(tableView: UITableView){
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CategoryViewCell.cRowHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryViewCell.cIdentifier,
                                                 for: indexPath)
        
        (cell as? CategoryViewCell)?.update(data: self.categories[indexPath.row].nombre)
        
        return cell
    }
}
