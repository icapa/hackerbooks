//
//  SetOrderView.swift
//  HackerBooks
//
//  Created by Iván Cayón Palacio on 7/7/16.
//  Copyright © 2016 KeepCoding. All rights reserved.
//

import UIKit

class SetOrderView: UIViewController {
    @IBOutlet weak var selectOrder: UISegmentedControl!

    @IBOutlet weak var tableView: UITableView!
    
    
    let theTable : LibraryViewController
    
    init(withTable table: LibraryViewController){
        self.theTable = table
        super.init(nibName: "SetOrderView", bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.dataSource = self
        let cellNib = UINib(nibName: "BookCellViewTableViewCell", bundle: nil)
        self.tableView.registerNib(cellNib, forCellReuseIdentifier: "CellBook")

    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
         edgesForExtendedLayout = .None
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension SetOrderView: UITableViewDataSource, UITableViewDelegate{
   
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return theTable.numberOfSectionsInTableView(tableView)
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return theTable.tableView(tableView, numberOfRowsInSection: section)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        theTable.tableView(tableView, didSelectRowAtIndexPath: indexPath)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return theTable.tableView(tableView, cellForRowAtIndexPath: indexPath)
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return theTable.tableView(tableView, titleForHeaderInSection: section)
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.reloadData()
        
    }
    
    // MARK - Heigh
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath)->CGFloat{
        return self.theTable.tableView(tableView, heightForRowAtIndexPath: indexPath)
    }
    //MARK: - Table presentation
   
    
    
  }