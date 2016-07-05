//
//  ReaderViewController.swift
//  HackerBooks
//
//  Created by Iván Cayón Palacio on 5/7/16.
//  Copyright © 2016 KeepCoding. All rights reserved.
//

import UIKit

class ReaderViewController: UIViewController {
    
    //MARK: Properties
    var model : Book
    
    @IBOutlet weak var pdfViewer: UIWebView!
    
    init(model: Book){
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Sync View & Model
    func syncModelWithView(){
        guard let pdf = model.pdfFile else{
            pdfViewer.loadHTMLString("<H1> Error loading pdf </H1>", baseURL: NSURL())
            return
        }
        pdfViewer.loadData(pdf,
                          MIMEType: "application/pdf",
                          textEncodingName: "UTF-8",
                          baseURL: NSURL())
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - View life cycle
    override func viewDidLoad(){
        super.viewDidLoad()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillDisappear(animated)
        let nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self, selector: #selector(bookDidChange), name: BookDidChangeNotification, object: nil)
        syncModelWithView()
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    //MARK: - Notification
    func bookDidChange(notification: NSNotification){
        let info = notification.userInfo
        let book = info![BookKey] as? Book
        self.model = book!
        syncModelWithView()
    }

}
