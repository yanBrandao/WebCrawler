//
//  CrawlerIA.swift
//  WebCrawler
//
//  Created by Yan Brandão Diniz on 09/06/16.
//  Copyright © 2016 UFAM. All rights reserved.
//

import Foundation

class CralwerIA {
    func IALoop() -> (String, Bool) {
        var newQuery = ""
        var correct = false
        var ret = true
        while(correct == false){
        print("WebCrawler| Do you want to update your url database with a search query? :3")
        let keyboard = NSFileHandle.fileHandleWithStandardInput()
        let inputData = keyboard.availableData
        
        let answer = NSString(data: inputData, encoding: NSUTF8StringEncoding)
        
        if (answer!.containsString("Yes") || answer!.localizedCaseInsensitiveContainsString("yEs")) {
            print("WebCrawler| So, write your query: ")
            let otherKeyboard = NSFileHandle.fileHandleWithStandardInput()
            let otherInputData = otherKeyboard.availableData
            newQuery = NSString(data: otherInputData, encoding: NSUTF8StringEncoding) as! String
            correct = true
        }else if answer!.containsString("No"){
            print("WebCrawler| Ok, thanks for using this WebCrawler. ^^")
            ret = false
            correct = true
        }else{
            print("WebCrawler| Sorry, I don't understand what you're trying to asnwer me. Let's try again.")
        }
        }
        return (newQuery, ret)
    }
}