//
//  CoreData.swift
//  createYourDict
//
//  Created by Bora Erdem on 26.07.2022.
//

import Foundation
import CoreData
import Combine

class CoreData: ObservableObject{
    
    let container: NSPersistentContainer
    @Published var words: [Word] = []
    @Published var favWords : [Word] = []
    var cancellable = Set<AnyCancellable>()
    
    init(){
        container = NSPersistentContainer(name: "WordCoreModel")
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Error: Not Loaded Core Data \(error)")
            }
        }
        self.fetchData()
    }
    
    func addFav(data: Word){
        if (favWords.first(where: {$0.id == data.id}) == nil){
            data.fav = true
            finish()
        }
    }
    
    
    func removeFav(data: Word){
        if let i = (favWords.firstIndex(where: {$0.id == data.id})) {
            data.fav = false
            finish()
            
        }
    }
    
    
    
    
    
    func fetchData(){
        let request = NSFetchRequest<Word>(entityName: "Word")
        
        do {
            self.words =  try container.viewContext.fetch(request)
        } catch let error {
            print(error)
        }
        
        
         $words
            .map { gelen -> [Word] in
                let filtered = gelen.filter { kelime -> Bool in
                    return kelime.fav ? true : false
                }
                return filtered
            }
            .sink { gelen in
                self.favWords = gelen
            }
            .store(in: &cancellable)
        
    }
        
    
    func addData(name: String, pronantation: String, definition: String, examples: String){
        let entity = Word(context: container.viewContext)
        entity.name = name
        entity.definition = definition
        entity.examples = examples
        entity.pronantation = pronantation
        finish()
    }
    
    func deleteData(indexSet : IndexSet){
        guard let index = indexSet.first else {return}
        let entity = words[index]
        container.viewContext.delete(entity)
        finish()
    }
    
    func deleteDataFromEntity(entity: Word){
        container.viewContext.delete(entity)
        finish()
    }
    
    func updateData(entity: Word){
        //
        
    }
    
    
    func save(){
        do {
            try container.viewContext.save()
        } catch let error {
            print(error)
        }
    }

    func finish(){
        save()
        fetchData()
    }

    
}

