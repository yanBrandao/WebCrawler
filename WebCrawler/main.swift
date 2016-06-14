/*
 *  main.swift
 *  WebCrawler
 *
 *      1. Introduction
 *      This is a web crawler prototype to extract words related from term
 *  used in different search engines.
 *  Our first target is Yahoo Search Engine.
 *
 *      2. Crawler Jobs
 *      There are two jobs to do, first we need to get a maximun number of
 *  of url from search term. The second task is to extract words from every
 *  page obtained.
 *
 *      3. Objective
 *      Our main objective is to create a relationship graph with all words
 *  related to that term, matching the same words in different pages and
 *  specifying a weight to every word in that context.
 *
 *  Created by DINIZ, Y. on 10/05/16.
 *  Copyright © 2016 UFAM. All rights reserved.
 */
import Foundation
import WebKit

let crawlerIA = CralwerIA()
let contentEx = ContentExtractor()

//Directory of Developer folder.
let devDirectoryURL = try! NSFileManager.defaultManager().URLForDirectory(.DeveloperDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: true)

//Destinantion of our file to read the urls and save them.
let fileDestinationUrl = devDirectoryURL.URLByAppendingPathComponent("/WebCrawler/WebCrawler/base.txt")

var ret = ("", true)
print("WebCrawler| Wellcome to your personal webcrawler. :D")
ret = crawlerIA.IALoop()
while(ret.1){
    
    
    let genURL = URLGenerator()
    var queryURLs = genURL.urlGenerator(ret.0)
    
    print("WebCrawler| Starting url extraction from websearch.\n")
    for i in 0..<queryURLs.count{
        do {
            var fullpage = ""
            
            var url = NSURL(string: queryURLs[i])
            //Converting string to url.
            let myHTMLString = try String(contentsOfURL: url!)
            
            /* Our first process is to recognize the pattern used by this search engine.
             *  Yahoo show only 10 web pages and uses this pattern to describe his search:
             *
             *  Webpage:
             *          How To Crash A Website | Tech Me Out
             *          http://techmeout.org/how-to-crash-a-website/
             *
             *  Source code:
             *          <h3 class="title"><a class=" td-u" data-sb="..."
             *          href="http://techmeout.org/how-to-crash-a-website/"
             *          referrerpolicy="origin"
             *          target="_blank"><b><b>How To Crash</b></b> <b>A </b>Website | Tech Me Out</a></h3>
             */
            let splittedString = myHTMLString.componentsSeparatedByString("<")
            //First we sepate string in low block using "<"
            for i in 0..<splittedString.count{
                //Here we verify if this string has the that we want: td-u, like we saw before, this class have our URL
                if(splittedString[i].containsString("a class=\" td-u\" href=\"")){
                    //Now, after found our URLs, we sepate to get only the URL.
                    let anotherSplit = splittedString[i].componentsSeparatedByString("a class=\" td-u\" href=\"")
                    for j in 0..<anotherSplit.count{
                        //And we do a last separation to the end of URL.
                        let oneMoreSplit = anotherSplit[j].componentsSeparatedByString("\"")
                        for k in 0..<oneMoreSplit.count{
                            //To don't get trash, we use this to get only URL strings.
                            if(oneMoreSplit[k].containsString("http")){
                                fullpage.appendContentsOf(oneMoreSplit[k])
                                //contentEx.extraction(oneMoreSplit[k], content: ret.0)
                                fullpage.appendContentsOf("\n")
                            }
                        }
                    }
                }
            }
            // writing to disk
            //NSOutputStream(toFileAtPath: fileDestinationUrl.absoluteString, append: true){
            if let outputStream = NSOutputStream(URL: fileDestinationUrl, append: true){
                outputStream.open()
                let data:NSData = fullpage.dataUsingEncoding(NSUTF8StringEncoding)!
                outputStream.write(UnsafePointer<UInt8>(data.bytes), maxLength: data.length)
                outputStream.close()
            }
            /*try fullpage.writeToURL(fileDestinationUrl, atomically: true, encoding: NSUTF8StringEncoding)
             
             // saving was successful. any code posterior code goes here
             */
            // reading from disk
            
            
        } catch let error as NSError {
            print("error writing to url \(fileDestinationUrl)")
            print(error.localizedDescription)
        }
    }
    print("WebCrawler| Showing your url database.")
    do {
        let mytext = try String(contentsOfURL: fileDestinationUrl, encoding: NSUTF8StringEncoding)
        print(mytext)   // "some text\n"
    } catch let error as NSError {
        print("error loading from url \(fileDestinationUrl)")
        print(error.localizedDescription)
    }
    print("WebCrawler| Your url database has been succesfully updated.")
    ret = crawlerIA.IALoop()
}