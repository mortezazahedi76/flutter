package com.example.demo.student;

import com.example.demo.StudentRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping(path = "api/mori/student")
public class StudentController {
    private final StudentService studentService;




    @Autowired
    public StudentController(StudentService studentService, StudentRepo s) {
        this.studentService = studentService;
        s.save(new Student("morteza", LocalDate.of(1998,4,22),"mmmmmm",27));
        s.save(new Student("moriano",LocalDate.of(1376,4,4),"moriano@gmail.com",22));
        s.save(new Student("esy",LocalDate.of(1376,4,4),"esy@gmail.com",30));
        s.save(new Student("milad",LocalDate.of(1376,4,4),"milad@gmail.com",27));
        s.save(new Student("amir",LocalDate.of(1376,4,4),"amir@gmail.com",24));
        s.save(new Student("matin",LocalDate.of(1376,4,4),"matin@gmail.com",24));
        s.save(new Student("kazem",LocalDate.of(1376,4,4),"kazem@gmail.com",33));
        s.save(new Student("amin",LocalDate.of(1376,4,4),"amin@gmail.com",36));
        System.out.println(s.findAll());
    }

    @GetMapping("/get")
    public  List<StudentDto> getStudent() {
        return studentService.getStudent();
    }

    @PostMapping("/save")
    public void registerStudent(@RequestBody Student student){
        studentService.addNewStudent(student);
    }

    @DeleteMapping(path = "/delete/{studentId}")
    public void deleteStudent(@PathVariable("studentId")Long studentId){
        studentService.deleteStudent(studentId);
    }


}
