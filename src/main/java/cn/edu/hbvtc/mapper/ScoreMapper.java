// src/main/java/cn/edu/hbvtc/mapper/ScoreMapper.java
package cn.edu.hbvtc.mapper;

import cn.edu.hbvtc.entity.Score;
import cn.edu.hbvtc.entity.ScoreDTO;

import java.util.List;

public interface ScoreMapper {
    /**
     * 查询所有成绩，关联学生姓名和课程名称
     */
    List<ScoreDTO> selectAllScoresWithDetails();
}