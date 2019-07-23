//
//  SystemManager.swift
//  NYTimes
//
//  Created by Amrita Ghosh on 22/07/19.
//  Copyright © 2019 Amrita Ghosh. All rights reserved.
//


import UIKit
import CoreData

class SystemManager: NSObject {
    
    static let sharedManager = SystemManager()
    var loadingView : UIView?
  
    
    static var coreDataOpeartionQueue: OperationQueue = {
        let queue = OperationQueue()
        
        queue.name = "CoreData Opeartion Queue"
        
        return queue
    }()
    
    
    private override init() {
        super.init()
    } //This prevents others from using the default '()' initializer for this class.
    
 
    func deleteArticleList(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ArticleList")
            let result = try? CoreDataStackManager.sharedManager.managedObjectContext.fetch(request)
            let resultData = result as! [ArticleList]
            
            for object in resultData {
                CoreDataStackManager.sharedManager.managedObjectContext.delete(object)
            }
            do {
                try CoreDataStackManager.sharedManager.managedObjectContext.save()
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            } catch {
                
            }
    }
    
    func uniqueString() -> String {
        var uuid = NSUUID().uuidString
        uuid = uuid.substring(to: uuid.index(uuid.startIndex, offsetBy: 4))
        return uuid
    }
   
    
    // MARK: Loading Screens
    
    func showLoadingIndicatorScreen() {
        let storyboard: UIStoryboard = UIStoryboard.init(name: StoryboardName.articleList, bundle: nil)
        let loadingViewController = storyboard.instantiateViewController(withIdentifier: StoryboardIdentifier.loadingViewController)
        self.loadingView = loadingViewController.view
        AppDelegate.shared.window?.addSubview(self.loadingView!)
    }
    
    func dismissLoadingIndicatorScreen() {
        if let view = self.loadingView {
            view.removeFromSuperview()
            self.loadingView = nil
        }
    }
    

}

