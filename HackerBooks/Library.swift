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
    var books   : [Book]?           // Los libros
    var tags    : Tags?             // Lista de los tags
    var favorites = Set<String>()
    
    var booksCount : Int{
        get{
            guard let b = books else{
                return 0;
            }
            return b.count
        }
    }
    
    var tagsCount : Int{
        get{
            guard let t = tags else{
                return 0
            }
            return t.count
        }
    }
    
    //MARK: - Initializacion
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
            self.books=theBooks
            self.favorites = loadFavoritesFile()
        }catch{
            
        }
        // Leemos los favoritos guardados
        
    }
    //MARK: - Table requirements
    func bookCountForTag (tag: String?) -> Int{
        guard let book = booksForTag(tag) else {
            return 0
        }
        return book.count
    }
    func booksForTag (tag: String?) -> [Book]?{
        var theBooks = [Book]()
        guard let b = self.books else{
            return nil
        }
        for oneBook in b{
            if tag=="Favorites"{    // El tag favorito es distingo
                if (oneBook.isFavorite==true){
                    theBooks.append(oneBook)
                }
            }
            else{
                if oneBook.tags.doesTagExist(tag){
                    theBooks.append(oneBook)
                }
            }
        }
        
        if theBooks.count==0{
            return nil
        }
        return theBooks
    }
    
    func bookAtIndex(index: Int, tag: String?) -> Book?{
        guard let b = booksForTag(tag) else{
            return nil
        }
        let theBook : Book? = b[index]
        guard let tb = theBook else{
            return nil
        }
        return tb
    }

    
}
//MASK: - Extensions
extension Library {
    func saveFavoritesToFile() {
        saveFavoritesFile(withFile: self.favorites)
    }
}
