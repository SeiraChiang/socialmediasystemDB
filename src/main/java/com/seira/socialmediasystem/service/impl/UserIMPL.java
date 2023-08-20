package com.seira.socialmediasystem.service.impl;

import com.seira.socialmediasystem.Dto.UserDTO;
import com.seira.socialmediasystem.Entity.User;
import com.seira.socialmediasystem.Repo.UserRepo;
import com.seira.socialmediasystem.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;

public class UserIMPL implements UserService {

    @Autowired
    private UserRepo userRepo;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public String addUser(UserDTO userDTO){

        User user = new User(
                userDTO.getUserid(),
                userDTO.getUsername(),
                userDTO.getEmail(),

                this.passwordEncoder.encode(userDTO.getPassword())
        );

        userRepo.save(user);

        return user.getUsername();
    }
}
