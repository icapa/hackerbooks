//
//  BookViewController.swift
//  HackerBooks
//
//  Created by Iván Cayón Palacio on 4/7/16.
//  Copyright © 2016 KeepCoding. All rights reserved.
//

import UIKit

class BookViewController: UIViewController {

    //MARK: - Properties
    var model: Book
    
    var delegate: BookViewControlerDelegate?
    
    //MARK: - Initialization
    init(model: Book){
        self.model=model
        super.init(nibName: "BookViewController", bundle: nil)
    }
    

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func syncModelWithView(){
        
        
        // La imagen
        self.imageView.image = model.imgFile
        
        // El titulo
        self.titleView.text = model.title
        
        // Los autores
        self.authorsView.text = "Authors: \(model.authors.description)"
        
        // Los tags
        self.tagsView.text = "Tags: \(model.tags.tagToOrderArray().description)"
        
        // Favorito
        favButton.titleLabel?.hidden=true

        if model.isFavorite == true {
            favButton.setBackgroundImage(UIImage(named: "favorito.jpeg"), forState: UIControlState.Normal)
            //favButton.setTitle("No Fav", forState: UIControlState.Normal)
            //favButton.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)

        }else{
            favButton.setBackgroundImage(UIImage(named: "no_favorito.png"), forState: UIControlState.Normal)
            //favButton.setTitle("Favorite", forState: UIControlState.Normal)
            //favButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        }
        
        
    }
    
    @IBOutlet weak var tagsView: UILabel!
    
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var favButton: UIButton!
    
    @IBOutlet weak var authorsView: UILabel!
    
    @IBOutlet weak var imageBoot: UIImageView!
    //MARK: IB Actions Fav & Read
    
    @IBAction func markFavorite(sender: AnyObject) {
        if model.isFavorite == false {
            model.setFavorite(true)
        }else{
            model.setFavorite(false)
        }
        syncModelWithView()
        // Mando al delegado el libro que quiero meter o quitar
        delegate?.bookViewControler(self, didSelectBook: model)
        
        
    }
    
    @IBAction func readBook(sender: AnyObject) {
        let pdfReader = ReaderViewController(model: model)
        navigationController?.pushViewController(pdfReader, animated: true)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                // Do any additional setup after loading the view.
        favButton.titleLabel?.hidden=true
        self.title = "Book properties"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self, selector: #selector(bookDidChange), name: BookDidChangeNotification, object: nil)
        edgesForExtendedLayout = .None
        self.syncModelWithView()
    }
    
    //MARK: Notification
    func bookDidChange(notification: NSNotification){
        // La info de la notificacion
        let info = notification.userInfo
        let book = info![BookKey] as? Book
        model = book!
        // Quitamos la portada
        if self.imageBoot.hidden == false {
            self.imageBoot.hidden = true
        }

        syncModelWithView()
    }
}
//MARK: - Delegate
protocol BookViewControlerDelegate{
    func bookViewControler(vc: BookViewController, didSelectBook book: Book)
}
