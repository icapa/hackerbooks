//
//  LibraryViewController.swift
//  HackerBooks
//
//  Created by Iván Cayón Palacio on 4/7/16.
//  Copyright © 2016 KeepCoding. All rights reserved.
//

import UIKit



class LibraryViewController: UITableViewController {

    //MARK - Properties
    let model : Library
    
    //MARK - Delegate
    
    //MARK - Initialization
    init(model: Library){
        self.model = model
        super.init(nibName: nil, bundle: nil)
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
        if model.favorites.count>0{
            return model.tagsCount+1
        }
        else{
            return model.tagsCount
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if model.favorites.count>0 {
            if section == 0{
                return model.bookCountForTag("Favorites")
            } else{
                return model.bookCountForTag(model.tags!.tagToOrderArray()[section-1])
            }
        }
        else{
            return model.bookCountForTag(model.tags!.tagToOrderArray()[section])
        }
            
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Tipo de celda
        let cellId = "BookCell"
        var book : Book?
        if model.favorites.count>0 {
            if indexPath.section == 0{
                book = model.bookAtIndex(indexPath.row, tag: "Favorites")
            }else{
                book = model.bookAtIndex(indexPath.row,
                                         tag: model.tags!.tagToOrderArray()[indexPath.section-1])
            }
        }else{
            book = model.bookAtIndex(indexPath.row,
                                     tag: model.tags!.tagToOrderArray()[indexPath.section])
        }
        
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId)
        if (cell==nil){
            // Opcional vacio se crea a pelo
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: cellId)
        }
        // Sincronizamos personaje -> celda
        cell?.imageView?.image = book?.imgFile
        cell?.textLabel?.text = book?.title
        cell?.detailTextLabel?.text = book?.authors.description
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // Si hay favoritos la seccion 0 es la de favoritos
        if model.favorites.count>0 {
            if section == 0 {
                return "Favorites"
            }else{
                return model.tags!.tagToOrderArray()[section-1]
            }
        }
        else{
            return model.tags!.tagToOrderArray()[section]
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
