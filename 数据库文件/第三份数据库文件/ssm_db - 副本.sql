

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course`  (
  `course_id` char(8) ,
  `course_name` varchar(100) ,
  `credit` tinyint UNSIGNED NOT NULL,
  PRIMARY KEY (`course_id`) 
) ;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES ('CS1001', '高等数学', 5);
INSERT INTO `course` VALUES ('CS1002', '大学英语', 3);
INSERT INTO `course` VALUES ('CS1003', '计算机导论', 4);
INSERT INTO `course` VALUES ('CS1004', '数据结构', 4);
INSERT INTO `course` VALUES ('CS1005', 'Python程序设计', 3);

-- ----------------------------
-- Table structure for score
-- ----------------------------
DROP TABLE IF EXISTS `score`;
CREATE TABLE `score`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `student_id` char(10) ,
  `course_id` char(8) ,
  `score` decimal(5, 2) NULL DEFAULT NULL,
  `exam_date` date NULL DEFAULT NULL,
  PRIMARY KEY (`id`) 
) ;

-- ----------------------------
-- Records of score
-- ----------------------------
INSERT INTO `score` VALUES (1, '2023000001', 'CS1001', 88.50, '2025-01-10');
INSERT INTO `score` VALUES (2, '2023000001', 'CS1002', 92.00, '2025-01-12');
INSERT INTO `score` VALUES (3, '2023000001', 'CS1003', 76.00, '2025-01-15');
INSERT INTO `score` VALUES (4, '2023000002', 'CS1001', 95.00, '2025-01-10');
INSERT INTO `score` VALUES (5, '2023000002', 'CS1002', 89.50, '2025-01-12');
INSERT INTO `score` VALUES (6, '2023000002', 'CS1004', 84.00, '2025-01-18');
INSERT INTO `score` VALUES (7, '2023000003', 'CS1001', 78.00, '2025-01-10');
INSERT INTO `score` VALUES (8, '2023000003', 'CS1003', 90.00, '2025-01-15');
INSERT INTO `score` VALUES (9, '2023000003', 'CS1005', 93.50, '2025-01-20');
INSERT INTO `score` VALUES (10, '2023000004', 'CS1002', 87.00, '2025-01-12');
INSERT INTO `score` VALUES (11, '2023000004', 'CS1004', 79.00, '2025-01-18');
INSERT INTO `score` VALUES (12, '2023000004', 'CS1005', 88.00, '2025-01-20');
INSERT INTO `score` VALUES (13, '2023000005', 'CS1001', 82.50, '2025-01-10');
INSERT INTO `score` VALUES (14, '2023000005', 'CS1003', 85.00, '2025-01-15');
INSERT INTO `score` VALUES (15, '2023000005', 'CS1004', 91.00, '2025-01-18');

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student`  (
  `student_id` char(10) ,
  `name` varchar(50) ,
  `gender` char(1) ,
  `birth_date` date NULL DEFAULT NULL,
  `phone` varchar(20) ,
  `email` varchar(100) ,
  PRIMARY KEY (`student_id`) 
) ;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES ('2023000001', '张三', '男', '2004-05-12', '13800138001', 'zhangsan@example.com');
INSERT INTO `student` VALUES ('2023000002', '李四', '女', '2005-08-23', '13800138002', 'lisi@example.com');
INSERT INTO `student` VALUES ('2023000003', '王五', '男', '2004-11-30', '13800138003', 'wangwu@example.com');
INSERT INTO `student` VALUES ('2023000004', '赵六', '女', '2005-03-17', '13800138004', 'zhaoliu@example.com');
INSERT INTO `student` VALUES ('2023000005', '陈七', '男', '2004-09-05', '13800138005', 'chenqi@example.com');
INSERT INTO `student` VALUES ('2023000006', 'baomihua1', '男', '2023-01-02', '18888890988', '18888890988@qq.com');
INSERT INTO `student` VALUES ('2023000007', 'baomihua2', '男', '2026-01-01', '18888890987', '18888890978@qq.com');
INSERT INTO `student` VALUES ('2023000008', 'baomihua3', '男', '2026-01-03', '18888890989', '18888890978@qq.com');

