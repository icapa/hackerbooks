//: Playground - noun: a place where people can play

import Cocoa

/*
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
*/

// Prueba con arrays
/*
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
*/

//### Prueba de los set para guardar los favoritos

// Creo un Set vacio
var unset = Set<String>()
unset.insert("3")
unset.insert("2")
unset.insert("1")   // Al insertar repetido no lo añada..de puta madre


// Imprimo cuantos elementos tiene
print(unset.count)
// Compruebo si esta un elemento
print (unset)

// Busco si esta un elemento
if unset.contains("1"){
    print("Encontre el 1")
}
else{
    print ("No encontre")

}
// Quito un elemento
unset.remove("1")
print ("Ahora lo quito y busco a ver")
if unset.contains("1"){
    print("Encontre")
}
else{
    print ("No encontre 1 ")
    
}

// Quiero convertir el tag a un array de strings
print("La descripcion es", unset.description)

// Guarda en disco
var paraDisco : String = unset.description

print ("Este es el string del set \(paraDisco)")

// Se crea un array intermedio
var arraySet = unset.sort()
print (arraySet)

var arrayString = arraySet as NSArray











