/*
SQLyog Community v13.3.0 (64 bit)
MySQL - 5.7.38-log : Database - ssm_db
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`ssm_db` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `ssm_db`;

/*Table structure for table `course` */

DROP TABLE IF EXISTS `course`;

CREATE TABLE `course` (
  `course_id` char(8) NOT NULL,
  `course_name` varchar(100) DEFAULT NULL,
  `credit` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `course` */

insert  into `course`(`course_id`,`course_name`,`credit`) values 
('CS1001','高等数学',5),
('CS1002','大学英语',3),
('CS1003','计算机导论',4),
('CS1004','数据结构',4),
('CS1005','Python程序设计',3);

/*Table structure for table `score` */

DROP TABLE IF EXISTS `score`;

CREATE TABLE `score` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `student_id` char(10) DEFAULT NULL,
  `course_id` char(8) DEFAULT NULL,
  `score` decimal(5,2) DEFAULT NULL,
  `exam_date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

/*Data for the table `score` */

insert  into `score`(`id`,`student_id`,`course_id`,`score`,`exam_date`) values 
(1,'2023000001','CS1001',88.50,'2025-01-10'),
(2,'2023000001','CS1002',92.00,'2025-01-12'),
(3,'2023000001','CS1003',76.00,'2025-01-15'),
(4,'2023000002','CS1001',95.00,'2025-01-10'),
(5,'2023000002','CS1002',89.50,'2025-01-12'),
(6,'2023000002','CS1004',84.00,'2025-01-18'),
(7,'2023000003','CS1001',78.00,'2025-01-10'),
(8,'2023000003','CS1003',90.00,'2025-01-15'),
(9,'2023000003','CS1005',93.50,'2025-01-20'),
(10,'2023000004','CS1002',87.00,'2025-01-12'),
(11,'2023000004','CS1004',79.00,'2025-01-18'),
(12,'2023000004','CS1005',88.00,'2025-01-20'),
(13,'2023000005','CS1001',82.50,'2025-01-10'),
(14,'2023000005','CS1003',85.00,'2025-01-15'),
(15,'2023000005','CS1004',91.00,'2025-01-18');

/*Table structure for table `student` */

DROP TABLE IF EXISTS `student`;

CREATE TABLE `student` (
  `student_id` char(10) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `gender` char(1) DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `student` */
INSERT INTO `student` VALUES ('2023000001', '张三', '男', '2004-05-12', '13800138001', 'zhangsan@example.com');
INSERT INTO `student` VALUES ('2023000002', '李四', '女', '2005-08-23', '13800138002', 'lisi@example.com');
INSERT INTO `student` VALUES ('2023000003', '王五', '男', '2004-11-30', '13800138003', 'wangwu@example.com');
INSERT INTO `student` VALUES ('2023000004', '赵六', '女', '2005-03-17', '13800138004', 'zhaoliu@example.com');
INSERT INTO `student` VALUES ('2023000005', '陈七', '男', '2004-09-05', '13800138005', 'chenqi@example.com');
INSERT INTO `student` VALUES ('2023000006', 'baomihua1', '男', '2023-01-02', '18888890988', '18888890988@qq.com');
INSERT INTO `student` VALUES ('2023000007', 'baomihua2', '男', '2026-01-01', '18888890987', '18888890978@qq.com');
INSERT INTO `student` VALUES ('2023000008', 'baomihua3', '男', '2026-01-03', '18888890989', '18888890978@qq.com');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
