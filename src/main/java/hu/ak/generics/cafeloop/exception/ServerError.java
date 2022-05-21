package hu.ak.generics.cafeloop.exception;

public class ServerError extends RuntimeException {

    public ServerError(Throwable cause) {
        super(cause);
    }

    public ServerError(String message) {
        super(message);
    }

    public ServerError(String message, Throwable cause) {
        super(message, cause);
    }
}
