//
//  DataImporter.swift
//  NYTimes
//
//  Created by Amrita Ghosh on 22/07/19.
//  Copyright © 2019 Amrita Ghosh. All rights reserved.
//

import UIKit

class DataImporter: NSObject {
        
    static let sharedManager = DataImporter()
    
    private override init() {
        super.init()
    } //This prevents others from using the default '()' initializer for this class.
    
    
    func extractArticleListData(parameters : Dictionary <String, Any>) throws {
        if let resultsArray = parameters["results"] as? [Dictionary<String, Any>] {
            for resultDictionary:Dictionary<String,Any> in resultsArray {
                
                var articleList: ArticleList?
                
                // Note
                guard let newArticleId = resultDictionary["id"] as? Int64  else {
                    
                    let localizedDescription = NSLocalizedString(Server.error, comment: "")
                    throw NSError(domain: NetworkManager.ErrorDomain, code: 999, userInfo: [
                        NSLocalizedDescriptionKey: localizedDescription])
                }
                articleList = ArticleList.findArticleList(newArticleId)
                if (articleList == nil) {
                    articleList = ArticleList.newObject()
                }
                do {
                    try articleList?.updateFromDictionary(resultDictionary)
                }
                catch {
                    //error fetch author Data
                }
            }
            
            //Save context
            
            CoreDataStackManager.sharedManager.save(context: CoreDataStackManager.sharedManager.managedObjectContext)
        }
        
    }
    
    func extractError(error : NSError) throws {
        throw NSError(domain: NetworkManager.ErrorDomain, code: 401, userInfo: ["message" : "Error!!!"])
    }
    
}


