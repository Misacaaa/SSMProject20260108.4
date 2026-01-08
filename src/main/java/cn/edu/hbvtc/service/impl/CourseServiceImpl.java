package cn.edu.hbvtc.service.impl;

import cn.edu.hbvtc.entity.Course;
import cn.edu.hbvtc.mapper.CourseMapper;
import cn.edu.hbvtc.service.CourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class CourseServiceImpl implements CourseService {

    @Autowired
    private CourseMapper courseMapper;

    @Override
    public List<Course> getAllCourses() {
        return courseMapper.selectAllCourses();
    }
}