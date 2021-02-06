//
//  News.swift
//  News
//
//  Created by Nagaraj on 06/02/21.
//

import Foundation

struct Responce: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable, Identifiable {
    var id = UUID()
    let source: Source
    let author, title, articleDescription: String
    let url: String
    let urlToImage: String
    let publishedAt: String
    let content: String

    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
}

extension Article: Hashable {
    static func == (lhs: Article, rhs: Article) -> Bool {
        //wrte a better logic
        lhs.title == rhs.title
    }
}

// MARK: - Source
struct Source: Codable, Identifiable, Hashable {
    let id, name: String
}


enum EndPoint {
    case top, popular, search(String)
    
    var urlRequest: URLRequest {
        var urlRequest: URLRequest
        switch self {
        case .top:
            urlRequest = URLRequest(url: URL(string: "https://newsapi.org/v2/top-headlines?sources=techcrunch& =70216437bc104978ab2b3e8d2593f5d0")!)
            
        case .popular:
            urlRequest = URLRequest(url: URL(string: "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=70216437bc104978ab2b3e8d2593f5d0")!)
        case .search(let str):
            urlRequest = URLRequest(url: URL(string: "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=70216437bc104978ab2b3e8d2593f5d0")!)
        }
        return urlRequest
    }
}
