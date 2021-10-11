import Foundation
import CoreData

class CoreDataManger {
    
    static let shared = CoreDataManger()
    
    var notes: [Note]? {
        return currentUser?.notes?.allObjects as? [Note]
    }
    
    var currentNote: Note?
    var currentSelectedDate: Date?
    var currentUser: User?
    var userName: String?
    
    var context: NSManagedObjectContext { persistentContainer.viewContext }
    
    func authorize(with mail: String) {
        do {
            let request: NSFetchRequest<User> = User.fetchRequest()
            let users: [User] = try context.fetch(request)
            if let user = users.filter( { $0.mail == mail }).first {
                currentUser = user
                userName = user.name
            } else {
                currentUser = createUser(with: mail)
            }
            updateNote(by: Date())
        } catch {
            print("Error fetching data from context: \(error)")
        }
    }
    
    func updateNote(by date: Date) { //вызвается после обьновления даты в календаре
        let stringFromDate = date.toString()
        currentSelectedDate = date
        currentNote = notes?.filter({ $0.date!.toString() == stringFromDate}).first
        if currentNote == nil {
            createNote(date: date)
        }
    }
    
    func getMeals(by mealType: Meals?) -> [Meal]? {
        return (currentNote?.meals?.allObjects as? [Meal])?.filter({ $0.mealType == mealType?.rawValue ?? "" })
    }
    
    func addMeal(calories: Int, mealType: String?, carbs: Double, fats: Double, proteins: Double, foodName: String, measureType: String?) {//добавить все остальные парметры
        let entityDescription = NSEntityDescription.entity(forEntityName: "Meal", in: context)!
        
        let meal = Meal(entity: entityDescription, insertInto: context)
        meal.calories = Int16(calories)
        meal.mealType = mealType
        meal.carbs = carbs
        meal.fats = fats
        meal.proteins = proteins
        meal.foodName = foodName
        meal.measureType = measureType
        
        currentNote?.addToMeals(meal)
        saveContext()
    }
    
    func createNote(date: Date) {
        let entityDescription = NSEntityDescription.entity(forEntityName: "Note", in: context)!
        
        let note = Note(entity: entityDescription, insertInto: context)
        
        note.date = date
        currentUser?.addToNotes(note)
        saveContext()
        currentNote = note
    }
    
    func delete(meal: Meal) {
        context.delete(meal)
        saveContext()
    }
    
    func createUser(with email: String) -> User {
        let entityDescription = NSEntityDescription.entity(forEntityName: "User", in: context)!
        
        let user = User(entity: entityDescription, insertInto: context)
        
        user.mail = email
        
        self.saveContext()
        return user
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "FoodExpert")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
