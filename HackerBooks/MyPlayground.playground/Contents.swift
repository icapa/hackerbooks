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

mierda()


