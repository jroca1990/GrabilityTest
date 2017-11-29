//
//  MovieViewCellCollectionViewCell.swift
//  GrabilityTest
//
//  Created by Jorge on 11/23/17.
//  Copyright © 2017 Jorge. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet var movieImage: UIImageView!
    @IBOutlet var movieTitle: UILabel!

    func diplayContent(imageUrl:String, movieTitle:String) {
        let url = URL(string: imageUrl)!
        self.movieImage.image = nil
        self.movieImage.af_setImage(withURL: url)
        self.movieTitle.text = movieTitle
    }
}
