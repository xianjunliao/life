/*
Navicat MySQL Data Transfer

Source Server         : bd
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : life-dev

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2018-01-30 14:13:58
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for pc_user
-- ----------------------------
DROP TABLE IF EXISTS `pc_user`;
CREATE TABLE `pc_user` (
  `userCode` varchar(25) NOT NULL COMMENT '编号',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `userRole` varchar(25) DEFAULT NULL COMMENT '用户角色',
  `updateTime` datetime DEFAULT NULL COMMENT '修改时间',
  `phoneNo` varchar(11) DEFAULT NULL COMMENT '手机号码',
  `emailAddress` varchar(20) DEFAULT NULL COMMENT '邮箱地址',
  `defaultPlayAddress` varchar(255) DEFAULT NULL COMMENT '默认播放地址',
  `selfIntroduction` varchar(255) DEFAULT NULL COMMENT '自我介绍',
  `headAddress` varchar(255) DEFAULT NULL COMMENT '头像地址',
  `userName` varchar(50) DEFAULT NULL COMMENT '用户名称',
  `password` varchar(50) DEFAULT NULL COMMENT '登陆密码',
  PRIMARY KEY (`userCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
