// src/main/java/cn/edu/hbvtc/mapper/CourseMapper.java
package cn.edu.hbvtc.mapper;

import cn.edu.hbvtc.entity.Course;
import java.util.List;

public interface CourseMapper {
    List<Course> selectAllCourses();
}