//
//  ViewModel.swift
//  News
//
//  Created by Nagaraj on 06/02/21.
//

import Foundation
import Combine

class ViewModel: ObservableObject {
    @Published var topArticle: Article?
    @Published var popularArticles = [Article]()
    private var cancellables = Set<AnyCancellable>()

    func fetchHomeScreenContents() {
        fetchTopArticles()
        fetchPopularArticles()
    }

    func fetchTopArticles() {
        let publisher = fetchArticles(endPoint: EndPoint.top)
        let cancellable = publisher.sink(receiveCompletion: { (completion) in
            print(completion)
        }, receiveValue: { (responce) in
            dump(responce)
            self.topArticle = responce.articles.first
        })
        cancellables.insert(cancellable)
    }
    
    func fetchPopularArticles() {
        let publisher = fetchArticles(endPoint: EndPoint.popular)
        let cancellable = publisher.sink(receiveCompletion: { (completion) in
            print(completion)
        }, receiveValue: { (responce) in
            dump(responce)
            self.popularArticles = responce.articles
        })
        cancellables.insert(cancellable)
    }
    
    func bookMark(article: Article) {
        let shared = Persistance.shared
        shared.add(article: article)
    }
}

private extension ViewModel {
    func fetchArticles(apiClient: APIClient = APIClient(), endPoint: EndPoint) -> AnyPublisher<Responce, Error> {
        apiClient.execute(endPoint.urlRequest, decodingType: Responce.self, queue: .main)
    }
}
