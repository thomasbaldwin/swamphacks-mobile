//
//  ViewController.swift
//  NewTextExchange
//
//  Created by Eric Suarez on 1/23/16.
//  Copyright © 2016 Eric Suarez. All rights reserved.
//

import UIKit
import AFNetworking

class BooksViewController: UIViewController {
    
    var filteredBooks = [Book]()
    let books = [
        Book(
            title: "Operating Systems",
            course: "COP4600", price: 45, coverImage: NSURL(string: "http://ecx.images-amazon.com/images/I/51T73lIemvL._SX328_BO1,204,203,200_.jpg")),
        Book(title: "English Composition 1", course: "ENC1102", price: 60, coverImage: NSURL(string: "http://image.slidesharecdn.com/modernworldhistorytextbooksocialtb-140208031911-phpapp01/95/modern-world-history-textbook-social-tb-1-638.jpg?cb=1391830310"))
    
    ]

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var searchField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        navigationController?.navigationBar.barTintColor = UIColor.orangeColor()
        
        searchField.delegate = self
        searchField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.whiteColor()
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
}

extension BooksViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let totalwidth = collectionView.bounds.size.width;
        let numberOfCellsPerRow = 2
        let dimensions = CGFloat(Int(totalwidth) / numberOfCellsPerRow)
        
        return CGSizeMake(dimensions, 325)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (searchField.text!.isEmpty ? books.count: filteredBooks.count)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("BookCell", forIndexPath: indexPath) as! BookListingCell
        
        let book = searchField.text!.isEmpty ? books[indexPath.row] : filteredBooks[indexPath.row]
        cell.book = book
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        storyboard?.instantiateViewControllerWithIdentifier("BookDetailsViewController")
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


