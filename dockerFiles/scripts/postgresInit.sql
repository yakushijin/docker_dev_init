--ユーザ作成※以下は開発版のパスワード。本番の際は相応のものを設定すること。
CREATE ROLE app_user WITH LOGIN PASSWORD 'userPassword1!';
CREATE ROLE admin_user WITH LOGIN PASSWORD 'adminPassword1!';

--データベース作成
CREATE DATABASE pjdb
    WITH 
    OWNER = admin_user
    ENCODING = 'UTF8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

--接続切り替え    
\c pjdb
\connect - admin_user

--スキーマ作成
CREATE SCHEMA S_Main AUTHORIZATION admin_user;

--接続切り替え  
set search_path to S_Main;

--権限付与
GRANT USAGE ON SCHEMA S_Main TO app_user;
GRANT SELECT,INSERT,UPDATE,DELETE ON ALL TABLES IN SCHEMA S_Main TO app_user;
GRANT ALL ON ALL SEQUENCES IN SCHEMA S_Main TO app_user; 
