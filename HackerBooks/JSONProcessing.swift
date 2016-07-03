//
//  JSONProcessing.swift
//  HackerBooks
//
//  Created by Iván Cayón Palacio on 2/7/16.
//  Copyright © 2016 KeepCoding. All rights reserved.
//

import Foundation
import UIKit

/* La forma del json
 
 "authors": "Scott Chacon, Ben Straub",
 "image_url": "http://hackershelf.com/media/cache/b4/24/b42409de128aa7f1c9abbbfa549914de.jpg",
 "pdf_url": "https://progit2.s3.amazonaws.com/en/2015-03-06-439c2/progit-en.376.pdf",
 "tags": "version control, git",
 "title": "Pro Git"
 
 */

//MARK: - Aliases
// Para representar un JSON usamos estos tres objetos

typealias JSONObject        = AnyObject
typealias JSONDictionary    = [String: JSONObject]
typealias JSONArray         = [JSONDictionary]



// Devuelve un libro

func decode (book json: JSONDictionary) throws -> Book{
    guard let authorsStr = json["authors"] as? String,
    imageUrl = NSURL(string: (json["image_url"] as? String)!),
    pdfUrl = NSURL(string: (json["pdf_url"] as? String)!),
    theTags = json["tags"] as? String,
        theTitle = json["title"] as? String else{
            throw ErrorHackerBooks.wrongJSONFormat
    }
    // Aqui se supone que hay valores correctos
    // Habrá que descargar los que no estén
    
    let authorsList = authorsStr.characters.split(",").map(String.init)
    
    
    // Convertimos primero los tags, tenemos una clase para ello
    // Quito los espacios al final y principio
    
    let arrayTags = theTags.characters.split(",").map(String.init)
    var extraArray = [String]()
    for t in arrayTags{
        extraArray.append(t.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()))
    }
    
    let tag = Tags(withTags: extraArray)
    
    // Descargamos o leemos la imagen
    
    // Descargamos o leemos el pdf
    var theImage : UIImage?
    do{
        let imageData = try loadResource(withUrl: imageUrl)
        theImage = UIImage(data: imageData)!
        
    }catch{
        theImage=nil
    }
    var pdfData : NSData?
    do{
        pdfData = try loadResource(withUrl: pdfUrl)
    }catch{
        pdfData=nil
    }
    
    return Book(title: theTitle, authors: authorsList, tags: tag, image: theImage, pdf: pdfData)
    
    

}


func loadJSONFromLocalFile() throws -> JSONArray{
    var data : NSData
    do{
        try data = loadJSONFile()
        if let maybeArray = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? JSONArray,
            array = maybeArray{
                return array
        } else{
            throw ErrorHackerBooks.wrongJSONFormat
        }
        
    }
    catch{
        throw ErrorHackerBooks.wrongJSONFormat
    }
    
}




