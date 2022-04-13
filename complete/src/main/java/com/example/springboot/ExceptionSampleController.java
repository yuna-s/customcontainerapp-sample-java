package com.example.springboot;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@RestController
public class ExceptionSampleController {

    Logger logger = LoggerFactory.getLogger(ExceptionSampleController.class);

    @GetMapping("/exception")
    public String index() {
        // log test
        StringLength("sample");
        StringLength(null);

        return "This is log test page!";
    }

    static void StringLength(String str) {
        int strlen = str.length();
        System.out.println(str + "は" + strlen + "文字です");
    }
}