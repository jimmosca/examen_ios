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

class CategoryDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    let db = Firestore.firestore()
    var category: Category?
    var items: Array<String> = []
    
    @IBOutlet weak var cTableView: UITableView!
    @IBOutlet weak var cNavigationItem: UINavigationItem!
    
    @IBAction func addPressed(_ sender: AnyObject){
        
        let alert = UIAlertController(title: "Add New Item", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Add a New Item"
        }
        
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak alert] (_) in
            guard let text = alert?.textFields![0].text else{return}
            print("Text field: \(text)")
            self.addItem(nombre: text)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func backPressed(_ sender: AnyObject){
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cNavigationItem.title = category?.nombre
        configure(tableView: cTableView)
        fetchItems()
    }
    
    func set(categorySelected: Category){
        self.category = categorySelected
    }
    
    
    func fetchItems(){
        var items: Array<String> = []
        db.collection("categories").document((category?.id!)!)
            .getDocument() { (document, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    
                    print("\(document?.documentID) => \(document?.data())")
                    items = document?.data()?["items"] as! Array<String>
                    
                }
                
                DispatchQueue.main.async {
                    self.items = items
                    self.cTableView.reloadData()
                }
        }
        
        
        
    }
    
    func addItem(nombre: String) {
        self.items.append(nombre)
        var ref: DocumentReference? = db.collection("categories").document((category?.id!)!)
        ref?.updateData([
            "items": self.items
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        self.fetchItems()
    }
    
    private func configure(tableView: UITableView){
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CategoryViewCell.cRowHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryViewCell.cIdentifier,
                                                 for: indexPath)
        
        (cell as? CategoryViewCell)?.update(data: self.items[indexPath.row])
        
        return cell
    }
}
