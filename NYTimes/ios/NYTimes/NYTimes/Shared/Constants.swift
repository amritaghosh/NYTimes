//
//  Constant.swift
//  NYTimes
//
//  Created by Amrita Ghosh on 22/07/19.
//  Copyright © 2019 Amrita Ghosh. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

typealias NetworkRetrieverDownloadTaskDidWriteDataBlock = (Int64, Int64, Int64) -> Swift.Void
typealias NetworkRetrieverDataTaskDidReceiveData = (Any?, NSError?) -> Swift.Void
public typealias CompletionHandler = () -> Swift.Void


// Set Environment for API
let currentEnvironment: Environments = Environments.Development

enum Environments {
    case Development
}

struct APIKey {
    static let key      = "gVFgrbb2ilAz8wUW0DTUqx9h0zk7jUyI"
}

struct NetworkingConstants {
    static let DataHeaderContentType    = "application/json; charset=utf-8"
    static let baseURLDevelopment       = "https://api.nytimes.com/svc/"
   
    static func baseURL() -> String {
        switch currentEnvironment {
        case .Development:
            return NetworkingConstants.baseURLDevelopment
        }
    }
}


struct NetworkingHeaders {
    static let ContentTypeHeaderField      = "Content-Type"
}

struct HttpMethods{
    static let httpGET      = "GET"
}

struct QueryParameters {
    static let mostPopularArticleList  = "mostpopular/v2/viewed/1.json?api-key=%@"
}

struct NetworkingTasks {
    static let mostPopularArticleListTask                       = "MostPopularArticleListTask"
    
}

struct StoryboardName {
    static let articleList = "ArticleList"
}

struct StoryboardIdentifier {
    static let loadingViewController          = "kLoadingViewController"
}


struct JsonKeys {
    struct Errors {
        static let type             = "error"
    }
}

struct Server {
    static let error       = "Could not interpret data from the server."
}



