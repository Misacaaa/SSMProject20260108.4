package cn.edu.hbvtc.controller;

import cn.edu.hbvtc.entity.Student;
import cn.edu.hbvtc.service.StudentService;
import cn.edu.hbvtc.util.Result;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class StudentController {
    @Autowired
    private StudentService studentService;

    @RequestMapping("/addStudent")
    public String addStudent() {
        return "addStudent";//addStudent.jsp页面
    }

//    @RequestMapping("/studentList")
//    public String listAllStudents(Model model) {
//        model.addAttribute("studentList", studentService.getAllStudents());
//        return "studentList";
//    }
@RequestMapping("/studentList")
public String listAllStudents(
        @RequestParam(defaultValue = "1") Integer pageNum,
        @RequestParam(defaultValue = "5") Integer pageSize,
        @RequestParam(required = false) String studentId,
        @RequestParam(required = false) String name,
        @RequestParam(required = false) String email,
        Model model) {

    // 启用 PageHelper 分页（必须在查询前调用）
    PageHelper.startPage(pageNum, pageSize);

    // 执行查询（PageHelper 会自动拦截并生成 LIMIT 和 COUNT）
    PageInfo<Student> pageInfo = studentService.searchStudents(pageNum, pageSize, studentId, name, email);

//    // 封装分页信息（navigatePages=5 表示页码导航最多显示5个数字按钮）
//    PageInfo<Student> pageInfo =
//            new PageInfo<>(studentList, 5);

    // 传递数据到 JSP 页面
//    model.addAttribute("studentList", studentList);
    model.addAttribute("pageInfo", pageInfo);
//    model.addAttribute("pageNum", pageNum);     // 可选：用于前端记住当前页
//    model.addAttribute("pageSize", pageSize);   // 可选：用于动态切换每页条数

    return "studentList";
}

    @PostMapping("/studentAdd")
    @ResponseBody
    public Result<?> saveStudent(Student student) {
        try {
            // 可选：校验学号是否重复
            if (studentService.existsByStudentId(student.getStudentId())) {
                return Result.error("学号已存在，请使用其他学号");
            }
            studentService.saveStudent(student);
            return Result.success("添加学生成功!"); // 默认 message: "操作成功"
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("保存失败：" + e.getMessage());
        }
    }


    @RequestMapping("/studentEdit")
    public String studentEdit() {
        return "";
    }

    @PostMapping("/studentDelete")
    @ResponseBody
    public Result<?> studentDelete(@RequestParam("studentId") String studentId) {
        if (studentId == null || studentId.trim().isEmpty()) {
            return Result.error("学号不能为空");
        }
        try {
            boolean deleted = studentService.deleteStudentById(studentId);
            if (deleted) {
                Result<?> result = Result.success("删除成功!");
                return result;
//                return "{\"success\":true, \"message\":\"删除成功\"}";
            } else {
                return Result.error("未找到该学号的学生");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("删除失败：" + e.getMessage());
        }
    }

    @PostMapping("/getStudentInfoById")
    @ResponseBody
    public Student getStudentInfoById(@RequestParam("studentId") String studentId) {
        return studentService.findById(studentId);
    }

    @PostMapping("/studentUpdate")
    @ResponseBody
    public Result<?> updateStudent(@RequestBody Student student) {
        try {
            studentService.updateStudent(student);
            return Result.success("更新成功!");
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("更新失败: " + e.getMessage());
        }
    }
}
