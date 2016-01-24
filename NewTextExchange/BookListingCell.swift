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
    var didSetupConstraints = false
    
    var bookImageView = UIImageView.newAutoLayoutView()
    var bookTitleLabel = UILabel.newAutoLayoutView()
    var bookPriceLabel = UILabel.newAutoLayoutView()
    var bookCourseLabel = UILabel.newAutoLayoutView()
    
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
        
        contentView.addSubview(bookImageView)
        contentView.addSubview(bookTitleLabel)
        contentView.addSubview(bookPriceLabel)
        contentView.addSubview(bookCourseLabel)
        updateConstraints()
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
            bookCourseLabel.text = bookCourse
        }
        
        if let bookPrice = book.price as Int! {
            let priceFormatter = NSNumberFormatter()
            priceFormatter.numberStyle = .CurrencyStyle
            let formattedPrice = priceFormatter.stringFromNumber(bookPrice)
            bookPriceLabel.text = formattedPrice
        }
        
        if let bookCoverPhotoURL = book.thumbnailPhotoURL as String! {
            print(bookCoverPhotoURL)
            Database.getImageFromURL(bookCoverPhotoURL).then { image -> Void in
                self.bookImageView.image = image
            }.error { error -> Void in
                print(error)
            }
        }
    }
    
    override func updateConstraints() {
        if !didSetupConstraints {
            bookImageView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsZero, excludingEdge: .Bottom)
            bookImageView.autoSetDimension(.Height, toSize: 250)
            
            bookTitleLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: bookImageView, withOffset: 5)
            bookTitleLabel.autoAlignAxisToSuperviewAxis(.Vertical)
            
            bookCourseLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: bookTitleLabel, withOffset: 5)
            bookCourseLabel.autoAlignAxisToSuperviewAxis(.Vertical)
            
            bookPriceLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: bookCourseLabel, withOffset: 5)
            bookPriceLabel.autoAlignAxisToSuperviewAxis(.Vertical)

            didSetupConstraints = true
        }
        super.updateConstraints()
    }
}
