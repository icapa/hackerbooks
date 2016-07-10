//
//  LibraryViewController.swift
//  HackerBooks
//
//  Created by Iván Cayón Palacio on 4/7/16.
//  Copyright © 2016 KeepCoding. All rights reserved.
//

import UIKit

let BookDidChangeNotification = "Selected book did change"
let BookKey = "Key"


class LibraryViewController: UITableViewController {

    //MARK: - Properties
    let model : Library
    var sortModel : SortingModes
    
    
    //MARK: - Initialization
    init(model: Library){
        self.model = model
        self.sortModel = .tags
        super.init(nibName: nil, bundle: nil)
        // Celda personalizada
        let cellNib = UINib(nibName: "BookCellViewTableViewCell", bundle: nil)
        self.tableView.registerNib(cellNib, forCellReuseIdentifier: "CellBook")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        edgesForExtendedLayout = .None
        
        
    }
    
    //MARK: Tabke view delegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var book : Book?
        
        if self.model.bookCountForTag("Favorites") > 0 {  // Hay favoritos
            if indexPath.section == 0 { // Nos pide libro de favoritos
                book = model.bookAtIndex(indexPath.row, tag: "Favorites")
            }else{
                // Dependiendo del modelo
                switch self.sortModel {
                case .tags:
                    book = model.bookAtIndex(indexPath.row, tag: model.tags!.tagToOrderArray()[indexPath.section-1])
                case .books:
                    book = model.bookAtIndexGlobal(indexPath.row)
                }
                
            }
        }else{
            switch self.sortModel {
            case .tags:
                book = model.bookAtIndex(indexPath.row, tag: model.tags!.tagToOrderArray()[indexPath.section])
            case .books:
                book = model.bookAtIndexGlobal(indexPath.row)
            }
            
        }
        
        // Enviamos la notificacion
        let nc = NSNotificationCenter.defaultCenter()
        let notif = NSNotification(name: BookDidChangeNotification,
                                   object: self, userInfo: [BookKey:book!])
        nc.postNotification(notif)
        
    }
    
    
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if self.model.bookCountForTag("Favorites") > 0{
            switch self.sortModel {
            case .tags:
                return model.tagsCount+1
            case .books:
                return 2
            }
            
        }
        else{
            switch self.sortModel {
            case .tags:
                return model.tagsCount
            case .books:
                return 1
            }
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.model.bookCountForTag("Favorites") > 0 {
            if section == 0{
                return model.bookCountForTag("Favorites")
            } else{
                switch self.sortModel {
                case .tags:
                    return model.bookCountForTag(model.tags!.tagToOrderArray()[section-1])
                case .books:
                    return model.completeDict["all"]!.count
                }
            }
        }
        else{
            switch self.sortModel {
            case .tags:
                return model.bookCountForTag(model.tags!.tagToOrderArray()[section])
            case .books:
                return model.completeDict["all"]!.count
            }
            
        }
            
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var book : Book?
        if self.model.bookCountForTag("Favorites") > 0 {
            if indexPath.section == 0{
                book = model.bookAtIndex(indexPath.row, tag: "Favorites")
            }else{
                switch self.sortModel {
                case .tags:
                    book = model.bookAtIndex(indexPath.row,
                                             tag: model.tags!.tagToOrderArray()[indexPath.section-1])
                case .books:
                    book = model.bookAtIndexGlobal(indexPath.row)
                }
               
            }
        }else{
            switch self.sortModel {
            case .tags:
                book = model.bookAtIndex(indexPath.row,
                                         tag: model.tags!.tagToOrderArray()[indexPath.section])
            case .books:
                book = model.bookAtIndexGlobal(indexPath.row)
            }
            
        }
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CellBook", forIndexPath: indexPath) as? BookCellViewTableViewCell
        cell?.bookImg.image = book?.imgFile
        cell?.bookName.text = book?.title
        
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // Si hay favoritos la seccion 0 es la de favoritos
        if self.model.bookCountForTag("Favorites") > 0 {
            if section == 0 {
                return "Favorites"
            }else{
                switch sortModel {
                case .tags:
                    return model.tags!.tagToOrderArray()[section-1]
                case .books:
                    return "Book List"
                }
                
            }
        }
        else{
            switch sortModel {
            case .tags:
                return model.tags!.tagToOrderArray()[section]
            case .books:
                return "Book List"
            }
            
        }
    }
    
    //MARK: - Table presentation
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath)->CGFloat{
        return 75.0
    }
    
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
     
        if model.favorites.count>0{
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
    
       
     
        let title = UILabel()
        title.textColor = UIColor.whiteColor()
        title.textAlignment = NSTextAlignment.Left
     
    
     
        let header : UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        
        header.textLabel?.textColor = title.textColor
        header.textLabel?.textAlignment = title.textAlignment
 
    }
    
}
//MARK: - Extension Delegate
extension LibraryViewController:  BookViewControlerDelegate{
    func bookViewControler(vc: BookViewController, didSelectBook book: Book){
        if book.isFavorite == true{
            model.addBookInTag("Favorites", withBook: book)
            model.favorites.insert(book.title)
        }else{
            model.remoteBookInTag("Favorites", withBook: book)
            model.favorites.remove(book.title)
        }
        
        // El fichero guarda
        saveFavoritesFile(withFile: model.favorites)
        
        
        self.tableView.reloadData()
    }
    
}
//MARK: - Extension order
extension LibraryViewController{
    enum SortingModes : Int{
        case tags   =   0
        case books  =   1
    }
}



