//
//  ContentExtractor.swift
//  WebCrawler
//
//  Created by Yan Brandão Diniz on 09/06/16.
//  Copyright © 2016 UFAM. All rights reserved.
//

import Foundation
import WebKit

class ContentExtractor {
    func extraction(urlString: String, content: String) -> Void {
        //Directory of Developer folder.
        let devDirectoryURL = try! NSFileManager.defaultManager().URLForDirectory(.DeveloperDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: true)
        
        //Destinantion of our file to read the urls and save them.
        let fileDestinationUrl = devDirectoryURL.URLByAppendingPathComponent("/WebCrawler/WebCrawler/content.txt")

        do{
            let url = NSURL(string: urlString)
            let myURLContent = try String(contentsOfURL: url!, encoding: NSUTF8StringEncoding)
            
            let splitContent = myURLContent.componentsSeparatedByString("<")
            if let outputStream = NSOutputStream(URL: fileDestinationUrl, append: true){
                outputStream.open()
                var data:NSData = NSData()
            for i in 0..<splitContent.count{
                //if splitContent[i].containsString("p>") {
                        data = splitContent[i].dataUsingEncoding(NSUTF8StringEncoding)!
                //}
                
            }
            outputStream.write(UnsafePointer<UInt8>(data.bytes), maxLength: data.length)
            outputStream.close()
            }
        }catch let error as NSError {
            print("error writing to url \(fileDestinationUrl)")
            print(error.localizedDescription)
        }
    }
}