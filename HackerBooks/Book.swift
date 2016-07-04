//
//  Book.swift
//  HackerBooks
//
//  Created by Iván Cayón Palacio on 2/7/16.
//  Copyright © 2016 KeepCoding. All rights reserved.
//

import Foundation
import UIKit

class Book : Comparable, Hashable{
    
    //MARK: - Stored properties
    // Los primeros son oblitatorios
    let title       : String
    let authors     :[String]
    let tags        : Tags
    let image       : NSURL
    let pdf         : NSURL
    var isFavorite    : Bool?
    //MARK: - Private Image,Pdf
    private var dataImg: UIImage?
    private var dataPdf : NSData?
    
    
    
    
    //MARK: - Resource loading
    var imgFile: UIImage?{
        get{
            if self.dataImg==nil{
                do{
                    let imgData = try loadResource(withUrl: self.image)
                    let ui = UIImage(data: imgData)
                    self.dataImg=ui
                    return ui
                }catch{
                    return nil
                }
            }else{
                return self.dataImg
            }
        }
    }
    var pdfFile: NSData?{
        get{
            if self.dataPdf==nil{
                do{
                    let pdfData = try loadResource(withUrl: self.pdf)
                    self.dataPdf = pdfData
                    return pdfData
                    
                }catch{
                    return nil
                }
            }else{
                return self.dataPdf
            }
        }
    }
    
    //MARK: - Inicializadores
    init(title : String, authors: [String],
         tags: Tags, image: NSURL, pdf: NSURL){
        self.title=title
        self.authors=authors
        self.tags=tags
        self.image=image
        self.pdf=pdf
    }
    
    convenience init(title : String, authors: [String],
                     tags: Tags, image: NSURL, pdf: NSURL,
                     favorite: Bool){
        
        self.init(title: title,
                  authors: authors,
                  tags: tags,
                  image: image,
                  pdf: pdf)
        self.isFavorite = favorite
    }
    
    func setFavorite(fav : Bool){
        self.isFavorite=fav
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

//MARK: - Protocol Hashable
extension Book{
    var hashValue: Int {
        get{
            return "\(self.title)\(self.authors)".hash  // Devuelvo el hash del titulo y autores
        }
    }
    
}
