//
//  ViewController.swift
//  NewTextExchange
//
//  Created by Eric Suarez on 1/23/16.
//  Copyright © 2016 Eric Suarez. All rights reserved.
//

import UIKit
import AFNetworking

class BooksViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    let books = [
        Book(
            title: "Operating Systems",
            course: "COP4600", price: 45, coverImage: NSURL(string: "http://ecx.images-amazon.com/images/I/51T73lIemvL._SX328_BO1,204,203,200_.jpg")),
        Book(title: "English Composition 1", course: "ENC1102", price: 60, coverImage: NSURL(string: "http://image.slidesharecdn.com/modernworldhistorytextbooksocialtb-140208031911-phpapp01/95/modern-world-history-textbook-social-tb-1-638.jpg?cb=1391830310"))
    
    ]

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var booksForSale: [Book] = []
    var filteredData: [Book]?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationController?.navigationBar.barTintColor = UIColor.orangeColor()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        searchBar.delegate = self
        
        collectionView.backgroundColor = UIColor.whiteColor()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let totalwidth = collectionView.bounds.size.width;
        let numberOfCellsPerRow = 2
        let dimensions = CGFloat(Int(totalwidth) / numberOfCellsPerRow)
        
        return CGSizeMake(dimensions, 325)
        
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("BookCell", forIndexPath: indexPath) as! BookListingCell
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.grayColor()
        
        cell.selectedBackgroundView = backgroundView
        cell.ratingStarsView.backgroundColor = .None
        
        let singleBook = books[indexPath.row]
        
        let priceFormatter = NSNumberFormatter()
        priceFormatter.numberStyle = .CurrencyStyle
        var formattedPrice = priceFormatter.stringFromNumber(singleBook.price!)
        
        cell.bookTitleLabel.text = singleBook.title! as String
        cell.bookPriceLabel.text = formattedPrice! as String
        cell.courseLabel.text = singleBook.course! as String
        cell.bookImageView.setImageWithURL(singleBook.coverImage!)
        cell.bookTitleLabel.sizeToFit()

        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        storyboard?.instantiateViewControllerWithIdentifier("BookDetailsViewController")
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
//        let searchString = searchBar.text
//        
//        filteredData = searchText.isEmpty ? books : books.filter({(dataString: String) -> Bool in
//            return dataString.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil
//        })
    }
    
    

}

