//
//  ResourceManager.swift
//  HackerBooks
//
//  Created by Iván Cayón Palacio on 1/7/16.
//  Copyright © 2016 KeepCoding. All rights reserved.
//

// La informacion que tenemos
let jsonFileName = "books_readable.json"
let jsonUrl="https://keepcodigtest.blob.core.windows.net/containerblobstest/"   // Url to get json file
let favoritesFile="favorites.txt"

import Foundation

enum FileSystemDirectory{
    case documentDirectory  // Documentos como por ejemplo json
    case cacheDirectory     // La cache para los recursos
}




//MARK: - User persistence
// Guarda en la persistencia que ya se cargo el json
func markFirstLaunch(to read: Bool){
    let persistencia = NSUserDefaults.standardUserDefaults()
    persistencia.setObject(read, forKey: "read")
    persistencia.synchronize()
}

// Resetea la persistencia para probar


// Indica si es la primera vez que se ejecutó
func isFirstLaunch()->Bool{
    let persistencia = NSUserDefaults.standardUserDefaults()
    let read = persistencia.objectForKey("read")
    if let read = read as? Bool{
        return read
    }else{
        return true
    }
}

//MARK: - JSON


// Esto descarga el json
func downloadJSONFile() throws -> NSData {
    
    //let data = NSData(contentsOfURL: NSURL(string: completeJSONUrl())!)

    let data = NSData(contentsOfURL: NSURL(string: "\(jsonUrl)\(jsonFileName)")!)
    
    guard let dat = data else{
        throw ErrorHackerBooks.urlResourceNotFound
    }
    try! saveJSONFile(withData: dat)
    return dat
}

func loadJSONFile() throws -> NSData{
    var url : NSURL
    var newUrl : NSURL
    do{
        try url = getUrlLocalFileSystem(fromPath: .documentDirectory)
        newUrl = url.URLByAppendingPathComponent(jsonFileName)
    }catch{
        throw ErrorHackerBooks.urlResourceNotFound
    }
    let datos = NSData(contentsOfURL: newUrl)
    guard let data = datos else{
        throw ErrorHackerBooks.urlResourceNotFound
    }
    return data
    
}

func downloadJSONifNeeded() throws  {
        // Si es la primera vez
    // Lo truco
    //markFirstLaunch(to: true)
    
    if isFirstLaunch()==true{
        do{
            try _ = downloadJSONFile()
            markFirstLaunch(to: false)
            
        }catch{
            throw ErrorHackerBooks.urlResourceNotFound
        }
    }
}

// Guarda el fichero
func saveJSONFile(withData data: NSData) throws {
    var url: NSURL
    var newUrl: NSURL
    do{
        try url = getUrlLocalFileSystem(fromPath: .documentDirectory)
        newUrl = url.URLByAppendingPathComponent(jsonFileName)
    }catch{
        throw ErrorHackerBooks.urlResourceNotFound
    }
    
    
    guard data.writeToURL(newUrl, atomically: true) else{
        print("No se pudo guardar")
        throw ErrorHackerBooks.urlResourceNotFound
        
    }
    
}






//MARK: Book Resources download
// Global load, remote or local
func loadResource(withUrl url: NSURL) throws -> NSData{
    var data : NSData
    do{
        data = try loadLocalResource(withUrl: url)
        return data
    }catch{
        // No esta en local, descargamos de remoto
        do{
            data = try loadRemoteResource(withUrl: url)
            // Fue bien asi que guardamos en disco
            try saveResource(withUrl: url, andData: data)
            return data
        }
        catch{
            throw ErrorHackerBooks.urlResourceNotFound
        }
    }
    
}

// Load resource from local
func loadLocalResource(withUrl remoteUrl: NSURL) throws -> NSData{
    do{
        
        let path = try getUrlLocalFileSystem(fromPath: .cacheDirectory)
        guard let fileName = remoteUrl.lastPathComponent else{
            throw ErrorHackerBooks.wrongLocalResource
        }
        
        let newUrl = path.URLByAppendingPathComponent(fileName)
        let data = NSData(contentsOfURL: newUrl)
        guard let losDatos = data else{
            throw ErrorHackerBooks.wrongLocalResource
        }
        return losDatos
    }
    catch{
        throw ErrorHackerBooks.wrongLocalResource
    }
}

// Load Remote resource
func loadRemoteResource(withUrl url: NSURL) throws -> NSData{
    let data = NSData(contentsOfURL: url)
    guard let dat = data else{
        throw ErrorHackerBooks.urlResourceNotFound
    }
    return dat
}
    
   
 // Save resource
func saveResource(withUrl url: NSURL, andData data: NSData) throws {
    var newUrl: NSURL
    let path = try! getUrlLocalFileSystem(fromPath: .cacheDirectory)
    newUrl = (path.URLByAppendingPathComponent(url.lastPathComponent!))
    guard data.writeToURL(newUrl, atomically: true) else{
        print("No se pudo guardar")
        throw ErrorHackerBooks.urlResourceNotFound
    }
}

//MARK: - Favorites

func loadFavoritesFile() -> Set<String> {
    var elSet = Set<String>()
    var url : NSURL
    var newUrl : NSURL
    
    try! url = getUrlLocalFileSystem(fromPath: .documentDirectory)
    newUrl = url.URLByAppendingPathComponent(favoritesFile)
    
    
    let elArray = NSArray(contentsOfURL: newUrl)     // Si no hay nada devuelvo vacio el set
    guard let a = elArray else{
        return elSet
    }
    for b in a{
        elSet.insert(b as! String)
    }
    return elSet
}

func saveFavoritesFile(withFile file: Set<String>){
    var listaStrings = [String]()
    for i in file{
        listaStrings.append(i)
    }
    var url: NSURL
    var newUrl : NSURL
    try! url = getUrlLocalFileSystem(fromPath: .documentDirectory)
    newUrl = url.URLByAppendingPathComponent(favoritesFile)
    let elArray : NSArray = listaStrings as NSArray
    elArray.writeToURL(newUrl, atomically: true)
    
}



    
//MARK: - Utils
func getUrlLocalFileSystem(fromPath path: FileSystemDirectory) throws -> NSURL{
    let fm = NSFileManager.defaultManager()
    
    var url: NSURL?
    switch path {
    case .cacheDirectory:
         url = fm.URLsForDirectory(NSSearchPathDirectory.CachesDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask).last
        
    case .documentDirectory:
        url = fm.URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask).last
    }
       guard let laUrl = url else{
        throw ErrorHackerBooks.urlResourceNotFound
    }
    return laUrl
}
   

