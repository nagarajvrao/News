//
//  Persistance.swift
//  News
//
//  Created by Nagaraj on 06/02/21.
//

import Foundation
import CoreData

class Persistance {
    static let shared = Persistance()
    
    lazy var persistentContainer: NSPersistentContainer = {
      let container = NSPersistentContainer(name: "FaveFlicks")
      container.loadPersistentStores { _, error in
        if let error = error as NSError? {
          fatalError("Unresolved error \(error), \(error.userInfo)")
        }
      }
      return container
    }()
    
    lazy var context = persistentContainer.viewContext
    
    func saveContext() {
      let context = persistentContainer.viewContext
      if context.hasChanges {
        do {
          try context.save()
        } catch {

          let nserror = error as NSError
          fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
      }
    }
    
    func add(article: Article) {
        let cdArticle = CDArticle(context: context)
        cdArticle.author = article.author
        cdArticle.decription = article.articleDescription
        cdArticle.sourceName = article.source.name
        cdArticle.url = article.url
//        cdArticle.image = 
    }
    
    func delete(article: Article) {
//        context.delete(article)
    }
    
    
}
