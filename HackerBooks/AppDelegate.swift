//
//  AppDelegate.swift
//  HackerBooks
//
//  Created by Iván Cayón Palacio on 30/6/16.
//  Copyright © 2016 KeepCoding. All rights reserved.
//

import UIKit







@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        do{
            try downloadJSONifNeeded()
        }catch{
            fatalError("Data couldn't be loaded")
        }
        
        // Modelos de la libraria
        let theLibrary = Library()
        let theBook = theLibrary.allBooks[0]    // Para pintar uno
        
        // Creamos el controlador de la libreria
        let libraryVc = LibraryViewController(model: theLibrary)
        
        // Creamos el controlador de la tabla ordenada
        let orderVc = SetOrderView(withTable: libraryVc)
        let uNavOrder = UINavigationController(rootViewController: orderVc)
        
        // Metemos en un nav
        // Esto es antes
        //let uNav = UINavigationController(rootViewController: libraryVc)
        
       
        
        
        // Creamos un book para que abra
        let bookVc = BookViewController(model: theBook)
        
        // Creamos el characterViewControler
        let bookNav = UINavigationController(rootViewController: bookVc)
        
        
        
        
        // Creamos un splitView y le endosamos los dos navs
        let splitVc = UISplitViewController()
        splitVc.viewControllers = [uNavOrder,bookNav]
        
        // Crear la ventana
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        // Asignamos nav como root View Controller
        window?.rootViewController = splitVc
        
        // Asignamos delegados...
        //bookVc.delegate = libraryVc
        bookVc.delegate = libraryVc
        
        // Mostramos la ventana
        window?.makeKeyAndVisible()
        
        //-- Tema de la ventanas
        
        
        
        
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

