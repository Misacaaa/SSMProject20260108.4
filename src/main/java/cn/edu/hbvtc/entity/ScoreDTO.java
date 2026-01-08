package cn.edu.hbvtc.entity;

import java.math.BigDecimal;
import java.util.Date;

public class ScoreDTO {
    private Integer id;            // 主键ID
    private String studentId;      // 学号
    private String courseId;       // 课程编号
    private BigDecimal score;      // 成绩（0.00 ～ 100.00）
    private Date examDate;    // 考试日期
    // 扩展字段（用于展示）
    private String studentName;   // 来自 student.name
    private String courseName;    // 来自 course.course_name
    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }




    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public String getCourseId() {
        return courseId;
    }

    public void setCourseId(String courseId) {
        this.courseId = courseId;
    }

    public BigDecimal getScore() {
        return score;
    }

    public void setScore(BigDecimal score) {
        this.score = score;
    }

    public Date getExamDate() {
        return examDate;
    }

    public void setExamDate(Date examDate) {
        this.examDate = examDate;
    }
}
