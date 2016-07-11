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

    //@IBOutlet weak var tableView: UITableView!
    
    @IBAction func selectOrderChange(sender: AnyObject) {
        
        self.theTable.sortModel = LibraryViewController.SortingModes(rawValue: sender.selectedSegmentIndex)!
        self.theTable.tableView.reloadData()
        //self.tableView.reloadData()
        
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
        self.title = "Library"
        
        self.selectOrder.layer.cornerRadius = 0.0
        self.selectOrder.layer.borderWidth = 0
        // En un subview meto el LibraryController que tengo hecho
        addTableControllerView()
       
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
         edgesForExtendedLayout = .None
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Add Subview
    func addTableControllerView(){
        
        let segBounds = self.selectOrder.bounds
        let totalBounds = self.navigationController?.view.bounds
        
        
        
        
        //let position = CGPoint(x: segBounds.origin.x, y: segBounds.origin.y+segBounds.size.height)
        let position = CGPoint(x: segBounds.origin.x, y: segBounds.origin.y+segBounds.size.height/2)
        let totalSpace = CGSize(width: segBounds.size.width,
                                height: totalBounds!.size.height)
        
        // Hasta aquí calculo donde dibujar la vista
        let cgRect = CGRect(origin: position, size: totalSpace)
        
        let tV = UIScrollView(frame: cgRect)
       
        // Modifico los bordes del tableView para que se ajuste bien
        self.theTable.tableView.frame = tV.frame
        self.theTable.tableView.bounds = tV.bounds
        
        // Añado la subvista al uiview intermedio
        tV.addSubview(self.theTable.tableView)
        
        // Inserto la vista en el uiview principal
        self.view.addSubview(tV)
    }

    
}
