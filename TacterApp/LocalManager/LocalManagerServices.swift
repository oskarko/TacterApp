//
//  LocalManagerServices.swift
//  TacterApp
//
//  Created by Oscar Rodriguez Garrucho on 27/12/20.
//

import CoreData
import Foundation
import UIKit

/// Core Data Manager Layer which will help us to save or read entities to our data base.
class LocalManagerServices {
    static let shared = LocalManagerServices()

    /// White method.
    /// Save to Core Data any composition.
    func write(composition: Composition) {

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        for champion in composition.listOfChampions {
            let entity = NSEntityDescription.entity(forEntityName: "Character", in: context)
            let newCharacter = NSManagedObject(entity: entity!, insertInto: context)

            newCharacter.setValue(champion.championId, forKey: "championId")
            newCharacter.setValue(champion.name, forKey: "name")
            newCharacter.setValue(champion.cost, forKey: "cost")
            newCharacter.setValue(champion.costColor, forKey: "costColor")
            newCharacter.setValue(champion.iconURL, forKey: "iconURL")
            newCharacter.setValue(composition.id, forKey: "compositionId")
            newCharacter.setValue(composition.date, forKey: "date")

            do {
               try context.save()
              } catch {
               print("Failed saving")
            }
        }


    }

    /// Read method
    /// Read from Core Data ALL Champions and filter them and return an array of Compositions.
    /// This method SHOULD be splitted. TODO
    func read() -> [Composition] {

        var comps = [Composition]()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Character")
        let sectionSortDescriptor = NSSortDescriptor(key: "compositionId", ascending: true)
        let sortDescriptors = [sectionSortDescriptor]
        request.sortDescriptors = sortDescriptors
        request.returnsObjectsAsFaults = false

        do {
            let result = try context.fetch(request)

            var comp = Composition()
            for data in result as! [NSManagedObject] {
                let compositionId = data.value(forKey: "compositionId") as! UUID
                let championId = data.value(forKey: "championId") as! Int
                let name = data.value(forKey: "name") as! String
                let cost = data.value(forKey: "cost") as! Int
                let costColor = data.value(forKey: "costColor") as! String
                let iconURL = data.value(forKey: "iconURL") as! String
                let date = data.value(forKey: "date") as! Date

                let champion = Champion(championId: championId,
                                        name: name,
                                        cost: cost,
                                        costColor: costColor,
                                        iconURL: iconURL)

                if comp.id != compositionId && !comp.listOfChampions.isEmpty {
                    comps.append(comp)
                    comp = Composition()
                }
                comp.id = compositionId
                comp.date = date
                comp.listOfChampions.append(champion)
            }
            if !comp.listOfChampions.isEmpty {
                comps.append(comp)
            }

        } catch {
            print("Failed")
            return []
        }

        comps.sort {
            $0.date < $1.date
        }
        
        return comps
    }
}
