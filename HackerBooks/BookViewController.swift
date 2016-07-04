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
        self.authorsView.text = model.authors.description
        //TODO: Esto lo tengo que dejar más bonito
        
    }
    
    
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var authorsView: UILabel!
    
    
    @IBAction func markFavorite(sender: AnyObject) {
    }
    
    @IBAction func readBook(sender: AnyObject) {
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.syncModelWithView()
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
