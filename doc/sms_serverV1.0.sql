/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50535
Source Host           : 127.0.0.1:3306
Source Database       : dingchang_core

Target Server Type    : MYSQL
Target Server Version : 50535
File Encoding         : 65001

Date: 2014-10-21 16:03:52
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for sms_sendlogs
-- ----------------------------
DROP TABLE IF EXISTS `sms_sendlogs`;
CREATE TABLE `sms_sendlogs` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mobile` varchar(255) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `platfrom` varchar(255) DEFAULT NULL,
  `vals` varchar(255) DEFAULT NULL,
  `template` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `createDate` varchar(255) DEFAULT NULL,
  `delFlag` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sms_sendqueue
-- ----------------------------
DROP TABLE IF EXISTS `sms_sendqueue`;
CREATE TABLE `sms_sendqueue` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mobile` varchar(255) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `platfrom` varchar(255) DEFAULT NULL,
  `vals` varchar(255) DEFAULT NULL,
  `template` varchar(255) DEFAULT NULL,
  `status` int(255) DEFAULT NULL,
  `createDate` varchar(255) DEFAULT NULL,
  `sendDate` varchar(255) DEFAULT NULL,
  `delFlag` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sms_templatesms
-- ----------------------------
DROP TABLE IF EXISTS `sms_templatesms`;
CREATE TABLE `sms_templatesms` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `createDate` varchar(255) DEFAULT NULL,
  `platfrom` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `delFlag` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
