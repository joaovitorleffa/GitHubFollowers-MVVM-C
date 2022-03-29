//
//  FavoriteManager.swift
//  GitHubFollowers
//
//  Created by joaovitor on 28/03/22.
//

import Foundation
import CoreData

protocol FavoriteManagerProtocol: AnyObject {
    func saveFavorite(_ favorite: FavoriteToSave, completion: (Result<Favorite, CoreDataError>) -> Void)
    func fetchFavorites(completion: (Result<[Favorite], CoreDataError>) -> Void)
    func deleteFavorite(_ favorite: Favorite, completion: (Result<Favorite, CoreDataError>) -> Void)
}

class FavoriteManager {
    let mainContext: NSManagedObjectContext
    
    init(mainContext: NSManagedObjectContext = CoreDataManager.shared.mainContext) {
        self.mainContext = mainContext
    }
}

extension FavoriteManager: FavoriteManagerProtocol {
    func saveFavorite(_ favorite: FavoriteToSave, completion: (Result<Favorite, CoreDataError>) -> Void) {
        let alreadyExists = checkIfExistsBy(id: favorite.id)
        
        guard let alreadyExists = alreadyExists else {
            completion(.failure(.requestError))
            return
        }
        
        // FIXME: está adicionando o usuário mesmo que ele já esteja salvo
        if alreadyExists {
            completion(.failure(.alreadyExists))
            return
        }
        
        let newFavorite = Favorite(context: mainContext)
        
        newFavorite.id = Int64(favorite.id)
        newFavorite.name = favorite.name
        newFavorite.username = favorite.username
        newFavorite.avatarURL = favorite.avatarURL
        
        do {
            try mainContext.save()
            completion(.success(newFavorite))
        } catch {
            completion(.failure(.saveError))
        }
    }
    
    func fetchFavorites(completion: (Result<[Favorite], CoreDataError>) -> Void) {
        let fetchRequest = NSFetchRequest<Favorite>(entityName: "Favorite")
        
        do {
            let favorites = try mainContext.fetch(fetchRequest)
            completion(.success(favorites))
        } catch {
            completion(.failure(.requestError))
        }
    }
    
    func deleteFavorite(_ favorite: Favorite, completion: (Result<Favorite, CoreDataError>) -> Void) {
        mainContext.delete(favorite)
        
        do {
            try mainContext.save()
            completion(.success(favorite))
        } catch {
            completion(.failure(.requestError))
        }
    }
}

extension FavoriteManager {
    private func checkIfExistsBy(id: Int) -> Bool? {
        let fetchRequest = NSFetchRequest<Favorite>(entityName: "Favorite")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "id == %d", Int64(id))
        
        do {
            let favorite = try mainContext.fetch(fetchRequest)
            return favorite.count > 0
        } catch {
            return nil
        }
    }
}
