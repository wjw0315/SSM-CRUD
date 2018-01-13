/*
MySQL Backup
Source Server Version: 5.5.5
Source Database: ssm-crud
Date: 2017/11/29 10:04:46
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
--  Table structure for `tbl_dept`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_dept`;
CREATE TABLE `tbl_dept` (
  `dept_id` int(11) NOT NULL AUTO_INCREMENT,
  `dept_name` varchar(255) NOT NULL,
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `tbl_emp`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_emp`;
CREATE TABLE `tbl_emp` (
  `emp_id` int(11) NOT NULL AUTO_INCREMENT,
  `emp_name` varchar(255) NOT NULL,
  `gender` varchar(1) NOT NULL,
  `email` varchar(255) NOT NULL,
  `d_id` int(11) NOT NULL,
  PRIMARY KEY (`emp_id`),
  KEY `d_id` (`d_id`),
  CONSTRAINT `key_emp_dept` FOREIGN KEY (`d_id`) REFERENCES `tbl_dept` (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records 
-- ----------------------------
INSERT INTO `tbl_dept` VALUES ('4','开发部'), ('5','测试部');
INSERT INTO `tbl_emp` VALUES ('25','sadfasdf','F','asdfasdf@q.com','4'), ('26','asdfjklasdfsa','F','adfj@qq.com','4'), ('27','asdfsadfasd','M','adfj@qq.com','4'), ('28','asdgdfh','M','asdk@qq.com','4'), ('29','治安为现在','M','asdaaa@qq.com','4'), ('30','rwegtkdsf','F','asdgshgs@qq.com','5'), ('31','aaaaa','M','adfj@qq.com','4'), ('32','wgfsagd','M','wwww@qq.com','4'), ('33','党风接口','F','askdgjahs@qq.com','5'), ('34','伍嘉威','M','821060818@qq.com','4'), ('35','伍嘉威','M','821060818@qq.com','4'), ('40','现在模糊','M','hjjjj@ed.com','4'), ('41','文件文件','M','asdfasd@126.com','4'), ('42','啥富商大贾','M','asdf@qq.oc','4'), ('43','sadfjaskdg','M','asdgj@qq.com','4'), ('44','sadfklsdjf','M','sadjsdafj@qih.com','4'), ('45','asdfsdjf','F','asdhg@qkaf.com','5'), ('46','痛苦辛苦','M','gfvv@cc.com','4'), ('47','同哦你领李','F','bjsgshhd@jjs.com','5'), ('48','来咯思敏','M','hhjsjsjdj@jjx.com','5'), ('49','费明明','M','jxjdjdjdj@jjzjzjz.com','4'), ('50','safasdf','M','asdfasdf@qefj.com','4'), ('51','safasdf','F','asdfasdf@qefj.com','4'), ('52','safasdf','F','asdfasdf@qefj.com','4'), ('53','safasdf','F','asdfasdf@qefj.com','4'), ('54','qwetwe','M','asdf@qweht.com','4');
