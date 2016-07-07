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
    
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    init(model: Book){
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Sync View & Model
    func syncModelWithView(){
        
        activityView.startAnimating()
        activityView.hidden = false

        // Lanza en background, para que deje actualizar el UIView
        downloadPDF()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - View life cycle
    override func viewDidLoad(){
        super.viewDidLoad()
        
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        syncModelWithView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillDisappear(animated)
        // Delegado de aviso
        pdfViewer.delegate = self
        
        let nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self, selector: #selector(bookDidChange), name: BookDidChangeNotification, object: nil)
        //syncModelWithView()
        
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
//MARK: - Extension UIWebViewDelegate
extension ReaderViewController: UIWebViewDelegate{
    func webViewDidFinishLoad(webView: UIWebView) {
        activityView.stopAnimating()
        activityView.hidden = true
    }
}
//MARK: - Extension GCD
extension ReaderViewController{
    func downloadPDF(){
        let  download = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0)
        let elBloque : dispatch_block_t = {
            guard let pdf = self.model.pdfFile else{
                self.pdfViewer.loadHTMLString("<H1> Error loading pdf </H1>", baseURL: NSURL())
                return
            }
            self.pdfViewer.loadData(pdf,
                               MIMEType: "application/pdf",
                               textEncodingName: "UTF-8",
                               baseURL: NSURL())

        }
        dispatch_async(download, elBloque)
        
    }
}
//MARK: - GCD


