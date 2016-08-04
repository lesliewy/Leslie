--mymovie project

-- movie ?
create table movie(
  id number,
  name varchar2(60) not null, 
  director varchar2(20),
  corp varchar2(30),
  constraint pk_movie primary key(id) 
);

-- movie image ?, ????
create table image(
  id number,
  image Blob,
  constraint image_fk foreign key (id) references movie (id) on delete cascade
);

select * from movie;
insert into movie(id,name,director,corp) values(1,'Ashes of Time','Wang Jiawei','ZeDong');

truncate table movie;
drop table movie;

grant create sequence to leslie1;
create sequence seq1 increment by 1 start with 1 maxvalue 9999999999 nocycle nocache;

select seq1.nextval from dual;
select seq1.currval from dual;

select * from image;
insert into image (id,image) values (4,Empty_BLOB());


  











