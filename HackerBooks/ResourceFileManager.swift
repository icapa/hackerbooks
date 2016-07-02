//
//  ResourceManager.swift
//  HackerBooks
//
//  Created by Iván Cayón Palacio on 1/7/16.
//  Copyright © 2016 KeepCoding. All rights reserved.
//

import Foundation



class ResourceFileManager {
    let jsonFileName    : String
    var jsonUrl         : String
    var jsonData        : NSData?
    
    
    //MARK: - Initialitation
    init(jsonFileName: String, jsonUrl: String){
        self.jsonFileName   = jsonFileName
        self.jsonUrl        = jsonUrl
        
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
        let data = NSData(contentsOfURL: NSURL(string: "https://keepcodigtest.blob.core.windows.net/containerblobstest/books_readable.json")!)
        
        guard let dat = data else{
            throw ErrorHackerBooks.urlResourceNotFound
        }
        
        self.jsonData = dat
        try! saveJSONFile(withData: dat)
        return dat
    }
    
    func loadJSONFile() throws -> NSData{
        var url : NSURL
        var newUrl : NSURL
        do{
            try url = getUrlLocalFileSystem()
            newUrl = url.URLByAppendingPathComponent(self.jsonFileName)
        }catch{
            throw ErrorHackerBooks.urlResourceNotFound
        }
        let datos = NSData(contentsOfURL: newUrl)
        guard let data = datos else{
            throw ErrorHackerBooks.urlResourceNotFound
        }
        return data
        
    }
    
    func descargaJSON() throws {
        
        // Si es la primera vez
        if isFirstLaunch()==true{
            do{
                try self.jsonData = downloadJSONFile()
                markFirstLaunch(to: false)
            }catch{
                self.jsonData=nil
            }
        }else{
            do{
                try self.jsonData = loadJSONFile()
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
            try url = getUrlLocalFileSystem()
            newUrl = url.URLByAppendingPathComponent(self.jsonFileName)
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
            
            let path = try getUrlLocalFileSystem()
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
        let path = try! getUrlLocalFileSystem()
        newUrl = (path.URLByAppendingPathComponent(url.lastPathComponent!))
        guard data.writeToURL(newUrl, atomically: true) else{
            print("No se pudo guardar")
            throw ErrorHackerBooks.urlResourceNotFound
        }
    }
   
    
    //MARK: - Utils
    func getUrlLocalFileSystem() throws -> NSURL{
        let fm = NSFileManager.defaultManager()
        
        var url: NSURL?
        
        url = fm.URLsForDirectory(NSSearchPathDirectory.CachesDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask).last
        guard let laUrl = url else{
            throw ErrorHackerBooks.urlResourceNotFound
        }
        return laUrl
    }
   
}

