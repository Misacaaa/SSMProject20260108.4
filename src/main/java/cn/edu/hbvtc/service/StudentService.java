package cn.edu.hbvtc.service;

import cn.edu.hbvtc.entity.Student;
import com.github.pagehelper.PageInfo;

import java.util.List;

/**
 * 学生服务接口
 */
public interface StudentService {
    /**
     * 查询所有学生信息
     * @return 学生列表
     */
    List<Student> getAllStudents();

    /**
     * 判断学号是否存在
     */
    boolean existsByStudentId(String studentId);

    /**
     * 保存学生信息
     */
    void saveStudent(Student student);
    boolean deleteStudentById(String studentId);

    /**
     * 根据学号查询学生信息
     * @param studentId 学号（如 "2023000001"）
     * @return Student 对象，若不存在则返回 null
     */
    Student findById(String studentId);
    void updateStudent(Student student);
    public PageInfo<Student> searchStudents(Integer pageNum, Integer pageSize, String studentId, String name, String email);
}