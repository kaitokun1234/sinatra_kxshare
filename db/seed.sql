drop table if exists subjects;
drop table if exists profiles;

create table subjects(
    content text NOT NULL,
    created_at datetime NOT NULL DEFAULT (DATETIME('now', 'localtime'))
);

create table profiles(
    addr text NOT NULL,
    'name' text NOT NULL DEFAULT ("名無し"),
    comment text DEFAULT ("no comment"),
    created_at text NOT NULL DEFAULT (DATETIME('now', 'localtime')),
    updated_at text NOT NULL DEFAULT (DATETIME('now', 'localtime'))
);

insert into subjects(content) values("aaa");