package org.example.controller;


import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloWorld {
    @RequestMapping("/hello")
    public String hello(){
        return "Hello World again! I am a Java Application";
    }

    @RequestMapping("/")
    public String index(){
        return "Hello World! I am a Java Application";
    }
}
