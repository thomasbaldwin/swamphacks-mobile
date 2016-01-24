//
//  BookListingCell.swift
//  NewTextExchange
//
//  Created by Eric Suarez on 1/23/16.
//  Copyright © 2016 Eric Suarez. All rights reserved.
//

import UIKit
import Cosmos

class BookListingCell: UICollectionViewCell {
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookPriceLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    //@IBOutlet weak var ratingStarsView: CosmosView!
    
    var book: Book? {
        didSet {
            updateUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    func setupViews() {
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.grayColor()
        selectedBackgroundView = backgroundView
        //ratingStarsView.backgroundColor = .None
    }
    
    func updateUI() {
        guard let book = self.book else {
            return
        }
        
        if let bookTitle = book.title as String! {
            bookTitleLabel.text = bookTitle
            bookTitleLabel.sizeToFit()
        }
        
        if let bookCourse = book.course as String! {
            courseLabel.text = bookCourse
        }
        
        if let bookPrice = book.price as Int! {
            let priceFormatter = NSNumberFormatter()
            priceFormatter.numberStyle = .CurrencyStyle
            let formattedPrice = priceFormatter.stringFromNumber(bookPrice)
            bookPriceLabel.text = formattedPrice
        }
        
        bookImageView.setImageWithURL(book.coverImage!)
        
    }
}
