//
//  BookDetailsNEWController.swift
//  NewTextExchange
//
//  Created by Brian Roytman on 1/23/16.
//  Copyright © 2016 Eric Suarez. All rights reserved.
//

import Foundation
import Cosmos
import MessageUI
import AFNetworking

class BookDetailsNEWController: UIViewController, UINavigationBarDelegate, MFMessageComposeViewControllerDelegate {
    var book: Book? {
        didSet {
            updateUI()
        }
    }
 
    var bookImageView = UIImageView()
    var detailsView = UIView.newAutoLayoutView()
    
    var thumbnailImageView = UIImageView(image: UIImage(named: "ProfilePic"))
    var nameLabel = UILabel.newAutoLayoutView()
    var phoneImageButton = UIButton.newAutoLayoutView()
    var facebookImageButton = UIButton.newAutoLayoutView()
    
    var bookTitleLabel = UILabel.newAutoLayoutView()
    var courseCodeLabel = UILabel.newAutoLayoutView()
    var ratingStarsView: CosmosView = CosmosView()
    var priceLabel = UILabel.newAutoLayoutView()
    var authorLabel = UILabel.newAutoLayoutView()
    var isbnLabel = UILabel.newAutoLayoutView()
    
    var detailsViewTopConstraint: NSLayoutConstraint!
    
    var payImageButton = UIButton.newAutoLayoutView()
    
    
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
        
        nameLabel.textColor = UIColor.whiteColor()
        
        bookTitleLabel.font = UIFont.boldSystemFontOfSize(19)
        bookTitleLabel.textColor = UIColor.whiteColor()
        
        courseCodeLabel.font = UIFont.systemFontOfSize(17)
        courseCodeLabel.textColor = UIColor.whiteColor()
        
        authorLabel.font = UIFont.systemFontOfSize(17)
        authorLabel.textColor = UIColor.whiteColor()
        
        isbnLabel.font = UIFont.systemFontOfSize(17)
        isbnLabel.textColor = UIColor.whiteColor()
        
        //DO THIS FOR STAR RATINGS AS WELL
        
        ratingStarsView.settings.updateOnTouch = false
        ratingStarsView.settings.fillMode = .Half
        
        phoneImageButton.setImage(UIImage(named: "PhoneIcon"), forState: .Normal)
        phoneImageButton.addTarget(self, action: "presentPhoneOptions", forControlEvents: UIControlEvents.TouchUpInside)
        
        facebookImageButton.setImage(UIImage(named: "FacebookIcon"), forState: .Normal)
        facebookImageButton.addTarget(self, action: "openFacebookProfile", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        //payImageButton.setImage(UIImage(named: "PayIcon"), forState: .Normal)
        
        payImageButton.backgroundColor = .orangeColor()
        payImageButton.setTitle("Purchase Book", forState: .Normal)
        payImageButton.hidden = true
        payImageButton.alpha = 1.0
        
        
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
        detailsView.addSubview(phoneImageButton)
        detailsView.addSubview(facebookImageButton)
        detailsView.addSubview(payImageButton)
        detailsView.addSubview(ratingStarsView)
        detailsView.addSubview(bookTitleLabel)
        detailsView.addSubview(courseCodeLabel)
        detailsView.addSubview(priceLabel)
        detailsView.addSubview(isbnLabel)
        detailsView.addSubview(authorLabel)
        setupConstraints()
    }
    
    func updateUI() {
        phoneImageButton.hidden = true
        
        guard let book = self.book else {
            return
        }
        
        if let bookTitle = book.title {
            bookTitleLabel.text = bookTitle
        }
        
        if let bookCourse = book.course {
            courseCodeLabel.text = bookCourse
        }
        
        if let bookAuthor = book.author {
            authorLabel.text = "Author: \(bookAuthor)"
        }
        
        if let isbn = book.isbn {
            isbnLabel.text = "ISBN: \(isbn)"
        }
        
        if let price = book.price {
            let priceFormatter = NSNumberFormatter()
            priceFormatter.numberStyle = .CurrencyStyle
            let formattedPrice = priceFormatter.stringFromNumber(price)
            priceLabel.font = UIFont.boldSystemFontOfSize(17)
            priceLabel.text = "Price: \(formattedPrice!)"
            priceLabel.textColor = UIColor.whiteColor()
        } else {
            priceLabel.font = UIFont.boldSystemFontOfSize(17)
            priceLabel.text = "Price: Best Offer"
            priceLabel.textColor = UIColor.whiteColor()
        }
        
        if let bookQuality = book.quality {
            ratingStarsView.rating = bookQuality
        }
        
        if let bookCoverImageURL = book.coverPhotoURL {
            Database.getImageFromURL(bookCoverImageURL).then{ image -> Void in
                self.bookImageView.image = image
            }.error { error -> Void in
                print(error)
            }
        }
        
        guard let creator = book.creator else {
            return
        }
        
        if let thumbnailPhotoURL = creator.thumbnailPhotoURL {
            Database.getImageFromURL(thumbnailPhotoURL).then{image -> Void in
                let aspectScaledToFillImage = image.af_imageAspectScaledToFillSize(CGSize(width: 40, height: 40))
                self.thumbnailImageView.image = aspectScaledToFillImage
            }.error{ error -> Void in
                print(error)
            }
        }
        
        if let firstName = creator.firstName,
            let lastName = creator.lastName {
                self.nameLabel.text = "\(firstName) \(lastName)"
        }
        
        if let _ = creator.phone {
            phoneImageButton.hidden = false
        }

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
        nameLabel.autoPinEdge(.Trailing, toEdge: .Leading, ofView: phoneImageButton, withOffset: 10)
        
        phoneImageButton.autoAlignAxis(.Horizontal, toSameAxisOfView: thumbnailImageView)
        phoneImageButton.autoPinEdge(.Trailing, toEdge: .Leading, ofView: facebookImageButton, withOffset: -15)
        
        facebookImageButton.autoAlignAxis(.Horizontal, toSameAxisOfView: thumbnailImageView)
        facebookImageButton.autoPinEdgeToSuperviewEdge(.Trailing, withInset: 20)

        bookTitleLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: thumbnailImageView, withOffset: 40)
        bookTitleLabel.autoPinEdge(.Leading, toEdge: .Leading, ofView: thumbnailImageView)
        
        authorLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: bookTitleLabel, withOffset: 40)
        authorLabel.autoPinEdge(.Leading, toEdge: .Leading, ofView: thumbnailImageView)
        
        courseCodeLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: authorLabel, withOffset: 10)
        courseCodeLabel.autoPinEdge(.Leading, toEdge: .Leading, ofView: thumbnailImageView)
        
        priceLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: courseCodeLabel, withOffset: 10)
        priceLabel.autoPinEdge(.Leading, toEdge: .Leading, ofView: thumbnailImageView)
        
        isbnLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: priceLabel, withOffset: 10)
        isbnLabel.autoPinEdge(.Leading, toEdge: .Leading, ofView: thumbnailImageView)
        
        ratingStarsView.autoPinEdge(.Top, toEdge: .Bottom, ofView: isbnLabel, withOffset: 10)
        ratingStarsView.autoPinEdge(.Leading, toEdge: .Leading, ofView: thumbnailImageView)

        
        payImageButton.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsZero, excludingEdge: .Top)
        payImageButton.autoSetDimension(.Height, toSize: 50)
    }
    
    func respondToSwipeGestureUp() {
        self.detailsViewTopConstraint.constant = 0
        UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
            self.view.layoutIfNeeded()
            self.payImageButton.hidden = false
        }, completion: { finished in
            print("Basket doors opened!")
        })
        
    }
    
    func respondToSwipeGestureDown() {
        self.detailsViewTopConstraint.constant = UIScreen.mainScreen().bounds.height - 124
        UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
            self.view.layoutIfNeeded()
            self.payImageButton.hidden = true
        }, completion: { finished in
            print("Basket doors closed!")
            
        })
        
    }
    
    func presentPhoneOptions() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        
        let callAction = UIAlertAction(title: "Call", style: .Default, handler: {(ACTION) in
            self.callPhoneNumber()
        })
        
        let sendMessageAction = UIAlertAction(title: "Send Text Message", style: .Default, handler: {(ACTION) in
            self.sendMessage()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        alertController.addAction(callAction)
        alertController.addAction(sendMessageAction)
        alertController.addAction(cancelAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func openFacebookProfile() {
        guard let facebookUID = book?.creator?.facebookUID else {
            return
        }
        
        
        
        let facebookURL = "http://facebook.com/\(facebookUID)"
        
        if UIApplication.sharedApplication().canOpenURL(NSURL(string: facebookURL)!) {
            print("should work")
            UIApplication.sharedApplication().openURL(NSURL(string: facebookURL)!)
            
        } else {
            print("doesnt")
            //redirect to safari because the user doesn't have Facebook
            UIApplication.sharedApplication().openURL(NSURL(string: facebookURL)!)
        }
    }
    
    func callPhoneNumber() {
        guard let creatorPhone = book?.creator?.phone else {
            return
        }
        
        UIApplication.sharedApplication().openURL(NSURL(string: "tel://\(creatorPhone)")!)

    }
    
    func sendMessage() {
        guard let creatorPhone = book?.creator?.phone,
            let firstName = book?.creator?.firstName else {
                return
        }
        
        let messageVC = MFMessageComposeViewController()
        messageVC.body = "Hey \(firstName)! I saw your textbook posted on OGBooks, I'm interested in purchasing it."
        messageVC.recipients = [creatorPhone] // Optionally add some tel numbers
        messageVC.messageComposeDelegate = self
        presentViewController(messageVC, animated: true, completion: nil)
    }
    
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        switch result.rawValue {
        case MessageComposeResultCancelled.rawValue :
            print("message canceled")
            
        case MessageComposeResultFailed.rawValue :
            print("message failed")
            
        case MessageComposeResultSent.rawValue :
            print("message sent")
            
        default:
            break
        }
        controller.dismissViewControllerAnimated(true, completion: nil)
    }

}