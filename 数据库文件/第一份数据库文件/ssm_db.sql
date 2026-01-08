/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50651
Source Host           : localhost:3306
Source Database       : ssm_db

Target Server Type    : MYSQL
Target Server Version : 50651
File Encoding         : 65001

Date: 2025-12-29 16:03:24
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `tb_book`
-- ----------------------------
DROP TABLE IF EXISTS `tb_book`;
CREATE TABLE `tb_book` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `press` varchar(20) NOT NULL,
  `author` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_book
-- ----------------------------
INSERT INTO `tb_book` VALUES ('1', 'Java程序设计', '人民邮电出版社', 'baomihua1');
INSERT INTO `tb_book` VALUES ('2', 'PHP程序设计', '人民邮电出版社', 'baomihua2');
