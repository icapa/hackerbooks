//
//  Foundation.swift
//  HackerBooks
//
//  Created by Iván Cayón Palacio on 1/7/16.
//  Copyright © 2016 KeepCoding. All rights reserved.
//

import Foundation

extension NSBundle{
    func URLForResource(name: String?) -> NSURL?{
        let components = name?.componentsSeparatedByString(".")
        let fileTitle = components?.first
        let fileExtension = components?.last
        return URLForResource(fileTitle, withExtension: fileExtension)
    }
}