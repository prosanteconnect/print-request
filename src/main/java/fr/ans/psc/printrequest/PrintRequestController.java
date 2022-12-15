package fr.ans.psc.printrequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class PrintRequestController {

    @PostMapping("/print")
    public ResponseEntity<String> printRequest(@RequestBody String body) {
        return new ResponseEntity<>(body, HttpStatus.OK);
    }
    
    @GetMapping("/check")
    public String check() {
        return "print-request is alive";
    }
}
