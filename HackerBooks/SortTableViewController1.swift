//
//  SortTableTableViewController.swift
//  HackerBooks
//
//  Created by Iván Cayón Palacio on 6/7/16.
//  Copyright © 2016 KeepCoding. All rights reserved.
//

import UIKit

class SortTableViewController: UITableViewController {
    
    @IBOutlet weak var orderSelector: UISegmentedControl!
    
    // MARK - Properties
    let theTable : LibraryViewController
    
    // MARK: - Init
    init(withTable table: LibraryViewController){
        self.theTable = table
        super.init(nibName: "SortTableViewController", bundle: nil)
        
        // Celda personalizada
        let cellNib = UINib(nibName: "BookCellViewTableViewCell", bundle: nil)
        self.tableView.registerNib(cellNib, forCellReuseIdentifier: "CellBook")

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return theTable.numberOfSectionsInTableView(tableView)
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return theTable.tableView(tableView, numberOfRowsInSection: section)
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        theTable.tableView(tableView, didSelectRowAtIndexPath: indexPath)
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return theTable.tableView(tableView, cellForRowAtIndexPath: indexPath)
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return theTable.tableView(tableView, titleForHeaderInSection: section)
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.reloadData()
        
    }
    
    // MARK - Heigh
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath)->CGFloat{
        return self.theTable.tableView(tableView, heightForRowAtIndexPath: indexPath)
    }
    
    
}
//MARK: - Extension Delegate
extension SortTableViewController:  BookViewControlerDelegate{
    func bookViewControler(vc: BookViewController, didSelectBook book: Book){
        self.theTable.bookViewControler(vc, didSelectBook: book)
        self.tableView.reloadData()
        
    }
}

