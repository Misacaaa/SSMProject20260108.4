package cn.edu.hbvtc.service.impl;

import cn.edu.hbvtc.entity.Student;
import cn.edu.hbvtc.mapper.StudentMapper;
import cn.edu.hbvtc.service.StudentService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 学生服务实现类
 */
@Service
public class StudentServiceImpl implements StudentService {

    @Autowired
    private StudentMapper studentMapper;

    @Override
    public List<Student> getAllStudents() {
        return studentMapper.selectAllStudents();
    }

    @Override
    public boolean existsByStudentId(String studentId) {
        if (studentId == null || studentId.trim().isEmpty()) {
            return false;
        }
        Integer count = studentMapper.countByStudentId(studentId.trim());
        return count != null && count > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void saveStudent(Student student) {
        if (student == null) {
            throw new IllegalArgumentException("学生信息不能为空");
        }
        studentMapper.insertStudent(student);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean deleteStudentById(String studentId) {
        // 可选：先检查是否存在
        Student exists = studentMapper.selectByStudentId(studentId);
        if (exists == null) {
            return false;
        }
        int rows = studentMapper.deleteStudentById(studentId);
        return rows > 0;
    }

    @Override
    public Student findById(String studentId) {
        if (studentId == null || studentId.trim().isEmpty()) {
            return null;
        }
        return studentMapper.selectById(studentId);
    }

    @Override
    public void updateStudent(Student student) {
        if (student == null || student.getStudentId() == null) {
            throw new IllegalArgumentException("学生ID不能为空");
        }
        studentMapper.updateStudent(student);
    }

    @Override
    public PageInfo<Student> searchStudents(Integer pageNum, Integer pageSize, String studentId, String name, String email) {
        // ✅ PageHelper 必须在 Mapper 查询前调用
        PageHelper.startPage(pageNum, pageSize);
        List<Student> list = studentMapper.selectByConditions(studentId, name, email);
        return new PageInfo<>(list, 5); // 5 表示导航页码数
    }

}