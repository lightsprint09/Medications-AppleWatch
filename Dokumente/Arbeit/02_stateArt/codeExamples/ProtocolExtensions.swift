protocol List {
    typealias T
    var count: Int { get }
    func objectAtIndex(index: Int) -> T
    
    var last: T? { get }
    var first: T? { get }
}

extension List {
    var last: T {
        return objectAtIndex(count - 1)
    }
    
    var first: T {
        return objectAtIndex(0)
    }
}

class ArrayList<Element>: List {
    typealias T = Element
    var count: Int = 0
    
    func objectAtIndex(index: Int) -> T {
        //some Implementation
    }
}


