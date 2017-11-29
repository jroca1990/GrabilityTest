//
//  MovieDetailViewController.swift
//  GrabilityTest
//
//  Created by Jorge on 11/28/17.
//  Copyright © 2017 Jorge. All rights reserved.
//

import UIKit
import SwiftSpinner
import ImageSlideshow

class MovieDetailViewController: UIViewController {
    var movie: Movie!
    let movieDetaikPresenter = MovieDetailPresenter()
    @IBOutlet var movieImages: ImageSlideshow!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var releaseDateLabel: UILabel!
    @IBOutlet var homePageLabel: UIButton!
    @IBOutlet var overviewPageTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        movieDetaikPresenter.attachView(self)
        movieDetaikPresenter.getMovieDetail(movie: self.movie);
        movieImages.activityIndicator = DefaultActivityIndicator()
        movieImages.slideshowInterval = 1.0
        movieImages.contentScaleMode = .scaleAspectFill
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MovieDetailViewController.didTap))
        movieImages.addGestureRecognizer(gestureRecognizer)
        // Do any additional setup after loading the view.
    }

    @objc func didTap() {
        movieImages.presentFullScreenController(from: self)
    }
    
    @IBAction func openUrl(sender: UIButton) {
        let urlString = sender.titleLabel?.text
        guard let url = URL(string: urlString!) else {
            return //be safe
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MovieDetailViewController: MovieDetailView {
    func setMovieDetails(movie: Movie) {
        self.titleLabel.text = movie.original_title
        self.releaseDateLabel.text = movie.release_date
        self.overviewPageTextView.text = movie.overview
        self.homePageLabel.setTitle(movie.homepage, for: .normal)
    }
    
    func startLoading() {
        SwiftSpinner.show("loading movies...")
    }
    
    func finishLoading() {
        SwiftSpinner.hide()
    }
    
    func setMovieImages(images: [String]) {
        var imagesSource:[AlamofireSource] = [AlamofireSource]()
        for image in images {
            imagesSource.append(AlamofireSource(urlString: Constants.IMAGE_HOST + image)!)
        }
        
        movieImages.setImageInputs(imagesSource)
    }

}
