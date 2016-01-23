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
    @IBOutlet weak var ratingStarsView: CosmosView!
    
    
}
