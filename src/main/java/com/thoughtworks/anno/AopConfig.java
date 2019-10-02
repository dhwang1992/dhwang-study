package com.thoughtworks.anno;

import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.stereotype.Component;

import java.lang.reflect.Method;
import java.lang.reflect.Parameter;
import java.util.Arrays;

@Aspect
@Component
@Slf4j
public class AopConfig {

    //定义切点
    @Pointcut("execution(public * com.thoughtworks.api.*(..)))")
    public void pointCut() {
    }

    //@Before("pointCut()")
    //使用@Before在切入点之前切入内容
    //使用@After在切入点之后切入内容
    @Before("@annotation(BusinessLog)")
    public void before(JoinPoint joinPoint) {
        //获取所有加了BusinessLog注解的方法
        MethodSignature signature = (MethodSignature) joinPoint.getSignature();
        Method method = signature.getMethod();
        String methodName = method.getName();
        log.info("call method, method is {}, args is {}, parameters is {}", method.getName(), joinPoint.getArgs(), method.getParameters().toString());
    }
}
