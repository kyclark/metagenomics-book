SET foreign_key_checks=0;

drop table if exists case_worker;
create table case_worker (
  case_worker_id int unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name varchar(100)
) ENGINE=InnoDB;

drop table if exists case_worker_to_client;

drop table if exists client_phone;
create table client_phone (
  client_phone_id int unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
  client_id int unsigned not null,
  phone varchar(50),
  type varchar(50),
  foreign key (client_id) references client (client_id) on delete cascade
) ENGINE=InnoDB;

drop table if exists client;
create table client (
  client_id int unsigned NOT NULL AUTO_INCREMENT,
  case_worker_id int unsigned default null,
  case_num int unsigned not null default 0,
  first_name varchar(100) DEFAULT NULL,
  last_name varchar(100) DEFAULT NULL,
  aka varchar(100) default null,
  dob date default null,
  sex enum('U', 'M', 'F') null default 'U',
  ethnicity varchar(50) default null,
  race varchar(50) default null,
  is_homeless enum('Y', 'N') default 'N',
  is_disabled enum('Y', 'N') default 'N',
  is_employed enum('Y', 'N') default 'N',
  marital_status varchar(100),
  original_date_service date default null,
  address_street varchar(100) default null,
  address_city varchar(100) default null,
  address_state varchar(100) default null,
  address_zip varchar(100) default null,
  email varchar(255) default null,
  notes text,
  KEY last_name (last_name),
  foreign key (case_worker_id) references case_worker (case_worker_id) on delete cascade,
  PRIMARY KEY (client_id)
) ENGINE=InnoDB;

drop table if exists dependent;
create table dependent (
  dependent_id int unsigned NOT NULL AUTO_INCREMENT primary key,
  client_id int unsigned NOT NULL,
  first_name varchar(100) DEFAULT NULL,
  last_name varchar(100) DEFAULT NULL,
  sex enum('U', 'M', 'F') null default 'U',
  relationship varchar(100) DEFAULT NULL,
  dob date default null,
  ethnicity varchar(50) default null,
  race varchar(50) default null,
  is_disabled enum('Y', 'N') default 'N',
  foreign key (client_id) references client (client_id) on delete cascade
) ENGINE=InnoDB;
