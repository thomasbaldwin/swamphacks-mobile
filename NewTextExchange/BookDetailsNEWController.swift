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

class BookDetailsNEWController: UIViewController, UINavigationBarDelegate, MFMessageComposeViewControllerDelegate {
    var book: Book?
 
    var bookImageView = UIImageView(image: UIImage(named: "RagtimeBookCover"))
    var detailsView = UIView.newAutoLayoutView()
    
    var thumbnailImageView = UIImageView(image: UIImage(named: "ProfilePic"))
    var nameLabel = UILabel.newAutoLayoutView()
    var phoneImageButton = UIButton.newAutoLayoutView()
    var messageImageButton = UIButton.newAutoLayoutView()
    
    var bookTitleLabel = UILabel.newAutoLayoutView()
    var courseCodeLabel = UILabel.newAutoLayoutView()
    var ratingStarsView: CosmosView!
    var priceLabel = UILabel.newAutoLayoutView()
    
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
        
        phoneImageButton.setImage(UIImage(named: "PhoneIcon"), forState: .Normal)
        messageImageButton.setImage(UIImage(named: "MessageIcon"), forState: .Normal)
        payImageButton.setImage(UIImage(named: "PayIcon"), forState: .Normal)
        
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
        detailsView.addSubview(messageImageButton)
        detailsView.addSubview(payImageButton)
        detailsView.addSubview(bookTitleLabel)
        detailsView.addSubview(courseCodeLabel)
        detailsView.addSubview(priceLabel)
        
        
        
        phoneImageButton.addTarget(self, action: "callPhoneNumber", forControlEvents: UIControlEvents.TouchUpInside)
        messageImageButton.addTarget(self, action: "sendMessage", forControlEvents: UIControlEvents.TouchUpInside)
        payImageButton.addTarget(self, action: "venmoPaymentController", forControlEvents: UIControlEvents.TouchUpInside)
        
        
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
        nameLabel.autoPinEdge(.Trailing, toEdge: .Leading, ofView: phoneImageButton, withOffset: 10)
        
        phoneImageButton.autoAlignAxis(.Horizontal, toSameAxisOfView: thumbnailImageView)
        phoneImageButton.autoPinEdge(.Trailing, toEdge: .Leading, ofView: messageImageButton, withOffset: -15)
        
        messageImageButton.autoAlignAxis(.Horizontal, toSameAxisOfView: thumbnailImageView)
        messageImageButton.autoPinEdgeToSuperviewEdge(.Trailing, withInset: 20)

        bookTitleLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: thumbnailImageView, withOffset: 40)
        bookTitleLabel.autoPinEdge(.Leading, toEdge: .Leading, ofView: thumbnailImageView)
        
        courseCodeLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: bookTitleLabel, withOffset: 10)
        courseCodeLabel.autoPinEdge(.Leading, toEdge: .Leading, ofView: bookTitleLabel)
        
        
        priceLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: courseCodeLabel, withOffset: 10)
        priceLabel.autoPinEdge(.Leading, toEdge: .Leading, ofView: courseCodeLabel)
        
        payImageButton.autoPinEdge(.Top, toEdge: .Bottom, ofView: priceLabel, withOffset: 60)
        payImageButton.autoPinEdge(.Leading, toEdge: .Leading, ofView: priceLabel)
        
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
    
    func callPhoneNumber() {
        if let phoneCallURL:NSURL = NSURL(string:"telprompt://5614003685") {
            let application:UIApplication = UIApplication.sharedApplication()
            if (application.canOpenURL(phoneCallURL)) {
                application.openURL(phoneCallURL);
            }
        }
    }
    
    func sendMessage() {
        let messageVC = MFMessageComposeViewController()
        messageVC.body = "Message String"
        messageVC.recipients = ["5614003685"] // Optionally add some tel numbers
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
    
    func venmoPaymentController() {
        //self.performSegueWithIdentifier("about", sender: sender)
    }
    
    
    
}