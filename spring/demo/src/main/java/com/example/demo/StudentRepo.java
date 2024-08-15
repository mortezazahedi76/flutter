package com.example.demo;

import com.example.demo.student.Student;
import org.hibernate.annotations.Comment;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface StudentRepo extends JpaRepository<Student,Long> {

    public List<Student> findAllByAge(int age);
    public List<Student> findAllByAgeGreaterThanEqualAndNameEquals(int age, String name);

}
