//
//  CategoryTableViewController.swift
//  GrabilityTest
//
//  Created by Jorge on 11/22/17.
//  Copyright © 2017 Jorge. All rights reserved.
//

import UIKit
import SwiftSpinner

class CategoryTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var table: UITableView!
    let categoryPresenter = CategoryPresenter()
    var categoriesToDisplay = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryPresenter.attachView(self)
        categoryPresenter.getCategories()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesToDisplay.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)

        let category:Category = categoriesToDisplay[indexPath.row]
        cell.textLabel?.text = category.name

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMovies" {
            let indexPath = self.table.indexPathForSelectedRow
            let category:Category = categoriesToDisplay[indexPath!.row]
            let moviesViewController = segue.destination as! MoviesViewController
            moviesViewController.category = category
        }
    }
}

extension CategoryTableViewController: CategoriesView {
    func setCategories(categories: [Category]) {
        categoriesToDisplay = categories
        table?.reloadData()
    }
    
    func startLoading() {
        SwiftSpinner.show("loading categories...")
    }
    
    func finishLoading() {
        SwiftSpinner.hide()
    }
}
