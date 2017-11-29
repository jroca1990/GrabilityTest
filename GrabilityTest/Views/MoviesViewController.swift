//
//  MoviesViewController.swift
//  GrabilityTest
//
//  Created by Jorge on 11/23/17.
//  Copyright © 2017 Jorge. All rights reserved.
//

import UIKit
import SwiftSpinner

class MoviesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var category: Category!
    let moviesPresenter = MoviesPresenter()
    var moviewsToDisplay = [Movie]()
    var currentPage = 1
    var totalPages:Int = 0
    @IBOutlet var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        moviesPresenter.attachView(self)
        moviesPresenter.getMovies(category: self.category, page: currentPage);
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviewsToDisplay.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! MovieCollectionViewCell
        let movie = moviewsToDisplay[indexPath.row]
        cell.diplayContent(imageUrl: Constants.IMAGE_HOST+movie.poster_path!,movieTitle:movie.title!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if(indexPath.row == self.moviewsToDisplay.count - 1 && self.currentPage <= self.totalPages) {
            //load next page, more movies
            self.currentPage = currentPage+1
            moviesPresenter.getMovies(category: self.category, page: self.currentPage);
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.size.width - 60) / 2
        return CGSize(width: width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        let width = (self.view.frame.size.width - 60) / 2

        let totalCellWidth = Int(width) * 2
        let totalSpacingWidth = 10 * (2 - 1)
        
        let leftInset = (self.view.frame.size.width - CGFloat(totalCellWidth+totalSpacingWidth)) / 2
        let rightInset = leftInset
        
        return UIEdgeInsets(top:                                                                                                                                                                                                                                                                                                                          0, left: leftInset, bottom: 0, right: rightInset)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showMovieDetail" {
            let indexPaths : NSArray = collectionView.indexPathsForSelectedItems! as NSArray
            let index : IndexPath = indexPaths[0] as! IndexPath
            let moview:Movie = moviewsToDisplay[index.row]
            let moviesDetailViewController = segue.destination as! MovieDetailViewController
            moviesDetailViewController.movie = moview
        }
    }
}

extension MoviesViewController: MoviesView {
    func setMovies(movies: [Movie], totalPages:Int) {
        self.moviewsToDisplay = self.moviewsToDisplay + movies
        self.totalPages = totalPages
        self.collectionView.reloadData()
        self.moviesPresenter.saveMovies(movies: movies, category: self.category)
    }
    
    func startLoading() {
        SwiftSpinner.show("loading movies...")
    }
    
    func finishLoading() {
        SwiftSpinner.hide()
    }
}
