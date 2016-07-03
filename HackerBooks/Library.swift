//
//  Library.swift
//  HackerBooks
//
//  Created by Iván Cayón Palacio on 3/7/16.
//  Copyright © 2016 KeepCoding. All rights reserved.
//

import Foundation
class Library {
    //MARK: Utility types
    typealias BookArray =   [Book]
    typealias BookDictionary = [String: BookArray]
    
    
    // Dictionario completo
    var dict: BookDictionary = BookDictionary()
    
    //MARK: Stored properties
    var books   : BookArray?            // Los libros
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
        
        books = BookArray()
        
        do{
            let json = try loadJSONFromLocalFile()
            self.favorites = loadFavoritesFile()
            for jsonBook in json{
                do{
                    let book = try decode(book: jsonBook)
                    // Miro si tengo que meterlo en favoritos
                    book.isFavorite = self.favorites.contains(book.title)
                    
                    books?.append(book)
                    
                    
                    // Meto en cada dictionario por tags
                    for t in book.tags.tagToOrderArray(){
                        if var d = dict[t]{ // Si existe el diccionario inserto
                            d.append(book)
                            dict[t]=d
                        }else{
                            // Si no tengo que crearlo, y lo añado
                            dict[t] = BookArray()
                            // Fuerzo pq le acabo de crear
                            dict[t]!.append(book)
                        }
                        
                    }
                    
                    // Meto en el dictionario si es favorito
                    if book.isFavorite == true{
                        if var f = dict["Favorite"] {
                            f.append(book)
                            dict["Favorite"]=f
                        }else{
                            dict["Favorite"] = BookArray()
                            dict["Favorite"]!.append(book)
                        
                        }
                    }
        
                    // Guardo los tags para posterior uso
                    tags?.addTags(tags: book.tags.tagToOrderArray())
                    let desc = tags?.description
                    print("\(desc)")
 
                
                }catch{
                    print ("Failed json element \(jsonBook)")
                }
                // Vamos a hacer debug
                
            }
            
        }catch{
            
        }
    }
    //MARK: - Table requirements
    // Libros para un tag
    func bookCountForTag (tag: String?) -> Int{
        guard let b = dict[tag!] else{
            return 0
        }
        return b.count
    }
    
    // Array de libros para un tag
    func booksForTag (tag: String?) -> BookArray?{
        guard let t = tag else{
            return nil
        }
        guard let a = dict[t] else{
            return nil
        }
        return a
    }
    // Libro en un indice y un tag
    func bookAtIndex(index: Int, tag: String?) -> Book?{
        guard let t = tag else{
            return nil
        }
        guard let bookDict = dict[t] else{
            return nil
        }
        return bookDict[index]
    }

    
}
//MARK: - Extensions
extension Library {
    func saveFavoritesToFile() {
        saveFavoritesFile(withFile: self.favorites)
    }
    func debugDictionary() {
        for t in tags!.tagToOrderArray(){
            print("----------------------")
            print("\(t) ->")
            for a in dict[t]!{
                print("- \t\(a.title)")
            }
        }
    }
}
