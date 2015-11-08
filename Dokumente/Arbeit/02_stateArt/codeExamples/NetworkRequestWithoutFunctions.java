
public interface NetworkRequestResponseHandler
    public handleNetworkResponse(Error error, Response response);
}

public interface NetworkRequest
    public performNetworkRequest(NetworkRequestResponseHandler handler);
}

public class ExampleClass implements NetworkRequestResponseHandler {
    public handleNetworkResponse(Error error, Response response) {
        //Use Response
    }
    
    public static main(String[] args) {
       NetworkRequestImpl().performNetworkRequest(this)
    }
}

