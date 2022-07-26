//
//  CoreData.swift
//  createYourDict
//
//  Created by Bora Erdem on 26.07.2022.
//

import Foundation
import CoreData

class CoreData: ObservableObject{
    
    let container: NSPersistentContainer
    @Published var words: [Word] = []
    
    init(){
        container = NSPersistentContainer(name: "WordCoreModel")
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Error: Not Loaded Core Data \(error)")
            }
        }
        self.fetchData()
    }
    
    func fetchData(){
        let request = NSFetchRequest<Word>(entityName: "Word")
        
        do {
            self.words =  try container.viewContext.fetch(request)
        } catch let error {
            print(error)
        }
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
