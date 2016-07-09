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
    
    @IBAction func selectOrderChange(sender: AnyObject) {
        
        self.theTable.sortModel = LibraryViewController.SortingModes(rawValue: sender.selectedSegmentIndex)!
        self.theTable.tableView.reloadData()
        self.tableView.reloadData()
        
    }
    
    //MARK: - Properties
    let theTable : LibraryViewController
    
    //MARK: - Initializations
    
    init(withTable table: LibraryViewController){
        self.theTable = table
        super.init(nibName: "SetOrderView", bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.selectOrder.setTitle("Sort by Tag", forSegmentAtIndex: 0)
        self.selectOrder.setTitle("Sort by title", forSegmentAtIndex: 1)
        
        // El delegado para los datos la propia clase
        self.tableView.dataSource = self
        // El delegado para seleccionar elementos, etc...
        self.tableView.delegate = self
        
        let cellNib = UINib(nibName: "BookCellViewTableViewCell", bundle: nil)
        self.tableView.registerNib(cellNib, forCellReuseIdentifier: "CellBook")
        
        tableView.rowHeight = self.theTable.tableView(tableView, heightForRowAtIndexPath: NSIndexPath(index: 0))
        
        // Le digo a la tabla original que soy su delegado para actualizar rápido los fav
        self.theTable.delegate = self
        
        // Cambio algún formato de la tabla
        self.tableView.separatorStyle = .SingleLine
        self.tableView.separatorColor = UIColor.blueColor()
        
        self.title = "Library"
        
    

    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
         edgesForExtendedLayout = .None
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
//MARK: - Extension TableDataSource
extension SetOrderView: UITableViewDataSource {
   
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return theTable.numberOfSectionsInTableView(tableView)
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return theTable.tableView(tableView, numberOfRowsInSection: section)
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
    
    
}
//MARK: - Delegates
extension SetOrderView: UITableViewDelegate{
    // Table View select row
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        theTable.tableView(tableView, didSelectRowAtIndexPath: indexPath)
    }
    
    // Format
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if (theTable.model.favorites.count>0){
            if section==0{
                view.tintColor = UIColor.redColor()
            }
            else{
                view.tintColor = UIColor.blueColor()
            }
        }
        else{
            view.tintColor = UIColor.blueColor()
        }
        
        let header : UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.whiteColor()
        header.textLabel?.textAlignment = NSTextAlignment.Center
    }

}

extension SetOrderView: LibraryViewControllerDelegate{
    func libraryViewController(vc: LibraryViewController, needReload reload: Bool) {
        self.tableView.reloadData()
    }
}

