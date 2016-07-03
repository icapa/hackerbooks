//
//  Book.swift
//  HackerBooks
//
//  Created by Iván Cayón Palacio on 2/7/16.
//  Copyright © 2016 KeepCoding. All rights reserved.
//

import Foundation
import UIKit

class Book : Comparable{
    
    //MARK: - Stored properties
    // Los primeros son oblitatorios
    let title       : String
    let authors     :[String]
    let tags        : Tags
    let image       : UIImage?
    let pdf         : NSData?
    // El favorito de momento lo marco a falso
    var isFavorite    : Bool? = false
    
    //MARK: - Inicializadores
    init(title : String, authors: [String],
         tags: Tags, image: UIImage?, pdf: NSData?){
        self.title=title
        self.authors=authors
        self.tags=tags
        self.image=image
        self.pdf=pdf
    }
    
    convenience init(title : String, authors: [String],
                     tags: Tags, image: UIImage, pdf: NSData,
                     favorite: Bool){
        
        self.init(title: title,
                  authors: authors,
                  tags: tags,
                  image: image,
                  pdf: pdf)
        self.isFavorite = favorite
        
    }
    
    var proxyForComparison : String{
        get{
            return "\(title)"
        }
    }
    var proxyForSorting : String{
        get{
            return proxyForComparison
        }
    }
    
    
    
}
//MARK: - Equatable & Comparable
func == (lhs: Book, rhs: Book) -> Bool{
    return lhs.proxyForComparison == rhs.proxyForComparison
}

func  < (lhs: Book, rhs: Book) -> Bool{
    return lhs.proxyForSorting < rhs.proxyForSorting
}

