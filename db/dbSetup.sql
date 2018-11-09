--
-- PostgreSQL database dump
--

-- Dumped from database version 10.5
-- Dumped by pg_dump version 10.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: category; Type: TABLE; Schema: public; Owner: postgres
--

DROP TABLE IF EXISTS public.user_record, public.item, public.dashboard, public.category, public.gator_message;

CREATE TABLE public.category (
    category_id integer NOT NULL,
    category_name text NOT NULL
);


ALTER TABLE public.category OWNER TO postgres;

--
-- Name: category_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.category_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.category_category_id_seq OWNER TO postgres;

--
-- Name: category_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.category_category_id_seq OWNED BY public.category.category_id;


--
-- Name: dashboard; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dashboard (
    dashboard_id integer NOT NULL,
    user_id integer NOT NULL,
    message_id integer NOT NULL,
    item_id integer NOT NULL
);


ALTER TABLE public.dashboard OWNER TO postgres;

--
-- Name: dashboard_dashboard_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dashboard_dashboard_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dashboard_dashboard_id_seq OWNER TO postgres;

--
-- Name: dashboard_dashboard_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dashboard_dashboard_id_seq OWNED BY public.dashboard.dashboard_id;


--
-- Name: dashboard_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dashboard_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dashboard_item_id_seq OWNER TO postgres;

--
-- Name: dashboard_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dashboard_item_id_seq OWNED BY public.dashboard.item_id;


--
-- Name: dashboard_message_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dashboard_message_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dashboard_message_id_seq OWNER TO postgres;

--
-- Name: dashboard_message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dashboard_message_id_seq OWNED BY public.dashboard.message_id;


--
-- Name: dashboard_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dashboard_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dashboard_user_id_seq OWNER TO postgres;

--
-- Name: dashboard_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dashboard_user_id_seq OWNED BY public.dashboard.user_id;


--
-- Name: gator_message; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gator_message (
    message_id integer NOT NULL,
    message_text text NOT NULL,
    message_date timestamp(6) with time zone DEFAULT now(),
    user_id integer NOT NULL,
    item_id integer NOT NULL
);


ALTER TABLE public.gator_message OWNER TO postgres;

--
-- Name: gator_message_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.gator_message_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gator_message_item_id_seq OWNER TO postgres;

--
-- Name: gator_message_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.gator_message_item_id_seq OWNED BY public.gator_message.item_id;


--
-- Name: gator_message_message_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.gator_message_message_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gator_message_message_id_seq OWNER TO postgres;

--
-- Name: gator_message_message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.gator_message_message_id_seq OWNED BY public.gator_message.message_id;


--
-- Name: gator_message_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.gator_message_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gator_message_user_id_seq OWNER TO postgres;

--
-- Name: gator_message_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.gator_message_user_id_seq OWNED BY public.gator_message.user_id;


--
-- Name: item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.item (
    item_id integer NOT NULL,
    item_title text NOT NULL,
    item_description text NOT NULL,
    item_price money NOT NULL,
    item_status text NOT NULL,
    user_id integer NOT NULL,
    category_id integer NOT NULL,
    item_image text NOT NULL,
    item_availability boolean NOT NULL,
    item_image_thumbnail text NOT NULL,
    item_date timestamp(6) with time zone DEFAULT now()
);


ALTER TABLE public.item OWNER TO postgres;

--
-- Name: item_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.item_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.item_category_id_seq OWNER TO postgres;

--
-- Name: item_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.item_category_id_seq OWNED BY public.item.category_id;


--
-- Name: item_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.item_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.item_item_id_seq OWNER TO postgres;

--
-- Name: item_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.item_item_id_seq OWNED BY public.item.item_id;


--
-- Name: item_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.item_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.item_user_id_seq OWNER TO postgres;

--
-- Name: item_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.item_user_id_seq OWNED BY public.item.user_id;


--
-- Name: user_record; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_record (
    user_id integer NOT NULL,
    user_name text NOT NULL,
    user_password text NOT NULL,
    user_email text NOT NULL,
    admin_right boolean NOT NULL,
    user_date timestamp(6) with time zone DEFAULT now()
);


ALTER TABLE public.user_record OWNER TO postgres;

--
-- Name: user_record_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_record_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_record_user_id_seq OWNER TO postgres;

--
-- Name: user_record_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_record_user_id_seq OWNED BY public.user_record.user_id;


--
-- Name: category category_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category ALTER COLUMN category_id SET DEFAULT nextval('public.category_category_id_seq'::regclass);


--
-- Name: dashboard dashboard_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard ALTER COLUMN dashboard_id SET DEFAULT nextval('public.dashboard_dashboard_id_seq'::regclass);


--
-- Name: dashboard user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard ALTER COLUMN user_id SET DEFAULT nextval('public.dashboard_user_id_seq'::regclass);


--
-- Name: dashboard message_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard ALTER COLUMN message_id SET DEFAULT nextval('public.dashboard_message_id_seq'::regclass);


--
-- Name: dashboard item_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard ALTER COLUMN item_id SET DEFAULT nextval('public.dashboard_item_id_seq'::regclass);


--
-- Name: gator_message message_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gator_message ALTER COLUMN message_id SET DEFAULT nextval('public.gator_message_message_id_seq'::regclass);


--
-- Name: gator_message user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gator_message ALTER COLUMN user_id SET DEFAULT nextval('public.gator_message_user_id_seq'::regclass);


--
-- Name: gator_message item_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gator_message ALTER COLUMN item_id SET DEFAULT nextval('public.gator_message_item_id_seq'::regclass);


--
-- Name: item item_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item ALTER COLUMN item_id SET DEFAULT nextval('public.item_item_id_seq'::regclass);


--
-- Name: item user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item ALTER COLUMN user_id SET DEFAULT nextval('public.item_user_id_seq'::regclass);


--
-- Name: item category_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item ALTER COLUMN category_id SET DEFAULT nextval('public.item_category_id_seq'::regclass);


--
-- Name: user_record user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_record ALTER COLUMN user_id SET DEFAULT nextval('public.user_record_user_id_seq'::regclass);


--
-- Name: category category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (category_id);


--
-- Name: dashboard dashboard_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard
    ADD CONSTRAINT dashboard_pkey PRIMARY KEY (dashboard_id);


--
-- Name: gator_message gator_message_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gator_message
    ADD CONSTRAINT gator_message_pkey PRIMARY KEY (message_id);


--
-- Name: item item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item
    ADD CONSTRAINT item_pkey PRIMARY KEY (item_id);


--
-- Name: user_record user_record_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_record
    ADD CONSTRAINT user_record_pkey PRIMARY KEY (user_id);


--
-- Name: user_record user_record_user_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_record
    ADD CONSTRAINT user_record_user_email_key UNIQUE (user_email);


--
-- Name: item fk_category; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item
    ADD CONSTRAINT fk_category FOREIGN KEY (category_id) REFERENCES public.category(category_id);


--
-- Name: dashboard fk_gator_message; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard
    ADD CONSTRAINT fk_gator_message FOREIGN KEY (message_id) REFERENCES public.gator_message(message_id);


--
-- Name: gator_message fk_item; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gator_message
    ADD CONSTRAINT fk_item FOREIGN KEY (item_id) REFERENCES public.item(item_id);


--
-- Name: dashboard fk_item; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard
    ADD CONSTRAINT fk_item FOREIGN KEY (item_id) REFERENCES public.item(item_id);


--
-- Name: item fk_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item
    ADD CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES public.user_record(user_id);


--
-- Name: gator_message fk_user_record; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gator_message
    ADD CONSTRAINT fk_user_record FOREIGN KEY (user_id) REFERENCES public.user_record(user_id);


--
-- Name: dashboard fk_user_record; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard
    ADD CONSTRAINT fk_user_record FOREIGN KEY (user_id) REFERENCES public.user_record(user_id);


--
-- PostgreSQL database dump complete
--

