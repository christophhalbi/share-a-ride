
begin;

create table if not exists drivers(
    id serial not null primary key,
    name varchar not null
);

create table if not exists rides(
    id serial not null primary key,
    driver_id integer not null references drivers(id) on delete cascade,
    start_from varchar not null,
    start_dt timestamp not null,
    go_to varchar not null,
    seats numeric not null
);

insert into drivers(id, name) values (1, 'test') on conflict do nothing;

commit;
