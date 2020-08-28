DROP TABLE IF EXISTS filedrop;

CREATE TABLE filedrop (
  id int(11) NOT NULL AUTO_INCREMENT,
  uploader varchar(255) NOT NULL DEFAULT '',
  uploader_fullname varchar(255) DEFAULT NULL,
  created timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  upload_key varchar(255) NOT NULL DEFAULT '',
  download_key varchar(255) NOT NULL DEFAULT '',
  encrypt_key varchar(255) NOT NULL DEFAULT '',
  valid_until timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  is_valid char(1) NOT NULL DEFAULT 'Y',
  require_auth char(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (id),
  UNIQUE KEY download_key (download_key),
  UNIQUE KEY upload_key (upload_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS download;

CREATE TABLE download (
  id int(11) NOT NULL AUTO_INCREMENT,
  filedrop_id int(11) NOT NULL DEFAULT '0',
  file_name varchar(255) NOT NULL DEFAULT '',
  status_code VARCHAR(48) NOT NULL default 'INPROGRESS',
  started timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  completed timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  ip_addr varchar(16) NOT NULL DEFAULT '',
  PRIMARY KEY (id),
  CONSTRAINT download_ibfk_1 FOREIGN KEY (filedrop_id) REFERENCES filedrop (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS fd_fileset;

CREATE TABLE fd_fileset (
  filedrop_id int(11) NOT NULL DEFAULT '0',
  file_name varchar(255) NOT NULL DEFAULT '',
  type varchar(255) NOT NULL DEFAULT '',
  comment varchar(255) NOT NULL DEFAULT '',
  size BIGINT NOT NULL DEFAULT '0',
  id int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (id),
  CONSTRAINT file_data_ibfk_1 FOREIGN KEY (filedrop_id) REFERENCES filedrop (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS recipient;

CREATE TABLE recipient (
  id int(11) NOT NULL AUTO_INCREMENT,
  filedrop_id int(11) NOT NULL,
  name varchar(255) NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT recipient_ibfk_1 FOREIGN KEY (filedrop_id) REFERENCES filedrop (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS qrtz_job_details;

CREATE TABLE qrtz_job_details (
  JOB_NAME varchar(80) NOT NULL DEFAULT '',
  JOB_GROUP varchar(80) NOT NULL DEFAULT '',
  DESCRIPTION varchar(120) DEFAULT NULL,
  JOB_CLASS_NAME varchar(128) NOT NULL DEFAULT '',
  IS_DURABLE char(1) NOT NULL DEFAULT '',
  IS_VOLATILE char(1) NOT NULL DEFAULT '',
  IS_STATEFUL char(1) NOT NULL DEFAULT '',
  REQUESTS_RECOVERY char(1) NOT NULL DEFAULT '',
  JOB_DATA blob,
  PRIMARY KEY (JOB_NAME,JOB_GROUP)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS qrtz_triggers;

CREATE TABLE qrtz_triggers (
  TRIGGER_NAME varchar(80) NOT NULL DEFAULT '',
  TRIGGER_GROUP varchar(80) NOT NULL DEFAULT '',
  JOB_NAME varchar(80) NOT NULL DEFAULT '',
  JOB_GROUP varchar(80) NOT NULL DEFAULT '',
  IS_VOLATILE char(1) NOT NULL DEFAULT '',
  DESCRIPTION varchar(120) DEFAULT NULL,
  NEXT_FIRE_TIME bigint(13) DEFAULT NULL,
  PREV_FIRE_TIME bigint(13) DEFAULT NULL,
  TRIGGER_STATE varchar(16) NOT NULL DEFAULT '',
  TRIGGER_TYPE varchar(8) NOT NULL DEFAULT '',
  START_TIME bigint(13) NOT NULL DEFAULT '0',
  END_TIME bigint(13) DEFAULT NULL,
  CALENDAR_NAME varchar(80) DEFAULT NULL,
  MISFIRE_INSTR smallint(2) DEFAULT NULL,
  JOB_DATA blob,
  PRIMARY KEY (TRIGGER_NAME,TRIGGER_GROUP),
  KEY JOB_NAME (JOB_NAME,JOB_GROUP),
  CONSTRAINT QRTZ_TRIGGERS_ibfk_1 FOREIGN KEY (JOB_NAME, JOB_GROUP) REFERENCES qrtz_job_details (JOB_NAME, JOB_GROUP)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS qrtz_blob_triggers;

CREATE TABLE qrtz_blob_triggers (
  TRIGGER_NAME varchar(80) NOT NULL DEFAULT '',
  TRIGGER_GROUP varchar(80) NOT NULL DEFAULT '',
  BLOB_DATA blob,
  PRIMARY KEY (TRIGGER_NAME,TRIGGER_GROUP),
  KEY TRIGGER_NAME (TRIGGER_NAME,TRIGGER_GROUP),
  CONSTRAINT QRTZ_BLOB_TRIGGERS_ibfk_1 FOREIGN KEY (TRIGGER_NAME, TRIGGER_GROUP) REFERENCES qrtz_triggers (TRIGGER_NAME, TRIGGER_GROUP)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS qrtz_calendars;

CREATE TABLE qrtz_calendars (
  CALENDAR_NAME varchar(80) NOT NULL DEFAULT '',
  CALENDAR blob NOT NULL,
  PRIMARY KEY (CALENDAR_NAME)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS qrtz_cron_triggers;

CREATE TABLE qrtz_cron_triggers (
  TRIGGER_NAME varchar(80) NOT NULL DEFAULT '',
  TRIGGER_GROUP varchar(80) NOT NULL DEFAULT '',
  CRON_EXPRESSION varchar(80) NOT NULL DEFAULT '',
  TIME_ZONE_ID varchar(80) DEFAULT NULL,
  PRIMARY KEY (TRIGGER_NAME,TRIGGER_GROUP),
  CONSTRAINT QRTZ_CRON_TRIGGERS_ibfk_1 FOREIGN KEY (TRIGGER_NAME, TRIGGER_GROUP) REFERENCES qrtz_triggers (TRIGGER_NAME, TRIGGER_GROUP)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS qrtz_fired_triggers;

CREATE TABLE qrtz_fired_triggers (
  ENTRY_ID varchar(95) NOT NULL DEFAULT '',
  TRIGGER_NAME varchar(80) NOT NULL DEFAULT '',
  TRIGGER_GROUP varchar(80) NOT NULL DEFAULT '',
  IS_VOLATILE char(1) NOT NULL DEFAULT '',
  INSTANCE_NAME varchar(80) NOT NULL DEFAULT '',
  FIRED_TIME bigint(13) NOT NULL DEFAULT '0',
  STATE varchar(16) NOT NULL DEFAULT '',
  JOB_NAME varchar(80) DEFAULT NULL,
  JOB_GROUP varchar(80) DEFAULT NULL,
  IS_STATEFUL char(1) DEFAULT NULL,
  REQUESTS_RECOVERY char(1) DEFAULT NULL,
  PRIMARY KEY (ENTRY_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS qrtz_job_listeners;

CREATE TABLE qrtz_job_listeners (
  JOB_NAME varchar(80) NOT NULL DEFAULT '',
  JOB_GROUP varchar(80) NOT NULL DEFAULT '',
  JOB_LISTENER varchar(80) NOT NULL DEFAULT '',
  PRIMARY KEY (JOB_NAME,JOB_GROUP,JOB_LISTENER),
  CONSTRAINT QRTZ_JOB_LISTENERS_ibfk_1 FOREIGN KEY (JOB_NAME, JOB_GROUP) REFERENCES qrtz_job_details (JOB_NAME, JOB_GROUP)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS qrtz_locks;

CREATE TABLE qrtz_locks (
  LOCK_NAME varchar(40) NOT NULL DEFAULT '',
  PRIMARY KEY (LOCK_NAME)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS qrtz_paused_trigger_grps;

CREATE TABLE qrtz_paused_trigger_grps (
  TRIGGER_GROUP varchar(80) NOT NULL DEFAULT '',
  PRIMARY KEY (TRIGGER_GROUP)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS qrtz_scheduler_state;

CREATE TABLE qrtz_scheduler_state (
  INSTANCE_NAME varchar(80) NOT NULL DEFAULT '',
  LAST_CHECKIN_TIME bigint(13) NOT NULL DEFAULT '0',
  CHECKIN_INTERVAL bigint(13) NOT NULL DEFAULT '0',
  RECOVERER varchar(80) DEFAULT NULL,
  PRIMARY KEY (INSTANCE_NAME)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS qrtz_simple_triggers;

CREATE TABLE qrtz_simple_triggers (
  TRIGGER_NAME varchar(80) NOT NULL DEFAULT '',
  TRIGGER_GROUP varchar(80) NOT NULL DEFAULT '',
  REPEAT_COUNT bigint(7) NOT NULL DEFAULT '0',
  REPEAT_INTERVAL bigint(12) NOT NULL DEFAULT '0',
  TIMES_TRIGGERED bigint(7) NOT NULL DEFAULT '0',
  PRIMARY KEY (TRIGGER_NAME,TRIGGER_GROUP),
  CONSTRAINT QRTZ_SIMPLE_TRIGGERS_ibfk_1 FOREIGN KEY (TRIGGER_NAME, TRIGGER_GROUP) REFERENCES qrtz_triggers (TRIGGER_NAME, TRIGGER_GROUP)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS qrtz_trigger_listeners;

CREATE TABLE qrtz_trigger_listeners (
  TRIGGER_NAME varchar(80) NOT NULL DEFAULT '',
  TRIGGER_GROUP varchar(80) NOT NULL DEFAULT '',
  TRIGGER_LISTENER varchar(80) NOT NULL DEFAULT '',
  PRIMARY KEY (TRIGGER_NAME,TRIGGER_GROUP,TRIGGER_LISTENER),
  CONSTRAINT QRTZ_TRIGGER_LISTENERS_ibfk_1 FOREIGN KEY (TRIGGER_NAME, TRIGGER_GROUP) REFERENCES qrtz_triggers (TRIGGER_NAME, TRIGGER_GROUP)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS message;

CREATE TABLE message (
  msg_id int(11) NOT NULL AUTO_INCREMENT,
  msg_enabled char(1) NOT NULL DEFAULT 'Y',
  msg_type_id int(11) NOT NULL,
  msg_text varchar(1000) NOT NULL,
  PRIMARY KEY (msg_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS validation;

CREATE TABLE validation (
  address varchar(64) NOT NULL DEFAULT '',
  name varchar(64) DEFAULT NULL,
  vkey varchar(64) NOT NULL DEFAULT '',
  created timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  ip_addr varchar(32) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS allowlist;

CREATE TABLE allowlist (
  id int(11) NOT NULL AUTO_INCREMENT,
  entry varchar(128) NOT NULL,
  registrant varchar(128) NOT NULL,
  created timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  expiration_check int(11) NOT NULL,
  expired bit NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS person;

CREATE TABLE person (
  id int(11) NOT NULL AUTO_INCREMENT,
  uhuuid varchar(32) NOT NULL,
  name varchar(255) NOT NULL,
  username varchar(255) NOT NULL,
  email varchar(255) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE (uhuuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE role (
  id int(11) NOT NULL AUTO_INCREMENT,
  description varchar(255) NOT NULL,
  role varchar(255) NOT NULL,
  security_role varchar(255) NOT NULL,
  PRIMARY KEY(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE campus (
  id int(11) NOT NULL AUTO_INCREMENT,
  code varchar(3) NOT NULL,  
  actual char(1) NOT NULL DEFAULT 'Y',
  description varchar(255) NOT NULL,
  PRIMARY KEY(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE office (
  id int(11) NOT NULL AUTO_INCREMENT,
  campus_id int(11) NOT NULL,
  description varchar(255) NOT NULL,
  sort_id int(11) NOT NULL,
  PRIMARY KEY(id),
  CONSTRAINT office_ibfk_1 FOREIGN KEY (campus_id) REFERENCES campus (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE system_role (
  id int(11) NOT NULL,
  person_id int(11) NOT NULL,
  role_id int(11) NOT NULL,
  office_id int(11) NOT NULL,
  PRIMARY KEY(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE setting (
  id int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  value varchar(255) NOT NULL,
  PRIMARY KEY(id),
  UNIQUE (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;