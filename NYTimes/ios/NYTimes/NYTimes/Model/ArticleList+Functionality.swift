//
//  ArticleList+Functionality.swift
//  NYTimes
//
//  Created by Amrita Ghosh on 22/07/19.
//  Copyright © 2019 Amrita Ghosh. All rights reserved.
//
import Foundation
import CoreData

extension ArticleList {
    
    func updateFromDictionary(_ articleListDictionary: Dictionary<String, Any>) throws {
     if let playerIdValue    =  (articleListDictionary["id"] as? Int64) {
            id = playerIdValue
        }
        byline = articleListDictionary["byline"] as? String
        published_date = articleListDictionary["published_date"] as? String
        section = articleListDictionary["section"] as? String
        title = articleListDictionary["title"] as? String
        type = articleListDictionary["type"] as? String
        isFetching = true
    }
    
    
    class func findArticleList(_ id : Int64) -> ArticleList? {
        let request: NSFetchRequest<ArticleList> = ArticleList.fetchRequest()
        request.predicate = NSPredicate.init(format: "id = %i", id as CVarArg)
        do {
            let fetchResults = try CoreDataStackManager.sharedManager.managedObjectContext.fetch(request)
            return fetchResults.count > 0 ? fetchResults.first! : nil
        } catch {
           // print("Error with request: \(error)")
        }
        return nil
    }

    
    class func newObject() -> ArticleList {
        let articleList: ArticleList
        articleList = ArticleList(context: CoreDataStackManager.sharedManager.managedObjectContext)
        return articleList
    }
    
}
