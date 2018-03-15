/*
Navicat MySQL Data Transfer

Source Server         : 47.91.252.134
Source Server Version : 50721
Source Host           : 47.91.252.134:3306
Source Database       : life

Target Server Type    : MYSQL
Target Server Version : 50721
File Encoding         : 65001

Date: 2018-03-15 18:29:50
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for learn_english
-- ----------------------------
DROP TABLE IF EXISTS `learn_english`;
CREATE TABLE `learn_english` (
  `id` varchar(32) NOT NULL,
  `usercode` varchar(255) DEFAULT NULL COMMENT '用户编号',
  `externalLinks` varchar(255) DEFAULT NULL COMMENT '外部链接',
  `externalLinks2` varchar(255) DEFAULT NULL COMMENT '外部链接2',
  `externalLinks3` varchar(255) DEFAULT NULL COMMENT '外部链接3',
  `note` varchar(500) DEFAULT NULL COMMENT '笔记',
  `diary` varchar(50) DEFAULT NULL COMMENT '日记',
  `headline` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '头部标题',
  `timeClass` varchar(50) DEFAULT NULL COMMENT '时间类（前端jsp html元素class）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for learn_english_interpretayion
-- ----------------------------
DROP TABLE IF EXISTS `learn_english_interpretayion`;
CREATE TABLE `learn_english_interpretayion` (
  `id` varchar(32) NOT NULL COMMENT 'id',
  `wordType` varchar(255) DEFAULT NULL COMMENT '词性',
  `wordInterpretation` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '释义',
  `wordid` varchar(32) DEFAULT NULL COMMENT '英文表i（learn_english_words）d',
  `definition` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for learn_english_words
-- ----------------------------
DROP TABLE IF EXISTS `learn_english_words`;
CREATE TABLE `learn_english_words` (
  `id` varchar(32) NOT NULL,
  `word` varchar(5000) CHARACTER SET utf8 DEFAULT NULL COMMENT '英文',
  `addTime` datetime DEFAULT NULL COMMENT '添加时间',
  `addUser` varchar(255) DEFAULT NULL COMMENT '添加用户',
  `type` varchar(12) DEFAULT NULL COMMENT '类型（词组，单词，长句子）',
  `mp3Path` varchar(255) DEFAULT NULL COMMENT '语音mp3文件地址',
  `mp3Url` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '语音mp3url',
  `elseUrl` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '其他的url',
  `us_pronunciation` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `uk_pronunciation` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `uk_audio` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `us_audio` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `definition` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for learn_relation
-- ----------------------------
DROP TABLE IF EXISTS `learn_relation`;
CREATE TABLE `learn_relation` (
  `learnid` varchar(32) DEFAULT NULL COMMENT '学习主表（learn_english）id',
  `wordid` varchar(32) DEFAULT NULL COMMENT '英文表(learn_english_words)id',
  `usercode` varchar(255) DEFAULT NULL COMMENT '用户编码',
  `interpertayionid` varchar(32) DEFAULT NULL COMMENT '释义表（learn_english_interpretayion）id'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for memos
-- ----------------------------
DROP TABLE IF EXISTS `memos`;
CREATE TABLE `memos` (
  `id` varchar(255) NOT NULL COMMENT '编号',
  `userCode` varchar(25) DEFAULT NULL COMMENT '用户编号',
  `subject` varchar(255) DEFAULT NULL COMMENT '备忘主题',
  `content` varchar(500) DEFAULT NULL COMMENT '备忘内容',
  `emailNo` varchar(50) DEFAULT NULL COMMENT '邮箱地址',
  `phoneNo` varchar(11) DEFAULT NULL COMMENT '手机号码',
  `sendTime` varchar(50) DEFAULT NULL COMMENT '发送时间',
  `createTime` varchar(50) DEFAULT NULL COMMENT '创建时间',
  `updateTime` varchar(50) DEFAULT NULL COMMENT '修改时间',
  `executeResult` varchar(50) DEFAULT NULL COMMENT '执行结果',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for pc_files
-- ----------------------------
DROP TABLE IF EXISTS `pc_files`;
CREATE TABLE `pc_files` (
  `id` varchar(30) NOT NULL COMMENT '文件id',
  `file_originalFilename` varchar(255) DEFAULT NULL COMMENT '文件名称',
  `file_name` varchar(150) DEFAULT NULL COMMENT '文件别名',
  `file_type` varchar(100) DEFAULT NULL COMMENT '文件后缀',
  `file_path` varchar(255) DEFAULT NULL COMMENT '文件上传的路径',
  `file_url` varchar(255) DEFAULT NULL COMMENT '文件的访问url',
  `file_size` varchar(30) DEFAULT NULL COMMENT '文件大小',
  `upload_time` varchar(50) DEFAULT NULL COMMENT '上传时间',
  `upload_user` varchar(25) DEFAULT NULL COMMENT '上传用户',
  `sort_no` varchar(30) DEFAULT NULL COMMENT '排序号',
  `content_type` varchar(25) DEFAULT NULL COMMENT '文件类型',
  `isShare` varchar(255) DEFAULT '0' COMMENT '是否分享',
  `purpose` varchar(4) DEFAULT NULL COMMENT '用途',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for pc_tree
-- ----------------------------
DROP TABLE IF EXISTS `pc_tree`;
CREATE TABLE `pc_tree` (
  `id` varchar(20) NOT NULL,
  `text` varchar(55) DEFAULT NULL,
  `iconCls` varchar(20) DEFAULT NULL,
  `checked` varchar(20) DEFAULT NULL,
  `state` varchar(20) DEFAULT NULL,
  `attributes` varchar(255) DEFAULT NULL,
  `pid` varchar(20) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  `updateTime` datetime DEFAULT NULL,
  `userCode` varchar(25) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `readMode` varchar(20) DEFAULT NULL,
  `sortNo` varchar(20) DEFAULT '',
  `status` varchar(5) DEFAULT NULL COMMENT '状态',
  `level` varchar(5) DEFAULT NULL COMMENT '级别 1 一级菜单  2 二级菜单 3 三级菜单',
  `isShare` varchar(5) DEFAULT '0' COMMENT '是否参与分享',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for pc_user
-- ----------------------------
DROP TABLE IF EXISTS `pc_user`;
CREATE TABLE `pc_user` (
  `userCode` varchar(200) NOT NULL COMMENT '编号',
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

-- ----------------------------
-- Table structure for system_data
-- ----------------------------
DROP TABLE IF EXISTS `system_data`;
CREATE TABLE `system_data` (
  `indexes` varchar(255) DEFAULT NULL,
  `itemNo` varchar(255) DEFAULT NULL,
  `itemName` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `usestatus` varchar(4) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for wx_login_info
-- ----------------------------
DROP TABLE IF EXISTS `wx_login_info`;
CREATE TABLE `wx_login_info` (
  `signature` varchar(255) NOT NULL COMMENT '微信唯一码',
  `nickName` varchar(50) DEFAULT NULL COMMENT '微信昵称',
  `loginResult` varchar(25) DEFAULT NULL COMMENT '登陆结果',
  `loginTime` datetime DEFAULT NULL COMMENT '登陆时间',
  `loginAddress` varchar(50) DEFAULT NULL COMMENT '登陆地址',
  `loginMessages` varchar(255) DEFAULT NULL COMMENT '登陆信息',
  `brand` varchar(20) DEFAULT NULL COMMENT '登陆时所用手机品牌',
  `model` varchar(20) DEFAULT NULL COMMENT '登陆时所用手机型号',
  `version` varchar(20) DEFAULT NULL COMMENT '微信版本',
  `language` varchar(25) DEFAULT NULL COMMENT '微信设置的语言',
  `system` varchar(25) DEFAULT NULL COMMENT '操作系统版本号',
  `avatarurl` varchar(255) DEFAULT NULL COMMENT '登陆时的微信头像',
  `scene` varchar(6) DEFAULT NULL COMMENT '场景值'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for wx_user_info
-- ----------------------------
DROP TABLE IF EXISTS `wx_user_info`;
CREATE TABLE `wx_user_info` (
  `nickName` varchar(50) DEFAULT NULL COMMENT '微信昵称',
  `avatarUrl` varchar(200) DEFAULT NULL COMMENT '头像地址',
  `gender` varchar(5) DEFAULT NULL COMMENT '性别 (1 男 0 女)',
  `province` varchar(25) DEFAULT NULL COMMENT '省份',
  `city` varchar(25) DEFAULT NULL COMMENT '城市',
  `country` varchar(25) DEFAULT NULL COMMENT '国家',
  `signature` varchar(255) NOT NULL COMMENT '微信唯一码',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`signature`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
