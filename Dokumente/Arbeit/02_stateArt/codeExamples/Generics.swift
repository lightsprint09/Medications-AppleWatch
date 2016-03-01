class Medication: NSObject {
    //...
}
//Could only store type Medication
class CustomMedicationArray {
    //...
    func add(medication: Medication) {
        //...
    }
    
    func objectAtIndex(index: Int) -> Medication {
        
    }
}
//Could only store any type which inherits from NSObject
//loses all type information
class CustomArray {
    //...
    func add(medication: NSObject) {
        //...
    }
    
    func objectAtIndex(index: Int) -> NSObject {
        //...
        //return object
    }
}
//Could store any type
//Does not lose type information
class GenericArray<T> {
    //...
    func add(medication: T) {
        //...
    }
    
    func objectAtIndex(index: Int) -> T {
        //...
        //return object
    }
}
let genericArray = GenericArray<Medication>()