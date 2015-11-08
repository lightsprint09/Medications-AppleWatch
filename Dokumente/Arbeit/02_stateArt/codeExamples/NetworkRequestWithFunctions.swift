protocol NetworkRequest {
    func performNetworkRequest(handleNetworkRequest:(Error, Response)->())
}

class ExampleClass {
    func main() {
        //Store a function in a variable
        let handleRequest = {(error, response) in
            //Handle Response
        }
        NetworkRequestImpl.performNetworkRequest(handleRequest)
    }
}


