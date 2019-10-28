//
//  ViewController.swift
//  Artable
//
//  Created by Umair Latif on 16/10/2019.
//  Copyright © 2019 Umair Latif. All rights reserved.
//

import UIKit
import  Firebase

class HomeVC: UIViewController {
    
    //Outlets
    
    @IBOutlet weak var LoginOutBtn: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //Variables
    
    var categories = [Category]()
    var selectedCategory : Category!
    let db = Firestore.firestore()
    var listner : ListenerRegistration!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUpCollectionView()
        setUpInitialAnonymousUser()
        setUpNavigationBar()
    }
    
    func setUpNavigationBar() {
        
        guard let font = UIFont(name: "futura", size: 26) else {return}
        
        navigationController?.navigationBar.titleTextAttributes = [
        
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.font : font
        ]
    }
    
    func setUpCollectionView() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: Identifiers.CategoryCellIdentifier, bundle: nil), forCellWithReuseIdentifier: Identifiers.CategoryCellIdentifier)
    }
    
    func setUpInitialAnonymousUser() {
        
        if Auth.auth().currentUser == nil {
            
            Auth.auth().signInAnonymously { (result, error) in
                
                if let error = error {
                    
                    print(error)
                    Auth.auth().handleFireAuthError(error: error, vc: self)
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        setCategoryListener()
        
        if let user = Auth.auth().currentUser , !user.isAnonymous {
            
            LoginOutBtn.title = "Logout"
            
        }else{
            
            LoginOutBtn.title = "Login"
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        listner.remove()
        categories.removeAll()
        collectionView.reloadData()
    }
    
    func setCategoryListener(){
        
        listner = db.categories.addSnapshotListener({ (snap, error) in
            
            if let error = error {
                
                print(error)
                self.simpleAlert(title: "Dismiss", msg: "Something went wrong, while fetching data.")
                return
            }
            
            snap?.documentChanges.forEach({ (change) in
                
                let data = change.document.data()
                let category = Category.init(data: data)
                
                switch change.type {
                    
                case .added:
                    self.onDocumentAdded(change: change, category: category)
                case .modified:
                    self.onDocumentModified(change: change, category: category)
                case .removed:
                    self.onDocumentRemoved(change: change)
                @unknown default:
                    fatalError()
                }
            })
        })
    }
    
    fileprivate func presentLoginController() {
        let storyboard = UIStoryboard(name: StoryboardId.LoginStoryboard, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: StoryboardIdentifier.LoginVC)
        present(controller, animated: true, completion: nil)
    }

    @IBAction func LoginOutClciked(_ sender: Any) {
        
        guard let user = Auth.auth().currentUser else { return }
        
        if user.isAnonymous {
            
            presentLoginController()
        }
        else {
            
            do {
                
                try Auth.auth().signOut()
                Auth.auth().signInAnonymously { (result, error) in
                    
                    if let error = error {
                        print(error)
                        Auth.auth().handleFireAuthError(error: error, vc: self)
                    }
                    self.presentLoginController()
                }
                
            }catch{
                Auth.auth().handleFireAuthError(error: error, vc: self)
                print(error)
            }
        }
    }
}

extension HomeVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func onDocumentAdded(change : DocumentChange, category : Category){
        
        let newIndex = Int(change.newIndex)
        categories.insert(category, at: newIndex)
        collectionView.insertItems(at: [IndexPath(item: newIndex, section: 0)])
    }
    
    func onDocumentModified(change : DocumentChange, category : Category){
        
        if change.newIndex == change.oldIndex {
            
            let index = Int(change.newIndex)
            categories[index] = category
            collectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
            
        }else {
            
            let oldIndex = Int(change.oldIndex)
            let newIndex = Int(change.newIndex)
            
            categories.remove(at: oldIndex)
            categories.insert(category, at: newIndex)
            
            collectionView.moveItem(at: IndexPath(item: oldIndex, section: 0), to: IndexPath(item: newIndex, section: 0))
        }
    }
    
    func onDocumentRemoved(change : DocumentChange){
        
        let oldIndex = Int(change.oldIndex)
        categories.remove(at: oldIndex)
        collectionView.deleteItems(at: [IndexPath(item: oldIndex, section: 0)])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.CategoryCellIdentifier, for: indexPath) as? CategoryCell {
            
            cell.ConfigureCell(category: categories[indexPath.item])
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width
        let cellWidth = (width - 30) / 2
        let cellHeight = cellWidth * 1.5
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedCategory = categories[indexPath.item]
        performSegue(withIdentifier: Segues.ToProducts, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Segues.ToProducts {
            
            if let destination = segue.destination as? ProductsVC {
                
                destination.category = selectedCategory
            }
        }
    }
    
}






//This is a prior code for fetching Single Document and a complete collection
//Also snapshot listner for real time update

//    func fetchDocument(){
//
//        let docRef = db.collection("categories").document("sc1blhuljyuzhOQa7a0N")
//
//        docRef.getDocument { (result, error) in
//
//            if let error = error {
//
//                print(error)
//                self.simpleAlert(title: "Dismiss", msg: "Something went wrong, while fetching data.")
//                return
//            }
//
//            guard let data = result?.data() else {return}
//
//            let newCategory = Category.init(data: data)
//
//            self.categories.append(newCategory)
//            self.collectionView.reloadData()
//        }
//    }
    
//    func fetchCollection(){
//
//        let collectionRef = db.collection("categories")
//
//        listner = collectionRef.addSnapshotListener { (snap, error) in
//
//            if let error = error {
//
//                print(error)
//                self.simpleAlert(title: "Dismiss", msg: "Something went wrong, while fetching data.")
//                return
//            }
//
//            guard let documents = snap?.documents else {return}
//            self.categories.removeAll()
//            for document in documents {
//
//                let data = document.data()
//                let newCategory = Category.init(data: data)
//                self.categories.append(newCategory)
//            }
//
//            self.collectionView.reloadData()
//        }
        
//        collectionRef.getDocuments { (snap, error) in
//
//            if let error = error {
//
//                print(error)
//                self.simpleAlert(title: "Dismiss", msg: "Something went wrong, while fetching data.")
//                return
//            }
//
//            guard let documents = snap?.documents else {return}
//            for document in documents {
//
//                let data = document.data()
//                let newCategory = Category.init(data: data)
//                self.categories.append(newCategory)
//            }
//
//            self.collectionView.reloadData()
//        }
//    }
