//
//  BookDetailsViewController.swift
//  NewTextExchange
//
//  Created by Eric Suarez on 1/23/16.
//  Copyright © 2016 Eric Suarez. All rights reserved.
//

import UIKit
import Cosmos

class BookDetailsViewController: UIViewController {
    
    @IBOutlet weak var bookCoverImageView: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var courseNumberLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var contactInfoButton: UIBarButtonItem!
    @IBOutlet weak var ratingStarsView: CosmosView!
    @IBOutlet var priceLabel: UILabel!
    
    
    var singleBook: Book?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        bookCoverImageView.setImageWithURL((singleBook?.coverImage)!)
        
        bookTitleLabel.text = singleBook?.title
        courseNumberLabel.text = singleBook?.course
        priceLabel.text = String(singleBook?.price)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //fix this
    @IBAction func showDetails(sender: AnyObject) {
        /*
        let xPosition = detailsView.frame.origin.x
        
        //View will slide 300px up
        let yPosition = detailsView.frame.origin.y - 500
        
        let height = detailsView.frame.size.height
        let width = UIScreen.mainScreen().bounds.width
        
        UIView.animateWithDuration(1.0, animations: {
    
            self.detailsView.frame = CGRectMake(xPosition, yPosition, height, width)
            
        })
        */
        
        
        
    }
    
    
    
    @IBAction func hideDetails(sender: AnyObject) {
        
        
        let xPosition = detailsView.frame.origin.x
        
        //View will slide 300px down
        let yPosition = detailsView.frame.origin.y + 300
        
        let height = detailsView.frame.size.height
        //let width = UIScreen.mainScreen().bounds.height
        
        UIView.animateWithDuration(1.0, animations: {
            
            self.detailsView.frame = CGRectMake(xPosition, yPosition, height, 375)
            
        })
        
        
    }
    

}
