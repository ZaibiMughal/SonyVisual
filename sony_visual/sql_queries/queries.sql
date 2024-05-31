alter table user rename to sac_user;
alter table sac_user add column first_name varchar(255) not null default '';
alter table sac_user add column last_name varchar(255) not null default '';
alter table sac_user add column cell_phone varchar(255) not null default '';
alter table sac_user add column user_type int not null default 1;
alter table sac_user add column updated_by int not null default 1;
alter table sac_user ADD CONSTRAINT fk_user_type FOREIGN KEY (user_type) REFERENCES user_type (id);
alter table sac_user ADD CONSTRAINT fk_updated_by FOREIGN KEY (updated_by) REFERENCES sac_user (id);
alter table sac_user drop column username;
-- alter table sac_user drop column created_at;
-- alter table sac_user drop column updated_at;
-- alter table sac_user add column created TIMESTAMP default now();
-- alter table sac_user add column updated TIMESTAMP default now();
-- ALTER TABLE sac_user ALTER COLUMN created_at TYPE int not null DEFAULT TIMESTAMP 'epoch';
-- alter table sac_user add column created_at bigint not null DEFAULT (date_part('epoch'::text, now()) * (1000)::double precision);
-- alter table sac_user add column updated_at bigint not null DEFAULT (date_part('epoch'::text, now()) * (1000)::double precision);

-- pgsql --
set timezone TO 'Asia/Karachi';

-- mysql --


insert into user_type(name) values('Employee');
insert into user_type(name) values('Manager');
insert into user_type(name) values('Customer');

insert into user_type(name) values('User');
insert into user_type(name) values('Admin');

insert into sac_user(auth_key,password_hash,email,status,created_at,updated_at,first_name,last_name,cell_phone,user_type) values('EDGXddzns3DB5GYcAi_Y0lE7Nk6Tt-eB','$2y$13$pDfdiMRgoPsZge2GYOE7U.0gpKfHTM53JYoWrjPPt67aB21zy7A5e','admin@gmail.com',10,1660574397,1660574397,'Demo','Manager','03001234567',5);
-- Disable authentication in login form for login and create new Manager


create table video_post(
      id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
      user_id int not null,
      title varchar(255) NOT NULL,
      description varchar(1000) NOT NULL,
      url varchar(1000) NOT NULL,
      privacy int NOT NULL DEFAULT 0,
      category varchar(1000) NULL,
      created TIMESTAMP DEFAULT now(),
      CONSTRAINT fk_user FOREIGN KEY(user_id) REFERENCES sac_user(id)
);


create table posts(
      id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
      author_id int not null,
      title varchar(255) NOT NULL,
      description varchar(1000) NOT NULL,
      created TIMESTAMP DEFAULT now()
);

create table product_type(
      id serial primary key,
      name varchar(255) NOT NULL,
      created TIMESTAMP DEFAULT now()
);
create table payment_type(
     id serial primary key,
     name varchar(255) NOT NULL,
     created TIMESTAMP DEFAULT now()
);
create table product_color(
     id serial primary key,
     name varchar(255) NOT NULL,
     created TIMESTAMP DEFAULT now()
);
create table product_company(
     id serial primary key,
     name varchar(255) NOT NULL,
     created TIMESTAMP DEFAULT now()
);
create table user_type(
    id serial primary key,
    name varchar(255) NOT NULL,
    created TIMESTAMP DEFAULT now()
);
create table customer(
      id serial primary key,
      cnic varchar(255) NOT NULL,
      address varchar(500) NOT NULL,
      photo varchar(250) NOT NULL,
      user_id int not null,
      created TIMESTAMP DEFAULT now(),
      CONSTRAINT fk_user FOREIGN KEY(user_id) REFERENCES sac_user(id)
);
create table product_model(
    id serial primary key,
    type int not null,
    company int not null,
    model varchar(255) not null,
    price bigint not null,
    created TIMESTAMP DEFAULT now(),
    updated TIMESTAMP not null,
    updated_by int not null,
    CONSTRAINT fk_type FOREIGN KEY(type) REFERENCES product_type(id),
    CONSTRAINT fk_company FOREIGN KEY(company) REFERENCES product_company(id),
    CONSTRAINT fk_updated_by FOREIGN KEY(updated_by) REFERENCES sac_user(id)
);
create table product(
      id serial primary key,
      product_model_id int not null,
      color int not null,
      engine_no varchar(255),
      chassis_no varchar(255),
      order_no int not null,
      created TIMESTAMP DEFAULT now(),
      updated TIMESTAMP not null,
      updated_by int not null,
      CONSTRAINT fk_product_model FOREIGN KEY(product_model_id) REFERENCES product_model(id),
      CONSTRAINT fk_color FOREIGN KEY(color) REFERENCES product_color(id),
      CONSTRAINT fk_updated_by FOREIGN KEY(updated_by) REFERENCES sac_user(id),
      CONSTRAINT fk_order_no FOREIGN KEY(order_no) REFERENCES product_order(order_no)
);
create table product_booking(
    id serial primary key,
    customer int not null,
    product int not null,
    payment_type int not null,
    created TIMESTAMP DEFAULT now(),
    updated TIMESTAMP not null,
    updated_by int not null,
    down_payment int not null,
    total_months_plan int,
    status_id smallint not null,
    whole_sale_price bigint not null,
    price bigint not null,
    account_no int not null,
    reference_id varchar(255) not null,
    customer_of_whom varchar(255) not null,
    payment_per_installment int,
    CONSTRAINT fk_customer FOREIGN KEY(customer) REFERENCES customer(id),
    CONSTRAINT fk_product FOREIGN KEY(product) REFERENCES product(id),
    CONSTRAINT fk_payment_plan FOREIGN KEY(payment_type) REFERENCES payment_type(id),
    CONSTRAINT fk_updated_by FOREIGN KEY(updated_by) REFERENCES sac_user(id)
);
create table booking_installment(
    id serial primary key,
    booking_id int not null,
    due_date TIMESTAMP not null,
    status_id smallint not null,
    payment int not null,
    pre_balance int,
    rem_balance int,
    created TIMESTAMP DEFAULT now(),
    updated TIMESTAMP not null,
    updated_by int not null,
    received_by int,
    received_on TIMESTAMP,
    received_place varchar(1000),
    comments varchar(1000),
    CONSTRAINT fk_booking_id FOREIGN KEY(booking_id) REFERENCES product_booking(id),
    CONSTRAINT fk_updated_by FOREIGN KEY(updated_by) REFERENCES sac_user(id),
    CONSTRAINT fk_received_by FOREIGN KEY(received_by) REFERENCES sac_user(id)
);
create table product_registration(
    id serial primary key,
    booking_id int not null,
    registration_no varchar(255) not null,
    card_received smallint not null,
    created TIMESTAMP DEFAULT now(),
    updated TIMESTAMP not null,
    date_registered TIMESTAMP not null,
    updated_by int not null,
    CONSTRAINT fk_booking_id FOREIGN KEY(booking_id) REFERENCES product_booking(id),
    CONSTRAINT fk_updated_by FOREIGN KEY(updated_by) REFERENCES sac_user(id)
);
create table product_order(
     id serial primary key,
     order_no int not null unique,
     quantity int not null,
     created TIMESTAMP DEFAULT now(),
     updated TIMESTAMP not null,
     updated_by int not null,
     CONSTRAINT fk_updated_by FOREIGN KEY(updated_by) REFERENCES sac_user(id)
);
create table print_log(
      id serial primary key,
      class varchar(255) not null,
      class_model_id int not null,
      created TIMESTAMP DEFAULT now()
);
create table vendor_order(
      id serial primary key,
      order_no int not null unique,
      reference_no int not null,
      order_date TIMESTAMP not null,
      delivery_date TIMESTAMP,
      is_delivered int not null default 0,
      amount_paid bigint not null,
      created TIMESTAMP DEFAULT now()
);
create table vendor_order_products(
      id serial primary key,
      order_no int not null,
      product_model_id int not null,
      quantity int not null,
      created TIMESTAMP DEFAULT now(),
    CONSTRAINT fk_order_no FOREIGN KEY(order_no) REFERENCES vendor_order(order_no),
    CONSTRAINT fk_product_model_id FOREIGN KEY (product_model_id) REFERENCES product_model(id)
);

create table backup(
     id serial primary key,
     backup_name varchar(255) not null,
     backup_done_on TIMESTAMP DEFAULT now()
);


insert into user_type(name) values('Manager');
insert into user_type(name) values('Customer');


insert into product_type(name) values('Motor Bike');
insert into product_type(name) values('Fridge');
insert into product_type(name) values('Air Conditioner');
insert into product_type(name) values('Fridge');
insert into product_type(name) values('Oven');

insert into product_color(name) values('Red');
insert into product_color(name) values('Black');
insert into product_color(name) values('White');
insert into product_color(name) values('Grey');

insert into product_company(name) values('Gree');
insert into product_company(name) values('Haier');
insert into product_company(name) values('Honda');
insert into product_company(name) values('Suzuki');
insert into product_company(name) values('Dawlance');

alter table product_booking add column price bigint not null;
alter table product_booking alter column reference_id set not null;
alter table product_booking alter column reference_id type varchar(255) not null;


-- Mysql --
ALTER TABLE sac_user MODIFY columnname INTEGER;


pg_dump salamat > salamat.sql
