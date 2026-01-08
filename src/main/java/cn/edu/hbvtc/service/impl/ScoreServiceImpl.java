// src/main/java/cn/edu/hbvtc/service/impl/ScoreServiceImpl.java
package cn.edu.hbvtc.service.impl;

import cn.edu.hbvtc.entity.Score;
import cn.edu.hbvtc.entity.ScoreDTO;
import cn.edu.hbvtc.mapper.ScoreMapper;
import cn.edu.hbvtc.service.ScoreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ScoreServiceImpl implements ScoreService {

    @Autowired
    private ScoreMapper scoreMapper;

    @Override
    public List<ScoreDTO> getAllScoresWithDetails() {
        return scoreMapper.selectAllScoresWithDetails();
    }
}