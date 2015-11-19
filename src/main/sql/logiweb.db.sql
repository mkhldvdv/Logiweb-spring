------------------------------------------------
-- Export file for user LOGIWEB               --
-- Created by mkhldvdv on 18.11.2015, 0:52:51 --
------------------------------------------------

spool logiweb.db.new.log

prompt
prompt Creating table CARGO_STATUSES
prompt =============================
prompt
create table logiweb.CARGO_STATUSES
(
  cargo_status_id   NUMBER not null,
  cargo_status_name VARCHAR2(30) not null
)
;
alter table logiweb.CARGO_STATUSES
  add constraint CARGO_STATUS_PK primary key (CARGO_STATUS_ID);

prompt
prompt Creating table CARGOS
prompt =====================
prompt
create table logiweb.CARGOS
(
  cargo_id        NUMBER not null,
  cargo_name      VARCHAR2(50) not null,
  weight          NUMBER not null,
  cargo_status_id NUMBER not null
)
;
alter table logiweb.CARGOS
  add constraint CARGO_PK primary key (CARGO_ID);
alter table logiweb.CARGOS
  add constraint CARGO_STATUS_FK foreign key (CARGO_STATUS_ID)
  references logiweb.CARGO_STATUSES (CARGO_STATUS_ID);
create index logiweb.CARGO_STATUS_IDX on logiweb.CARGOS (CARGO_STATUS_ID);

prompt
prompt Creating table CARGO_TYPES
prompt ==========================
prompt
create table logiweb.CARGO_TYPES
(
  cargo_type_id   NUMBER not null,
  cargo_type_name VARCHAR2(30) not null
)
;
alter table logiweb.CARGO_TYPES
  add constraint CARGO_TYPE_PK primary key (CARGO_TYPE_ID);

prompt
prompt Creating table CITIES
prompt =====================
prompt
create table logiweb.CITIES
(
  city_id   NUMBER not null,
  city_name VARCHAR2(50) not null
)
;
alter table logiweb.CITIES
  add constraint CITY_PK primary key (CITY_ID);

prompt
prompt Creating table DRIVER_STATUSES
prompt ==============================
prompt
create table logiweb.DRIVER_STATUSES
(
  driver_status_id   NUMBER not null,
  driver_status_name VARCHAR2(30) not null
)
;
alter table logiweb.DRIVER_STATUSES
  add constraint DRIVER_STATUS_PK primary key (DRIVER_STATUS_ID);

prompt
prompt Creating table TRUCK_STATUSES
prompt =============================
prompt
create table logiweb.TRUCK_STATUSES
(
  truck_status_id   NUMBER not null,
  truck_status_name VARCHAR2(30)
)
;
alter table logiweb.TRUCK_STATUSES
  add constraint TRUCK_STATUS_PK primary key (TRUCK_STATUS_ID);

prompt
prompt Creating table TRUCKS
prompt =====================
prompt
create table logiweb.TRUCKS
(
  truck_id        NUMBER not null,
  reg_num         VARCHAR2(7) not null,
  driver_count    NUMBER not null,
  capacity        NUMBER not null,
  truck_status_id NUMBER not null,
  city_id         NUMBER not null
)
;
alter table logiweb.TRUCKS
  add constraint TRUCK_PK primary key (TRUCK_ID);
alter table logiweb.TRUCKS
  add constraint REG_NUM_UK unique (REG_NUM);
alter table logiweb.TRUCKS
  add constraint TRUCK_CITY_FK foreign key (CITY_ID)
  references logiweb.CITIES (CITY_ID);
alter table logiweb.TRUCKS
  add constraint TRUCK_STATUS_FK foreign key (TRUCK_STATUS_ID)
  references logiweb.TRUCK_STATUSES (TRUCK_STATUS_ID);
create index logiweb.TRUCK_CITY_IDX on logiweb.TRUCKS (CITY_ID);
create index logiweb.TRUCK_STATUS_IDX on logiweb.TRUCKS (TRUCK_STATUS_ID);

prompt
prompt Creating table ROLES
prompt ====================
prompt
create table logiweb.ROLES
(
  role_id   NUMBER not null,
  role_name VARCHAR2(30) not null
)
;
alter table logiweb.ROLES
  add constraint ROLE_PK primary key (ROLE_ID);

prompt
prompt Creating table USERS
prompt ====================
prompt
create table logiweb.USERS
(
  user_id    NUMBER not null,
  first_name VARCHAR2(50) not null,
  last_name  VARCHAR2(50) not null,
  role_id    NUMBER not null,
  password   VARCHAR2(64) not null
)
;
alter table logiweb.USERS
  add constraint USER_PK primary key (USER_ID);
alter table logiweb.USERS
  add constraint USER_ROLE_FK foreign key (ROLE_ID)
  references logiweb.ROLES (ROLE_ID);
create index logiweb.USER_ROLE_IDX on logiweb.USERS (ROLE_ID);

prompt
prompt Creating table DRIVERS
prompt ======================
prompt
create table logiweb.DRIVERS
(
  driver_id        NUMBER not null,
  hours            NUMBER not null,
  driver_status_id NUMBER not null,
  city_id          NUMBER not null,
  truck_id         NUMBER not null,
  user_id          NUMBER not null
)
;
alter table logiweb.DRIVERS
  add constraint DRIVER_PK primary key (DRIVER_ID);
alter table logiweb.DRIVERS
  add constraint DRIVER_USER_UK unique (USER_ID);
alter table logiweb.DRIVERS
  add constraint DRIVER_CITY_FK foreign key (CITY_ID)
  references logiweb.CITIES (CITY_ID);
alter table logiweb.DRIVERS
  add constraint DRIVER_STATUS_FK foreign key (DRIVER_STATUS_ID)
  references logiweb.DRIVER_STATUSES (DRIVER_STATUS_ID);
alter table logiweb.DRIVERS
  add constraint DRIVER_TRUCK_FK foreign key (TRUCK_ID)
  references logiweb.TRUCKS (TRUCK_ID);
alter table logiweb.DRIVERS
  add constraint DRIVER_USER_FK foreign key (USER_ID)
  references logiweb.USERS (USER_ID);
create index logiweb.DRIVER_CITY_IDX on logiweb.DRIVERS (CITY_ID);
create index logiweb.DRIVER_STATUS_IDX on logiweb.DRIVERS (DRIVER_STATUS_ID);
create index logiweb.DRIVER_TRUCK_IDX on logiweb.DRIVERS (TRUCK_ID);

prompt
prompt Creating table MAP
prompt ==================
prompt
create table logiweb.MAP
(
  map_id   NUMBER not null,
  city_id1 NUMBER not null,
  city_id2 NUMBER not null,
  distance NUMBER not null
)
;
alter table logiweb.MAP
  add constraint MAP_PK primary key (MAP_ID);
alter table logiweb.MAP
  add constraint MAP_CITY1_CITY2_UK unique (CITY_ID1, CITY_ID2);
alter table logiweb.MAP
  add constraint MAP_CITY_ID1_FK foreign key (CITY_ID1)
  references logiweb.CITIES (CITY_ID);
alter table logiweb.MAP
  add constraint MAP_CITY_ID2_FK foreign key (CITY_ID2)
  references logiweb.CITIES (CITY_ID);
create index logiweb.MAP_CITY1_IDX on logiweb.MAP (CITY_ID1);
create index logiweb.MAP_CITY2_IDX on logiweb.MAP (CITY_ID2);

prompt
prompt Creating table ORDER_STATUSES
prompt =============================
prompt
create table logiweb.ORDER_STATUSES
(
  order_status_id   NUMBER not null,
  order_status_name VARCHAR2(30) not null
)
;
alter table logiweb.ORDER_STATUSES
  add constraint ORDER_STATUS_PK primary key (ORDER_STATUS_ID);

prompt
prompt Creating table ORDERS
prompt =====================
prompt
create table logiweb.ORDERS
(
  order_id        NUMBER not null,
  order_status_id NUMBER not null,
  truck_id        NUMBER not null
)
;
alter table logiweb.ORDERS
  add constraint ORDER_PK primary key (ORDER_ID);
alter table logiweb.ORDERS
  add constraint ORDER_STATUS_FK foreign key (ORDER_STATUS_ID)
  references logiweb.ORDER_STATUSES (ORDER_STATUS_ID);
alter table logiweb.ORDERS
  add constraint ORDER_TRUCK_FK foreign key (TRUCK_ID)
  references logiweb.TRUCKS (TRUCK_ID);
create index logiweb.ORDER_STATUS_IDX on logiweb.ORDERS (ORDER_STATUS_ID);
create index logiweb.ORDER_TRUCK_IDX on logiweb.ORDERS (TRUCK_ID);

prompt
prompt Creating table ORDER_DRIVER
prompt ===========================
prompt
create table logiweb.ORDER_DRIVER
(
  order_driver_id NUMBER not null,
  order_id        NUMBER not null,
  driver_id       NUMBER not null
)
;
alter table logiweb.ORDER_DRIVER
  add constraint ORDER_DRIVER_PK primary key (ORDER_DRIVER_ID);
alter table logiweb.ORDER_DRIVER
  add constraint ORDER_DRIVER_FK foreign key (DRIVER_ID)
  references logiweb.DRIVERS (DRIVER_ID);
alter table logiweb.ORDER_DRIVER
  add constraint ORDER_ID_FK foreign key (ORDER_ID)
  references logiweb.ORDERS (ORDER_ID);
create index logiweb.ORDER_DRIVER_IDX on logiweb.ORDER_DRIVER (DRIVER_ID);
create index logiweb.ORDER_IDX on logiweb.ORDER_DRIVER (ORDER_ID);

prompt
prompt Creating table SEQUENCES
prompt ========================
prompt
create table logiweb.SEQUENCES
(
  seq_name  VARCHAR2(30) not null,
  seq_value NUMBER
)
;
alter table logiweb.SEQUENCES
  add constraint SEQ_PK primary key (SEQ_NAME);

prompt
prompt Creating table WAYPOINTS
prompt ========================
prompt
create table logiweb.WAYPOINTS
(
  waypoint_id   NUMBER not null,
  order_id      NUMBER not null,
  city_id       NUMBER not null,
  cargo_id      NUMBER not null,
  cargo_type_id NUMBER not null
)
;
alter table logiweb.WAYPOINTS
  add constraint WAYPOINT_PK primary key (WAYPOINT_ID);
alter table logiweb.WAYPOINTS
  add constraint WAYPOINT_CARGO_FK foreign key (CARGO_ID)
  references logiweb.CARGOS (CARGO_ID);
alter table logiweb.WAYPOINTS
  add constraint WAYPOINT_CARGO_TYPE_FK foreign key (CARGO_TYPE_ID)
  references logiweb.CARGO_TYPES (CARGO_TYPE_ID);
alter table logiweb.WAYPOINTS
  add constraint WAYPOINT_CITY_FK foreign key (CITY_ID)
  references logiweb.CITIES (CITY_ID);
alter table logiweb.WAYPOINTS
  add constraint WAYPOINT_ORDER_FK foreign key (ORDER_ID)
  references logiweb.ORDERS (ORDER_ID);
create index logiweb.WAYPOINT_CARGO_IDX on logiweb.WAYPOINTS (CARGO_ID);
create index logiweb.WAYPOINT_CARGO_TYPE_IDX on logiweb.WAYPOINTS (CARGO_TYPE_ID);
create index logiweb.WAYPOINT_CITY_IDX on logiweb.WAYPOINTS (CITY_ID);
create index logiweb.WAYPOINT_ORDER_IDX on logiweb.WAYPOINTS (ORDER_ID);


spool off
