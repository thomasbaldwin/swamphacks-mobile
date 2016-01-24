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
    var starRatingView = CosmosView()
    //starRatingView.addSubview(CosmosView() as UIView)
    
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
        
        bookTitleLabel.numberOfLines = 0
        bookTitleLabel.font = UIFont.boldSystemFontOfSize(16)
        bookTitleLabel.textAlignment = .Center
        
        bookCourseLabel.numberOfLines = 0
        bookCourseLabel.font = UIFont.systemFontOfSize(13)
        bookCourseLabel.textAlignment = .Center
        
        bookPriceLabel.numberOfLines = 0
        bookPriceLabel.font = UIFont.boldSystemFontOfSize(13)
        bookPriceLabel.textAlignment = .Center
        
        starRatingView.settings.updateOnTouch = false
        starRatingView.settings.fillMode = .Half
        
        contentView.addSubview(bookImageView)
        contentView.addSubview(bookTitleLabel)
        contentView.addSubview(bookPriceLabel)
        contentView.addSubview(bookCourseLabel)
        contentView.addSubview(starRatingView)
        updateConstraints()
    }
    
    func updateUI() {
        guard let book = self.book else {
            return
        }
        
        if let bookTitle = book.title as String! {
            bookTitleLabel.text = bookTitle
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
        
        if let bookQuality = book.quality as Double! {
            starRatingView.rating = bookQuality
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
            bookTitleLabel.autoPinEdgeToSuperviewEdge(.Leading)
            bookTitleLabel.autoPinEdgeToSuperviewEdge(.Trailing)
            
            bookCourseLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: bookTitleLabel, withOffset: 5)
            bookCourseLabel.autoAlignAxisToSuperviewAxis(.Vertical)
            
            bookPriceLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: bookCourseLabel, withOffset: 5)
            bookPriceLabel.autoAlignAxisToSuperviewAxis(.Vertical)
            
            starRatingView.autoPinEdge(.Top, toEdge: .Bottom, ofView: bookPriceLabel, withOffset: 5)
            starRatingView.autoAlignAxisToSuperviewAxis(.Vertical)

            didSetupConstraints = true
        }
        super.updateConstraints()
    }
}
