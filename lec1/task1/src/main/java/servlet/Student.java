package servlet;

import java.util.ArrayList;
import java.util.List;

public class Student {
    public String name;
    public String email;
    public String phone;

    private static List<Student> students = new ArrayList<>();

    public Student() {}

    public Student(String name, String email, String phone) {
        this.name = name;
        this.email = email;
        this.phone = phone;
    }

    public List<Student> showStudents() {
        return students;
    }
}
