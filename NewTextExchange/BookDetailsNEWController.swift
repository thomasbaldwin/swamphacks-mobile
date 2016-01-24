//
//  BookDetailsNEWController.swift
//  NewTextExchange
//
//  Created by Brian Roytman on 1/23/16.
//  Copyright © 2016 Eric Suarez. All rights reserved.
//

import Foundation

class BookDetailsNEWController: UIViewController, UINavigationBarDelegate {
    var book: Book?
 
    var bookImageView = UIImageView(image: UIImage(named: "RagtimeBookCover"))
    var detailsView = UIView.newAutoLayoutView()
    
    var thumbNailImageView = UIImageView.newAutoLayoutView()
    var nameLabel = UILabel.newAutoLayoutView()
    var phoneIconImageView = UIImageView.newAutoLayoutView()
    var fbChatImageView = UIImageView.newAutoLayoutView()
    
    var bookTitleLabel = UILabel.newAutoLayoutView()
    var courseCodeLabel = UILabel.newAutoLayoutView()
    //var starRatingLabel =
    var priceLabel = UILabel.newAutoLayoutView()
    
    var detailsViewTopConstraint: NSLayoutConstraint!
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //bookTitleLabel.text = book?.title
        //courseCodeLabel.text = book?.course
        //priceLabel.text = String(book?.price)
        
        
        
        setupViews()
    }
    
    func setupViews() {
        
        detailsView.backgroundColor = UIColor.blackColor()
        detailsView.opaque = true
        detailsView.alpha = 0.8
        
        bookTitleLabel.font = UIFont.systemFontOfSize(19)
        bookTitleLabel.text = "Ragtime"
        bookTitleLabel.textColor = UIColor.whiteColor()
        
        courseCodeLabel.font = UIFont.systemFontOfSize(16)
        //courseCodeLabel.text = "ENC1102"
        courseCodeLabel.textColor = UIColor.whiteColor()
        
        //DO THIS FOR STAR RATINGS AS WELL
        priceLabel.font = UIFont.systemFontOfSize(16)
        //priceLabel.text = "$10"
        priceLabel.textColor = UIColor.whiteColor()
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGestureUp")
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        view.addGestureRecognizer(swipeUp)

        let swipeDown = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGestureDown")
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        view.addGestureRecognizer(swipeDown)
        
        view.addSubview(bookImageView)
        view.addSubview(detailsView)
        detailsView.addSubview(thumbNailImageView)
        detailsView.addSubview(nameLabel)
        detailsView.addSubview(phoneIconImageView)
        detailsView.addSubview(fbChatImageView)
        detailsView.addSubview(bookTitleLabel)
        detailsView.addSubview(courseCodeLabel)
        detailsView.addSubview(priceLabel)
    
        setupConstraints()
    }
    
    func setupConstraints() {
        bookImageView.autoPinEdgesToSuperviewEdges()
        
    
        
        detailsViewTopConstraint = detailsView.autoPinEdgeToSuperviewEdge(.Top, withInset: UIScreen.mainScreen().bounds.height - 40)
        detailsView.autoPinEdgeToSuperviewEdge(.Leading)
        detailsView.autoPinEdgeToSuperviewEdge(.Trailing)
        detailsView.autoPinEdgeToSuperviewEdge(.Bottom)
        
        bookTitleLabel.autoAlignAxisToSuperviewAxis(.Horizontal)
        bookTitleLabel.autoPinEdgeToSuperviewEdge(.Leading, withInset: 5)
        
        
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
        self.detailsViewTopConstraint.constant = UIScreen.mainScreen().bounds.height - 40
        UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
            self.view.layoutIfNeeded()
            }, completion: { finished in
                print("Basket doors closed!")
        })
        
    }
    
}