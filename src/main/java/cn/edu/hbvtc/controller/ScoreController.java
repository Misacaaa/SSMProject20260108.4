// src/main/java/cn/edu/hbvtc/controller/ScoreController.java
package cn.edu.hbvtc.controller;

import cn.edu.hbvtc.entity.Score;
import cn.edu.hbvtc.entity.ScoreDTO;
import cn.edu.hbvtc.entity.Student;
import cn.edu.hbvtc.service.ScoreService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/score")
public class ScoreController {

    @Autowired
    private ScoreService scoreService;

    /**
     * 跳转到成绩列表页面
     */
    @RequestMapping("/list")
    public String listScores(Model model,  @RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "5") Integer pageSize) {
        // 启用 PageHelper 分页（必须在查询前调用）
        PageHelper.startPage(pageNum, pageSize);
        List<ScoreDTO> scores = scoreService.getAllScoresWithDetails();
//        model.addAttribute("scoreList", scores);
        // 封装分页信息（navigatePages=5 表示页码导航最多显示5个数字按钮）
        PageInfo<ScoreDTO> pageInfo =
                new PageInfo<>(scores, 5);

        // 传递数据到 JSP 页面
//    model.addAttribute("studentList", studentList);
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("pageNum", pageNum);     // 可选：用于前端记住当前页
        model.addAttribute("pageSize", pageSize);   // 可选：用于动态切换每页条数
        return "scoreList"; // 对应 /WEB-INF/jsp/scoreList.jsp
    }
}