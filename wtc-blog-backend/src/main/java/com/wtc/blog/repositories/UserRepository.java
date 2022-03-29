package com.wtc.blog.repositories;

import com.wtc.blog.entities.User;

import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Integer>{
    User emailAndPassword(String email, String password);
    
    public boolean existsByEmail(String email);
}
