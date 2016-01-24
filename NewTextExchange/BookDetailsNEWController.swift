//
//  BookDetailsNEWController.swift
//  NewTextExchange
//
//  Created by Brian Roytman on 1/23/16.
//  Copyright © 2016 Eric Suarez. All rights reserved.
//

import Foundation
import Cosmos


class BookDetailsNEWController: UIViewController, UINavigationBarDelegate {
    var book: Book?
 
    var bookImageView = UIImageView(image: UIImage(named: "RagtimeBookCover"))
    var detailsView = UIView.newAutoLayoutView()
    
    var thumbnailImageView = UIImageView(image: UIImage(named: "ProfilePic"))
    var nameLabel = UILabel.newAutoLayoutView()
    var phoneImageView = UIImageView(image: UIImage(named: "PhoneIcon"))
    var messageImageView = UIImageView(image: UIImage(named: "MessageIcon"))
    
    var bookTitleLabel = UILabel.newAutoLayoutView()
    var courseCodeLabel = UILabel.newAutoLayoutView()
    var ratingStarsView: CosmosView!
    var priceLabel = UILabel.newAutoLayoutView()

    
    var detailsViewTopConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        detailsView.backgroundColor = UIColor.blackColor()
        detailsView.opaque = true
        detailsView.alpha = 0.9
        
        thumbnailImageView.layer.cornerRadius = 20
        thumbnailImageView.clipsToBounds = true
        
        nameLabel.text = "Brian Roytman"
        nameLabel.textColor = UIColor.whiteColor()
        
        bookTitleLabel.font = UIFont.systemFontOfSize(24)
        bookTitleLabel.text = "Ragtime"
        bookTitleLabel.textColor = UIColor.whiteColor()
        
        courseCodeLabel.font = UIFont.systemFontOfSize(24)
        courseCodeLabel.text = "ENC1102"
        courseCodeLabel.textColor = UIColor.whiteColor()
        
        //DO THIS FOR STAR RATINGS AS WELL
        priceLabel.font = UIFont.systemFontOfSize(24)
        priceLabel.text = "$10"
        priceLabel.textColor = UIColor.whiteColor()
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGestureUp")
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        view.addGestureRecognizer(swipeUp)

        let swipeDown = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGestureDown")
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        view.addGestureRecognizer(swipeDown)
        
        view.addSubview(bookImageView)
        view.addSubview(detailsView)
        detailsView.addSubview(thumbnailImageView)
        detailsView.addSubview(nameLabel)
        detailsView.addSubview(phoneImageView)
        detailsView.addSubview(messageImageView)
        detailsView.addSubview(bookTitleLabel)
        detailsView.addSubview(courseCodeLabel)
        detailsView.addSubview(priceLabel)
        setupConstraints()
    }
    
    func setupConstraints() {
        bookImageView.autoPinToTopLayoutGuideOfViewController(self, withInset: 0)
        bookImageView.autoPinEdgeToSuperviewEdge(.Leading)
        bookImageView.autoPinEdgeToSuperviewEdge(.Trailing)
        bookImageView.autoPinToBottomLayoutGuideOfViewController(self, withInset: 0)
        
        detailsViewTopConstraint = detailsView.autoPinToTopLayoutGuideOfViewController(self, withInset: UIScreen.mainScreen().bounds.height - 124)
        detailsView.autoPinEdgeToSuperviewEdge(.Leading)
        detailsView.autoPinEdgeToSuperviewEdge(.Trailing)
        detailsView.autoPinEdgeToSuperviewEdge(.Bottom)
        
        thumbnailImageView.autoPinEdgeToSuperviewEdge(.Top, withInset: 10)
        thumbnailImageView.autoPinEdgeToSuperviewEdge(.Leading, withInset: 10)
        thumbnailImageView.autoSetDimensionsToSize(CGSize(width: 40, height: 40))
        
        nameLabel.autoAlignAxis(.Horizontal, toSameAxisOfView: thumbnailImageView)
        nameLabel.autoPinEdge(.Leading, toEdge: .Trailing, ofView: thumbnailImageView, withOffset: 20)
        nameLabel.autoPinEdge(.Trailing, toEdge: .Leading, ofView: phoneImageView, withOffset: 10)
        
        phoneImageView.autoAlignAxis(.Horizontal, toSameAxisOfView: thumbnailImageView)
        phoneImageView.autoPinEdge(.Trailing, toEdge: .Leading, ofView: messageImageView, withOffset: -20)
        
        messageImageView.autoAlignAxis(.Horizontal, toSameAxisOfView: thumbnailImageView)
        messageImageView.autoPinEdgeToSuperviewEdge(.Trailing, withInset: 20)

        bookTitleLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: thumbnailImageView, withOffset: 40)
        bookTitleLabel.autoPinEdge(.Leading, toEdge: .Leading, ofView: thumbnailImageView)
        
        courseCodeLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: bookTitleLabel, withOffset: 10)
        courseCodeLabel.autoPinEdge(.Leading, toEdge: .Leading, ofView: bookTitleLabel)
        
        
        priceLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: courseCodeLabel, withOffset: 10)
        priceLabel.autoPinEdge(.Leading, toEdge: .Leading, ofView: courseCodeLabel)
    }
    
    func respondToSwipeGestureUp() {
        self.detailsViewTopConstraint.constant = 0
        UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: { finished in
            print("Basket doors opened!")
        })
        
    }
    
    func respondToSwipeGestureDown() {
        self.detailsViewTopConstraint.constant = UIScreen.mainScreen().bounds.height - 124
        UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: { finished in
            print("Basket doors closed!")
        })
        
    }
    
}