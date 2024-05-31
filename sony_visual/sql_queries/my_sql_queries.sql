create table user_type(
  id INT AUTO_INCREMENT PRIMARY KEY,
  name varchar(255) NOT NULL,
  created TIMESTAMP DEFAULT now()
);

insert into user_type(name) values('Employee');
insert into user_type(name) values('Manager');
insert into user_type(name) values('Customer');

alter table user rename to sac_user;
alter table sac_user drop username;
alter table sac_user add column first_name varchar(255) not null default '';
alter table sac_user add column last_name varchar(255) not null default '';
alter table sac_user add column cell_phone varchar(255) not null default '';
alter table sac_user add column user_type int not null default 1;
alter table sac_user add column updated_by int not null default 1;
alter table sac_user ADD CONSTRAINT fk_user_type FOREIGN KEY (user_type) REFERENCES user_type (id);


alter table sac_user ADD CONSTRAINT fk_updated_by FOREIGN KEY (updated_by) REFERENCES sac_user (id);
-- alter table sac_user drop column created_at;
-- alter table sac_user drop column updated_at;
-- alter table sac_user add column created TIMESTAMP default now();
-- alter table sac_user add column updated TIMESTAMP default now();
-- ALTER TABLE sac_user ALTER COLUMN created_at TYPE int not null DEFAULT TIMESTAMP 'epoch';
-- alter table sac_user add column created_at bigint not null DEFAULT (date_part('epoch'::text, now()) * (1000)::double precision);
-- alter table sac_user add column updated_at bigint not null DEFAULT (date_part('epoch'::text, now()) * (1000)::double precision);

-- pgsql --
set timezone TO 'GMT';

-- mysql --



insert into user_type(name) values ('Employee'),('Manager'),('Customer');
insert into sac_user(auth_key,password_hash,email,status,created_at,updated_at,first_name,last_name,cell_phone,user_type) values('EDGXddzns3DB5GYcAi_Y0lE7Nk6Tt-eB','$2y$13$pDfdiMRgoPsZge2GYOE7U.0gpKfHTM53JYoWrjPPt67aB21zy7A5e','demo@gmail.com',10,1660574397,1660574397,'Demo','Manager','03001234567',2);
-- Disable authentication in login form for login and create new Manager

alter table event add start_time_epoch bigint;

create table contact_us(
        id int AUTO_INCREMENT PRIMARY KEY,
        name varchar(255) not null,
        email varchar(255) not null,
        message varchar(500) not null
);


create table event_portfolio(
       id int AUTO_INCREMENT PRIMARY KEY,
       filename varchar(255) not null
);

-- create table meetup(
--        id int AUTO_INCREMENT PRIMARY KEY,
--        address varchar(500) not null,
--        map_url varchar(500) not null,
--        timings varchar(255),
--        filename varchar(255),
--        is_repeat smallint not null
-- );


create table meetup(
       id int AUTO_INCREMENT PRIMARY KEY,
       address varchar(500) not null,
       title varchar(255) not null,
       description text not null,
       map_url varchar(500) not null,
       filename varchar(255),
       location_id int not null,
       FOREIGN KEY (location_id) REFERENCES location(id)
);

create table venue(
        id int AUTO_INCREMENT PRIMARY KEY,
        title varchar(255) not null,
        description text not null,
        address varchar(500) not null,
        map_url varchar(500) not null,
        filename varchar(255),
        location_id int not null,
        FOREIGN KEY (location_id) REFERENCES location(id)
);

create table about(
      id int AUTO_INCREMENT PRIMARY KEY,
      description text not null
);

create table location(
      id int AUTO_INCREMENT PRIMARY KEY,
      name varchar(255) not null
);

insert into location(name) values ('UK'),('Europe'),('Worldwide');

alter table event add location_id int not null default 1;

alter table event MODIFY filename varchar(255);


create table region(
      id int AUTO_INCREMENT PRIMARY KEY,
      title varchar(255) not null,
      location_id int not null,
      FOREIGN KEY (location_id) REFERENCES location(id)
);


alter table venue add sort_id smallint not null default 0;
alter table venue add region_id int;
alter table venue ADD CONSTRAINT fk_region_id FOREIGN KEY (region_id) REFERENCES region (id);

alter table meetup add region_id int;
alter table meetup ADD CONSTRAINT fk_meetup FOREIGN KEY (region_id) REFERENCES region (id);

alter table meetup add sort_id smallint not null default 0;
alter table meetup add is_session smallint not null default 0;

mysqldump -u root -p salamat > salamat_mysql.sql
