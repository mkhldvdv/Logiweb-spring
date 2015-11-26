prompt PL/SQL Developer import file
prompt Created on 27 Ноябрь 2015 г. by mkhldvdv
set feedback off
set define off
prompt Dropping CARGO_STATUSES...
drop table CARGO_STATUSES cascade constraints;
prompt Dropping CARGOS...
drop table CARGOS cascade constraints;
prompt Dropping CARGO_TYPES...
drop table CARGO_TYPES cascade constraints;
prompt Dropping CITIES...
drop table CITIES cascade constraints;
prompt Dropping MAP...
drop table MAP cascade constraints;
prompt Dropping ORDER_STATUSES...
drop table ORDER_STATUSES cascade constraints;
prompt Dropping TRUCK_STATUSES...
drop table TRUCK_STATUSES cascade constraints;
prompt Dropping TRUCKS...
drop table TRUCKS cascade constraints;
prompt Dropping ORDERS...
drop table ORDERS cascade constraints;
prompt Dropping USER_STATUSES...
drop table USER_STATUSES cascade constraints;
prompt Dropping ROLES...
drop table ROLES cascade constraints;
prompt Dropping USERS...
drop table USERS cascade constraints;
prompt Dropping ORDER_DRIVER...
drop table ORDER_DRIVER cascade constraints;
prompt Dropping SEQUENCES...
drop table SEQUENCES cascade constraints;
prompt Dropping WAYPOINTS...
drop table WAYPOINTS cascade constraints;
prompt Creating CARGO_STATUSES...
create table CARGO_STATUSES
(
  cargo_status_id   NUMBER not null,
  cargo_status_name VARCHAR2(30) not null
)
;
alter table CARGO_STATUSES
  add constraint CARGO_STATUS_PK primary key (CARGO_STATUS_ID);

prompt Creating CARGOS...
create table CARGOS
(
  cargo_id        NUMBER not null,
  cargo_name      VARCHAR2(50) not null,
  weight          NUMBER not null,
  cargo_status_id NUMBER not null,
  deleted         NUMBER(1) default 0 not null
)
;
alter table CARGOS
  add constraint CARGO_PK primary key (CARGO_ID);
alter table CARGOS
  add constraint CARGO_STATUS_FK foreign key (CARGO_STATUS_ID)
  references CARGO_STATUSES (CARGO_STATUS_ID);
create index CARGO_STATUS_IDX on CARGOS (CARGO_STATUS_ID);

prompt Creating CARGO_TYPES...
create table CARGO_TYPES
(
  cargo_type_id   NUMBER not null,
  cargo_type_name VARCHAR2(30) not null
)
;
alter table CARGO_TYPES
  add constraint CARGO_TYPE_PK primary key (CARGO_TYPE_ID);

prompt Creating CITIES...
create table CITIES
(
  city_id   NUMBER not null,
  city_name VARCHAR2(50) not null
)
;
alter table CITIES
  add constraint CITY_PK primary key (CITY_ID);
alter table CITIES
  add constraint CITY_NAME_UK unique (CITY_NAME);

prompt Creating MAP...
create table MAP
(
  map_id   NUMBER not null,
  city_id1 NUMBER not null,
  city_id2 NUMBER not null,
  distance NUMBER not null
)
;
alter table MAP
  add constraint MAP_PK primary key (MAP_ID);
alter table MAP
  add constraint MAP_CITY1_CITY2_UK unique (CITY_ID1, CITY_ID2);
alter table MAP
  add constraint MAP_CITY_ID1_FK foreign key (CITY_ID1)
  references CITIES (CITY_ID) on delete cascade;
alter table MAP
  add constraint MAP_CITY_ID2_FK foreign key (CITY_ID2)
  references CITIES (CITY_ID) on delete cascade;
create index MAP_CITY1_IDX on MAP (CITY_ID1);
create index MAP_CITY2_IDX on MAP (CITY_ID2);

prompt Creating ORDER_STATUSES...
create table ORDER_STATUSES
(
  order_status_id   NUMBER not null,
  order_status_name VARCHAR2(30) not null
)
;
alter table ORDER_STATUSES
  add constraint ORDER_STATUS_PK primary key (ORDER_STATUS_ID);

prompt Creating TRUCK_STATUSES...
create table TRUCK_STATUSES
(
  truck_status_id   NUMBER not null,
  truck_status_name VARCHAR2(30)
)
;
alter table TRUCK_STATUSES
  add constraint TRUCK_STATUS_PK primary key (TRUCK_STATUS_ID);

prompt Creating TRUCKS...
create table TRUCKS
(
  truck_id        NUMBER not null,
  reg_num         VARCHAR2(7) not null,
  driver_count    NUMBER not null,
  capacity        NUMBER not null,
  truck_status_id NUMBER not null,
  city_id         NUMBER not null,
  deleted         NUMBER(1) default 0 not null
)
;
alter table TRUCKS
  add constraint TRUCK_PK primary key (TRUCK_ID);
alter table TRUCKS
  add constraint REG_NUM_UK unique (REG_NUM);
alter table TRUCKS
  add constraint TRUCK_CITY_FK foreign key (CITY_ID)
  references CITIES (CITY_ID);
alter table TRUCKS
  add constraint TRUCK_STATUS_FK foreign key (TRUCK_STATUS_ID)
  references TRUCK_STATUSES (TRUCK_STATUS_ID);
create index TRUCK_CITY_IDX on TRUCKS (CITY_ID);
create index TRUCK_STATUS_IDX on TRUCKS (TRUCK_STATUS_ID);

prompt Creating ORDERS...
create table ORDERS
(
  order_id        NUMBER not null,
  order_status_id NUMBER not null,
  truck_id        NUMBER not null,
  deleted         NUMBER(1) default 0 not null
)
;
alter table ORDERS
  add constraint ORDER_PK primary key (ORDER_ID);
alter table ORDERS
  add constraint ORDER_STATUS_FK foreign key (ORDER_STATUS_ID)
  references ORDER_STATUSES (ORDER_STATUS_ID);
alter table ORDERS
  add constraint ORDER_TRUCK_FK foreign key (TRUCK_ID)
  references TRUCKS (TRUCK_ID);
create index ORDER_STATUS_IDX on ORDERS (ORDER_STATUS_ID);
create index ORDER_TRUCK_IDX on ORDERS (TRUCK_ID);

prompt Creating USER_STATUSES...
create table USER_STATUSES
(
  user_status_id   NUMBER not null,
  user_status_name VARCHAR2(30) not null
)
;
alter table USER_STATUSES
  add constraint USER_STATUS_PK primary key (USER_STATUS_ID);

prompt Creating ROLES...
create table ROLES
(
  role_id   NUMBER not null,
  role_name VARCHAR2(30) not null
)
;
alter table ROLES
  add constraint ROLE_PK primary key (ROLE_ID);

prompt Creating USERS...
create table USERS
(
  user_id        NUMBER not null,
  first_name     VARCHAR2(30) not null,
  last_name      VARCHAR2(30) not null,
  login          VARCHAR2(8) not null,
  password       VARCHAR2(256) not null,
  role_id        NUMBER not null,
  hours          NUMBER,
  user_status_id NUMBER,
  city_id        NUMBER,
  truck_id       NUMBER,
  deleted        NUMBER(1) default 0 not null
)
;
alter table USERS
  add constraint USER_PK primary key (USER_ID);
alter table USERS
  add constraint USER_LOGIN_UK unique (LOGIN);
alter table USERS
  add constraint USER_CITY_FK foreign key (CITY_ID)
  references CITIES (CITY_ID);
alter table USERS
  add constraint USER_ROLE_FK foreign key (ROLE_ID)
  references ROLES (ROLE_ID);
alter table USERS
  add constraint USER_TRUCK_FK foreign key (TRUCK_ID)
  references TRUCKS (TRUCK_ID);
alter table USERS
  add constraint USER_USER_STATUS_FK foreign key (USER_STATUS_ID)
  references USER_STATUSES (USER_STATUS_ID);
create index USER_CITY_IDX on USERS (CITY_ID);
create index USER_ROLE_IDX on USERS (ROLE_ID);
create index USER_TRUCK_IDX on USERS (TRUCK_ID);
create index USER_USER_STATUS_IDX on USERS (USER_STATUS_ID);

prompt Creating ORDER_DRIVER...
create table ORDER_DRIVER
(
  order_driver_id NUMBER not null,
  order_id        NUMBER not null,
  user_id         NUMBER not null
)
;
alter table ORDER_DRIVER
  add constraint ORDER_DRIVER_PK primary key (ORDER_DRIVER_ID);
alter table ORDER_DRIVER
  add constraint ORDER_ID_FK foreign key (ORDER_ID)
  references ORDERS (ORDER_ID) on delete cascade;
alter table ORDER_DRIVER
  add constraint ORDER_USER_FK foreign key (USER_ID)
  references USERS (USER_ID) on delete cascade;
create index ORDER_IDX on ORDER_DRIVER (ORDER_ID);
create index ORDER_USER_IDX on ORDER_DRIVER (USER_ID);

prompt Creating SEQUENCES...
create table SEQUENCES
(
  seq_name  VARCHAR2(30) not null,
  seq_value NUMBER
)
;
alter table SEQUENCES
  add constraint SEQ_PK primary key (SEQ_NAME);

prompt Creating WAYPOINTS...
create table WAYPOINTS
(
  waypoint_id   NUMBER not null,
  order_id      NUMBER not null,
  city_id       NUMBER not null,
  cargo_id      NUMBER not null,
  cargo_type_id NUMBER not null
)
;
alter table WAYPOINTS
  add constraint WAYPOINT_PK primary key (WAYPOINT_ID);
alter table WAYPOINTS
  add constraint WAYPOINT_CARGO_FK foreign key (CARGO_ID)
  references CARGOS (CARGO_ID);
alter table WAYPOINTS
  add constraint WAYPOINT_CARGO_TYPE_FK foreign key (CARGO_TYPE_ID)
  references CARGO_TYPES (CARGO_TYPE_ID);
alter table WAYPOINTS
  add constraint WAYPOINT_CITY_FK foreign key (CITY_ID)
  references CITIES (CITY_ID);
alter table WAYPOINTS
  add constraint WAYPOINT_ORDER_FK foreign key (ORDER_ID)
  references ORDERS (ORDER_ID);
create index WAYPOINT_CARGO_IDX on WAYPOINTS (CARGO_ID);
create index WAYPOINT_CARGO_TYPE_IDX on WAYPOINTS (CARGO_TYPE_ID);
create index WAYPOINT_CITY_IDX on WAYPOINTS (CITY_ID);
create index WAYPOINT_ORDER_IDX on WAYPOINTS (ORDER_ID);

prompt Disabling triggers for CARGO_STATUSES...
alter table CARGO_STATUSES disable all triggers;
prompt Disabling triggers for CARGOS...
alter table CARGOS disable all triggers;
prompt Disabling triggers for CARGO_TYPES...
alter table CARGO_TYPES disable all triggers;
prompt Disabling triggers for CITIES...
alter table CITIES disable all triggers;
prompt Disabling triggers for MAP...
alter table MAP disable all triggers;
prompt Disabling triggers for ORDER_STATUSES...
alter table ORDER_STATUSES disable all triggers;
prompt Disabling triggers for TRUCK_STATUSES...
alter table TRUCK_STATUSES disable all triggers;
prompt Disabling triggers for TRUCKS...
alter table TRUCKS disable all triggers;
prompt Disabling triggers for ORDERS...
alter table ORDERS disable all triggers;
prompt Disabling triggers for USER_STATUSES...
alter table USER_STATUSES disable all triggers;
prompt Disabling triggers for ROLES...
alter table ROLES disable all triggers;
prompt Disabling triggers for USERS...
alter table USERS disable all triggers;
prompt Disabling triggers for ORDER_DRIVER...
alter table ORDER_DRIVER disable all triggers;
prompt Disabling triggers for SEQUENCES...
alter table SEQUENCES disable all triggers;
prompt Disabling triggers for WAYPOINTS...
alter table WAYPOINTS disable all triggers;
prompt Loading CARGO_STATUSES...
insert into CARGO_STATUSES (cargo_status_id, cargo_status_name)
values (0, 'n/a');
insert into CARGO_STATUSES (cargo_status_id, cargo_status_name)
values (1, 'prepared');
insert into CARGO_STATUSES (cargo_status_id, cargo_status_name)
values (2, 'delivered');
insert into CARGO_STATUSES (cargo_status_id, cargo_status_name)
values (3, 'unloaded');
commit;
prompt 4 records loaded
prompt Loading CARGOS...
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (1, 'berkelium', 435, 2, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (2, 'berkelium', 36, 3, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (3, 'nitrogen', 97, 3, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (4, 'curium', 40, 3, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (5, 'potassium', 24, 1, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (6, 'mercury', 11, 3, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (7, 'sodium', 201, 1, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (8, 'hafnium', 427, 2, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (9, 'californium', 172, 1, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (10, 'promethium', 474, 1, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (11, 'helium', 297, 1, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (12, 'arsenic', 182, 2, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (13, 'iron', 97, 1, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (14, 'lawrencium', 134, 2, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (15, 'cadmium', 58, 2, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (16, 'zinc', 215, 1, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (17, 'neodymium', 40, 2, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (18, 'manganese', 371, 3, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (19, 'tungsten', 161, 2, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (20, 'rhodium', 405, 3, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (21, 'actinium', 249, 1, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (22, 'osmium', 297, 3, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (23, 'molybdenum', 295, 1, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (24, 'antimony', 67, 3, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (25, 'titanium', 459, 2, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (26, 'silver', 157, 3, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (27, 'strontium', 111, 1, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (28, 'americium', 371, 3, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (29, 'cadmium', 351, 1, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (30, 'oxygen', 320, 3, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (31, 'cesium', 171, 1, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (32, 'holmium', 387, 3, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (33, 'magnesium', 14, 1, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (34, 'bromine', 266, 1, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (35, 'lithium', 451, 3, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (36, 'lead', 487, 1, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (37, 'titanium', 403, 2, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (38, 'germanium', 28, 2, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (39, 'francium', 302, 1, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (40, 'nobelium', 356, 3, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (41, 'silicon', 366, 3, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (42, 'carbon', 160, 1, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (43, 'erbium', 390, 2, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (44, 'cesium', 430, 1, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (45, 'uranium', 47, 3, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (46, 'sodium', 236, 3, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (47, 'aluminum', 207, 2, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (48, 'ytterbium', 393, 3, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (49, 'tungsten', 363, 1, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (50, 'strontium', 289, 2, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (51, 'niobium', 496, 3, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (52, 'cadmium', 131, 3, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (53, 'curium', 34, 2, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (54, 'gold', 293, 3, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (55, 'iridium', 274, 2, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (56, 'neon', 188, 2, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (57, 'iodine', 454, 3, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (58, 'curium', 129, 1, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (59, 'radium', 238, 3, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (60, 'thorium', 266, 3, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (61, 'erbium', 266, 2, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (62, 'hafnium', 48, 1, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (63, 'mendlevium', 282, 2, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (64, 'ytterbium', 173, 1, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (65, 'calcium', 237, 1, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (66, 'promethium', 147, 2, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (67, 'tin', 443, 2, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (68, 'samarium', 289, 3, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (69, 'yttrium', 283, 3, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (70, 'molybdenum', 339, 2, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (71, 'fluorine', 387, 1, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (72, 'protactinium', 54, 2, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (73, 'osmium', 422, 1, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (74, 'radium', 324, 3, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (75, 'krypton', 352, 3, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (76, 'rutherfordium', 399, 3, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (77, 'selenium', 248, 3, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (78, 'rhenium', 48, 1, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (79, 'rhenium', 140, 3, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (80, 'selenium', 278, 2, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (81, 'palladium', 378, 2, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (82, 'actinium', 161, 3, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (83, 'iridium', 69, 1, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (84, 'nobelium', 69, 3, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (85, 'mercury', 453, 1, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (86, 'americium', 28, 2, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (87, 'promethium', 449, 1, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (88, 'beryllium', 75, 2, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (89, 'neodymium', 94, 1, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (90, 'neodymium', 147, 3, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (91, 'xenon', 79, 1, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (92, 'polonium', 493, 1, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (93, 'lithium', 339, 1, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (94, 'radon', 158, 3, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (95, 'americium', 143, 3, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (96, 'boron', 400, 3, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (97, 'beryllium', 180, 1, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (98, 'iodine', 287, 1, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (99, 'chlorine', 256, 3, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (100, 'barium', 177, 2, 0);
commit;
prompt 100 records committed...
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (101, 'hydrogen', 458, 2, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (102, 'einsteinium', 326, 2, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (103, 'neptunium', 391, 3, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (104, 'arsenic', 497, 1, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (105, 'niobium', 396, 2, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (106, 'tungsten', 103, 1, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (107, 'boron', 362, 3, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (108, 'praseodymium', 332, 3, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (109, 'lutetium', 23, 2, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (110, 'germanium', 425, 1, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (111, 'aluminum', 282, 2, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (112, 'technetium', 355, 1, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (113, 'oxygen', 141, 3, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (114, 'praseodymium', 108, 3, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (115, 'radium', 43, 1, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (116, 'yttrium', 460, 2, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (117, 'iodine', 337, 3, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (118, 'strontium', 358, 1, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (119, 'bromine', 265, 2, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (120, 'bromine', 215, 2, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (121, 'hafnium', 417, 2, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (122, 'holmium', 330, 1, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (123, 'thulium', 304, 2, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (124, 'chromium', 314, 1, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (125, 'erbium', 382, 1, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (126, 'sulfur', 34, 3, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (127, 'neon', 181, 3, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (128, 'chlorine', 82, 3, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (129, 'hydrogen', 392, 3, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (130, 'tungsten', 314, 3, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (131, 'nobelium', 68, 1, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (132, 'fermium', 394, 2, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (133, 'phosphorus', 250, 1, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (134, 'polonium', 354, 2, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (135, 'tellurium', 248, 1, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (136, 'berkelium', 211, 1, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (137, 'rubidium', 347, 1, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (138, 'molybdenum', 106, 1, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (139, 'oxygen', 110, 2, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (140, 'sulfur', 470, 2, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (141, 'mercury', 164, 2, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (142, 'rutherfordium', 259, 2, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (143, 'promethium', 78, 2, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (144, 'neptunium', 131, 3, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (145, 'titanium', 202, 1, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (146, 'magnesium', 247, 3, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (147, 'rutherfordium', 107, 2, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (148, 'cobalt', 73, 1, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (149, 'indium', 479, 3, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (150, 'tellurium', 175, 3, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (151, 'mendlevium', 148, 3, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (152, 'actinium', 114, 3, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (153, 'terbium', 500, 3, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (154, 'holmium', 305, 1, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (155, 'samarium', 111, 3, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (156, 'lawrencium', 461, 3, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (157, 'cerium', 206, 3, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (158, 'terbium', 40, 2, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (159, 'silicon', 331, 2, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (160, 'oxygen', 196, 2, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (161, 'zirconium', 439, 1, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (162, 'titanium', 349, 2, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (163, 'holmium', 60, 3, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (164, 'europium', 200, 1, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (165, 'dysprosium', 451, 3, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (166, 'terbium', 296, 2, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (167, 'zirconium', 385, 3, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (168, 'cerium', 172, 2, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (169, 'cadmium', 331, 1, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (170, 'bismuth', 452, 1, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (171, 'cesium', 268, 2, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (172, 'calcium', 72, 1, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (173, 'lanthanum', 485, 3, 1);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (174, 'cesium', 406, 2, 0);
commit;
prompt 174 records loaded
prompt Loading CARGO_TYPES...
insert into CARGO_TYPES (cargo_type_id, cargo_type_name)
values (0, 'n/a');
insert into CARGO_TYPES (cargo_type_id, cargo_type_name)
values (1, 'load');
insert into CARGO_TYPES (cargo_type_id, cargo_type_name)
values (2, 'unload');
commit;
prompt 3 records loaded
prompt Loading CITIES...
insert into CITIES (city_id, city_name)
values (0, 'n/a');
insert into CITIES (city_id, city_name)
values (1, 'st petersburg');
insert into CITIES (city_id, city_name)
values (2, 'moskow');
insert into CITIES (city_id, city_name)
values (3, 'kyiv');
insert into CITIES (city_id, city_name)
values (4, 'minsk');
insert into CITIES (city_id, city_name)
values (5, 'copenhagen');
insert into CITIES (city_id, city_name)
values (6, 'helsinki');
insert into CITIES (city_id, city_name)
values (7, 'prague');
insert into CITIES (city_id, city_name)
values (8, 'berlin');
insert into CITIES (city_id, city_name)
values (9, 'paris');
insert into CITIES (city_id, city_name)
values (10, 'london');
commit;
prompt 11 records loaded
prompt Loading MAP...
prompt Table is empty
prompt Loading ORDER_STATUSES...
insert into ORDER_STATUSES (order_status_id, order_status_name)
values (0, 'n/a');
insert into ORDER_STATUSES (order_status_id, order_status_name)
values (1, 'complete');
insert into ORDER_STATUSES (order_status_id, order_status_name)
values (2, 'not complete');
commit;
prompt 3 records loaded
prompt Loading TRUCK_STATUSES...
insert into TRUCK_STATUSES (truck_status_id, truck_status_name)
values (2, 'not valid');
insert into TRUCK_STATUSES (truck_status_id, truck_status_name)
values (1, 'valid');
insert into TRUCK_STATUSES (truck_status_id, truck_status_name)
values (0, 'n/a');
commit;
prompt 3 records loaded
prompt Loading TRUCKS...
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (200, 'ac18490', 2, 17, 2, 1, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (201, 'id78450', 1, 12, 2, 9, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (202, 'ox00713', 2, 12, 1, 5, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (203, 'mx64508', 3, 18, 1, 2, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (204, 'ms34343', 3, 11, 1, 4, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (205, 'jr82932', 3, 19, 2, 2, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (206, 'qk72649', 2, 19, 2, 0, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (207, 'ei85221', 3, 19, 1, 9, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (208, 'at08483', 3, 12, 1, 6, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (209, 'ow67655', 3, 20, 2, 3, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (210, 'vj22090', 2, 13, 2, 2, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (211, 'bq94949', 2, 18, 2, 6, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (212, 'zd58874', 2, 15, 1, 5, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (213, 'xz09724', 2, 15, 2, 5, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (214, 'xa35508', 2, 10, 1, 3, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (215, 'ux74386', 1, 17, 2, 8, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (216, 'gy89372', 3, 16, 2, 2, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (217, 'rq96953', 2, 13, 1, 9, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (218, 'xj26838', 1, 16, 1, 10, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (219, 'sq77127', 2, 20, 2, 2, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (220, 'vq54867', 3, 13, 1, 8, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (221, 'fz77827', 1, 18, 2, 8, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (222, 'dh14455', 3, 20, 1, 4, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (223, 'qw31296', 1, 19, 2, 3, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (224, 'yb32250', 2, 18, 1, 5, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (225, 'ur34474', 2, 16, 1, 8, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (226, 'uq03062', 1, 18, 1, 4, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (227, 'ue48687', 3, 16, 2, 10, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (228, 'om97263', 3, 16, 2, 1, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (229, 'ka76201', 1, 17, 2, 2, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (230, 'ye83790', 1, 15, 2, 3, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (231, 'it36850', 1, 18, 2, 7, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (232, 'nu93935', 2, 14, 2, 3, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (233, 'ox22565', 1, 20, 2, 6, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (234, 'hu66206', 2, 15, 1, 7, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (235, 'po86030', 1, 15, 2, 6, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (236, 'zi81075', 3, 10, 1, 9, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (237, 'da87135', 2, 11, 2, 5, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (238, 'vl33397', 3, 10, 1, 9, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (239, 'me18842', 2, 12, 2, 9, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (240, 'qd12013', 3, 18, 1, 8, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (241, 'et17918', 1, 17, 2, 4, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (242, 'xh41214', 1, 20, 2, 5, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (243, 'ne07775', 2, 11, 1, 9, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (244, 'ea05044', 2, 10, 2, 0, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (245, 'pm47141', 3, 14, 1, 7, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (246, 'xr84864', 2, 19, 1, 5, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (247, 'qw36523', 1, 15, 2, 8, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (248, 'hn60311', 2, 11, 2, 8, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (249, 'gi32532', 3, 12, 2, 8, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (250, 'bi74807', 1, 15, 1, 4, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (251, 'yp75683', 2, 12, 2, 4, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (252, 'ky17310', 1, 20, 1, 2, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (253, 'lm28909', 3, 13, 1, 10, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (254, 'fh31372', 2, 20, 2, 0, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (255, 'mp96050', 1, 16, 2, 1, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (256, 'qo10441', 2, 12, 1, 6, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (257, 'ad02474', 2, 17, 2, 4, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (258, 'ta95876', 2, 18, 1, 5, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (259, 'fh97427', 2, 12, 1, 7, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (260, 'iq11831', 2, 18, 2, 10, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (261, 'yq65596', 3, 10, 2, 2, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (262, 'jn37166', 1, 10, 1, 3, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (263, 'rf48547', 2, 19, 2, 8, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (264, 'ei77239', 1, 18, 1, 7, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (265, 'fl28015', 3, 15, 1, 5, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (266, 'xg85932', 2, 18, 1, 4, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (267, 'ua08952', 2, 10, 2, 0, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (268, 'uz88567', 2, 12, 1, 10, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (269, 'tg88444', 2, 16, 1, 8, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (270, 'zk12536', 3, 17, 1, 6, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (271, 'vr58422', 1, 11, 1, 1, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (272, 'rc29234', 3, 11, 1, 6, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (273, 'ba95274', 1, 20, 2, 8, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (274, 'bu29102', 2, 15, 1, 5, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (275, 'bl61373', 3, 20, 1, 9, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (276, 'xi66461', 1, 20, 1, 10, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (277, 'dc93103', 3, 11, 1, 10, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (278, 'fx53015', 2, 12, 1, 7, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (279, 'qz53475', 2, 18, 1, 8, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (280, 'cp14370', 1, 15, 2, 9, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (281, 'gf12795', 3, 14, 2, 2, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (282, 'sd90935', 3, 14, 1, 9, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (283, 'lj01828', 2, 20, 1, 2, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (284, 'be52602', 3, 11, 2, 10, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (285, 'vo29558', 1, 18, 2, 8, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (286, 'cr14620', 2, 16, 1, 3, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (287, 'vf09694', 3, 18, 1, 10, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (288, 'su55415', 2, 19, 2, 3, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (289, 'cx55060', 1, 13, 1, 1, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (290, 'ys08518', 1, 13, 1, 1, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (291, 'lr62194', 1, 15, 1, 2, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (292, 'xm25072', 2, 19, 2, 2, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (293, 'dp40630', 2, 15, 2, 6, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (294, 'mi95033', 3, 19, 2, 7, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (295, 'co92123', 1, 17, 1, 0, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (296, 'dz14110', 1, 19, 2, 10, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (297, 'kq61487', 1, 19, 2, 4, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (298, 'rt80635', 1, 11, 1, 6, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (299, 'mj56042', 1, 14, 1, 8, 0);
commit;
prompt 100 records committed...
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (300, 'km99866', 3, 11, 1, 9, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (301, 'ut54980', 2, 16, 2, 2, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (302, 'wf95346', 3, 13, 2, 6, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (303, 'di77514', 2, 12, 1, 1, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (304, 'cv47339', 1, 10, 1, 8, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (305, 'km14818', 1, 16, 2, 2, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (306, 'pg69111', 2, 20, 1, 1, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (307, 'bl05753', 1, 13, 2, 7, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (308, 'sr75074', 3, 14, 1, 3, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (309, 'ee15090', 1, 12, 1, 7, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (310, 'oo39152', 2, 16, 2, 5, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (311, 'st19592', 1, 10, 1, 2, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (312, 'sj21763', 3, 16, 2, 1, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (313, 'xc52216', 3, 20, 2, 0, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (314, 'ed98830', 2, 15, 2, 4, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (315, 'rb73550', 1, 11, 1, 8, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (316, 'hb22691', 3, 10, 1, 1, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (317, 'zn01893', 3, 14, 1, 5, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (318, 'rk39690', 2, 16, 1, 7, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (319, 'ph32362', 2, 10, 1, 3, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (320, 'hv46485', 2, 15, 2, 2, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (321, 'gt97817', 1, 12, 1, 10, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (322, 'qc43843', 1, 13, 2, 5, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (323, 'vj80476', 3, 13, 2, 6, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (324, 'wt55843', 3, 13, 1, 0, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (325, 'rd62525', 2, 15, 1, 7, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (326, 'ap53460', 2, 14, 2, 8, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (327, 'nk81922', 2, 18, 1, 1, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (328, 'kx23171', 1, 16, 2, 7, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (329, 'hf66343', 1, 20, 1, 2, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (1, 'aa12345', 2, 10, 1, 1, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (0, 'aa00000', 0, 0, 1, 1, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (6, 'xx55555', 2, 15, 1, 3, 0);
commit;
prompt 133 records loaded
prompt Loading ORDERS...
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (4, 0, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (5, 2, 6, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (6, 1, 6, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (7, 2, 6, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (8, 0, 0, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (9, 1, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (10, 1, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (11, 0, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (12, 1, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (13, 1, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (14, 1, 6, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (15, 0, 6, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (16, 0, 0, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (17, 2, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (18, 0, 6, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (19, 0, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (20, 2, 6, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (21, 0, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (22, 0, 6, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (23, 1, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (24, 1, 6, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (25, 1, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (26, 2, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (27, 0, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (28, 0, 6, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (29, 0, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (30, 1, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (31, 2, 6, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (32, 2, 0, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (33, 1, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (34, 1, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (35, 2, 6, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (36, 2, 6, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (37, 1, 0, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (38, 1, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (39, 0, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (40, 2, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (41, 0, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (42, 1, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (43, 2, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (44, 0, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (45, 2, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (46, 1, 6, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (47, 1, 6, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (48, 2, 0, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (49, 2, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (50, 1, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (51, 2, 6, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (52, 0, 6, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (53, 2, 6, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (54, 1, 6, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (55, 0, 6, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (56, 1, 6, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (57, 0, 0, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (58, 1, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (59, 1, 0, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (60, 2, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (61, 2, 6, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (62, 1, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (63, 1, 6, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (64, 1, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (65, 1, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (66, 1, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (67, 0, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (68, 0, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (69, 2, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (70, 2, 6, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (71, 0, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (72, 1, 0, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (73, 2, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (74, 2, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (75, 1, 6, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (76, 0, 6, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (77, 1, 6, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (78, 1, 0, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (79, 2, 0, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (80, 1, 6, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (81, 2, 6, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (82, 0, 0, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (83, 2, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (84, 2, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (85, 0, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (86, 0, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (87, 1, 0, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (88, 1, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (89, 2, 6, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (90, 1, 6, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (91, 0, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (92, 0, 0, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (93, 0, 6, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (94, 0, 6, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (95, 0, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (96, 2, 6, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (97, 2, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (98, 0, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (99, 2, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (100, 1, 6, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (101, 0, 6, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (102, 1, 6, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (103, 2, 1, 0);
commit;
prompt 100 records committed...
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (104, 2, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (105, 2, 6, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (106, 2, 6, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (107, 2, 0, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (108, 0, 6, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (109, 2, 6, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (110, 0, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (111, 0, 0, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (112, 0, 0, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (113, 1, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (114, 2, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (115, 2, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (116, 1, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (117, 1, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (118, 1, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (119, 0, 6, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (120, 2, 6, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (121, 2, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (122, 0, 0, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (123, 1, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (124, 0, 0, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (125, 1, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (126, 0, 0, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (127, 2, 0, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (128, 0, 6, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (129, 2, 6, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (130, 2, 6, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (131, 1, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (132, 2, 6, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (133, 0, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (134, 1, 0, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (135, 2, 6, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (136, 0, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (137, 1, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (138, 2, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (139, 1, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (140, 2, 6, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (141, 0, 6, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (142, 0, 0, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (143, 1, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (144, 2, 0, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (145, 1, 6, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (146, 1, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (147, 0, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (148, 0, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (149, 1, 6, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (150, 1, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (151, 2, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (152, 0, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (153, 0, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (154, 0, 0, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (155, 1, 6, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (156, 2, 6, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (157, 1, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (158, 0, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (159, 2, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (160, 1, 6, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (161, 0, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (162, 2, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (163, 0, 6, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (164, 2, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (165, 1, 6, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (166, 1, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (167, 2, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (168, 0, 6, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (169, 2, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (170, 1, 6, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (171, 2, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (172, 2, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (173, 2, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (174, 1, 6, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (175, 0, 0, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (176, 2, 0, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (177, 2, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (178, 1, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (179, 1, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (180, 2, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (181, 2, 0, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (182, 2, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (183, 1, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (184, 0, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (185, 2, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (186, 1, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (187, 2, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (188, 1, 6, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (189, 2, 0, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (190, 1, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (191, 2, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (192, 2, 6, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (193, 0, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (194, 2, 6, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (195, 1, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (196, 1, 0, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (197, 2, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (198, 2, 6, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (199, 1, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (200, 1, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (201, 1, 6, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (202, 0, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (203, 1, 1, 1);
commit;
prompt 200 records committed...
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (204, 1, 0, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (205, 1, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (206, 0, 6, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (207, 0, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (208, 1, 6, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (209, 1, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (210, 1, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (211, 0, 6, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (212, 0, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (213, 1, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (214, 2, 6, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (215, 2, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (216, 0, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (217, 0, 6, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (218, 1, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (219, 1, 6, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (1, 2, 6, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (2, 1, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (3, 2, 1, 1);
commit;
prompt 219 records loaded
prompt Loading USER_STATUSES...
insert into USER_STATUSES (user_status_id, user_status_name)
values (0, 'n/a');
insert into USER_STATUSES (user_status_id, user_status_name)
values (2, 'in shift');
insert into USER_STATUSES (user_status_id, user_status_name)
values (3, 'on rest');
insert into USER_STATUSES (user_status_id, user_status_name)
values (1, 'driving');
commit;
prompt 4 records loaded
prompt Loading ROLES...
insert into ROLES (role_id, role_name)
values (0, 'n/a');
insert into ROLES (role_id, role_name)
values (1, 'administrator');
insert into ROLES (role_id, role_name)
values (2, 'operator');
insert into ROLES (role_id, role_name)
values (3, 'driver');
commit;
prompt 4 records loaded
prompt Loading USERS...
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (445, 'Jonathan', 'Garner', 'login445', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 72, 0, 4, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (446, 'Katrin', 'Orlando', 'login446', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 147, 2, 8, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (447, 'Christine', 'Sandler', 'login447', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 17, 3, 10, 0, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (448, 'Noah', 'Mortensen', 'login448', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 6, 0, 8, 6, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (449, 'Wes', 'Mitchell', 'login449', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 3, 0, 5, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (450, 'Busta', 'Shawn', 'login450', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 109, 1, 2, 6, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (451, 'Peabo', 'Sweet', 'login451', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 28, 1, 9, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (452, 'Gordie', 'Kleinenberg', 'login452', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 113, 2, 2, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (453, 'Balthazar', 'Rudd', 'login453', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 73, 2, 0, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (454, 'Regina', 'Mac', 'login454', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 145, 3, 4, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (455, 'Nora', 'Schwarzenegger', 'login455', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 85, 2, 8, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (456, 'Jaime', 'Neuwirth', 'login456', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 71, 3, 6, 0, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (457, 'Chantй', 'Zeta-Jones', 'login457', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 119, 2, 0, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (458, 'Meredith', 'Tomei', 'login458', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 27, 1, 10, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (459, 'Davis', 'Schiff', 'login459', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 69, 3, 4, 0, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (460, 'Chely', 'Brown', 'login460', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 141, 3, 10, 6, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (461, 'Emilio', 'Warburton', 'login461', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 98, 1, 5, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (462, 'Miriam', 'Nelligan', 'login462', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 150, 2, 4, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (463, 'Sarah', 'Birch', 'login463', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 141, 3, 2, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (464, 'Melba', 'Glover', 'login464', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 57, 0, 7, 0, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (465, 'Grant', 'Khan', 'login465', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 73, 1, 2, 0, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (466, 'Busta', 'Melvin', 'login466', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 114, 1, 6, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (467, 'Jodie', 'Love', 'login467', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 90, 1, 10, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (468, 'Gates', 'Bracco', 'login468', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 172, 1, 2, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (469, 'Saffron', 'Rain', 'login469', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 166, 3, 4, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (470, 'Ashton', 'Woodard', 'login470', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 60, 0, 9, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (471, 'Melanie', 'Paul', 'login471', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 82, 3, 7, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (472, 'Ralph', 'Northam', 'login472', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 98, 1, 2, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (473, 'Lou', 'Chao', 'login473', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 90, 1, 3, 6, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (474, 'Aidan', 'Haslam', 'login474', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 130, 2, 0, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (475, 'Harry', 'Neil', 'login475', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 105, 1, 6, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (476, 'Joaquim', 'Atkins', 'login476', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 112, 3, 1, 6, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (477, 'Roy', 'Kleinenberg', 'login477', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 116, 2, 0, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (478, 'Joaquim', 'Carrere', 'login478', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 149, 2, 2, 0, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (479, 'Daryle', 'Cleese', 'login479', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 19, 2, 3, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (480, 'Walter', 'Gershon', 'login480', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 49, 0, 1, 0, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (2, 'driver 1 first name', 'driver 1 last name', 'driver1', 'c8ffa9fcf473102b5526af2a62f39db33d006b49c8ee5324698bf1394556bd87', 3, 15, 3, 1, null, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (3, 'driver 2 first name', 'driver 2 last name', 'driver2', 'da4b3ff1c6297947d1cc6041fdb4b1a44a76c80d7f4b637e5a76f3c3c12dacb5', 3, 150, 1, 2, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (4, 'driver 3 first name', 'driver 3 last name', 'driver3', '7f518fe5d3488266838bfede7ef309bb401da157526b3f1a7f5a42c775181c28', 3, 20, 2, 3, 6, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (6, 'Jeffery', 'Snider', 'jeffery.', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 158, 0, 9, 0, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (7, 'Kylie', 'LuPone', 'kylie.lu', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 167, 2, 5, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (8, 'Tea', 'Hannah', 'tea@extr', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 168, 3, 5, 6, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (9, 'Maggie', 'Fariq', 'maggief@', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 170, 0, 7, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (10, 'Lorraine', 'Brothers', 'lorraine', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 171, 3, 3, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (11, 'Jude', 'Fisher', 'j.fisher', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 55, 2, 6, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (12, 'Gilbert', 'Giamatti', 'gilbert.', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 57, 1, 1, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (13, 'Sheryl', 'Koyana', 'sheryl.k', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 42, 0, 1, 0, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (14, 'Hilary', 'McNarland', 'hilary.m', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 97, 2, 7, 0, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (15, 'Angela', 'Landau', 'angela.l', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 63, 2, 10, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (16, 'Rosco', 'Tilly', 'rosco.ti', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 42, 2, 0, 0, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (17, 'Reese', 'Theron', 'rtheron@', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 21, 1, 9, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (18, 'Martha', 'Short', 'martha@f', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 173, 0, 6, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (19, 'Freddy', 'Schiff', 'freddy.s', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 54, 1, 8, 0, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (20, 'Temuera', 'Newman', 't.newman', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 27, 1, 5, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (21, 'Harvey', 'Hagerty', 'harvey.h', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 32, 1, 8, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (22, 'Judge', 'Van Der Beek', 'judge.v@', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 130, 2, 0, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (23, 'Eileen', 'Nunn', 'eileen.n', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 48, 0, 0, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (24, 'Allison', 'Lauper', 'alauper@', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 127, 3, 0, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (25, 'Hope', 'Watson', 'hope.wat', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 16, 1, 1, 0, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (26, 'Aimee', 'Kurtz', 'aimee.ku', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 15, 3, 6, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (27, 'Wally', 'Gano', 'wgano@tr', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 140, 0, 8, 6, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (28, 'Leo', 'Shaye', 'leos@mic', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 48, 1, 4, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (29, 'Wayman', 'Martinez', 'wayman.m', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 22, 0, 6, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (30, 'Selma', 'Giannini', 'selma.gi', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 16, 2, 7, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (31, 'Bruce', 'Cox', 'bruce.co', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 81, 0, 1, 0, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (32, 'Laurence', 'Baker', 'l.baker@', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 52, 2, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (33, 'Carlos', 'Sainte-Marie', 'carloss@', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 124, 0, 4, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (34, 'Lois', 'Getty', 'lois.get', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 169, 1, 0, 0, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (35, 'Pat', 'Chappelle', 'p.chappe', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 163, 3, 6, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (36, 'Wade', 'Gano', 'wade.gan', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 6, 2, 3, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (37, 'Bette', 'Washington', 'bette.w@', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 44, 3, 7, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (38, 'Ethan', 'Ratzenberger', 'ethan.ra', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 127, 1, 6, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (39, 'Peabo', 'Dawson', 'peabo@pa', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 127, 3, 10, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (40, 'Alicia', 'Wakeling', 'alicia.w', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 127, 2, 5, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (41, 'Harriet', 'Speaks', 'harriet.', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 167, 2, 1, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (42, 'Oded', 'Kirkwood', 'oded.kir', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 117, 2, 7, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (43, 'Rosanna', 'MacLachlan', 'rosanna.', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 155, 1, 7, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (44, 'Frankie', 'Finn', 'frankie.', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 116, 1, 0, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (45, 'Powers', 'Capshaw', 'powersc@', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 121, 1, 1, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (47, 'Rod', 'Lewis', 'rod@anhe', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 113, 3, 8, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (48, 'Rowan', 'Janssen', 'rowan@st', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 83, 2, 2, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (49, 'Rebeka', 'Sheen', 'rebeka.s', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 175, 1, 1, 0, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (50, 'Dabney', 'Colman', 'dabneyc@', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 9, 3, 3, 6, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (51, 'Avril', 'Arden', 'a.arden@', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 65, 3, 1, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (52, 'Peter', 'Supernaw', 'peter@sm', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 165, 2, 7, 6, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (53, 'Garry', 'Morrison', 'garry.m@', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 164, 2, 6, 0, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (54, 'Claude', 'Shandling', 'claude.s', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 19, 1, 2, 0, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (55, 'Toshiro', 'Lemmon', 'toshirol', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 2, 1, 1, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (56, 'Chaka', 'Vannelli', 'c.vannel', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 54, 2, 9, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (57, 'Janice', 'Goldblum', 'janice.g', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 79, 1, 4, 6, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (58, 'Veruca', 'Dooley', 'v.dooley', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 121, 3, 3, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (59, 'Natacha', 'Estevez', 'natacha.', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 81, 3, 9, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (60, 'Emma', 'Foley', 'emmaf@ah', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 151, 2, 6, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (61, 'Wesley', 'Rawls', 'wesley@l', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 27, 1, 5, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (62, 'Terry', 'Arden', 'terry.ar', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 39, 3, 9, 6, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (63, 'Arnold', 'Elizabeth', 'arnold@v', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 13, 2, 5, 6, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (64, 'Elvis', 'Pantoliano', 'elvis.pa', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 134, 3, 7, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (65, 'Goldie', 'Lang', 'goldie.l', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 98, 3, 6, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (66, 'Collective', 'Lofgren', 'collecti', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 22, 1, 4, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (67, 'Amy', 'Fiorentino', 'a.fioren', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 132, 1, 2, 0, 1);
commit;
prompt 100 records committed...
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (68, 'Frederic', 'Cooper', 'frederic', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 51, 2, 10, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (69, 'Luke', 'Masur', 'luke@ame', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 40, 3, 6, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (70, 'Lisa', 'Harris', 'lharris@', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 87, 2, 8, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (71, 'Laura', 'Witherspoon', 'laura.wi', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 27, 1, 9, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (72, 'Renee', 'Parish', 'renee.pa', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 111, 1, 8, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (73, 'Julia', 'Shaye', 'julia.s@', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 127, 0, 6, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (74, 'Kevin', 'Giamatti', 'kevin.gi', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 98, 3, 3, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (75, 'Geena', 'Blair', 'geena@nh', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 41, 3, 7, 0, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (76, 'Marc', 'Garofalo', 'marc@vms', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 159, 1, 8, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (77, 'Nik', 'McDowell', 'nik.mcdo', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 3, 3, 7, 0, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (78, 'Lou', 'Eldard', 'lou@tele', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 31, 1, 3, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (79, 'Loren', 'Burton', 'loren.bu', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 87, 3, 3, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (80, 'Taryn', 'Garfunkel', 'taryng@d', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 89, 2, 7, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (81, 'Sara', 'Hurley', 'sara.hur', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 109, 3, 9, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (82, 'Sammy', 'Winslet', 'sammy.wi', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 50, 3, 10, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (83, 'Katie', 'Penders', 'katie.pe', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 97, 2, 1, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (84, 'Cary', 'Puckett', 'c.pucket', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 108, 2, 8, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (85, 'Wally', 'David', 'w.david@', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 60, 1, 1, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (86, 'Kid', 'Phillippe', 'kid.p@mi', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 158, 1, 5, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (87, 'Freda', 'Wiest', 'freda@pr', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 169, 1, 7, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (88, 'Tanya', 'Akins', 'tanya.ak', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 81, 3, 5, 6, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (89, 'Humberto', 'Levin', 'humberto', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 47, 1, 9, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (90, 'Tracy', 'Herndon', 'tracy.he', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 63, 3, 5, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (91, 'Brian', 'Gunton', 'bgunton@', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 98, 1, 9, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (92, 'Millie', 'Mazar', 'millie.m', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 143, 1, 3, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (93, 'Roger', 'Metcalf', 'rogerm@c', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 61, 0, 2, 0, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (94, 'Leon', 'Swinton', 'leon.s@o', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 146, 1, 10, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (95, 'Gordie', 'Gallagher', 'gordie.g', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 85, 0, 5, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (96, 'Trey', 'Pryce', 'trey.pry', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 43, 3, 4, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (97, 'Kay', 'Ness', 'kay.ness', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 97, 1, 2, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (98, 'Jeff', 'Assante', 'jeff@dat', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 56, 1, 6, 6, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (99, 'Tilda', 'Dean', 't.dean@u', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 84, 2, 1, 6, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (100, 'Pat', 'Rock', 'pat.rock', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 162, 0, 4, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (101, 'Elle', 'Stills', 'elle.sti', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 157, 3, 8, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (102, 'Geena', 'Slater', 'geena.sl', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 147, 3, 1, 6, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (103, 'Rawlins', 'Streep', 'r.streep', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 1, 0, 9, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (104, 'Terri', 'Reilly', 'terri.re', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 11, 3, 5, 6, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (105, 'Faye', 'Spacey', 'faye.spa', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 64, 3, 0, 0, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (106, 'Orlando', 'Oszajca', 'orlando.', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 175, 3, 4, 0, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (107, 'Viggo', 'Guest', 'viggo.gu', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 124, 1, 10, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (108, 'Seann', 'Applegate', 'seann.a@', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 64, 2, 8, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (110, 'Denzel', 'Donelly', 'login', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 8, 1, 9, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (300, 'Jose', 'McIntosh', 'login300', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 74, 0, 8, 6, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (301, 'Franco', 'Rauhofer', 'login301', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 97, 0, 2, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (302, 'Jerry', 'Costa', 'login302', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 2, 2, 4, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (303, 'Brooke', 'Hyde', 'login303', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 135, 2, 1, 6, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (304, 'Nikki', 'Kudrow', 'login304', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 29, 3, 1, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (305, 'Gran', 'Olin', 'login305', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 80, 1, 5, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (306, 'Spike', 'Chilton', 'login306', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 146, 2, 2, 6, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (307, 'Terri', 'Maxwell', 'login307', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 77, 2, 4, 6, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (308, 'Heath', 'Sainte-Marie', 'login308', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 137, 3, 7, 6, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (309, 'Gina', 'Caan', 'login309', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 98, 3, 5, 6, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (310, 'Fats', 'McNeice', 'login310', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 48, 3, 9, 6, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (311, 'Thora', 'Skerritt', 'login311', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 55, 2, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (312, 'Rachel', 'Weiss', 'login312', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 115, 1, 4, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (313, 'Gilbert', 'Guzman', 'login313', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 135, 1, 4, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (314, 'Lili', 'Wincott', 'login314', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 44, 0, 8, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (315, 'Terri', 'Atkins', 'login315', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 114, 0, 1, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (316, 'Katrin', 'Ingram', 'login316', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 55, 0, 9, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (317, 'Miko', 'Adams', 'login317', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 56, 1, 10, 6, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (318, 'Ivan', 'Connelly', 'login318', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 164, 3, 2, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (319, 'Lorraine', 'Pacino', 'login319', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 7, 3, 10, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (320, 'Neneh', 'Burmester', 'login320', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 112, 3, 4, 0, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (0, 'admin', 'admin', 'admin', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', 1, 0, 0, 0, null, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (1, 'operator', 'operator', 'operator', '06e55b633481f7bb072957eabcf110c972e86691c3cfedabe088024bffe42f23', 2, 0, 0, 0, null, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (321, 'Howard', 'Dawson', 'login321', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 44, 2, 5, 0, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (322, 'Carole', 'Krumholtz', 'login322', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 13, 3, 9, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (323, 'Jay', 'Sandler', 'login323', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 58, 1, 7, 6, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (324, 'Nelly', 'Dutton', 'login324', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 154, 1, 5, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (325, 'Thora', 'Wakeling', 'login325', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 92, 1, 3, 0, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (326, 'Cesar', 'Plowright', 'login326', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 21, 2, 2, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (327, 'Jean-Claude', 'Dunn', 'login327', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 148, 1, 1, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (328, 'Freddie', 'Gaynor', 'login328', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 36, 1, 3, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (329, 'William', 'Robinson', 'login329', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 136, 2, 3, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (330, 'Desmond', 'Macht', 'login330', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 138, 0, 2, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (331, 'Pablo', 'Crystal', 'login331', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 126, 1, 7, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (332, 'Emmylou', 'Atkins', 'login332', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 107, 3, 2, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (333, 'Elijah', 'Hanks', 'login333', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 13, 3, 3, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (334, 'Kiefer', 'Ramirez', 'login334', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 33, 2, 1, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (335, 'Rick', 'Woodard', 'login335', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 22, 2, 7, 0, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (336, 'Denny', 'Winslet', 'login336', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 31, 2, 5, 0, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (337, 'Lesley', 'Woodard', 'login337', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 20, 2, 4, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (338, 'Jann', 'Kier', 'login338', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 118, 1, 4, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (339, 'Swoosie', 'Mifune', 'login339', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 94, 2, 0, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (340, 'Lou', 'Connelly', 'login340', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 36, 2, 7, 0, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (341, 'Vertical', 'Theron', 'login341', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 98, 3, 8, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (342, 'Howie', 'Buckingham', 'login342', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 117, 1, 4, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (343, 'Sigourney', 'McCready', 'login343', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 73, 2, 2, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (344, 'Chloe', 'McNarland', 'login344', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 101, 2, 0, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (345, 'Nik', 'Davis', 'login345', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 129, 0, 6, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (346, 'Anthony', 'Cleese', 'login346', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 91, 2, 1, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (347, 'Jennifer', 'Morton', 'login347', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 13, 2, 3, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (348, 'Franz', 'Ward', 'login348', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 57, 3, 6, 6, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (349, 'Loretta', 'Hanley', 'login349', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 126, 2, 8, 0, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (350, 'Sally', 'Chilton', 'login350', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 4, 3, 0, 6, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (351, 'Maura', 'Ripley', 'login351', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 73, 0, 9, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (352, 'Uma', 'Greene', 'login352', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 80, 0, 7, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (353, 'Tyrone', 'Waite', 'login353', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 95, 3, 9, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (354, 'Miranda', 'Rowlands', 'login354', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 2, 2, 10, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (355, 'Alec', 'Neeson', 'login355', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 146, 3, 4, 6, 0);
commit;
prompt 200 records committed...
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (356, 'Rene', 'Lapointe', 'login356', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 52, 1, 7, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (357, 'Sophie', 'Swayze', 'login357', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 12, 2, 3, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (358, 'Taye', 'Holliday', 'login358', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 59, 3, 4, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (359, 'Rosco', 'Cervine', 'login359', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 114, 2, 0, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (360, 'Kenny', 'Hurt', 'login360', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 4, 3, 0, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (361, 'Ali', 'Gayle', 'login361', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 139, 0, 1, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (362, 'Neve', 'Atkinson', 'login362', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 7, 2, 1, 0, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (363, 'Colleen', 'Neuwirth', 'login363', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 116, 1, 4, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (364, 'Aaron', 'Bush', 'login364', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 27, 0, 2, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (365, 'Andrea', 'Herndon', 'login365', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 97, 0, 8, 6, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (366, 'Morris', 'Turner', 'login366', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 114, 2, 6, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (367, 'Alan', 'Kinney', 'login367', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 127, 3, 6, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (368, 'Julia', 'Kurtz', 'login368', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 12, 1, 1, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (369, 'Rascal', 'O''Neill', 'login369', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 173, 1, 0, 0, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (370, 'Geoff', 'Vanian', 'login370', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 126, 1, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (371, 'Earl', 'Heslov', 'login371', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 98, 0, 2, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (372, 'Johnette', 'Keitel', 'login372', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 169, 3, 5, 6, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (373, 'Martin', 'Guzman', 'login373', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 33, 3, 4, 0, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (374, 'Mia', 'Alda', 'login374', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 36, 2, 2, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (375, 'Mos', 'DiFranco', 'login375', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 13, 1, 9, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (376, 'Praga', 'Dysart', 'login376', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 120, 0, 5, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (377, 'Luke', 'Kleinenberg', 'login377', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 150, 3, 0, 6, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (378, 'Sheena', 'Dern', 'login378', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 50, 3, 1, 0, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (379, 'Clea', 'Travers', 'login379', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 171, 2, 8, 6, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (380, 'Sissy', 'Westerberg', 'login380', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 79, 3, 0, 6, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (381, 'Bette', 'Bassett', 'login381', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 159, 2, 8, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (382, 'Hope', 'Root', 'login382', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 96, 3, 6, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (383, 'Jason', 'Kweller', 'login383', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 61, 0, 9, 6, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (384, 'Regina', 'Clarkson', 'login384', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 60, 1, 8, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (385, 'Jann', 'Moss', 'login385', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 72, 3, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (386, 'Donald', 'Geldof', 'login386', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 151, 2, 1, 6, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (387, 'Joaquin', 'Clayton', 'login387', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 118, 2, 5, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (388, 'Liquid', 'Candy', 'login388', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 5, 1, 7, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (389, 'Nicky', 'Osment', 'login389', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 55, 1, 8, 0, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (390, 'Lila', 'Atkins', 'login390', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 51, 3, 6, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (391, 'Colin', 'Armatrading', 'login391', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 46, 3, 4, 6, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (392, 'Omar', 'Swinton', 'login392', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 50, 2, 9, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (393, 'Frankie', 'Bloch', 'login393', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 16, 1, 10, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (394, 'Albert', 'Sampson', 'login394', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 148, 1, 7, 6, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (395, 'Dermot', 'de Lancie', 'login395', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 31, 3, 7, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (396, 'Solomon', 'Bailey', 'login396', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 5, 1, 6, 0, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (397, 'Ernie', 'Hughes', 'login397', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 115, 3, 0, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (398, 'Darius', 'Sartain', 'login398', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 148, 1, 9, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (399, 'Kiefer', 'Sylvian', 'login399', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 21, 3, 2, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (400, 'Hugh', 'Duchovny', 'login400', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 28, 0, 1, 6, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (401, 'Lara', 'Logue', 'login401', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 155, 2, 2, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (402, 'Joaquin', 'Harary', 'login402', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 60, 2, 1, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (403, 'Gena', 'Paul', 'login403', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 140, 1, 3, 6, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (404, 'Cate', 'Swinton', 'login404', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 48, 1, 8, 0, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (405, 'Ed', 'Duschel', 'login405', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 123, 0, 10, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (406, 'Gwyneth', 'Kinski', 'login406', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 152, 2, 6, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (407, 'Aidan', 'Cruz', 'login407', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 147, 1, 9, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (408, 'Andrea', 'Warren', 'login408', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 8, 3, 10, 6, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (409, 'Garry', 'Tsettos', 'login409', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 101, 1, 2, 0, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (410, 'Curt', 'Pollak', 'login410', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 43, 3, 1, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (411, 'Hilary', 'Francis', 'login411', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 26, 1, 1, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (412, 'Molly', 'Liotta', 'login412', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 1, 2, 7, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (413, 'Ice', 'Kinski', 'login413', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 143, 2, 5, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (414, 'Alice', 'Imbruglia', 'login414', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 98, 0, 6, 0, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (415, 'Maureen', 'Duchovny', 'login415', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 86, 1, 2, 0, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (416, 'Rutger', 'Gugino', 'login416', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 135, 2, 9, 0, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (417, 'Ashton', 'McIntosh', 'login417', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 14, 3, 6, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (418, 'Woody', 'Jonze', 'login418', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 35, 2, 8, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (419, 'Bob', 'Capshaw', 'login419', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 56, 2, 1, 0, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (420, 'Larnelle', 'Cagle', 'login420', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 19, 3, 6, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (421, 'Celia', 'Carlisle', 'login421', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 0, 3, 10, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (422, 'Gilbert', 'El-Saher', 'login422', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 138, 1, 0, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (423, 'Faye', 'Watson', 'login423', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 96, 2, 9, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (424, 'Hilton', 'Mazzello', 'login424', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 82, 2, 4, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (425, 'Carrie-Anne', 'Kleinenberg', 'login425', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 136, 2, 4, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (426, 'Suzy', 'Begley', 'login426', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 60, 2, 0, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (427, 'Humberto', 'Palminteri', 'login427', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 94, 3, 5, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (428, 'Yolanda', 'Smith', 'login428', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 105, 2, 5, 6, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (429, 'Heath', 'Eastwood', 'login429', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 14, 1, 10, 6, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (430, 'Debra', 'McFerrin', 'login430', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 168, 3, 5, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (431, 'Hal', 'Loveless', 'login431', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 94, 0, 10, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (432, 'Sal', 'Fariq', 'login432', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 104, 1, 1, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (433, 'Ewan', 'Sweet', 'login433', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 160, 3, 6, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (434, 'Nora', 'Bening', 'login434', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 157, 0, 1, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (435, 'Ty', 'Rizzo', 'login435', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 75, 2, 9, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (436, 'Tea', 'Pacino', 'login436', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 85, 2, 6, 6, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (437, 'Tom', 'Allan', 'login437', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 151, 2, 9, 0, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (438, 'Cloris', 'Furay', 'login438', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 139, 0, 7, 0, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (439, 'Edie', 'O''Sullivan', 'login439', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 62, 2, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (440, 'Taylor', 'Tinsley', 'login440', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 17, 1, 10, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (441, 'Marley', 'Dillane', 'login441', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 23, 3, 10, 6, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (442, 'Rip', 'Aaron', 'login442', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 94, 3, 8, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (443, 'Gordie', 'Grier', 'login443', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 145, 1, 0, 1, 0);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted)
values (444, 'Taylor', 'Cox', 'login444', 'b4def8217cadae26d4da633fd2a4e58e326cbb5d570afdc3989484da07af3579', 2, 161, 1, 2, 6, 0);
commit;
prompt 289 records loaded
prompt Loading ORDER_DRIVER...
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (1, 1, 2);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (2, 2, 3);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (3, 3, 4);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (196, 209, 7);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (166, 94, 9);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (211, 176, 10);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (293, 188, 10);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (152, 202, 11);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (68, 181, 12);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (268, 40, 12);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (49, 57, 13);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (96, 173, 16);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (92, 6, 17);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (283, 212, 17);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (243, 44, 18);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (254, 219, 18);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (226, 203, 19);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (217, 162, 22);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (168, 138, 24);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (181, 25, 24);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (65, 191, 27);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (105, 189, 27);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (172, 39, 28);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (145, 31, 29);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (23, 101, 30);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (170, 64, 30);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (204, 92, 30);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (106, 160, 33);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (115, 153, 34);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (291, 50, 34);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (29, 160, 38);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (289, 185, 39);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (42, 215, 40);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (136, 203, 40);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (207, 4, 41);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (219, 160, 42);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (233, 214, 43);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (299, 72, 44);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (180, 66, 47);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (230, 163, 47);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (118, 21, 48);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (32, 207, 49);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (212, 119, 49);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (282, 216, 49);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (103, 125, 51);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (264, 181, 52);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (215, 121, 55);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (140, 202, 56);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (213, 108, 56);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (11, 83, 57);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (79, 27, 57);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (38, 135, 58);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (184, 167, 58);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (40, 184, 59);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (77, 135, 59);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (47, 89, 60);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (214, 116, 62);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (253, 72, 63);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (37, 181, 65);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (71, 64, 65);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (98, 131, 65);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (85, 199, 66);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (281, 142, 66);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (97, 31, 68);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (132, 154, 68);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (31, 5, 69);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (100, 159, 69);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (301, 76, 71);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (50, 93, 72);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (13, 105, 73);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (167, 188, 73);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (148, 109, 74);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (74, 29, 75);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (294, 79, 75);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (229, 188, 76);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (82, 194, 77);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (259, 149, 77);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (241, 101, 80);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (20, 166, 81);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (130, 60, 82);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (48, 186, 84);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (220, 104, 84);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (285, 162, 84);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (147, 110, 88);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (236, 146, 88);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (286, 196, 88);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (195, 12, 89);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (225, 41, 89);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (266, 141, 89);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (153, 151, 91);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (174, 76, 94);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (111, 164, 95);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (131, 144, 95);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (154, 37, 95);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (43, 109, 96);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (61, 180, 96);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (52, 29, 97);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (27, 175, 99);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (223, 199, 101);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (276, 197, 101);
commit;
prompt 100 records committed...
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (157, 65, 103);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (137, 32, 104);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (150, 219, 104);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (95, 205, 107);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (36, 120, 108);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (84, 26, 108);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (125, 85, 108);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (33, 182, 110);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (73, 150, 300);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (123, 159, 300);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (60, 78, 301);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (99, 183, 301);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (185, 23, 301);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (202, 194, 303);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (67, 199, 305);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (133, 100, 305);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (66, 6, 306);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (263, 209, 308);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (284, 195, 308);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (244, 10, 313);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (143, 100, 314);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (70, 156, 315);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (28, 152, 321);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (257, 173, 321);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (12, 27, 322);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (45, 117, 323);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (178, 178, 324);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (83, 134, 327);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (205, 47, 328);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (146, 154, 329);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (53, 195, 331);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (54, 102, 331);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (127, 83, 331);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (258, 62, 331);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (102, 32, 332);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (119, 61, 333);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (208, 52, 333);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (113, 106, 335);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (209, 138, 335);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (272, 10, 335);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (30, 24, 337);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (64, 165, 337);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (190, 82, 337);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (295, 14, 337);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (21, 87, 339);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (63, 72, 339);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (129, 85, 340);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (55, 57, 342);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (122, 12, 342);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (265, 59, 342);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (261, 88, 344);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (108, 193, 345);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (128, 133, 345);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (187, 102, 345);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (75, 218, 346);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (116, 120, 346);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (39, 154, 348);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (134, 210, 348);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (249, 6, 348);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (287, 139, 348);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (76, 118, 349);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (250, 197, 349);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (112, 178, 350);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (46, 142, 351);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (277, 216, 351);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (278, 147, 352);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (164, 100, 353);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (165, 36, 354);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (227, 59, 354);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (151, 45, 357);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (175, 144, 359);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (198, 22, 359);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (298, 207, 359);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (192, 5, 360);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (251, 4, 360);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (275, 24, 361);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (117, 49, 363);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (290, 138, 363);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (237, 83, 365);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (228, 86, 367);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (235, 99, 367);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (292, 40, 369);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (19, 121, 370);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (72, 114, 371);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (107, 137, 372);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (210, 69, 372);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (86, 176, 373);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (89, 10, 374);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (191, 43, 374);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (260, 51, 374);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (177, 51, 376);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (80, 117, 378);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (256, 89, 379);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (139, 88, 380);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (238, 100, 380);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (255, 27, 380);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (296, 174, 380);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (297, 154, 380);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (239, 101, 382);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (104, 167, 383);
commit;
prompt 200 records committed...
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (135, 85, 383);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (199, 73, 383);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (22, 147, 385);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (34, 203, 385);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (59, 156, 385);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (124, 78, 387);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (56, 15, 388);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (193, 9, 393);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (246, 159, 393);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (91, 50, 396);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (17, 43, 397);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (169, 186, 397);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (234, 41, 397);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (176, 26, 399);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (126, 90, 400);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (158, 208, 401);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (156, 52, 405);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (25, 74, 406);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (247, 40, 406);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (141, 210, 407);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (15, 150, 408);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (149, 190, 408);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (51, 202, 411);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (81, 142, 411);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (109, 40, 412);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (182, 93, 412);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (270, 206, 417);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (302, 94, 417);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (240, 34, 418);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (273, 19, 419);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (10, 185, 420);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (189, 70, 424);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (200, 160, 424);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (274, 163, 428);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (16, 184, 430);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (24, 11, 430);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (186, 94, 430);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (248, 71, 430);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (88, 150, 431);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (155, 185, 431);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (159, 99, 432);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (183, 67, 432);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (18, 184, 434);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (62, 74, 434);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (69, 178, 434);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (288, 25, 434);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (90, 168, 438);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (35, 40, 441);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (78, 89, 441);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (144, 190, 441);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (218, 88, 444);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (26, 147, 445);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (94, 7, 445);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (44, 137, 446);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (142, 63, 448);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (179, 130, 448);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (216, 142, 448);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (300, 107, 448);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (224, 214, 449);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (262, 89, 449);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (101, 122, 450);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (267, 201, 450);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (110, 74, 451);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (138, 48, 451);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (232, 75, 451);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (206, 191, 452);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (114, 50, 453);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (222, 142, 453);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (171, 127, 454);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (269, 23, 454);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (93, 2, 456);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (41, 123, 459);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (161, 133, 459);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (194, 150, 459);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (197, 127, 459);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (280, 169, 459);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (279, 146, 460);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (87, 173, 461);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (252, 191, 461);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (121, 69, 463);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (221, 66, 463);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (57, 43, 465);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (188, 178, 465);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (160, 219, 467);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (163, 73, 468);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (173, 196, 468);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (201, 114, 468);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (203, 149, 468);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (231, 90, 468);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (245, 170, 468);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (162, 203, 469);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (120, 141, 470);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (14, 101, 471);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (242, 45, 477);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (58, 53, 480);
insert into ORDER_DRIVER (order_driver_id, order_id, user_id)
values (271, 33, 480);
commit;
prompt 296 records loaded
prompt Loading SEQUENCES...
insert into SEQUENCES (seq_name, seq_value)
values ('roles_seq', 7);
insert into SEQUENCES (seq_name, seq_value)
values ('trucks_seq', 7);
commit;
prompt 2 records loaded
prompt Loading WAYPOINTS...
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (100, 73, 1, 75, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (101, 22, 6, 75, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (102, 90, 4, 48, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (103, 162, 5, 40, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (104, 119, 9, 171, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (105, 103, 0, 118, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (106, 27, 2, 11, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (107, 108, 3, 26, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (108, 130, 7, 16, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (109, 26, 2, 33, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (110, 28, 3, 26, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (111, 21, 1, 20, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (112, 185, 4, 5, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (113, 44, 0, 62, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (114, 72, 8, 46, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (115, 40, 9, 121, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (116, 101, 9, 3, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (117, 219, 0, 38, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (118, 125, 0, 121, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (119, 83, 1, 32, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (120, 194, 2, 78, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (121, 143, 1, 110, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (122, 70, 0, 81, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (123, 214, 2, 141, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (124, 118, 3, 9, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (125, 175, 7, 81, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (126, 80, 0, 97, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (127, 143, 1, 155, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (128, 109, 7, 14, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (129, 64, 0, 140, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (130, 112, 5, 8, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (131, 24, 1, 8, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (132, 44, 3, 89, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (133, 193, 3, 17, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (134, 52, 3, 59, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (135, 178, 0, 66, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (136, 24, 4, 36, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (137, 198, 2, 67, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (138, 91, 2, 58, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (139, 140, 1, 113, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (140, 91, 10, 24, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (141, 211, 10, 82, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (142, 213, 2, 106, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (143, 129, 9, 86, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (144, 158, 8, 96, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (145, 134, 5, 16, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (146, 133, 3, 108, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (147, 99, 0, 99, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (148, 158, 4, 27, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (149, 15, 0, 26, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (150, 97, 5, 152, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (151, 115, 8, 137, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (152, 198, 0, 54, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (153, 189, 5, 147, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (154, 164, 5, 24, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (155, 59, 9, 81, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (156, 50, 5, 39, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (157, 123, 9, 157, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (158, 131, 1, 104, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (159, 2, 9, 92, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (160, 179, 3, 22, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (161, 94, 6, 130, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (162, 127, 9, 14, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (163, 137, 8, 120, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (164, 140, 2, 81, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (165, 28, 1, 122, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (166, 102, 8, 35, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (167, 53, 8, 115, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (168, 43, 7, 15, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (169, 90, 5, 24, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (170, 200, 8, 103, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (171, 198, 8, 54, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (172, 48, 2, 77, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (173, 173, 4, 125, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (174, 32, 3, 10, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (175, 59, 9, 150, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (176, 77, 0, 130, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (177, 54, 9, 94, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (178, 141, 2, 134, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (179, 65, 5, 14, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (180, 181, 1, 32, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (181, 195, 7, 59, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (182, 181, 10, 84, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (183, 207, 0, 84, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (184, 37, 2, 17, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (185, 151, 9, 117, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (186, 163, 3, 117, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (187, 184, 3, 83, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (188, 193, 6, 29, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (189, 23, 8, 23, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (190, 168, 5, 133, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (191, 213, 10, 105, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (192, 27, 10, 104, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (193, 181, 2, 84, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (194, 58, 8, 52, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (195, 84, 9, 116, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (196, 88, 8, 56, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (197, 94, 0, 154, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (198, 66, 9, 22, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (199, 189, 7, 172, 2);
commit;
prompt 100 records committed...
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (200, 56, 9, 27, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (201, 16, 4, 16, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (202, 72, 6, 105, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (203, 135, 0, 91, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (204, 211, 2, 5, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (205, 43, 6, 103, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (206, 188, 7, 132, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (207, 213, 3, 20, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (208, 43, 4, 23, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (209, 39, 6, 146, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (210, 33, 0, 87, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (211, 11, 8, 109, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (212, 161, 0, 22, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (213, 14, 9, 75, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (214, 202, 7, 138, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (215, 104, 1, 28, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (216, 31, 10, 57, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (217, 46, 5, 48, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (218, 3, 1, 149, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (219, 7, 1, 43, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (220, 100, 2, 157, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (221, 3, 4, 140, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (222, 17, 1, 57, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (223, 82, 6, 2, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (224, 192, 9, 4, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (225, 125, 4, 25, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (226, 60, 10, 83, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (227, 158, 3, 65, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (228, 98, 10, 18, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (229, 80, 0, 53, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (230, 211, 7, 69, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (231, 112, 1, 43, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (232, 165, 2, 162, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (233, 215, 4, 67, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (234, 83, 0, 26, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (235, 26, 6, 121, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (236, 133, 9, 160, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (237, 166, 3, 127, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (238, 70, 4, 174, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (239, 117, 4, 27, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (240, 157, 2, 40, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (241, 110, 1, 26, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (242, 185, 4, 101, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (243, 12, 7, 104, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (244, 90, 9, 174, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (245, 36, 6, 15, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (246, 208, 6, 15, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (247, 207, 4, 127, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (248, 62, 7, 93, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (249, 114, 9, 139, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (250, 59, 4, 79, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (251, 38, 0, 30, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (252, 199, 5, 79, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (253, 192, 6, 100, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (254, 162, 1, 97, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (255, 13, 10, 114, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (256, 117, 4, 161, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (257, 163, 6, 154, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (258, 71, 9, 69, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (259, 212, 6, 37, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (260, 162, 3, 144, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (261, 115, 10, 105, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (262, 144, 2, 48, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (263, 4, 1, 59, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (264, 33, 2, 164, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (265, 47, 8, 29, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (266, 168, 8, 173, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (267, 163, 1, 38, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (268, 25, 9, 24, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (269, 15, 7, 137, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (270, 163, 5, 7, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (271, 175, 3, 153, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (272, 83, 8, 98, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (273, 66, 9, 107, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (274, 94, 9, 135, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (275, 139, 8, 69, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (276, 178, 3, 146, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (277, 171, 7, 164, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (278, 25, 8, 108, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (279, 44, 8, 13, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (280, 11, 6, 40, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (281, 153, 4, 67, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (282, 48, 9, 42, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (283, 134, 8, 112, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (284, 45, 10, 147, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (285, 61, 3, 14, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (286, 213, 6, 128, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (287, 187, 1, 76, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (288, 123, 9, 144, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (289, 96, 1, 149, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (290, 27, 1, 143, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (291, 103, 4, 100, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (292, 53, 9, 92, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (293, 109, 7, 75, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (294, 131, 6, 7, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (295, 49, 0, 29, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (296, 199, 1, 123, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (297, 189, 1, 103, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (298, 46, 4, 160, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (299, 181, 2, 86, 1);
commit;
prompt 200 records committed...
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (300, 97, 0, 123, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (301, 155, 5, 71, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (302, 74, 10, 29, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (303, 129, 2, 33, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (304, 140, 5, 115, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (305, 145, 1, 66, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (306, 136, 9, 152, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (307, 30, 8, 73, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (308, 198, 3, 114, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (309, 110, 1, 113, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (310, 138, 3, 119, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (311, 15, 7, 19, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (312, 199, 10, 164, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (313, 184, 6, 33, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (314, 126, 8, 173, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (315, 148, 10, 12, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (316, 67, 6, 18, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (317, 176, 5, 170, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (318, 216, 4, 22, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (319, 132, 5, 43, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (320, 92, 6, 44, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (321, 161, 6, 35, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (322, 84, 2, 92, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (323, 121, 5, 150, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (324, 200, 3, 39, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (325, 189, 3, 75, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (326, 217, 8, 168, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (327, 211, 9, 109, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (328, 105, 2, 130, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (329, 3, 8, 141, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (330, 90, 4, 120, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (331, 154, 6, 160, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (332, 121, 2, 114, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (333, 58, 8, 43, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (334, 69, 10, 112, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (335, 164, 2, 170, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (336, 211, 5, 7, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (337, 146, 6, 104, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (338, 27, 10, 111, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (339, 195, 4, 13, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (340, 141, 7, 84, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (341, 199, 9, 150, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (342, 154, 1, 95, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (343, 85, 0, 125, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (344, 69, 2, 34, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (345, 4, 9, 62, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (346, 12, 10, 84, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (347, 154, 2, 147, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (348, 38, 0, 42, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (349, 8, 0, 159, 1);
commit;
prompt 250 records loaded
prompt Enabling triggers for CARGO_STATUSES...
alter table CARGO_STATUSES enable all triggers;
prompt Enabling triggers for CARGOS...
alter table CARGOS enable all triggers;
prompt Enabling triggers for CARGO_TYPES...
alter table CARGO_TYPES enable all triggers;
prompt Enabling triggers for CITIES...
alter table CITIES enable all triggers;
prompt Enabling triggers for MAP...
alter table MAP enable all triggers;
prompt Enabling triggers for ORDER_STATUSES...
alter table ORDER_STATUSES enable all triggers;
prompt Enabling triggers for TRUCK_STATUSES...
alter table TRUCK_STATUSES enable all triggers;
prompt Enabling triggers for TRUCKS...
alter table TRUCKS enable all triggers;
prompt Enabling triggers for ORDERS...
alter table ORDERS enable all triggers;
prompt Enabling triggers for USER_STATUSES...
alter table USER_STATUSES enable all triggers;
prompt Enabling triggers for ROLES...
alter table ROLES enable all triggers;
prompt Enabling triggers for USERS...
alter table USERS enable all triggers;
prompt Enabling triggers for ORDER_DRIVER...
alter table ORDER_DRIVER enable all triggers;
prompt Enabling triggers for SEQUENCES...
alter table SEQUENCES enable all triggers;
prompt Enabling triggers for WAYPOINTS...
alter table WAYPOINTS enable all triggers;
set feedback on
set define on
prompt Done.
