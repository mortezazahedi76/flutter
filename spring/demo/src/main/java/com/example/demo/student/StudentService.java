package com.example.demo.student;
import com.example.demo.StudentRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.time.LocalDate;
import java.time.Month;
import java.util.ArrayList;
import java.util.List;



@Service
public class StudentService {
    @Autowired
    StudentRepo repo;

    public  void addNewStudent(Student student) {
        System.out.println(student );
        repo.save(student);
    }


    public List<StudentDto> getStudent(){

        List<Student> students = repo.findAll();
        List<StudentDto> dtos = new ArrayList<>();
        for(Student s : students) {
            dtos.add(new StudentDto(s.getId(),s.getName(),s.getEmail(),s.getAge()));
        }
        return dtos;
    }

    public void save(Student s) {
        repo.save(s);
    }


    public void deleteStudent(Long studentId) {
        boolean exist = repo.existsById(studentId);
        if(!exist){
            throw new IllegalStateException("student with id " + studentId + "dose not exist" );

        }
        repo.deleteById(studentId);
    }

}
