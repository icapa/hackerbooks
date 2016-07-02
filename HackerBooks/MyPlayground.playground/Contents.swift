//: Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"

let data = NSData(contentsOfURL: NSURL(string: "https://keepcodigtest.blob.core.windows.net/containerblobstest/books_readable.json")!)


func mierda(){

    let data = NSData(contentsOfURL: NSURL(string: "https://keepcodigtest.blob.core.windows.net/containerblobstest/books_readable.json")!)

    guard let datos = data else{
        print("No hay nada")
        return
    }
    print(datos.length)
    
    
}

// Prueba con arrays

class Tags{
    var tags: [String] = []
    
    //MARK - Inicialitation
    init(){
        self.tags = []  // Empty
    }
    
    convenience init(withTags newTags :[String]){
        self.init()
        self.tags = newTags
    }
    
    func addTags(tags newTags: [String]){
        var auxArray : [String] = self.tags
        auxArray.appendContentsOf(newTags)
        
        tags = Array(Set(auxArray))
        
        tags.sortInPlace()
        
    }
    
}

var losTags = Tags()

let cadenas = ["uno","dos","tres"]

let otrosTags = Tags(withTags: cadenas)

print("\(otrosTags.tags)")
otrosTags.addTags(tags: ["1","2","3"])
print("\(otrosTags.tags)")



