//
//  MostPopularArticleListViewController.swift
//  NYTimes
//
//  Created by Amrita Ghosh on 22/07/19.
//  Copyright © 2019 Amrita Ghosh. All rights reserved.
//

import UIKit
import CoreData

class MostPopularArticleListViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
  }
    
    func setupUI() {
        SystemManager.sharedManager.showLoadingIndicatorScreen()
        self.fetchAndPopulateView( true)
    }
      
    
    func fetchAndPopulateView(_ isRefreshing: Bool) {
        DownSyncManager.sharedManager.fetchMostPopularArticleList(isRefreshing) { (responseObject, loginError) in
            DispatchQueue.main.async(execute: {
                SystemManager.sharedManager.dismissLoadingIndicatorScreen()
                if (loginError != nil) {
                    return
                }
                self.displayView()
            })
            
        }
    }
    
    
    // MARK: - Display View
    
    func displayView() {
        if((self.fetchedResultsController.fetchedObjects?.count)! > 0) {
            self.tableView.reloadData()
            return
        }
    }
    
 
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let sectionInfo = self.fetchedResultsController.sections?[section] {
            return sectionInfo.numberOfObjects
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "kMostPopularArticleListTableCell") as! MostPopularArticleListTableCell
        cell.separatorInset = UIEdgeInsets.zero
        self.configureCellUsingModel(cell, at: indexPath)
        return cell
    }
    
    
    func configureCellUsingModel(_ cell: MostPopularArticleListTableCell, at indexPath: IndexPath) {
        let playerList = self.fetchedResultsController.object(at: indexPath)
        cell.configureCellUsingModel(playerList)
    }

   override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }

    // MARK: - Fetched results controller
    
    var fetchedResultsController: NSFetchedResultsController<ArticleList> {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest: NSFetchRequest<ArticleList> = ArticleList.fetchRequest()
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 10
        
//        // Edit the sort key as appropriate.
//        let sortDescriptorName = NSSortDescriptor(key: "name", ascending: true,  selector: #selector(NSString.localizedCaseInsensitiveCompare(_:)))
        fetchRequest.sortDescriptors = []
        
        fetchRequest.predicate = NSPredicate.init(format: "isFetching = %i", 1)
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStackManager.sharedManager.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        _fetchedResultsController = aFetchedResultsController
        _fetchedResultsController?.delegate = self
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            //            let nserror = error as NSError
            //            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return _fetchedResultsController!
    }
    var _fetchedResultsController: NSFetchedResultsController<ArticleList>? = nil
    
    // MARK: - Fetched results controller
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            self.tableView.insertSections([sectionIndex], with: .fade)
        case .delete:
            self.tableView.deleteSections([sectionIndex], with: .fade)
        default:
            break;
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let newIndexPathForInsert = newIndexPath {
                self.tableView.insertRows(at: [newIndexPathForInsert], with: .fade)
            }
        case .delete:
            if let indexPathOfChange = indexPath {
                self.tableView.deleteRows(at:[indexPathOfChange], with: .fade)
            }
        case .update:
            if let indexPathOfChange = indexPath {
                if let cell = self.tableView.cellForRow(at: indexPathOfChange) as? MostPopularArticleListTableCell {
                    self.configureCellUsingModel(cell, at: indexPathOfChange)
                }
                
            }
            
        case .move:
            if let newIndexPathForInsert = newIndexPath,
                let indexPathOfChange = indexPath {
                self.tableView.insertRows(at: [newIndexPathForInsert], with: .fade)
                self.tableView.deleteRows(at: [indexPathOfChange], with: .fade)
            }
            
        @unknown default:
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.endUpdates()
        
        if controller.fetchedObjects?.count == 0 {
        }
    }
    


    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
