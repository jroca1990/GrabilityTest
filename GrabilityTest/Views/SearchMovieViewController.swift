//
//  SearchMovieViewController.swift
//  GrabilityTest
//
//  Created by Jorge on 11/29/17.
//  Copyright © 2017 Jorge. All rights reserved.
//

import UIKit
import SwiftSpinner

class SearchMovieViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    var moviewsToDisplay = [Movie]()
    @IBOutlet var table: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    let moviesSearchPresenter = MovieSearchPresenter()
    var currentPage = 1
    var totalPages:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesSearchPresenter.attachView(self)
        self.searchBar.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.moviewsToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath)
        let movie:Movie = moviewsToDisplay[indexPath.row]
        cell.textLabel?.text = movie.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if(indexPath.row == self.moviewsToDisplay.count - 1 && self.currentPage <= self.totalPages) {
            //load next page, more movies
            self.currentPage = currentPage+1
            moviesSearchPresenter.searchMovies(text: searchBar.text!, page: currentPage)
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.moviewsToDisplay.removeAll()
        self.currentPage = 1
        moviesSearchPresenter.searchMovies(text: searchBar.text!, page: currentPage)
        searchBar.resignFirstResponder()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showMovieDetail" {
            let indexPath = self.table.indexPathForSelectedRow
            let moview:Movie = moviewsToDisplay[indexPath!.row]
            let moviesDetailViewController = segue.destination as! MovieDetailViewController
            moviesDetailViewController.movie = moview
        }
    }
}

extension SearchMovieViewController: MoviesSearchView {
    func setMovies(movies: [Movie], totalPages:Int) {
        self.moviewsToDisplay = self.moviewsToDisplay + movies
        self.totalPages = totalPages
        self.table.reloadData()
    }
    
    func startLoading() {
        SwiftSpinner.show("searching movies...")
    }
    
    func finishLoading() {
        SwiftSpinner.hide()
    }
}

