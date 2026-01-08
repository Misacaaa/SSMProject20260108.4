package cn.edu.hbvtc.mapper;

import cn.edu.hbvtc.entity.Student;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface StudentMapper {
    /**
     * 查询所有学生
     * @return 学生列表
     */
    List<Student> selectAllStudents();

    /**
     * 方法1：根据学号统计数量（用于判断是否已存在）
     */
    Integer countByStudentId(@Param("studentId") String studentId);

    /**
     * 方法2：插入新学生
     */
    void insertStudent(Student student);
    Student selectByStudentId(String studentId);
    int deleteStudentById(String studentId);
    /**
     * 根据主键 student_id 查询学生
     * @param studentId 学号
     * @return Student 对象，未找到返回 null
     */
    Student selectById(@Param("studentId") String studentId);

    void updateStudent(Student student);
    List<Student> selectByConditions(
            @Param("studentId") String studentId,
            @Param("name") String name,
            @Param("email") String email
    );
}