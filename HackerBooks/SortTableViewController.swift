//
//  SortTableViewController.swift
//  HackerBooks
//
//  Created by Iván Cayón Palacio on 6/7/16.
//  Copyright © 2016 KeepCoding. All rights reserved.
//

import UIKit

class SortTableViewController: UITableViewController {

    @IBOutlet weak var libraryTableView: UITableView!
    
    @IBOutlet weak var orderSelector: UISegmentedControl!
    
    //MARK: - Properties
    
    let theTable : LibraryViewController

    
    
    //MARK: - Initializacion
    init(withTable table: LibraryViewController){
        
        self.theTable = table
        
        super.init(nibName: "SortTableViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension SortTableViewController {
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

