package cn.edu.hbvtc.service;

import cn.edu.hbvtc.entity.Score;
import cn.edu.hbvtc.entity.ScoreDTO;

import java.util.List;

public interface ScoreService {
    /**
     * 获取所有成绩详情（含学生姓名、课程名称）
     */
    List<ScoreDTO> getAllScoresWithDetails();
}