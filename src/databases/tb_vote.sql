
-- ----------------------------
-- Table structure for `tb_vote_candidate`
-- ----------------------------
DROP TABLE IF EXISTS `tb_vote_candidate`;
CREATE TABLE `tb_vote_candidate` (
  `user_no` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `id` bigint(20) DEFAULT NULL COMMENT '授权时对应的id',
  `unit_id` bigint(20) DEFAULT NULL COMMENT '单位id',
  `user_name` varchar(50) NOT NULL COMMENT '候选人姓名',
  `user_phone` varchar(20) DEFAULT NULL COMMENT '候选人电话',
  `user_votes` bigint(10) DEFAULT NULL COMMENT '候选人票数',
  `user_desc` varchar(200) DEFAULT NULL COMMENT '候选人描述',
  `reserve_1` varchar(255) DEFAULT NULL COMMENT '预留字段1',
  `reserve_2` varchar(255) DEFAULT NULL COMMENT '预留字段2',
  `create_date` datetime DEFAULT NULL COMMENT '预留字段3',
  PRIMARY KEY (`user_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_vote_candidate
-- ----------------------------

-- ----------------------------
-- Table structure for `tb_vote_candidate_pic`
-- ----------------------------
DROP TABLE IF EXISTS `tb_vote_candidate_pic`;
CREATE TABLE `tb_vote_candidate_pic` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `unit_id` bigint(20) DEFAULT NULL COMMENT '单位id',
  `candidate_id` bigint(20) NOT NULL COMMENT '候选人id',
  `pic_file_name` varchar(255) DEFAULT NULL COMMENT '图片名称',
  `disk_file_name` varchar(255) DEFAULT NULL COMMENT '文件存储名称',
  `root_path` varchar(255) DEFAULT NULL COMMENT '根路径',
  `relative_path` varchar(255) DEFAULT NULL COMMENT '相对路径',
  `file_size` bigint(20) DEFAULT NULL COMMENT '文件大小',
  `file_suffix` varchar(20) DEFAULT NULL COMMENT '文件后缀（扩展名）',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `opt_user_id` bigint(20) DEFAULT NULL COMMENT '操作人员id',
  `opt_user_account` varchar(20) DEFAULT NULL COMMENT '操作账号',
  `opt_user_name` varchar(50) DEFAULT NULL COMMENT '操作人员名称',
  `if_enable` int(11) DEFAULT NULL COMMENT '是否启用',
  `ord` int(11) DEFAULT NULL COMMENT '图片顺序',
  `reserve_1` varchar(255) DEFAULT NULL COMMENT '预留字段1',
  `reserve_2` varchar(255) DEFAULT NULL COMMENT '预留字段2',
  `reserve_3` varchar(255) DEFAULT NULL COMMENT '预留字段3',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_vote_candidate_pic
-- ----------------------------

-- ----------------------------
-- Table structure for `tb_vote_item`
-- ----------------------------
DROP TABLE IF EXISTS `tb_vote_item`;
CREATE TABLE `tb_vote_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `unit_id` bigint(20) DEFAULT NULL COMMENT '单位id',
  `voter_id` bigint(20) NOT NULL COMMENT '投票人id',
  `candidate_id` bigint(20) NOT NULL COMMENT '候选人id',
  `create_date` datetime DEFAULT NULL COMMENT '投票时间',
  `reserve_1` varchar(255) DEFAULT NULL COMMENT '预留字段1',
  `reserve_2` varchar(255) DEFAULT NULL COMMENT '预留字段2',
  `reserve_3` varchar(255) DEFAULT NULL COMMENT '预留字段3',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_vote_item
-- ----------------------------

-- ----------------------------
-- Table structure for `tb_vote_join_item`
-- ----------------------------
DROP TABLE IF EXISTS `tb_vote_join_item`;
CREATE TABLE `tb_vote_join_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `unit_id` bigint(20) DEFAULT NULL COMMENT '单位id',
  `voter_id` bigint(20) NOT NULL COMMENT '投票人id',
  `if_joined` int(10) DEFAULT '0' COMMENT '是否已报名(0未报名1已报名)',
  `create_date` datetime DEFAULT NULL COMMENT '投票时间',
  `reserve_1` varchar(255) DEFAULT NULL COMMENT '预留字段1',
  `reserve_2` varchar(255) DEFAULT NULL COMMENT '预留字段2',
  `reserve_3` varchar(255) DEFAULT NULL COMMENT '预留字段3',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_vote_join_item
-- ----------------------------

-- ----------------------------
-- Table structure for `tb_vote_limit`
-- ----------------------------
DROP TABLE IF EXISTS `tb_vote_limit`;
CREATE TABLE `tb_vote_limit` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `unit_id` bigint(20) DEFAULT NULL COMMENT '单位id',
  `limit_times` int(10) DEFAULT NULL COMMENT '每日投票次数限定',
  `start_date` datetime DEFAULT NULL COMMENT '开始时间',
  `end_date` datetime DEFAULT NULL COMMENT '结束时间',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_date` datetime DEFAULT NULL COMMENT '修改时间',
  `if_enable` int(10) DEFAULT NULL COMMENT '是否启用',
  `reserve_1` varchar(255) DEFAULT NULL COMMENT '预留字段1',
  `reserve_2` varchar(255) DEFAULT NULL COMMENT '预留字段2',
  `reserve_3` varchar(255) DEFAULT NULL COMMENT '预留字段3',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_vote_limit
-- ----------------------------

-- ----------------------------
-- Table structure for `tb_vote_scan_record`
-- ----------------------------
DROP TABLE IF EXISTS `tb_vote_scan_record`;
CREATE TABLE `tb_vote_scan_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `unit_id` bigint(20) DEFAULT NULL COMMENT '单位id',
  `user_id` bigint(20) DEFAULT NULL COMMENT '浏览者id',
  `operate_os` varchar(100) DEFAULT NULL COMMENT '浏览者操作系统',
  `operate_browser` varchar(100) DEFAULT NULL COMMENT '浏览者浏览器',
  `operate_ip` varchar(100) DEFAULT NULL COMMENT '浏览者ip',
  `create_date` datetime DEFAULT NULL COMMENT '浏览时间',
  `reserve_1` varchar(255) DEFAULT NULL COMMENT '预留字段1',
  `reserve_2` varchar(255) DEFAULT NULL COMMENT '预留字段2',
  `reserve_3` varchar(255) DEFAULT NULL COMMENT '预留字段3',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_vote_scan_record
-- ----------------------------
