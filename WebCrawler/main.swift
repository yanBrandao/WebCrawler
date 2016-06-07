//
//  main.swift
//  WebCrawler
//
//  Created by Yan Brandão Diniz on 10/05/16.
//  Copyright © 2016 UFAM. All rights reserved.
//

import Foundation
import WebKit


let url = NSURL(string: "https://br.search.yahoo.com/search?p=how+to+crach+a+server&fr=yfp-t-707")

do {
    let myHTMLString = try String(contentsOfURL: url!)
    
    let splittedString = myHTMLString.componentsSeparatedByString("href=")
    var i = 0
    
    while( i < splittedString.count){
        var j = 0
        let splitFromSplittedString = splittedString[i].componentsSeparatedByString(" ")
        while( j < splitFromSplittedString.count){
            print("HTML : \(splitFromSplittedString[i])")
            j += 1
        }
        i += 1
    }
    
    
} catch let error as NSError {
    print("Error: \(error)")
}