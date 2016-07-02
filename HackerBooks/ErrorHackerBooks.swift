//
//  ErrorHackerBooks.swift
//  HackerBooks
//
//  Created by Iván Cayón Palacio on 1/7/16.
//  Copyright © 2016 KeepCoding. All rights reserved.
//

import Foundation

enum ErrorHackerBooks: ErrorType {
    case urlResourceNotFound
    case wrongURLFormatForJSONResource
    case resourcePintedByURLNotReachable
    case jsonParsingError
    case wrongJSONFormat
    case nilJSONObject
    case wrongLocalResource
}