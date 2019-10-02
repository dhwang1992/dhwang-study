package com.thoughtworks.anno;

public @interface BusinessLog {

    String value() default "";

    String name() default "";
}
