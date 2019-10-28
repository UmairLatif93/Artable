//
//  ProductsVC.swift
//  Artable
//
//  Created by Umair Latif on 18/10/2019.
//  Copyright © 2019 Umair Latif. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class ProductsVC: UIViewController {

    
    //Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    //Variables
    
    var products = [Product]()
    var category : Category!
    var listner : ListenerRegistration!
    var db : Firestore!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: Identifiers.ProductCellIdentifier, bundle: nil), forCellReuseIdentifier: Identifiers.ProductCellIdentifier)
        
        setProductQuery()
    }
    
    func setProductQuery(){
        
        listner = db.products(category: category.id).addSnapshotListener({ (snap, error) in
            
            if let error = error {
                
                debugPrint(error)
                self.simpleAlert(title: "Dismiss", msg: "Something went wrong, while fetching data.")
                return
            }
            
            snap?.documentChanges.forEach({ (change) in
                
                let data = change.document.data()
                let product = Product.init(data: data)
                
                switch change.type {
                    
                case .added:
                    self.onDocumentAdded(change: change, product: product)
                case .modified:
                    self.onDocumentModified(change: change, product: product)
                case .removed:
                    self.onDocumentRemoved(change: change)
                @unknown default:
                    fatalError()
                }
                
            })
        })
    }
}



extension ProductsVC : UITableViewDelegate, UITableViewDataSource {
    
    func onDocumentAdded(change : DocumentChange, product : Product){
        
        let newIndex = Int(change.newIndex)
        products.insert(product, at: newIndex)
        tableView.insertRows(at: [IndexPath(row: newIndex, section: 0)], with: .fade)
    }
    
    func onDocumentModified(change : DocumentChange, product : Product){
        
        if change.newIndex == change.oldIndex {
            
            let index = Int(change.newIndex)
            products[index] = product
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
            
        }else {
            
            let oldIndex = Int(change.oldIndex)
            let newIndex = Int(change.newIndex)
            
            products.remove(at: oldIndex)
            products.insert(product, at: newIndex)
            
            tableView.moveRow(at: IndexPath(row: oldIndex, section: 0), to: IndexPath(row: newIndex, section: 0))
        }
       
    }
    
    func onDocumentRemoved(change : DocumentChange){
        
        let oldIndex = Int(change.oldIndex)
        products.remove(at: oldIndex)
        tableView.deleteRows(at: [IndexPath(row: oldIndex, section: 0)], with: .left)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.ProductCellIdentifier, for: indexPath) as? ProductCell {
            
            cell.ConfigureCell(product: products[indexPath.row])
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = ProductDetailVC()
        let selectedProduct = products[indexPath.row]
        vc.product = selectedProduct
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 200
    }
}
