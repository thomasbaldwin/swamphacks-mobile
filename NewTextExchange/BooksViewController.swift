//
//  ViewController.swift
//  NewTextExchange
//
//  Created by Eric Suarez on 1/23/16.
//  Copyright © 2016 Eric Suarez. All rights reserved.
//

import UIKit

let reuseIdentifier = "Cell"

class BooksViewController: UIViewController {
    var filteredBooks = [Book]()
    var books = [Book]()

    var collectionView: UICollectionView!
    let collectionViewInsets = UIEdgeInsets(top: 4, left: 4, bottom: 0, right: 4)
    
    let refreshControl = UIRefreshControl()

    @IBOutlet weak var searchField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        refresh(refreshControl)
    }
    
    func setupViews() {
        view.backgroundColor = .whiteColor()
        
        searchField.delegate = self
        searchField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        searchField.frame.size.width = view.frame.width
        searchField.frame.size.height = 26
        searchField.clearButtonMode = .Always
        navigationController?.navigationItem.titleView = searchField
        navigationController?.navigationBar.barTintColor = UIColor.orangeColor()
        
        searchField.delegate = self
        searchField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView!.delegate = self
        collectionView!.dataSource = self
        collectionView!.setCollectionViewLayout(layout, animated: false)
        collectionView!.registerClass(BookListingCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .whiteColor()
        collectionView.alwaysBounceVertical = true;
        collectionView.bounces = true
        
        refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        
        view.addSubview(collectionView)
        collectionView.addSubview(refreshControl)
        setupConstraints()
    }
    
    func setupConstraints() {
        collectionView.autoPinEdgesToSuperviewEdgesWithInsets(collectionViewInsets)
    }
    
    func filterBooks() {
        guard let text = searchField.text where !text.isEmpty else {
            filteredBooks = books
            return
        }
        
        filteredBooks.removeAll(keepCapacity: false)
        
        var predicateList = [NSPredicate]()
        let words = text.componentsSeparatedByString(" ")
        for word in words {
            let titlePredicate = NSPredicate(format: "title contains[c] %@", word)
            let coursePredicate = NSPredicate(format: "course contains[c] %@", word)
            
            let orCompoundPredicate = NSCompoundPredicate(type: NSCompoundPredicateType.OrPredicateType, subpredicates: [titlePredicate, coursePredicate])
            
            predicateList.append(orCompoundPredicate)
        }
        
        let searchPredicate = NSCompoundPredicate(type: NSCompoundPredicateType.AndPredicateType, subpredicates: predicateList)
        let array = (books as NSArray).filteredArrayUsingPredicate(searchPredicate)
        filteredBooks = array as! [Book]
    }
    
    func refresh(sender: UIRefreshControl) {
        Database.getBooks().then { books -> Void in
            self.books = books
            self.collectionView.reloadData()
            sender.endRefreshing()
        }.error { error -> Void in
            print("Getting Books Error: \(error)")
        }
    }
}

extension BooksViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {

        let screenSize = UIScreen.mainScreen().bounds
        let columnsPerPage: CGFloat = 2
        let itemHeight: CGFloat = 375
        return CGSize(width: (screenSize.width - 2 * (collectionViewInsets.left + collectionViewInsets.right)) / columnsPerPage, height: itemHeight)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (searchField.text!.isEmpty ? books.count: filteredBooks.count)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! BookListingCell
        let book = searchField.text!.isEmpty ? books[indexPath.row] : filteredBooks[indexPath.row]
        
        cell.book = book
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        if let bookDetailsViewController = storyboard?.instantiateViewControllerWithIdentifier("BookDetailsViewController")
            as? BookDetailsNEWController {
            let book = searchField.text!.isEmpty ? books[indexPath.row] : filteredBooks[indexPath.row]
            bookDetailsViewController.book = book
            navigationController?.pushViewController(bookDetailsViewController, animated: true)
        }
    }
}

extension BooksViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.text!.isEmpty {
            filteredBooks = books
        }
    }
    
    func textFieldDidChange(textField: UITextField) {
        filterBooks()
        collectionView!.reloadData()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}


