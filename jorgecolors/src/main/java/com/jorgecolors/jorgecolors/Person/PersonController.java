package com.jorgecolors.jorgecolors.Person;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/person")
@CrossOrigin(origins = "http://192.168.1.44:56315")
public class PersonController {
    private final PersonService personService;

    public PersonController(PersonService personService) {
        this.personService = personService;
    }

    @PostMapping
    public ResponseEntity<String> createPersona(@RequestBody Person person) {
        try {
            personService.createPersona(person);
            return ResponseEntity.ok("Persona created successfully");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error creating persona");
        }
    }

    @GetMapping
    public ResponseEntity<List<Person>> getPerson() {
        List<Person> person = personService.obtenerTodasPerson();
        return ResponseEntity.ok(person);
    }

    @GetMapping("/verify")
    public ResponseEntity<String> verify(@RequestParam String email, @RequestParam String username, @RequestParam String password) {
        boolean isAuthenticated = personService.authenticate(email, username, password);
        if (isAuthenticated) {
            return ResponseEntity.ok("Verification successful");
        } else {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Verification failed");
        }
    }

    @GetMapping("/search")
    public ResponseEntity<Person> searchPerson(@RequestParam String email, @RequestParam String username, @RequestParam String password) {
        Person person = personService.findByEmailAndUsernameAndPassword(email, username, password);
        if (person != null) {
            return ResponseEntity.ok(person);
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
