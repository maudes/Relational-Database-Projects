--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: game; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.game (
    game_id integer NOT NULL,
    guess_num integer,
    user_id integer
);


ALTER TABLE public.game OWNER TO freecodecamp;

--
-- Name: game_game_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.game_game_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.game_game_id_seq OWNER TO freecodecamp;

--
-- Name: game_game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.game_game_id_seq OWNED BY public.game.game_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(30) NOT NULL
);


ALTER TABLE public.users OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: game game_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.game ALTER COLUMN game_id SET DEFAULT nextval('public.game_game_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: game; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.game VALUES (1, 98, 1);
INSERT INTO public.game VALUES (2, 406, 1);
INSERT INTO public.game VALUES (3, 13, 2);
INSERT INTO public.game VALUES (4, 611, 2);
INSERT INTO public.game VALUES (5, 914, 1);
INSERT INTO public.game VALUES (6, 541, 1);
INSERT INTO public.game VALUES (7, 453, 1);
INSERT INTO public.game VALUES (8, 356, 3);
INSERT INTO public.game VALUES (9, 154, 3);
INSERT INTO public.game VALUES (10, 882, 4);
INSERT INTO public.game VALUES (11, 153, 4);
INSERT INTO public.game VALUES (12, 698, 3);
INSERT INTO public.game VALUES (13, 777, 3);
INSERT INTO public.game VALUES (14, 489, 3);
INSERT INTO public.game VALUES (15, 888, 5);
INSERT INTO public.game VALUES (16, 296, 5);
INSERT INTO public.game VALUES (17, 468, 6);
INSERT INTO public.game VALUES (18, 255, 6);
INSERT INTO public.game VALUES (19, 133, 5);
INSERT INTO public.game VALUES (20, 677, 5);
INSERT INTO public.game VALUES (21, 229, 5);
INSERT INTO public.game VALUES (22, 35, 7);
INSERT INTO public.game VALUES (23, 722, 7);
INSERT INTO public.game VALUES (24, 13, 8);
INSERT INTO public.game VALUES (25, 752, 8);
INSERT INTO public.game VALUES (26, 596, 7);
INSERT INTO public.game VALUES (27, 889, 7);
INSERT INTO public.game VALUES (28, 483, 7);
INSERT INTO public.game VALUES (29, 9, 9);
INSERT INTO public.game VALUES (30, 11, 9);
INSERT INTO public.game VALUES (31, 11, 9);
INSERT INTO public.game VALUES (32, 8, 9);
INSERT INTO public.game VALUES (33, 373, 10);
INSERT INTO public.game VALUES (34, 681, 10);
INSERT INTO public.game VALUES (35, 288, 11);
INSERT INTO public.game VALUES (36, 598, 11);
INSERT INTO public.game VALUES (37, 128, 10);
INSERT INTO public.game VALUES (38, 403, 10);
INSERT INTO public.game VALUES (39, 631, 10);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.users VALUES (1, 'user_1749605495980');
INSERT INTO public.users VALUES (2, 'user_1749605495979');
INSERT INTO public.users VALUES (3, 'user_1749605553948');
INSERT INTO public.users VALUES (4, 'user_1749605553947');
INSERT INTO public.users VALUES (5, 'user_1749605563037');
INSERT INTO public.users VALUES (6, 'user_1749605563036');
INSERT INTO public.users VALUES (7, 'user_1749605592882');
INSERT INTO public.users VALUES (8, 'user_1749605592881');
INSERT INTO public.users VALUES (9, 'Maude');
INSERT INTO public.users VALUES (10, 'user_1749606098050');
INSERT INTO public.users VALUES (11, 'user_1749606098049');


--
-- Name: game_game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.game_game_id_seq', 39, true);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.users_user_id_seq', 11, true);


--
-- Name: game game_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_pkey PRIMARY KEY (game_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: game game_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- PostgreSQL database dump complete
--

