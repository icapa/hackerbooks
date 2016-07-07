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
    
    var setOrder : UISegmentedControl
    
    //MARK: - Initialization
    init(model: Library){
        self.model = model
        setOrder = UISegmentedControl(items: ["Tags","Books"])
        
        super.init(nibName: nil, bundle: nil)
        // Celda personalizada
        let cellNib = UINib(nibName: "BookCellViewTableViewCell", bundle: nil)
        self.tableView.registerNib(cellNib, forCellReuseIdentifier: "CellBook")
        
        // Esto aparece pero hace scroll
        //self.tableView.tableHeaderView = setOrder
        
        
        
       
        setOrder.selectedSegmentIndex = 0
        
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    func addHeaderView(){
        let yPos = (self.navigationController?.navigationBar.frame.origin.y)! +
            (self.navigationController?.navigationBar.frame.size.height)!
        
        let mainHeaderView = UIView()
        mainHeaderView.addSubview(setOrder)
        mainHeaderView.frame = CGRectMake(0, yPos, self.view.frame.size.width, 44.0)
        //mainHeaderView.backgroundColor = UIColor.redColor()
        self.tableView.superview?.addSubview(mainHeaderView)
        //self.tableView.superview?.addSubview(setOrder)
        self.tableView.contentInset=UIEdgeInsetsMake(yPos+44.0,
                                                     self.tableView.contentInset.left, self.tableView.contentInset.bottom, self.tableView.contentInset.right)
        
 
    }
    */
    /*
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        addHeaderView()
    }
    */
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        edgesForExtendedLayout = .None
        
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //addHeaderView()
    }
    
    //MARK: Tabke view delegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var book : Book?
        
        if self.model.bookCountForTag("Favorites") > 0 {  // Hay favoritos
            if indexPath.section == 0 { // Nos pide libro de favoritos
                //delegate?.libraryViewController(self,
                //                                didSelectBook: model.bookAtIndex(indexPath.row, tag: "Favorites")!)
                book = model.bookAtIndex(indexPath.row, tag: "Favorites")
            }else{
                //delegate?.libraryViewController(self,
                //                                didSelectBook: model.bookAtIndex(indexPath.row,
                //                                    tag: model.tags!.tagToOrderArray()[indexPath.section-1])!)
                book = model.bookAtIndex(indexPath.row, tag: model.tags!.tagToOrderArray()[indexPath.section-1])
            }
        }else{
            //delegate?.libraryViewController(self,
            //                                didSelectBook: model.bookAtIndex(indexPath.row,
            //                                    tag: model.tags!.tagToOrderArray()[indexPath.section])!)
            book = model.bookAtIndex(indexPath.row, tag: model.tags!.tagToOrderArray()[indexPath.section])
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
            return model.tagsCount+1
        }
        else{
            return model.tagsCount
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.model.bookCountForTag("Favorites") > 0 {
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
        //let cellId = "BookCell"
        var book : Book?
        if self.model.bookCountForTag("Favorites") > 0 {
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
        
        /* Esto es con celda estándar */
        /*
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId)
        if (cell==nil){
            // Opcional vacio se crea a pelo
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: cellId)
        }
        // Sincronizamos personaje -> celda
        cell?.imageView?.image = book?.imgFile
        cell?.textLabel?.text = book?.title
        cell?.detailTextLabel?.text = book?.authors.description
        */
        
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
                return model.tags!.tagToOrderArray()[section-1]
            }
        }
        else{
            return model.tags!.tagToOrderArray()[section]
        }
    }
    
    //MARK: - Table presentation
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath)->CGFloat{
        return 80.0
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
        // Habría que guardar en fichero para la siguiente vez
        
        // El fichero guarda 
        
        saveFavoritesFile(withFile: model.favorites)
    
        
        self.tableView.reloadData()
        
        
    }
}


