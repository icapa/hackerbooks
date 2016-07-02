//
//  AppDelegate.swift
//  HackerBooks
//
//  Created by Iván Cayón Palacio on 30/6/16.
//  Copyright © 2016 KeepCoding. All rights reserved.
//

import UIKit

let jsonFileName = "books_readable.json"
let jsonUrl="https://keepcodigtest.blob.core.windows.net/containerblobstest/"   // Url to get json file





@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        
        
        //--- Todo esto hace la carga del fichero desde internet ---
        let res = ResourceFileManager(jsonFileName: jsonFileName,
                                  jsonUrl: jsonUrl)
        do{
            try res.descargaJSON()  // La descarga o lee de local, lo que haga falta
            let json = try loadFromLocalFile(resource: res)
            var theBooks = [Book]()
            for jsonBook in json{
                let book = try decode(book: jsonBook,resource: res)
                theBooks.append(book)
                
            }
            
            
        }catch{
            fatalError("Data couldn't be loaded")
        }
        
        
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

