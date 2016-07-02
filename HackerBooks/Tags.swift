//
//  Tags.swift
//  HackerBooks
//
//  Created by Iván Cayón Palacio on 2/7/16.
//  Copyright © 2016 KeepCoding. All rights reserved.
//

import Foundation

class Tags: CustomStringConvertible{
    
    var tags: Set = [""]
    
    //MARK: - Inicialitation
    init(){
        self.tags = [""]
    }
    
    convenience init(withTags newTags :[String]){
        self.init()
        addTags(tags: newTags)
    }
    
    //MARK: - Add tags
    func addTags(tags newTags: [String]){
        var auxArray : [String] = Array(tags)
        auxArray.appendContentsOf(newTags)
        auxArray.sortInPlace()  // Ordeno el array
        self.tags = Set(auxArray)   // Lo convierto en un set para que quite repetidos
    }

    func addTag(tag :String){
        let auxTags = [tag]
        addTags(tags: auxTags)
    }
    
    //MARK: - Array
    func tagToOrderArray()->[String]{
        var auxArray : [String] = Array(tags)
        auxArray.sortInPlace()
        return auxArray
    }
    
    
    //MARK: - CustomStringConvertible
    var description: String {
        get{
            return "\(tags)"
        }
    }

    
}

//MARK: - Protocols


