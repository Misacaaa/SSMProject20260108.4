// src/main/java/cn/edu/hbvtc/controller/CourseController.java
package cn.edu.hbvtc.controller;

import cn.edu.hbvtc.entity.Course;
import cn.edu.hbvtc.service.CourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/course")
public class CourseController {

    @Autowired
    private CourseService courseService;

    @RequestMapping("/list")
    public String listCourses(Model model) {
        List<Course> courses = courseService.getAllCourses();
        model.addAttribute("courseList", courses);
        return "courseList"; // 跳转到 /WEB-INF/jsp/courseList.jsp
    }
}