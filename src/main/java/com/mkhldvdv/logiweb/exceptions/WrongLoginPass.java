package com.mkhldvdv.logiweb.exceptions;

/**
 * Created by mkhldvdv on 27.11.2015.
 */
public class WrongLoginPass extends Exception {
    /**
     * Constructs a new exception with {@code null} as its detail message.
     * The cause is not initialized, and may subsequently be initialized by a
     * call to {@link #initCause}.
     */
    public WrongLoginPass() {
    }

    /**
     * Constructs a new exception with the specified detail message.  The
     * cause is not initialized, and may subsequently be initialized by
     * a call to {@link #initCause}.
     *
     * @param message the detail message. The detail message is saved for
     *                later retrieval by the {@link #getMessage()} method.
     */
    public WrongLoginPass(String message) {
        super(message);
    }
}
