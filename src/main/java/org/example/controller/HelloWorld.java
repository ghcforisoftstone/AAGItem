package org.example.controller;


import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/test")
public class HelloWorld {
    @RequestMapping("/hello")
    public String hello(){
        return "Hello World!";
    }
}
