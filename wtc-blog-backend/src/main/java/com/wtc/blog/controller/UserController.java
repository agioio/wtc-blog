package com.wtc.blog.controller;

import com.wtc.blog.entities.User;
import com.wtc.blog.repositories.UserRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class UserController {

    @Autowired
    private UserRepository userRepository;
    
    @RequestMapping(value = "info", method = RequestMethod.GET)
    public String info() {
        return "Test";
    }

    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public ResponseEntity<?> register(@RequestBody User user) {
        try {
            if(!userRepository.existsByEmail(user.getEmail())) {
                userRepository.save(user);
                return ResponseEntity.status(HttpStatus.CREATED).body(user);
            }else{
                return ResponseEntity.status(HttpStatus.CONFLICT).body("{\"error\": \"User exists\"}");
            }
        } catch (Exception e) {
            throw e;
        }
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody User user) {
        User oldUser = userRepository.emailAndPassword(user.getEmail(), user.getPassword());
        if (oldUser != null) {
            return ResponseEntity.status(HttpStatus.OK).body(oldUser);
        }
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("{\"error\": \"Incorrect credentials\"}");
        
    }
}
