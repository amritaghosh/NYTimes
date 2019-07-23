//
//  NetworkManager.swift
//  NYTimes
//
//  Created by Amrita Ghosh on 22/07/19.
//  Copyright © 2019 Amrita Ghosh. All rights reserved.
//

import Foundation
import UIKit

class NetworkManager: NSObject {
    
    static let sharedManager = NetworkManager()
    
    private override init() {
        super.init()
    } //This prevents others from using the default '()' initializer for this class.
    
    
    static let ErrorDomain = "com.assignment.error.networking"
    
    
    func fetchMostPopularArticleList( completion : @escaping NetworkRetrieverDataTaskDidReceiveData){
        
        //1. Create downloadURL
        let apiPath = String(format: QueryParameters.mostPopularArticleList, APIKey.key)
        let url = URL.init(string: NetworkingConstants.baseURL() + apiPath)
        
        //2. Create httpHeaders
        let keys = [ NetworkingHeaders.ContentTypeHeaderField]
        let values = [NetworkingConstants.DataHeaderContentType]
        let httpHeaders = NSDictionary.init(objects: values as [Any], forKeys: keys as [NSCopying])
        
        //3. Create httpMethod based on API request type
        let httpMethod = HttpMethods.httpGET
        
        //4. Request NetworkRetriever for performaing dataTask
        let payload = [String: String]()
        
        NetworkRetriever.sharedManager.performDataTask(
            for: url!,
            usingHttpMethod: httpMethod,
            usingHeaders:httpHeaders as! Dictionary,
            usingPayload:payload as Dictionary,
            withTask: NetworkingTasks.mostPopularArticleListTask + SystemManager.sharedManager.uniqueString(),
            completion: completion)
    }
}
