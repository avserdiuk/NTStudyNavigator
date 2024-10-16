//
//  CoreData.swift
//  Navigator
//
//  Created by Алексей Сердюк on 15.10.2024.
//

import CoreData
import StorageServices

class CoreDateServices {
    static let shared = CoreDateServices()
    
    var posts: [CDPost] = []
    
    private init(){
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Navigator")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        return container
    }()
    
    
    func getPosts(){
        let context = persistentContainer.viewContext
        let request: NSFetchRequest<CDPost> = CDPost.fetchRequest()
        do {
            posts = try context.fetch(request)
            print(posts.count)
        } catch {
            print("Error fetching posts: \(error)")
        }
    }
    
    func search(text: String){
        let context = persistentContainer.viewContext
        let request = CDPost.fetchRequest()
        request.predicate = NSPredicate(format: "author == %@", text)
        
        do {
            posts = try context.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func clear(){
        let context = persistentContainer.viewContext
        let request: NSFetchRequest<CDPost> = CDPost.fetchRequest()
        //request.predicate = NSPredicate()
        do {
            let posts = try context.fetch(request)
            
            posts.forEach {
                context.delete($0)
            }
            
            saveContext()
        } catch {
            print("Error fetching posts: \(error)")
        }
    }
    
    func deletePostFromFavorites(_ post: Post) {
        let context = persistentContainer.viewContext
        let request: NSFetchRequest<CDPost> = CDPost.fetchRequest()
        request.predicate = NSPredicate(format: "author == %@", post.author)
        print(post.author)
        do {
            let posts = try context.fetch(request)
            print(posts.count)
            context.delete(posts.first!)
            saveContext()
            getPosts()
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
   
    
    func addPostToFavorites(_ post: Post) {
        let _: Void = persistentContainer.performBackgroundTask { context in
            let newPost = CDPost(context: context)
            newPost.desc = post.description
            newPost.author = post.author
            newPost.image = post.image
            newPost.likes = Int32(post.likes)
            newPost.views = Int32(post.views)
            
                do {
                    try context.save()
                    print("post added to favorites")
                } catch {
                    print(error.localizedDescription)
                }
             
        }
    }

    func saveContext () {
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
    
}
