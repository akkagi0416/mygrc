CREATE TABLE sites(
  id    integer primary key autoincrement,
  url   text unique,
  title text,
  created_at  text,
  updated_at  text
);

CREATE TABLE keywords(
  id    integer primary key autoincrement,
  word  text unique,
  created_at  text,
  updated_at  text
);

CREATE TABLE site_keywords(
  id          integer primary key autoincrement,
  site_id     integer,
  keyword_id  integer,
  created_at  text,
  updated_at  text
);

CREATE TABLE rankings(
  id          integer primary key autoincrement,
  keyword_id  integer,
  rank        integer,
  url         text,
  created_at  text,
  updated_at  text
);

CREATE TABLE results(
  id          integer primary key autoincrement,
  site_id     integer,
  keyword_id  integer,
  rank        integer,
  created_at  text,
  updated_at  text
);
