//
//  URLGenerator.swift
//  WebCrawler
//
//  Created by Yan Brandão Diniz on 09/06/16.
//  Copyright © 2016 UFAM. All rights reserved.
//

import Foundation
import WebKit

let root = 0

class URLGenerator {
    func urlGenerator(query:String) -> [String] {
        print("WebCrawler| Query: "+query)
        var condition = false
        var yahooSearchPattern = [String]()
        yahooSearchPattern.append("https://br.search.yahoo.com/search?p=")
        var queryChanger = query.stringByReplacingOccurrencesOfString("\n", withString: "")
        queryChanger = queryChanger.stringByReplacingOccurrencesOfString(" ", withString: "+")
        
        
        yahooSearchPattern[root] = yahooSearchPattern[root] + queryChanger
    
        var iterator = 0
        
        while condition == false {
            do{
                let url = NSURL(string: yahooSearchPattern[iterator])
                let textFromURL = try String(contentsOfURL: url!)
                if textFromURL.containsString("Não encontramos resultados") {
                    condition = true
                }else{
                    let currentIteration = ((iterator+1)*10)+1
                    yahooSearchPattern.append(yahooSearchPattern[root] + "&b=" + String(currentIteration))
                }
                iterator += 1
                if iterator >= yahooSearchPattern.count {
                    condition = true
                }
            }catch let error as NSError {
                print("error writing to url \(fileDestinationUrl) - URLGenerator")
                print(error.localizedDescription)
            }
        }
        
        print("WebCrawler| I found", String(iterator) + " pages from your query.")
        return yahooSearchPattern
    }
}
