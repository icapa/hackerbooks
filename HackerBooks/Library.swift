//
//  Library.swift
//  HackerBooks
//
//  Created by Iván Cayón Palacio on 3/7/16.
//  Copyright © 2016 KeepCoding. All rights reserved.
//

import Foundation
class Library {
    //MARK: Stored properties
    var books   : [Book]?
    var tags    : Tags?
    
    //MARK: Initializacion
    init(){
        tags = Tags()
        do{
            let json = try loadJSONFromLocalFile()
            var theBooks = [Book]()
            for jsonBook in json{
                do{
                    let book = try decode(book: jsonBook)
                    theBooks.append(book)
                    tags?.addTags(tags: book.tags.tagToOrderArray())
                    let desc = tags?.description
                    print("\(desc)")
                
                }catch{
                    print ("Failed json element \(jsonBook)")
                }
            }
        }catch{
            
        }
    }
}