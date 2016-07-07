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
    typealias BookArray =   Set<Book>
    typealias BookDictionary = [String: BookArray]
    
    
    // Dictionario completo
    var dict: BookDictionary = BookDictionary()

    var completeDict : BookDictionary = BookDictionary()
    // U
    //MARK: Stored properties
    var tags    : Tags?             // Lista de los tags
    var favorites = Set<String>()

    
    var booksCount : Int{
        get{
            return completeDict.count
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
            self.favorites = loadFavoritesFile()
            for jsonBook in json{
                do{
                    let book = try decode(book: jsonBook)
                    // Miro si tengo que meterlo en favoritos
                    book.isFavorite = self.favorites.contains(book.title)
                    
                    if completeDict["all"] == nil{
                        completeDict["all"] = BookArray()
                    }
                    self.completeDict["all"]?.insert(book)
                    
                
                
                    
                    
                    
                    // Meto en cada dictionario por tags
                    for t in book.tags.tagToOrderArray(){
                        if dict[t] == nil{ // Si existe el diccionario inserto
                            dict[t] = BookArray()
                        }
                        dict[t]?.insert(book)
                        
                    }
                    
                    // Meto en el dictionario si es favorito
                    if book.isFavorite == true{
                        if dict["Favorites"] == nil {
                            dict["Favorites"] = BookArray()
                        }
                        dict["Favorites"]?.insert(book)
                    }
        
                    // Guardo los tags para posterior uso
                    tags?.addTags(tags: book.tags.tagToOrderArray())
                    
                
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
        
        
        // Array temporal para ordenar el set, es una cerdada pero bueno
        var tempArray = bookLibraryToOrderArray(withLibrary: bookDict)
        for a in bookDict{
            if tempArray[index] == a.title {
                return a
            }
        }
        return nil
    }
    func bookAtIndexGlobal(index: Int) -> Book?{
        var tempArray = bookLibraryToOrderArray(withLibrary: self.completeDict["all"]!)
        for a in self.completeDict["all"]!{
            if tempArray[index] == a.title {
                return a
            }
        }
        return nil

        
    }
    
    //MARK: - Utils
    func addBookInTag(tag :String, withBook book: Book){
        if dict[tag] == nil {
            dict[tag] = BookArray()
        }
        dict[tag]?.insert(book)
    }
    func remoteBookInTag(tag : String, withBook book: Book){
        if dict[tag] == nil{
            return
        }
        dict[tag]?.remove(book)
    }
    func bookLibraryToOrderArray(withLibrary lib: Set<Book>)->[String]{
        var auxArray = [String]()
        for i in lib{
            auxArray.append(i.title)
        }
        auxArray.sortInPlace()
        return auxArray
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
