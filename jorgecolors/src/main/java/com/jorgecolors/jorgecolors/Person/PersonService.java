package com.jorgecolors.jorgecolors.Person;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class PersonService {

    private final PersonRepository personRepo;

    public PersonService(PersonRepository personRepo) {
        this.personRepo = personRepo;
    }

    @Transactional
    public void createPersona(Person person) {
        personRepo.save(person);
    }

    @Transactional(readOnly = true)
    public List<Person> obtenerTodasPerson() {
        return personRepo.findAll();
    }

    @Transactional(readOnly = true)
    public boolean authenticate(String email, String username, String password) {
        Person person = personRepo.findByEmailAndUsernameAndPassword(email, username, password);
        return person != null;
    }

    @Transactional(readOnly = true)
    public Person findByEmailAndUsernameAndPassword(String email, String username, String password) {
        return personRepo.findByEmailAndUsernameAndPassword(email, username, password);
    }
}
