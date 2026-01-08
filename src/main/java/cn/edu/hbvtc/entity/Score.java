package cn.edu.hbvtc.entity;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Date;

public class Score {
    private Integer id;            // 主键ID
    private String studentId;      // 学号
    private String courseId;       // 课程编号
    private BigDecimal score;      // 成绩（0.00 ～ 100.00）
    private Date examDate;    // 考试日期

    public Score() {}

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

    @Override
    public String toString() {
        return "Score{" +
                "id=" + id +
                ", studentId='" + studentId + '\'' +
                ", courseId='" + courseId + '\'' +
                ", score=" + score +
                ", examDate=" + examDate +
                '}';
    }
}