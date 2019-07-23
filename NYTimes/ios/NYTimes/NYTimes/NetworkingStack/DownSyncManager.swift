//
//  DownSyncManager.swift
//  NYTimes
//
//  Created by Amrita Ghosh on 22/07/19.
//  Copyright © 2019 Amrita Ghosh. All rights reserved.
//

import UIKit
import Foundation


class DownSyncManager : NSObject {
    
    static let sharedManager = DownSyncManager()
    
    private override init() {
        super.init()
    } //This prevents others from using the default '()' initializer for this class.
    
    
    func fetchMostPopularArticleList(_ isRefresh: Bool, completion: @escaping NetworkRetrieverDataTaskDidReceiveData) {
       
        NetworkManager.sharedManager.fetchMostPopularArticleList(completion: {
            (responseObject, fetchError) in
            if fetchError != nil {
                do {
                    try DataImporter.sharedManager.extractError(error: fetchError!)
                    completion(nil, fetchError)
                } catch {
                    let nserror = error as NSError
                    completion(responseObject, nserror)
                }
                return
            }
            CoreDataStackManager.sharedManager.managedObjectContext.performAndWait {
                do {
                    if(isRefresh) {
                        SystemManager.sharedManager.deleteArticleList()
                    }
                    try DataImporter.sharedManager.extractArticleListData(parameters: responseObject! as! Dictionary<String, Any>)
                    completion(responseObject, nil)
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nserror = error as NSError
                    completion(responseObject, nserror)
                }
            }

        })
    }
    
   
}


