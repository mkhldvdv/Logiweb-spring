prompt PL/SQL Developer import file
prompt Created on 11 Январь 2016 г. by mkhldvdv
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
  cargo_status_name VARCHAR2(30)
)
;
alter table CARGO_STATUSES
  add constraint CARGO_STATUS_PK primary key (CARGO_STATUS_ID);

prompt Creating CARGOS...
create table CARGOS
(
  cargo_id        NUMBER not null,
  cargo_name      VARCHAR2(50),
  weight          NUMBER,
  cargo_status_id NUMBER,
  deleted         NUMBER(1) default 0
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
  cargo_type_name VARCHAR2(30)
)
;
alter table CARGO_TYPES
  add constraint CARGO_TYPE_PK primary key (CARGO_TYPE_ID);

prompt Creating CITIES...
create table CITIES
(
  city_id   NUMBER not null,
  city_name VARCHAR2(50)
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
  city_id1 NUMBER,
  city_id2 NUMBER,
  distance NUMBER
)
;
alter table MAP
  add constraint MAP_PK primary key (MAP_ID);
alter table MAP
  add constraint MAP_CITY1_CITY2_UK unique (CITY_ID1, CITY_ID2);
alter table MAP
  add constraint MAP_CITY_ID1_FK foreign key (CITY_ID1)
  references CITIES (CITY_ID);
alter table MAP
  add constraint MAP_CITY_ID2_FK foreign key (CITY_ID2)
  references CITIES (CITY_ID);
create index MAP_CITY1_IDX on MAP (CITY_ID1);
create index MAP_CITY2_IDX on MAP (CITY_ID2);

prompt Creating ORDER_STATUSES...
create table ORDER_STATUSES
(
  order_status_id   NUMBER not null,
  order_status_name VARCHAR2(30)
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
  reg_num         VARCHAR2(7),
  driver_count    NUMBER,
  capacity        NUMBER,
  truck_status_id NUMBER,
  city_id         NUMBER,
  deleted         NUMBER(1) default 0
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
  order_status_id NUMBER,
  truck_id        NUMBER,
  deleted         NUMBER(1) default 0
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
  user_status_name VARCHAR2(30)
)
;
alter table USER_STATUSES
  add constraint USER_STATUS_PK primary key (USER_STATUS_ID);

prompt Creating ROLES...
create table ROLES
(
  role_id   NUMBER not null,
  role_name VARCHAR2(30)
)
;
alter table ROLES
  add constraint ROLE_PK primary key (ROLE_ID);

prompt Creating USERS...
create table USERS
(
  user_id        NUMBER not null,
  first_name     VARCHAR2(30),
  last_name      VARCHAR2(30),
  login          VARCHAR2(10),
  password       VARCHAR2(256),
  role_id        NUMBER,
  hours          NUMBER,
  user_status_id NUMBER,
  city_id        NUMBER,
  truck_id       NUMBER,
  deleted        NUMBER(1) default 0,
  enabled        NUMBER(1) default 1
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
  order_id NUMBER,
  user_id  NUMBER
)
;
alter table ORDER_DRIVER
  add constraint ORDER_ID_FK foreign key (ORDER_ID)
  references ORDERS (ORDER_ID);
alter table ORDER_DRIVER
  add constraint ORDER_USER_FK foreign key (USER_ID)
  references USERS (USER_ID);
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
  order_id      NUMBER,
  city_id       NUMBER,
  cargo_id      NUMBER,
  cargo_type_id NUMBER
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
values (1011, 'catrgo name ', 123, 1, 0);
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
commit;
prompt 100 records committed...
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (100, 'barium', 177, 2, 0);
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
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (1008, 'testcargo1', 500, 1, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (1005, 'first cargo to add via application', 100, 1, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (1006, 'second cargo', 200, 1, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (1010, 'testcargo3', 1500, 1, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (1012, 'cargo name', 500, 1, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (1013, 'cargo name2', 600, 1, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (1018, 'second cargo', 100, 1, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (1021, 'catrgo name', 500, 1, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (1007, 'third BIG cargo', 900, 1, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (1009, 'testcargo2', 1000, 1, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (1025, 'test cargo spring', 30, 3, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (1026, 'test 2 cargo spring', 200, 1, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (1017, 'catrgo name', 500, 1, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (1019, '123 cargo', 2000, 1, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (1014, 'cargo name3', 400, 1, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (1015, 'testcargo1', 500, 1, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (1016, 'second cargo', 500, 1, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (1020, 'first cargo to add via application', 400, 1, 0);
insert into CARGOS (cargo_id, cargo_name, weight, cargo_status_id, deleted)
values (1022, 'testcargo1', 600, 1, 0);
commit;
prompt 194 records loaded
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
insert into MAP (map_id, city_id1, city_id2, distance)
values (1, 1, 2, 1000);
insert into MAP (map_id, city_id1, city_id2, distance)
values (2, 2, 3, 2000);
insert into MAP (map_id, city_id1, city_id2, distance)
values (3, 2, 2, 0);
commit;
prompt 3 records loaded
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
values (1015, 'qq11111', 1, 1, 1, 1, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (1034, 'qq44444', 1, 5, 1, 2, 0);
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
commit;
prompt 100 records committed...
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (299, 'mj56042', 1, 14, 1, 8, 0);
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
values (325, 'rd62525', 2, 15, 1, 7, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (326, 'ap53460', 2, 14, 2, 8, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (327, 'nk81922', 2, 18, 1, 1, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (328, 'kx23171', 1, 16, 2, 7, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (329, 'hf66343', 1, 20, 1, 2, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (1012, 'aa00002', 2, 5, 1, 2, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (1020, 'aa10000', 2, 1, 1, 1, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (1, 'aa12345', 2, 10, 1, 1, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (1025, 'qq33333', 1, 5, 1, 2, 1);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (1013, 'aa00003', 1, 10, 1, 3, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (0, 'aa00000', 0, 0, 1, 1, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (1000, 'az12345', 2, 1, 1, 1, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (1010, 'zz12345', 2, 2, 1, 5, 0);
insert into TRUCKS (truck_id, reg_num, driver_count, capacity, truck_status_id, city_id, deleted)
values (1021, 'aa20000', 2, 2, 1, 1, 0);
commit;
prompt 140 records loaded
prompt Loading ORDERS...
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (1004, 2, 1013, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (4, 0, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (5, 2, null, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (6, 1, null, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (7, 2, null, 1);
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
values (14, 1, null, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (15, 0, null, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (16, 0, 0, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (17, 2, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (18, 0, null, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (19, 0, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (20, 2, null, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (21, 0, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (22, 0, null, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (23, 1, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (24, 1, null, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (25, 1, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (26, 2, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (1007, 2, 327, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (28, 0, null, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (29, 0, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (30, 1, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (31, 2, null, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (32, 2, 0, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (33, 1, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (34, 1, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (35, 2, null, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (36, 2, null, 1);
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
values (46, 1, null, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (47, 1, null, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (48, 2, 0, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (49, 2, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (50, 1, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (51, 2, null, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (52, 0, null, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (53, 2, null, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (54, 1, null, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (55, 0, null, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (56, 1, null, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (57, 0, 0, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (58, 1, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (59, 1, 0, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (60, 2, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (61, 2, null, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (62, 1, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (63, 1, null, 0);
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
values (70, 2, null, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (71, 0, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (72, 1, 0, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (73, 2, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (74, 2, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (75, 1, null, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (76, 0, null, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (77, 1, null, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (78, 1, 0, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (79, 2, 0, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (80, 1, null, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (81, 2, null, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (82, 0, 0, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (1008, 2, 329, 0);
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
values (89, 2, null, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (90, 1, null, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (91, 0, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (92, 0, 0, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (93, 0, null, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (94, 0, null, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (95, 0, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (96, 2, null, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (97, 2, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (98, 0, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (99, 2, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (100, 1, null, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (101, 0, null, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (102, 1, null, 1);
commit;
prompt 100 records committed...
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (103, 2, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (104, 2, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (105, 2, null, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (106, 2, null, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (107, 2, 0, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (108, 0, null, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (109, 2, null, 1);
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
values (119, 0, null, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (120, 2, null, 0);
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
values (128, 0, null, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (129, 2, null, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (130, 2, null, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (131, 1, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (132, 2, null, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (133, 0, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (134, 1, 0, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (135, 2, null, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (136, 0, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (137, 1, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (138, 2, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (139, 1, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (140, 2, null, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (141, 0, null, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (142, 0, 0, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (143, 1, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (144, 2, 0, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (145, 1, null, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (146, 1, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (147, 0, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (148, 0, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (149, 1, null, 0);
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
values (155, 1, null, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (156, 2, null, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (157, 1, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (158, 0, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (159, 2, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (160, 1, null, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (161, 0, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (162, 2, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (163, 0, null, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (164, 2, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (165, 1, null, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (166, 1, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (167, 2, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (168, 0, null, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (169, 2, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (170, 1, null, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (171, 2, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (172, 2, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (173, 2, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (174, 1, null, 1);
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
values (1009, 2, 325, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (186, 1, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (187, 2, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (188, 1, null, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (189, 2, 0, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (190, 1, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (191, 2, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (192, 2, null, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (193, 0, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (194, 2, null, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (195, 1, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (196, 1, 0, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (197, 2, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (198, 2, null, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (199, 1, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (200, 1, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (201, 1, null, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (202, 0, 1, 0);
commit;
prompt 200 records committed...
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (203, 1, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (204, 1, 0, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (205, 1, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (206, 0, null, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (207, 0, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (208, 1, null, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (209, 1, 0, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (210, 1, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (211, 0, null, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (212, 0, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (213, 1, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (214, 2, null, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (215, 2, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (216, 0, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (217, 0, null, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (218, 1, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (219, 1, null, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (1011, 2, 1021, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (1, 2, null, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (2, 1, 1, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (3, 2, 1, 1);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (1010, 2, 1015, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (1003, 2, 1010, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (1005, 2, 1000, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (1006, 2, 1012, 0);
insert into ORDERS (order_id, order_status_id, truck_id, deleted)
values (1014, 2, 1025, 0);
commit;
prompt 226 records loaded
prompt Loading USER_STATUSES...
insert into USER_STATUSES (user_status_id, user_status_name)
values (0, 'n/a');
insert into USER_STATUSES (user_status_id, user_status_name)
values (2, 'shift');
insert into USER_STATUSES (user_status_id, user_status_name)
values (3, 'driving');
insert into USER_STATUSES (user_status_id, user_status_name)
values (4, 'n/a');
insert into USER_STATUSES (user_status_id, user_status_name)
values (1, 'vacant');
commit;
prompt 5 records loaded
prompt Loading ROLES...
insert into ROLES (role_id, role_name)
values (0, 'n/a');
insert into ROLES (role_id, role_name)
values (1, 'administrator');
insert into ROLES (role_id, role_name)
values (2, 'ROLE_OPERATOR');
insert into ROLES (role_id, role_name)
values (3, 'ROLE_DRIVER');
commit;
prompt 4 records loaded
prompt Loading USERS...
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (445, 'Jonathan', 'Garner', 'driver', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 72, 0, 4, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (446, 'Katrin', 'Orlando', 'login446', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 147, 2, 8, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (447, 'Christine', 'Sandler', 'login447', '$2a$10$3ndIbRBb9o7fedBOdbdt/uUv8GUMDla4j3QYUoA7WWiyKZOBhHUY6', 2, 17, 0, 0, 0, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (448, 'Noah', 'Mortensen', 'login448', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 6, 0, 8, null, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (449, 'Wes', 'Mitchell', 'login449', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 3, 0, 5, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (450, 'Busta', 'Shawn', 'login450', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 109, 1, 2, null, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (451, 'Peabo', 'Sweet', 'login451', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 28, 1, 9, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (452, 'Gordie', 'Kleinenberg', 'login452', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 113, 2, 2, 1, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (453, 'Balthazar', 'Rudd', 'login453', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 73, 2, 0, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (454, 'Regina', 'Mac', 'login454', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 145, 3, 4, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (455, 'Nora', 'Schwarzenegger', 'login455', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 85, 2, 8, 1, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (456, 'Jaime', 'Neuwirth', 'login456', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 71, 3, 6, 0, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (457, 'Chantй', 'Zeta-Jones', 'login457', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 119, 2, 0, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (458, 'Meredith', 'Tomei', 'login458', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 27, 1, 10, 1, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (459, 'Davis', 'Schiff', 'login459', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 69, 3, 4, 0, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (460, 'Chely', 'Brown', 'login460', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 141, 3, 10, null, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (461, 'Emilio', 'Warburton', 'login461', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 98, 1, 5, 1, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (462, 'Miriam', 'Nelligan', 'login462', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 150, 2, 4, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (463, 'Sarah', 'Birch', 'login463', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 141, 3, 2, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (465, 'Grant', 'Khan', 'login465', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 73, 1, 2, 0, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (466, 'Busta', 'Melvin', 'login466', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 114, 1, 6, 0, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (467, 'Jodie', 'Love', 'login467', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 90, 1, 10, 0, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (468, 'Gates', 'Bracco', 'login468', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 172, 1, 2, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (469, 'Saffron', 'Rain', 'login469', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 166, 3, 4, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (470, 'Ashton', 'Woodard', 'login470', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 60, 0, 9, 1, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (472, 'Ralph', 'Northam', 'login472', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 98, 1, 2, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (473, 'Lou', 'Chao', 'login473', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 90, 1, 3, null, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (474, 'Aidan', 'Haslam', 'login474', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 130, 2, 0, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (475, 'Harry', 'Neil', 'login475', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 105, 1, 6, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (476, 'Joaquim', 'Atkins', 'login476', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 112, 3, 1, 327, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (477, 'Roy', 'Kleinenberg', 'login477', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 116, 2, 0, 0, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (478, 'Joaquim', 'Carrere', 'login478', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 149, 2, 2, 300, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (479, 'Daryle', 'Cleese', 'login479', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 19, 2, 3, 0, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (480, 'Walter', 'Gershon', 'login480', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 49, 0, 1, 1015, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (-1, 'no user', 'no user', null, null, null, null, null, null, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (1001, 'mikhail', 'davydov', 'mdavydov', '$2a$10$3ndIbRBb9o7fedBOdbdt/uUv8GUMDla4j3QYUoA7WWiyKZOBhHUY6', 2, 1, 4, 1, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (1042, 'testuser1', 'testuser1', 'testuser1', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 0, 1, 1, 1021, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (1043, 'testuser2', 'testuser2', 'testuser2', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 0, 1, 1, 1021, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (1044, 'testuser3', 'testuser3', 'testuser3', '$2a$10$3ndIbRBb9o7fedBOdbdt/uUv8GUMDla4j3QYUoA7WWiyKZOBhHUY6', 2, 0, 1, 1, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (1057, 'testuser4', 'testuser4', 'testuser4', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 0, 3, 2, 1025, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (2, 'driver 1 first name', 'driver 1 last name', 'driver1', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 15, 3, 1, 1000, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (3, 'driver 2 first name', 'driver 2 last name', 'driver2', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 150, 1, 2, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (4, 'driver 3 first name', 'driver 3 last name', 'driver3', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 20, 2, 3, null, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (6, 'Jeffery', 'Snider', 'jeffery.', '$2a$10$3ndIbRBb9o7fedBOdbdt/uUv8GUMDla4j3QYUoA7WWiyKZOBhHUY6', 2, 158, 0, 9, 0, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (7, 'Kylie', 'LuPone', 'kylie.lu', '$2a$10$3ndIbRBb9o7fedBOdbdt/uUv8GUMDla4j3QYUoA7WWiyKZOBhHUY6', 2, 167, 2, 5, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (8, 'Tea', 'Hannah', 'tea@extr', '$2a$10$3ndIbRBb9o7fedBOdbdt/uUv8GUMDla4j3QYUoA7WWiyKZOBhHUY6', 2, 168, 3, 5, null, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (9, 'Maggie', 'Fariq', 'maggief@', '$2a$10$3ndIbRBb9o7fedBOdbdt/uUv8GUMDla4j3QYUoA7WWiyKZOBhHUY6', 2, 170, 0, 7, 1, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (10, 'Lorraine', 'Brothers', 'lorraine', '$2a$10$3ndIbRBb9o7fedBOdbdt/uUv8GUMDla4j3QYUoA7WWiyKZOBhHUY6', 2, 171, 3, 3, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (11, 'Jude', 'Fisher', 'j.fisher', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 55, 2, 6, 0, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (12, 'Gilbert', 'Giamatti', 'gilbert.', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 57, 1, 1, 1, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (13, 'Sheryl', 'Koyana', 'sheryl.k', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 42, 0, 1, 0, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (15, 'Angela', 'Landau', 'angela.l', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 63, 2, 10, 1, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (16, 'Rosco', 'Tilly', 'rosco.ti', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 42, 2, 0, 0, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (17, 'Reese', 'Theron', 'rtheron@', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 21, 1, 9, 1, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (18, 'Martha', 'Short', 'martha@f', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 173, 0, 6, 0, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (19, 'Freddy', 'Schiff', 'freddy.s', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 54, 1, 8, 0, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (20, 'Temuera', 'Newman', 't.newman', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 27, 1, 5, 1, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (21, 'Harvey', 'Hagerty', 'harvey.h', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 32, 1, 8, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (22, 'Judge', 'Van Der Beek', 'judge.v@', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 130, 2, 0, 1, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (23, 'Eileen', 'Nunn', 'eileen.n', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 48, 0, 0, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (24, 'Allison', 'Lauper', 'alauper@', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 127, 3, 0, 0, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (25, 'Hope', 'Watson', 'hope.wat', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 16, 1, 1, 0, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (26, 'Aimee', 'Kurtz', 'aimee.ku', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 15, 3, 6, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (27, 'Wally', 'Gano', 'wgano@tr', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 140, 0, 8, null, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (28, 'Leo', 'Shaye', 'leos@mic', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 48, 1, 4, 1, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (29, 'Wayman', 'Martinez', 'wayman.m', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 22, 0, 6, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (30, 'Selma', 'Giannini', 'selma.gi', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 16, 2, 7, 0, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (31, 'Bruce', 'Cox', 'bruce.co', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 81, 0, 1, 0, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (32, 'Laurence', 'Baker', 'l.baker@', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 52, 2, 1, 0, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (33, 'Carlos', 'Sainte-Marie', 'carloss@', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 124, 0, 4, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (34, 'Lois', 'Getty', 'lois.get', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 169, 1, 0, 0, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (35, 'Pat', 'Chappelle', 'p.chappe', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 163, 3, 6, 1, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (36, 'Wade', 'Gano', 'wade.gan', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 6, 2, 3, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (37, 'Bette', 'Washington', 'bette.w@', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 44, 3, 7, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (38, 'Ethan', 'Ratzenberger', 'ethan.ra', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 127, 1, 6, 0, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (39, 'Peabo', 'Dawson', 'peabo@pa', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 127, 3, 10, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (40, 'Alicia', 'Wakeling', 'alicia.w', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 127, 2, 5, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (41, 'Harriet', 'Speaks', 'harriet.', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 167, 2, 1, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (42, 'Oded', 'Kirkwood', 'oded.kir', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 117, 2, 7, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (43, 'Rosanna', 'MacLachlan', 'rosanna.', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 155, 1, 7, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (44, 'Frankie', 'Finn', 'frankie.', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 116, 1, 0, 0, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (45, 'Powers', 'Capshaw', 'powersc@', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 121, 1, 1, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (47, 'Rod', 'Lewis', 'rod@anhe', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 113, 3, 8, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (48, 'Rowan', 'Janssen', 'rowan@st', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 83, 2, 2, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (49, 'Rebeka', 'Sheen', 'rebeka.s', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 175, 1, 1, 0, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (50, 'Dabney', 'Colman', 'dabneyc@', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 9, 3, 3, null, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (51, 'Avril', 'Arden', 'a.arden@', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 65, 3, 1, 1, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (52, 'Peter', 'Supernaw', 'peter@sm', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 165, 2, 7, null, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (53, 'Garry', 'Morrison', 'garry.m@', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 164, 2, 6, 0, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (54, 'Claude', 'Shandling', 'claude.s', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 19, 1, 2, 0, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (55, 'Toshiro', 'Lemmon', 'toshirol', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 2, 1, 1, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (56, 'Chaka', 'Vannelli', 'c.vannel', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 54, 2, 9, 1, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (58, 'Veruca', 'Dooley', 'v.dooley', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 121, 3, 3, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (59, 'Natacha', 'Estevez', 'natacha.', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 81, 3, 9, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (60, 'Emma', 'Foley', 'emmaf@ah', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 151, 2, 6, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (61, 'Wesley', 'Rawls', 'wesley@l', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 27, 1, 5, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (62, 'Terry', 'Arden', 'terry.ar', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 39, 3, 9, null, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (63, 'Arnold', 'Elizabeth', 'arnold@v', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 13, 2, 5, null, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (64, 'Elvis', 'Pantoliano', 'elvis.pa', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 134, 3, 7, 0, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (65, 'Goldie', 'Lang', 'goldie.l', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 98, 3, 6, null, 0, 1);
commit;
prompt 100 records committed...
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (66, 'Collective', 'Lofgren', 'collecti', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 22, 1, 4, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (67, 'Amy', 'Fiorentino', 'a.fioren', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 132, 1, 2, 0, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (68, 'Frederic', 'Cooper', 'frederic', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 51, 2, 10, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (69, 'Luke', 'Masur', 'luke@ame', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 40, 3, 6, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (70, 'Lisa', 'Harris', 'lharris@', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 87, 2, 8, 0, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (71, 'Laura', 'Witherspoon', 'laura.wi', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 27, 1, 9, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (72, 'Renee', 'Parish', 'renee.pa', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 111, 1, 8, 0, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (74, 'Kevin', 'Giamatti', 'kevin.gi', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 98, 3, 3, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (75, 'Geena', 'Blair', 'geena@nh', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 41, 3, 7, 0, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (76, 'Marc', 'Garofalo', 'marc@vms', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 159, 1, 8, 1, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (77, 'Nik', 'McDowell', 'nik.mcdo', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 3, 3, 7, 0, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (78, 'Lou', 'Eldard', 'lou@tele', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 31, 1, 3, 1, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (79, 'Loren', 'Burton', 'loren.bu', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 87, 3, 3, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (80, 'Taryn', 'Garfunkel', 'taryng@d', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 89, 2, 7, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (81, 'Sara', 'Hurley', 'sara.hur', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 109, 3, 9, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (82, 'Sammy', 'Winslet', 'sammy.wi', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 50, 3, 10, 0, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (83, 'Katie', 'Penders', 'katie.pe', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 97, 2, 1, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (84, 'Cary', 'Puckett', 'c.pucket', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 108, 2, 8, 0, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (85, 'Wally', 'David', 'w.david@', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 60, 1, 1, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (86, 'Kid', 'Phillippe', 'kid.p@mi', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 158, 1, 5, 0, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (87, 'Freda', 'Wiest', 'freda@pr', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 169, 1, 7, 1, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (88, 'Tanya', 'Akins', 'tanya.ak', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 81, 3, 5, null, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (89, 'Humberto', 'Levin', 'humberto', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 47, 1, 9, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (90, 'Tracy', 'Herndon', 'tracy.he', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 63, 3, 5, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (91, 'Brian', 'Gunton', 'bgunton@', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 98, 1, 9, 1, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (92, 'Millie', 'Mazar', 'millie.m', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 143, 1, 3, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (93, 'Roger', 'Metcalf', 'rogerm@c', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 61, 0, 2, 0, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (94, 'Leon', 'Swinton', 'leon.s@o', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 146, 1, 10, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (95, 'Gordie', 'Gallagher', 'gordie.g', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 85, 0, 5, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (96, 'Trey', 'Pryce', 'trey.pry', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 43, 3, 4, 1, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (97, 'Kay', 'Ness', 'kay.ness', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 97, 1, 2, 1, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (98, 'Jeff', 'Assante', 'jeff@dat', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 56, 1, 6, null, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (99, 'Tilda', 'Dean', 't.dean@u', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 84, 2, 1, null, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (100, 'Pat', 'Rock', 'pat.rock', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 162, 0, 4, 0, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (101, 'Elle', 'Stills', 'elle.sti', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 157, 3, 8, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (102, 'Geena', 'Slater', 'geena.sl', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 147, 3, 1, null, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (103, 'Rawlins', 'Streep', 'r.streep', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 1, 0, 9, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (104, 'Terri', 'Reilly', 'terri.re', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 11, 3, 5, null, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (105, 'Faye', 'Spacey', 'faye.spa', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 64, 3, 0, 0, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (106, 'Orlando', 'Oszajca', 'orlando.', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 175, 3, 4, 0, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (107, 'Viggo', 'Guest', 'viggo.gu', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 124, 1, 10, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (108, 'Seann', 'Applegate', 'seann.a@', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 64, 2, 8, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (110, 'Denzel', 'Donelly', 'login', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 8, 1, 9, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (300, 'Jose', 'McIntosh', 'login300', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 74, 0, 8, null, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (301, 'Franco', 'Rauhofer', 'login301', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 97, 0, 2, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (302, 'Jerry', 'Costa', 'login302', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 2, 2, 4, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (303, 'Brooke', 'Hyde', 'login303', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 135, 2, 1, null, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (304, 'Nikki', 'Kudrow', 'login304', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 29, 3, 1, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (305, 'Gran', 'Olin', 'login305', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 80, 1, 5, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (306, 'Spike', 'Chilton', 'login306', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 146, 2, 2, null, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (307, 'Terri', 'Maxwell', 'login307', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 77, 2, 4, null, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (308, 'Heath', 'Sainte-Marie', 'login308', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 137, 3, 7, null, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (309, 'Gina', 'Caan', 'login309', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 98, 3, 5, null, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (310, 'Fats', 'McNeice', 'login310', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 48, 3, 9, null, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (311, 'Thora', 'Skerritt', 'login311', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 55, 2, 1, 0, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (312, 'Rachel', 'Weiss', 'login312', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 115, 1, 4, 0, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (313, 'Gilbert', 'Guzman', 'login313', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 135, 1, 4, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (314, 'Lili', 'Wincott', 'login314', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 44, 0, 8, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (315, 'Terri', 'Atkins', 'login315', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 114, 0, 1, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (316, 'Katrin', 'Ingram', 'login316', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 55, 0, 9, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (317, 'Miko', 'Adams', 'login317', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 56, 1, 10, null, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (318, 'Ivan', 'Connelly', 'login318', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 164, 3, 2, 0, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (319, 'Lorraine', 'Pacino', 'login319', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 7, 3, 10, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (320, 'Neneh', 'Burmester', 'login320', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 112, 3, 4, 0, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (0, 'admin', 'admin', 'admin', '$2a$10$3ndIbRBb9o7fedBOdbdt/uUv8GUMDla4j3QYUoA7WWiyKZOBhHUY6', 2, 0, 0, 0, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (1, 'operator', 'operator', 'operator', '$2a$10$3ndIbRBb9o7fedBOdbdt/uUv8GUMDla4j3QYUoA7WWiyKZOBhHUY6', 2, 0, 0, 0, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (321, 'Howard', 'Dawson', 'login321', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 44, 2, 5, 0, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (322, 'Carole', 'Krumholtz', 'login322', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 13, 3, 9, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (323, 'Jay', 'Sandler', 'login323', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 58, 1, 7, null, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (324, 'Nelly', 'Dutton', 'login324', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 154, 1, 5, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (325, 'Thora', 'Wakeling', 'login325', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 92, 1, 3, 0, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (326, 'Cesar', 'Plowright', 'login326', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 21, 2, 2, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (327, 'Jean-Claude', 'Dunn', 'login327', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 148, 1, 1, 1, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (328, 'Freddie', 'Gaynor', 'login328', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 36, 1, 3, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (329, 'William', 'Robinson', 'login329', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 136, 2, 3, 0, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (330, 'Desmond', 'Macht', 'login330', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 138, 0, 2, 1, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (331, 'Pablo', 'Crystal', 'login331', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 126, 1, 7, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (332, 'Emmylou', 'Atkins', 'login332', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 107, 3, 2, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (333, 'Elijah', 'Hanks', 'login333', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 13, 3, 3, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (334, 'Kiefer', 'Ramirez', 'login334', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 33, 2, 1, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (335, 'Rick', 'Woodard', 'login335', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 22, 2, 7, 0, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (336, 'Denny', 'Winslet', 'login336', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 31, 2, 5, 0, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (337, 'Lesley', 'Woodard', 'login337', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 20, 2, 4, 0, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (338, 'Jann', 'Kier', 'login338', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 118, 1, 4, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (339, 'Swoosie', 'Mifune', 'login339', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 94, 2, 0, 1, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (340, 'Lou', 'Connelly', 'login340', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 36, 2, 7, 0, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (341, 'Vertical', 'Theron', 'login341', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 98, 3, 8, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (342, 'Howie', 'Buckingham', 'login342', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 117, 1, 4, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (343, 'Sigourney', 'McCready', 'login343', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 73, 2, 2, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (344, 'Chloe', 'McNarland', 'login344', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 101, 2, 0, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (345, 'Nik', 'Davis', 'login345', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 129, 0, 6, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (346, 'Anthony', 'Cleese', 'login346', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 91, 2, 1, 1, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (347, 'Jennifer', 'Morton', 'login347', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 13, 2, 3, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (348, 'Franz', 'Ward', 'login348', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 57, 3, 6, null, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (349, 'Loretta', 'Hanley', 'login349', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 126, 2, 8, 0, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (350, 'Sally', 'Chilton', 'login350', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 4, 3, 0, null, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (351, 'Maura', 'Ripley', 'login351', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 73, 0, 9, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (352, 'Uma', 'Greene', 'login352', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 80, 0, 7, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (353, 'Tyrone', 'Waite', 'login353', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 95, 3, 9, 1, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (354, 'Miranda', 'Rowlands', 'login354', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 2, 2, 10, null, 0, 1);
commit;
prompt 200 records committed...
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (355, 'Alec', 'Neeson', 'login355', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 146, 3, 4, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (356, 'Rene', 'Lapointe', 'login356', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 52, 1, 7, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (357, 'Sophie', 'Swayze', 'login357', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 12, 2, 3, 0, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (358, 'Taye', 'Holliday', 'login358', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 59, 3, 4, 1, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (359, 'Rosco', 'Cervine', 'login359', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 114, 2, 0, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (360, 'Kenny', 'Hurt', 'login360', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 4, 3, 0, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (361, 'Ali', 'Gayle', 'login361', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 139, 0, 1, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (362, 'Neve', 'Atkinson', 'login362', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 7, 2, 1, 0, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (363, 'Colleen', 'Neuwirth', 'login363', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 116, 1, 4, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (364, 'Aaron', 'Bush', 'login364', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 27, 0, 2, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (365, 'Andrea', 'Herndon', 'login365', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 97, 0, 8, null, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (366, 'Morris', 'Turner', 'login366', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 114, 2, 6, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (367, 'Alan', 'Kinney', 'login367', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 127, 3, 6, 1, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (368, 'Julia', 'Kurtz', 'login368', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 12, 1, 1, 1, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (369, 'Rascal', 'O''Neill', 'login369', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 173, 1, 0, 0, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (370, 'Geoff', 'Vanian', 'login370', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 126, 1, 1, 0, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (371, 'Earl', 'Heslov', 'login371', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 98, 0, 2, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (372, 'Johnette', 'Keitel', 'login372', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 169, 3, 5, null, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (373, 'Martin', 'Guzman', 'login373', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 33, 3, 4, 0, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (374, 'Mia', 'Alda', 'login374', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 36, 2, 2, 1, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (375, 'Mos', 'DiFranco', 'login375', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 13, 1, 9, 0, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (376, 'Praga', 'Dysart', 'login376', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 120, 0, 5, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (377, 'Luke', 'Kleinenberg', 'login377', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 150, 3, 0, null, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (378, 'Sheena', 'Dern', 'login378', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 50, 3, 1, 0, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (379, 'Clea', 'Travers', 'login379', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 171, 2, 8, null, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (380, 'Sissy', 'Westerberg', 'login380', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 79, 3, 0, null, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (381, 'Bette', 'Bassett', 'login381', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 159, 2, 8, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (382, 'Hope', 'Root', 'login382', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 96, 3, 6, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (383, 'Jason', 'Kweller', 'login383', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 61, 0, 9, null, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (384, 'Regina', 'Clarkson', 'login384', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 60, 1, 8, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (385, 'Jann', 'Moss', 'login385', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 72, 3, 1, 0, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (386, 'Donald', 'Geldof', 'login386', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 151, 2, 1, null, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (387, 'Joaquin', 'Clayton', 'login387', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 118, 2, 5, 0, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (388, 'Liquid', 'Candy', 'login388', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 5, 1, 7, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (389, 'Nicky', 'Osment', 'login389', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 55, 1, 8, 0, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (390, 'Lila', 'Atkins', 'login390', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 51, 3, 6, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (391, 'Colin', 'Armatrading', 'login391', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 46, 3, 4, null, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (392, 'Omar', 'Swinton', 'login392', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 50, 2, 9, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (393, 'Frankie', 'Bloch', 'login393', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 16, 1, 10, 1, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (394, 'Albert', 'Sampson', 'login394', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 148, 1, 7, null, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (395, 'Dermot', 'de Lancie', 'login395', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 31, 3, 7, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (396, 'Solomon', 'Bailey', 'login396', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 5, 1, 6, 0, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (397, 'Ernie', 'Hughes', 'login397', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 115, 3, 0, 0, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (398, 'Darius', 'Sartain', 'login398', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 148, 1, 9, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (399, 'Kiefer', 'Sylvian', 'login399', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 21, 3, 2, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (400, 'Hugh', 'Duchovny', 'login400', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 28, 0, 1, null, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (401, 'Lara', 'Logue', 'login401', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 155, 2, 2, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (402, 'Joaquin', 'Harary', 'login402', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 60, 2, 1, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (403, 'Gena', 'Paul', 'login403', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 140, 1, 3, null, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (404, 'Cate', 'Swinton', 'login404', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 48, 1, 8, 0, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (405, 'Ed', 'Duschel', 'login405', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 123, 0, 10, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (406, 'Gwyneth', 'Kinski', 'login406', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 152, 2, 6, 1, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (407, 'Aidan', 'Cruz', 'login407', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 147, 1, 9, 0, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (408, 'Andrea', 'Warren', 'login408', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 8, 3, 10, null, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (409, 'Garry', 'Tsettos', 'login409', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 101, 1, 2, 0, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (410, 'Curt', 'Pollak', 'login410', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 43, 3, 1, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (411, 'Hilary', 'Francis', 'login411', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 26, 1, 1, 1, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (412, 'Molly', 'Liotta', 'login412', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 1, 2, 7, 1, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (413, 'Ice', 'Kinski', 'login413', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 143, 2, 5, 1, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (414, 'Alice', 'Imbruglia', 'login414', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 98, 0, 6, 0, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (415, 'Maureen', 'Duchovny', 'login415', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 86, 1, 2, 0, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (416, 'Rutger', 'Gugino', 'login416', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 135, 2, 9, 0, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (417, 'Ashton', 'McIntosh', 'login417', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 14, 3, 6, 1, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (418, 'Woody', 'Jonze', 'login418', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 35, 2, 8, 0, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (419, 'Bob', 'Capshaw', 'login419', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 56, 2, 1, 0, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (421, 'Celia', 'Carlisle', 'login421', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 0, 3, 10, 0, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (422, 'Gilbert', 'El-Saher', 'login422', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 138, 1, 0, 1, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (423, 'Faye', 'Watson', 'login423', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 96, 2, 9, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (424, 'Hilton', 'Mazzello', 'login424', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 82, 2, 4, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (425, 'Carrie-Anne', 'Kleinenberg', 'login425', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 136, 2, 4, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (426, 'Suzy', 'Begley', 'login426', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 60, 2, 0, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (427, 'Humberto', 'Palminteri', 'login427', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 94, 3, 5, 0, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (428, 'Yolanda', 'Smith', 'login428', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 105, 2, 5, null, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (429, 'Heath', 'Eastwood', 'login429', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 14, 1, 10, null, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (430, 'Debra', 'McFerrin', 'login430', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 168, 3, 5, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (431, 'Hal', 'Loveless', 'login431', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 94, 0, 10, 0, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (432, 'Sal', 'Fariq', 'login432', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 104, 1, 1, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (433, 'Ewan', 'Sweet', 'login433', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 160, 3, 6, 0, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (434, 'Nora', 'Bening', 'login434', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 157, 0, 1, 1, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (435, 'Ty', 'Rizzo', 'login435', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 75, 2, 9, 0, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (436, 'Tea', 'Pacino', 'login436', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 85, 2, 6, null, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (437, 'Tom', 'Allan', 'login437', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 151, 2, 9, 0, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (438, 'Cloris', 'Furay', 'login438', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 139, 0, 7, 0, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (439, 'Edie', 'O''Sullivan', 'login439', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 62, 2, 1, 0, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (440, 'Taylor', 'Tinsley', 'login440', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 17, 1, 10, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (441, 'Marley', 'Dillane', 'login441', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 23, 3, 10, null, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (442, 'Rip', 'Aaron', 'login442', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 94, 3, 8, 0, 1, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (443, 'Gordie', 'Grier', 'login443', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 145, 1, 0, 1, 0, 1);
insert into USERS (user_id, first_name, last_name, login, password, role_id, hours, user_status_id, city_id, truck_id, deleted, enabled)
values (444, 'Taylor', 'Cox', 'login444', '$2a$10$yp3xLVShq4sqey5Hg25wL.B8ebJGyR5UesvHVI9Hbgm8g7DvTi7aS', 3, 161, 1, 2, null, 0, 1);
commit;
prompt 289 records loaded
prompt Loading ORDER_DRIVER...
insert into ORDER_DRIVER (order_id, user_id)
values (1011, 1043);
insert into ORDER_DRIVER (order_id, user_id)
values (150, 408);
insert into ORDER_DRIVER (order_id, user_id)
values (184, 430);
insert into ORDER_DRIVER (order_id, user_id)
values (43, 397);
insert into ORDER_DRIVER (order_id, user_id)
values (184, 434);
insert into ORDER_DRIVER (order_id, user_id)
values (121, 370);
insert into ORDER_DRIVER (order_id, user_id)
values (166, 81);
insert into ORDER_DRIVER (order_id, user_id)
values (87, 339);
insert into ORDER_DRIVER (order_id, user_id)
values (147, 385);
insert into ORDER_DRIVER (order_id, user_id)
values (101, 30);
insert into ORDER_DRIVER (order_id, user_id)
values (11, 430);
insert into ORDER_DRIVER (order_id, user_id)
values (74, 406);
insert into ORDER_DRIVER (order_id, user_id)
values (147, 445);
insert into ORDER_DRIVER (order_id, user_id)
values (175, 99);
insert into ORDER_DRIVER (order_id, user_id)
values (152, 321);
insert into ORDER_DRIVER (order_id, user_id)
values (160, 38);
insert into ORDER_DRIVER (order_id, user_id)
values (24, 337);
insert into ORDER_DRIVER (order_id, user_id)
values (5, 69);
insert into ORDER_DRIVER (order_id, user_id)
values (207, 49);
insert into ORDER_DRIVER (order_id, user_id)
values (182, 110);
insert into ORDER_DRIVER (order_id, user_id)
values (203, 385);
insert into ORDER_DRIVER (order_id, user_id)
values (40, 441);
insert into ORDER_DRIVER (order_id, user_id)
values (120, 108);
insert into ORDER_DRIVER (order_id, user_id)
values (181, 65);
insert into ORDER_DRIVER (order_id, user_id)
values (135, 58);
insert into ORDER_DRIVER (order_id, user_id)
values (154, 348);
insert into ORDER_DRIVER (order_id, user_id)
values (184, 59);
insert into ORDER_DRIVER (order_id, user_id)
values (123, 459);
insert into ORDER_DRIVER (order_id, user_id)
values (215, 40);
insert into ORDER_DRIVER (order_id, user_id)
values (109, 96);
insert into ORDER_DRIVER (order_id, user_id)
values (137, 446);
insert into ORDER_DRIVER (order_id, user_id)
values (117, 323);
insert into ORDER_DRIVER (order_id, user_id)
values (142, 351);
insert into ORDER_DRIVER (order_id, user_id)
values (89, 60);
insert into ORDER_DRIVER (order_id, user_id)
values (186, 84);
insert into ORDER_DRIVER (order_id, user_id)
values (57, 13);
insert into ORDER_DRIVER (order_id, user_id)
values (93, 72);
insert into ORDER_DRIVER (order_id, user_id)
values (202, 411);
insert into ORDER_DRIVER (order_id, user_id)
values (29, 97);
insert into ORDER_DRIVER (order_id, user_id)
values (195, 331);
insert into ORDER_DRIVER (order_id, user_id)
values (102, 331);
insert into ORDER_DRIVER (order_id, user_id)
values (57, 342);
insert into ORDER_DRIVER (order_id, user_id)
values (15, 388);
insert into ORDER_DRIVER (order_id, user_id)
values (43, 465);
insert into ORDER_DRIVER (order_id, user_id)
values (1007, 476);
insert into ORDER_DRIVER (order_id, user_id)
values (156, 385);
insert into ORDER_DRIVER (order_id, user_id)
values (78, 301);
insert into ORDER_DRIVER (order_id, user_id)
values (180, 96);
insert into ORDER_DRIVER (order_id, user_id)
values (74, 434);
insert into ORDER_DRIVER (order_id, user_id)
values (72, 339);
insert into ORDER_DRIVER (order_id, user_id)
values (165, 337);
insert into ORDER_DRIVER (order_id, user_id)
values (191, 27);
insert into ORDER_DRIVER (order_id, user_id)
values (6, 306);
insert into ORDER_DRIVER (order_id, user_id)
values (199, 305);
insert into ORDER_DRIVER (order_id, user_id)
values (181, 12);
insert into ORDER_DRIVER (order_id, user_id)
values (178, 434);
insert into ORDER_DRIVER (order_id, user_id)
values (156, 315);
insert into ORDER_DRIVER (order_id, user_id)
values (64, 65);
insert into ORDER_DRIVER (order_id, user_id)
values (114, 371);
insert into ORDER_DRIVER (order_id, user_id)
values (150, 300);
insert into ORDER_DRIVER (order_id, user_id)
values (29, 75);
insert into ORDER_DRIVER (order_id, user_id)
values (218, 346);
insert into ORDER_DRIVER (order_id, user_id)
values (118, 349);
insert into ORDER_DRIVER (order_id, user_id)
values (135, 59);
insert into ORDER_DRIVER (order_id, user_id)
values (89, 441);
insert into ORDER_DRIVER (order_id, user_id)
values (1011, 1042);
insert into ORDER_DRIVER (order_id, user_id)
values (117, 378);
insert into ORDER_DRIVER (order_id, user_id)
values (142, 411);
insert into ORDER_DRIVER (order_id, user_id)
values (194, 77);
insert into ORDER_DRIVER (order_id, user_id)
values (134, 327);
insert into ORDER_DRIVER (order_id, user_id)
values (26, 108);
insert into ORDER_DRIVER (order_id, user_id)
values (199, 66);
insert into ORDER_DRIVER (order_id, user_id)
values (176, 373);
insert into ORDER_DRIVER (order_id, user_id)
values (173, 461);
insert into ORDER_DRIVER (order_id, user_id)
values (150, 431);
insert into ORDER_DRIVER (order_id, user_id)
values (10, 374);
insert into ORDER_DRIVER (order_id, user_id)
values (168, 438);
insert into ORDER_DRIVER (order_id, user_id)
values (50, 396);
insert into ORDER_DRIVER (order_id, user_id)
values (6, 17);
insert into ORDER_DRIVER (order_id, user_id)
values (2, 456);
insert into ORDER_DRIVER (order_id, user_id)
values (7, 445);
insert into ORDER_DRIVER (order_id, user_id)
values (205, 107);
insert into ORDER_DRIVER (order_id, user_id)
values (173, 16);
insert into ORDER_DRIVER (order_id, user_id)
values (31, 68);
insert into ORDER_DRIVER (order_id, user_id)
values (131, 65);
insert into ORDER_DRIVER (order_id, user_id)
values (183, 301);
insert into ORDER_DRIVER (order_id, user_id)
values (159, 69);
insert into ORDER_DRIVER (order_id, user_id)
values (122, 450);
insert into ORDER_DRIVER (order_id, user_id)
values (32, 332);
insert into ORDER_DRIVER (order_id, user_id)
values (125, 51);
insert into ORDER_DRIVER (order_id, user_id)
values (167, 383);
insert into ORDER_DRIVER (order_id, user_id)
values (189, 27);
insert into ORDER_DRIVER (order_id, user_id)
values (160, 33);
insert into ORDER_DRIVER (order_id, user_id)
values (137, 372);
insert into ORDER_DRIVER (order_id, user_id)
values (193, 345);
insert into ORDER_DRIVER (order_id, user_id)
values (40, 412);
insert into ORDER_DRIVER (order_id, user_id)
values (74, 451);
insert into ORDER_DRIVER (order_id, user_id)
values (164, 95);
insert into ORDER_DRIVER (order_id, user_id)
values (178, 350);
insert into ORDER_DRIVER (order_id, user_id)
values (106, 335);
commit;
prompt 100 records committed...
insert into ORDER_DRIVER (order_id, user_id)
values (50, 453);
insert into ORDER_DRIVER (order_id, user_id)
values (153, 34);
insert into ORDER_DRIVER (order_id, user_id)
values (120, 346);
insert into ORDER_DRIVER (order_id, user_id)
values (49, 363);
insert into ORDER_DRIVER (order_id, user_id)
values (21, 48);
insert into ORDER_DRIVER (order_id, user_id)
values (61, 333);
insert into ORDER_DRIVER (order_id, user_id)
values (141, 470);
insert into ORDER_DRIVER (order_id, user_id)
values (69, 463);
insert into ORDER_DRIVER (order_id, user_id)
values (12, 342);
insert into ORDER_DRIVER (order_id, user_id)
values (159, 300);
insert into ORDER_DRIVER (order_id, user_id)
values (78, 387);
insert into ORDER_DRIVER (order_id, user_id)
values (85, 108);
insert into ORDER_DRIVER (order_id, user_id)
values (90, 400);
insert into ORDER_DRIVER (order_id, user_id)
values (133, 345);
insert into ORDER_DRIVER (order_id, user_id)
values (85, 340);
insert into ORDER_DRIVER (order_id, user_id)
values (60, 82);
insert into ORDER_DRIVER (order_id, user_id)
values (144, 95);
insert into ORDER_DRIVER (order_id, user_id)
values (154, 68);
insert into ORDER_DRIVER (order_id, user_id)
values (100, 305);
insert into ORDER_DRIVER (order_id, user_id)
values (210, 348);
insert into ORDER_DRIVER (order_id, user_id)
values (85, 383);
insert into ORDER_DRIVER (order_id, user_id)
values (203, 40);
insert into ORDER_DRIVER (order_id, user_id)
values (32, 104);
insert into ORDER_DRIVER (order_id, user_id)
values (48, 451);
insert into ORDER_DRIVER (order_id, user_id)
values (88, 380);
insert into ORDER_DRIVER (order_id, user_id)
values (202, 56);
insert into ORDER_DRIVER (order_id, user_id)
values (210, 407);
insert into ORDER_DRIVER (order_id, user_id)
values (63, 448);
insert into ORDER_DRIVER (order_id, user_id)
values (100, 314);
insert into ORDER_DRIVER (order_id, user_id)
values (190, 441);
insert into ORDER_DRIVER (order_id, user_id)
values (31, 29);
insert into ORDER_DRIVER (order_id, user_id)
values (154, 329);
insert into ORDER_DRIVER (order_id, user_id)
values (110, 88);
insert into ORDER_DRIVER (order_id, user_id)
values (109, 74);
insert into ORDER_DRIVER (order_id, user_id)
values (190, 408);
insert into ORDER_DRIVER (order_id, user_id)
values (219, 104);
insert into ORDER_DRIVER (order_id, user_id)
values (45, 357);
insert into ORDER_DRIVER (order_id, user_id)
values (202, 11);
insert into ORDER_DRIVER (order_id, user_id)
values (151, 91);
insert into ORDER_DRIVER (order_id, user_id)
values (37, 95);
insert into ORDER_DRIVER (order_id, user_id)
values (52, 405);
insert into ORDER_DRIVER (order_id, user_id)
values (65, 103);
insert into ORDER_DRIVER (order_id, user_id)
values (208, 401);
insert into ORDER_DRIVER (order_id, user_id)
values (99, 432);
insert into ORDER_DRIVER (order_id, user_id)
values (219, 467);
insert into ORDER_DRIVER (order_id, user_id)
values (133, 459);
insert into ORDER_DRIVER (order_id, user_id)
values (203, 469);
insert into ORDER_DRIVER (order_id, user_id)
values (73, 468);
insert into ORDER_DRIVER (order_id, user_id)
values (100, 353);
insert into ORDER_DRIVER (order_id, user_id)
values (36, 354);
insert into ORDER_DRIVER (order_id, user_id)
values (94, 9);
insert into ORDER_DRIVER (order_id, user_id)
values (138, 24);
insert into ORDER_DRIVER (order_id, user_id)
values (186, 397);
insert into ORDER_DRIVER (order_id, user_id)
values (64, 30);
insert into ORDER_DRIVER (order_id, user_id)
values (127, 454);
insert into ORDER_DRIVER (order_id, user_id)
values (39, 28);
insert into ORDER_DRIVER (order_id, user_id)
values (196, 468);
insert into ORDER_DRIVER (order_id, user_id)
values (76, 94);
insert into ORDER_DRIVER (order_id, user_id)
values (144, 359);
insert into ORDER_DRIVER (order_id, user_id)
values (26, 399);
insert into ORDER_DRIVER (order_id, user_id)
values (51, 376);
insert into ORDER_DRIVER (order_id, user_id)
values (178, 324);
insert into ORDER_DRIVER (order_id, user_id)
values (130, 448);
insert into ORDER_DRIVER (order_id, user_id)
values (66, 47);
insert into ORDER_DRIVER (order_id, user_id)
values (25, 24);
insert into ORDER_DRIVER (order_id, user_id)
values (93, 412);
insert into ORDER_DRIVER (order_id, user_id)
values (67, 432);
insert into ORDER_DRIVER (order_id, user_id)
values (167, 58);
insert into ORDER_DRIVER (order_id, user_id)
values (23, 301);
insert into ORDER_DRIVER (order_id, user_id)
values (94, 430);
insert into ORDER_DRIVER (order_id, user_id)
values (102, 345);
insert into ORDER_DRIVER (order_id, user_id)
values (178, 465);
insert into ORDER_DRIVER (order_id, user_id)
values (70, 424);
insert into ORDER_DRIVER (order_id, user_id)
values (82, 337);
insert into ORDER_DRIVER (order_id, user_id)
values (43, 374);
insert into ORDER_DRIVER (order_id, user_id)
values (5, 360);
insert into ORDER_DRIVER (order_id, user_id)
values (9, 393);
insert into ORDER_DRIVER (order_id, user_id)
values (150, 459);
insert into ORDER_DRIVER (order_id, user_id)
values (12, 89);
insert into ORDER_DRIVER (order_id, user_id)
values (209, 7);
insert into ORDER_DRIVER (order_id, user_id)
values (127, 459);
insert into ORDER_DRIVER (order_id, user_id)
values (22, 359);
insert into ORDER_DRIVER (order_id, user_id)
values (73, 383);
insert into ORDER_DRIVER (order_id, user_id)
values (160, 424);
insert into ORDER_DRIVER (order_id, user_id)
values (114, 468);
insert into ORDER_DRIVER (order_id, user_id)
values (194, 303);
insert into ORDER_DRIVER (order_id, user_id)
values (149, 468);
insert into ORDER_DRIVER (order_id, user_id)
values (92, 30);
insert into ORDER_DRIVER (order_id, user_id)
values (47, 328);
insert into ORDER_DRIVER (order_id, user_id)
values (191, 452);
insert into ORDER_DRIVER (order_id, user_id)
values (4, 41);
insert into ORDER_DRIVER (order_id, user_id)
values (52, 333);
insert into ORDER_DRIVER (order_id, user_id)
values (138, 335);
insert into ORDER_DRIVER (order_id, user_id)
values (69, 372);
insert into ORDER_DRIVER (order_id, user_id)
values (176, 10);
insert into ORDER_DRIVER (order_id, user_id)
values (119, 49);
insert into ORDER_DRIVER (order_id, user_id)
values (108, 56);
insert into ORDER_DRIVER (order_id, user_id)
values (116, 62);
insert into ORDER_DRIVER (order_id, user_id)
values (121, 55);
insert into ORDER_DRIVER (order_id, user_id)
values (142, 448);
commit;
prompt 200 records committed...
insert into ORDER_DRIVER (order_id, user_id)
values (162, 22);
insert into ORDER_DRIVER (order_id, user_id)
values (88, 444);
insert into ORDER_DRIVER (order_id, user_id)
values (160, 42);
insert into ORDER_DRIVER (order_id, user_id)
values (104, 84);
insert into ORDER_DRIVER (order_id, user_id)
values (66, 463);
insert into ORDER_DRIVER (order_id, user_id)
values (142, 453);
insert into ORDER_DRIVER (order_id, user_id)
values (199, 101);
insert into ORDER_DRIVER (order_id, user_id)
values (214, 449);
insert into ORDER_DRIVER (order_id, user_id)
values (41, 89);
insert into ORDER_DRIVER (order_id, user_id)
values (203, 19);
insert into ORDER_DRIVER (order_id, user_id)
values (59, 354);
insert into ORDER_DRIVER (order_id, user_id)
values (86, 367);
insert into ORDER_DRIVER (order_id, user_id)
values (188, 76);
insert into ORDER_DRIVER (order_id, user_id)
values (163, 47);
insert into ORDER_DRIVER (order_id, user_id)
values (90, 468);
insert into ORDER_DRIVER (order_id, user_id)
values (75, 451);
insert into ORDER_DRIVER (order_id, user_id)
values (214, 43);
insert into ORDER_DRIVER (order_id, user_id)
values (41, 397);
insert into ORDER_DRIVER (order_id, user_id)
values (99, 367);
insert into ORDER_DRIVER (order_id, user_id)
values (146, 88);
insert into ORDER_DRIVER (order_id, user_id)
values (100, 380);
insert into ORDER_DRIVER (order_id, user_id)
values (101, 382);
insert into ORDER_DRIVER (order_id, user_id)
values (34, 418);
insert into ORDER_DRIVER (order_id, user_id)
values (101, 80);
insert into ORDER_DRIVER (order_id, user_id)
values (45, 477);
insert into ORDER_DRIVER (order_id, user_id)
values (44, 18);
insert into ORDER_DRIVER (order_id, user_id)
values (10, 313);
insert into ORDER_DRIVER (order_id, user_id)
values (170, 468);
insert into ORDER_DRIVER (order_id, user_id)
values (159, 393);
insert into ORDER_DRIVER (order_id, user_id)
values (40, 406);
insert into ORDER_DRIVER (order_id, user_id)
values (71, 430);
insert into ORDER_DRIVER (order_id, user_id)
values (6, 348);
insert into ORDER_DRIVER (order_id, user_id)
values (197, 349);
insert into ORDER_DRIVER (order_id, user_id)
values (4, 360);
insert into ORDER_DRIVER (order_id, user_id)
values (191, 461);
insert into ORDER_DRIVER (order_id, user_id)
values (72, 63);
insert into ORDER_DRIVER (order_id, user_id)
values (219, 18);
insert into ORDER_DRIVER (order_id, user_id)
values (89, 379);
insert into ORDER_DRIVER (order_id, user_id)
values (173, 321);
insert into ORDER_DRIVER (order_id, user_id)
values (62, 331);
insert into ORDER_DRIVER (order_id, user_id)
values (149, 77);
insert into ORDER_DRIVER (order_id, user_id)
values (51, 374);
insert into ORDER_DRIVER (order_id, user_id)
values (88, 344);
insert into ORDER_DRIVER (order_id, user_id)
values (89, 449);
insert into ORDER_DRIVER (order_id, user_id)
values (209, 308);
insert into ORDER_DRIVER (order_id, user_id)
values (181, 52);
insert into ORDER_DRIVER (order_id, user_id)
values (59, 342);
insert into ORDER_DRIVER (order_id, user_id)
values (141, 89);
insert into ORDER_DRIVER (order_id, user_id)
values (201, 450);
insert into ORDER_DRIVER (order_id, user_id)
values (40, 12);
insert into ORDER_DRIVER (order_id, user_id)
values (23, 454);
insert into ORDER_DRIVER (order_id, user_id)
values (206, 417);
insert into ORDER_DRIVER (order_id, user_id)
values (10, 335);
insert into ORDER_DRIVER (order_id, user_id)
values (19, 419);
insert into ORDER_DRIVER (order_id, user_id)
values (163, 428);
insert into ORDER_DRIVER (order_id, user_id)
values (24, 361);
insert into ORDER_DRIVER (order_id, user_id)
values (197, 101);
insert into ORDER_DRIVER (order_id, user_id)
values (216, 351);
insert into ORDER_DRIVER (order_id, user_id)
values (147, 352);
insert into ORDER_DRIVER (order_id, user_id)
values (146, 460);
insert into ORDER_DRIVER (order_id, user_id)
values (169, 459);
insert into ORDER_DRIVER (order_id, user_id)
values (142, 66);
insert into ORDER_DRIVER (order_id, user_id)
values (216, 49);
insert into ORDER_DRIVER (order_id, user_id)
values (212, 17);
insert into ORDER_DRIVER (order_id, user_id)
values (195, 308);
insert into ORDER_DRIVER (order_id, user_id)
values (162, 84);
insert into ORDER_DRIVER (order_id, user_id)
values (196, 88);
insert into ORDER_DRIVER (order_id, user_id)
values (139, 348);
insert into ORDER_DRIVER (order_id, user_id)
values (25, 434);
insert into ORDER_DRIVER (order_id, user_id)
values (138, 363);
insert into ORDER_DRIVER (order_id, user_id)
values (50, 34);
insert into ORDER_DRIVER (order_id, user_id)
values (40, 369);
insert into ORDER_DRIVER (order_id, user_id)
values (188, 10);
insert into ORDER_DRIVER (order_id, user_id)
values (79, 75);
insert into ORDER_DRIVER (order_id, user_id)
values (14, 337);
insert into ORDER_DRIVER (order_id, user_id)
values (174, 380);
insert into ORDER_DRIVER (order_id, user_id)
values (154, 380);
insert into ORDER_DRIVER (order_id, user_id)
values (207, 359);
insert into ORDER_DRIVER (order_id, user_id)
values (72, 44);
insert into ORDER_DRIVER (order_id, user_id)
values (107, 448);
insert into ORDER_DRIVER (order_id, user_id)
values (76, 71);
insert into ORDER_DRIVER (order_id, user_id)
values (94, 417);
insert into ORDER_DRIVER (order_id, user_id)
values (2, 3);
insert into ORDER_DRIVER (order_id, user_id)
values (3, 4);
insert into ORDER_DRIVER (order_id, user_id)
values (53, 480);
insert into ORDER_DRIVER (order_id, user_id)
values (33, 480);
insert into ORDER_DRIVER (order_id, user_id)
values (1005, 480);
insert into ORDER_DRIVER (order_id, user_id)
values (1007, 480);
insert into ORDER_DRIVER (order_id, user_id)
values (1010, 480);
insert into ORDER_DRIVER (order_id, user_id)
values (1014, 1057);
insert into ORDER_DRIVER (order_id, user_id)
values (1, 2);
insert into ORDER_DRIVER (order_id, user_id)
values (1005, 2);
commit;
prompt 292 records loaded
prompt Loading SEQUENCES...
insert into SEQUENCES (seq_name, seq_value)
values ('users_seq', 1063);
insert into SEQUENCES (seq_name, seq_value)
values ('trucks_seq', 1035);
insert into SEQUENCES (seq_name, seq_value)
values ('waypoints_seq', 1046);
insert into SEQUENCES (seq_name, seq_value)
values ('orders_seq', 1015);
insert into SEQUENCES (seq_name, seq_value)
values ('map_seq', 1000);
insert into SEQUENCES (seq_name, seq_value)
values ('cargo_seq', 1027);
commit;
prompt 6 records loaded
prompt Loading WAYPOINTS...
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (1014, 1005, 1, 1011, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (1015, 1005, 5, 1011, 2);
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
values (1005, 1003, 3, 1006, 2);
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
values (1002, 1003, 1, 1005, 1);
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
values (1003, 1003, 2, 1005, 2);
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
values (1004, 1003, 2, 1006, 1);
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
commit;
prompt 100 records committed...
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (198, 66, 9, 22, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (199, 189, 7, 172, 2);
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
values (1008, 1004, 1, 1008, 1);
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
values (1009, 1004, 2, 1008, 2);
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
values (1012, 1004, 1, 1010, 1);
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
values (1013, 1004, 4, 1010, 2);
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
commit;
prompt 200 records committed...
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (298, 46, 4, 160, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (299, 181, 2, 86, 1);
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
values (1016, 1006, 1, 1012, 1);
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
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (1017, 1006, 2, 1012, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (1018, 1006, 2, 1013, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (1019, 1006, 3, 1013, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (1028, 1010, 1, 1018, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (1029, 1010, 2, 1018, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (1034, 1011, 2, 1021, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (1035, 1011, 3, 1021, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (1006, 1003, 1, 1007, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (1007, 1003, 3, 1007, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (1010, 1004, 2, 1009, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (1011, 1004, 4, 1009, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (1045, 1014, 6, 1026, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (1042, 1014, 2, 1025, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (1043, 1014, 6, 1025, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (1044, 1014, 2, 1026, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (1026, 1009, 1, 1017, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (1027, 1009, 2, 1017, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (1030, 1010, 1, 1019, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (1031, 1010, 1, 1019, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (1020, 1006, 1, 1014, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (1021, 1006, 3, 1014, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (1022, 1007, 1, 1015, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (1023, 1007, 1, 1015, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (1024, 1008, 1, 1016, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (1025, 1008, 2, 1016, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (1032, 1011, 1, 1020, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (1033, 1011, 2, 1020, 2);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (1036, 1011, 1, 1022, 1);
insert into WAYPOINTS (waypoint_id, order_id, city_id, cargo_id, cargo_type_id)
values (1037, 1011, 3, 1022, 2);
commit;
prompt 281 records loaded
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
