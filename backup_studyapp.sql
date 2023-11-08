--
-- PostgreSQL database dump
--

-- Dumped from database version 14.5
-- Dumped by pg_dump version 14.5

-- Started on 2023-11-07 23:13:00

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
-- TOC entry 218 (class 1259 OID 49235)
-- Name: comments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comments (
    id integer NOT NULL,
    text text NOT NULL,
    topic_id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.comments OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 49234)
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.comments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comments_id_seq OWNER TO postgres;

--
-- TOC entry 3373 (class 0 OID 0)
-- Dependencies: 217
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.comments_id_seq OWNED BY public.comments.id;


--
-- TOC entry 220 (class 1259 OID 49277)
-- Name: shared_topics; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shared_topics (
    id integer NOT NULL,
    user_shared_id integer NOT NULL,
    topic_id integer NOT NULL,
    user_destination_id integer NOT NULL
);


ALTER TABLE public.shared_topics OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 49276)
-- Name: shared_topics_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.shared_topics_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shared_topics_id_seq OWNER TO postgres;

--
-- TOC entry 3374 (class 0 OID 0)
-- Dependencies: 219
-- Name: shared_topics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.shared_topics_id_seq OWNED BY public.shared_topics.id;


--
-- TOC entry 209 (class 1259 OID 49178)
-- Name: themes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.themes (
    id integer NOT NULL,
    create_date timestamp without time zone,
    name character varying,
    description character varying,
    keywords character varying,
    owner_user_id integer
);


ALTER TABLE public.themes OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 49183)
-- Name: themes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.themes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.themes_id_seq OWNER TO postgres;

--
-- TOC entry 3375 (class 0 OID 0)
-- Dependencies: 210
-- Name: themes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.themes_id_seq OWNED BY public.themes.id;


--
-- TOC entry 211 (class 1259 OID 49184)
-- Name: themes_properties; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.themes_properties (
    id integer NOT NULL,
    theme_id integer,
    property_name character varying,
    property_value character varying
);


ALTER TABLE public.themes_properties OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 49189)
-- Name: themes_properties_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.themes_properties_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.themes_properties_id_seq OWNER TO postgres;

--
-- TOC entry 3376 (class 0 OID 0)
-- Dependencies: 212
-- Name: themes_properties_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.themes_properties_id_seq OWNED BY public.themes_properties.id;


--
-- TOC entry 213 (class 1259 OID 49190)
-- Name: topics; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.topics (
    id integer NOT NULL,
    create_date timestamp without time zone,
    name character varying,
    topic_id integer,
    "order" integer,
    priority integer,
    color character varying,
    owner_user_id integer
);


ALTER TABLE public.topics OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 49195)
-- Name: topics_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.topics_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.topics_id_seq OWNER TO postgres;

--
-- TOC entry 3377 (class 0 OID 0)
-- Dependencies: 214
-- Name: topics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.topics_id_seq OWNED BY public.topics.id;


--
-- TOC entry 215 (class 1259 OID 49196)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying,
    last_name character varying,
    avatar character varying,
    email character varying,
    password character varying,
    deleted boolean,
    token character varying
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 49201)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 3378 (class 0 OID 0)
-- Dependencies: 216
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 3193 (class 2604 OID 49238)
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);


--
-- TOC entry 3195 (class 2604 OID 49280)
-- Name: shared_topics id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shared_topics ALTER COLUMN id SET DEFAULT nextval('public.shared_topics_id_seq'::regclass);


--
-- TOC entry 3189 (class 2604 OID 49202)
-- Name: themes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.themes ALTER COLUMN id SET DEFAULT nextval('public.themes_id_seq'::regclass);


--
-- TOC entry 3190 (class 2604 OID 49203)
-- Name: themes_properties id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.themes_properties ALTER COLUMN id SET DEFAULT nextval('public.themes_properties_id_seq'::regclass);


--
-- TOC entry 3191 (class 2604 OID 49204)
-- Name: topics id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.topics ALTER COLUMN id SET DEFAULT nextval('public.topics_id_seq'::regclass);


--
-- TOC entry 3192 (class 2604 OID 49205)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 3365 (class 0 OID 49235)
-- Dependencies: 218
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comments (id, text, topic_id, user_id, created_at) FROM stdin;
1	Este es un comentario de ejemplo	15	2	2023-11-07 10:20:00.123738
2	Este es un comentario de ejemplo	15	2	2023-11-07 10:22:14.417959
3	Este es un comentario de ejemplo	15	2	2023-11-07 10:22:15.392287
4	Este es un comentario de ejemplo	15	2	2023-11-07 10:22:16.034971
5	Este es un comentario de ejemplo	17	2	2023-11-07 15:08:02.011453
6	vsdvsdvsadsad	17	1	2023-11-07 18:41:35.334
7	Probando	17	1	2023-11-07 18:44:26.073
8	comentario de pruebal poisjadpojasodjaspoijdpoasjdiohsancvmdcamsodpmcokmasdopcmaosmdcpkomaspodmpomasdcopmaspokmdcpokmasdc	17	1	2023-11-07 18:47:06.533
9	test	15	1	2023-11-07 22:10:56.37
10	prueba comentario	15	1	2023-11-08 00:36:00.109
\.


--
-- TOC entry 3367 (class 0 OID 49277)
-- Dependencies: 220
-- Data for Name: shared_topics; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shared_topics (id, user_shared_id, topic_id, user_destination_id) FROM stdin;
16	1	15	1
17	1	15	2
18	1	15	13
\.


--
-- TOC entry 3356 (class 0 OID 49178)
-- Dependencies: 209
-- Data for Name: themes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.themes (id, create_date, name, description, keywords, owner_user_id) FROM stdin;
1	2023-05-12 00:00:00	Lenguaje IV	Aprender Java EE	programar, lenguaje	1
2	2023-05-12 00:00:00	Lenguaje V	Aprender Ionic y Node.js	programar, lenguaje, modf	1
5	2023-05-12 00:00:00	Idiomas	Aprender Ingles	ingles, castellano	1
4	2023-05-19 00:00:00	Algoritmica	Logica de Programacion	programar, logica	1
6	2023-05-19 00:00:00	Matematica IV	Aprender a multiplicar	multiplicar, matematica, numeros	1
\.


--
-- TOC entry 3358 (class 0 OID 49184)
-- Dependencies: 211
-- Data for Name: themes_properties; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.themes_properties (id, theme_id, property_name, property_value) FROM stdin;
1	1	unidad1	1
3	1	porcentaje completo	10
5	4	visitado	Falso
\.


--
-- TOC entry 3360 (class 0 OID 49190)
-- Dependencies: 213
-- Data for Name: topics; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.topics (id, create_date, name, topic_id, "order", priority, color, owner_user_id) FROM stdin;
15	2023-05-19 00:00:00	Topico Dos	\N	3	2	Lila	\N
17	2023-11-06 00:00:00	Recursividad	\N	1	10	Azul	\N
\.


--
-- TOC entry 3362 (class 0 OID 49196)
-- Dependencies: 215
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, last_name, avatar, email, password, deleted, token) FROM stdin;
1	Luis	Acosta	\N	gabi@gmail.com	123	f	\N
2	Efra	God	ava	efragod@gmail.com	456	f	\N
13	Adrian	Portillo	\N	adrian@gmail.com	\N	f	\N
\.


--
-- TOC entry 3379 (class 0 OID 0)
-- Dependencies: 217
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comments_id_seq', 10, true);


--
-- TOC entry 3380 (class 0 OID 0)
-- Dependencies: 219
-- Name: shared_topics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shared_topics_id_seq', 18, true);


--
-- TOC entry 3381 (class 0 OID 0)
-- Dependencies: 210
-- Name: themes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.themes_id_seq', 7, true);


--
-- TOC entry 3382 (class 0 OID 0)
-- Dependencies: 212
-- Name: themes_properties_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.themes_properties_id_seq', 6, true);


--
-- TOC entry 3383 (class 0 OID 0)
-- Dependencies: 214
-- Name: topics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.topics_id_seq', 17, true);


--
-- TOC entry 3384 (class 0 OID 0)
-- Dependencies: 216
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 13, true);


--
-- TOC entry 3205 (class 2606 OID 49243)
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- TOC entry 3207 (class 2606 OID 49282)
-- Name: shared_topics shared_topics_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shared_topics
    ADD CONSTRAINT shared_topics_pkey PRIMARY KEY (id);


--
-- TOC entry 3197 (class 2606 OID 49207)
-- Name: themes themes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.themes
    ADD CONSTRAINT themes_pkey PRIMARY KEY (id);


--
-- TOC entry 3199 (class 2606 OID 49209)
-- Name: themes_properties themes_properties_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.themes_properties
    ADD CONSTRAINT themes_properties_pkey PRIMARY KEY (id);


--
-- TOC entry 3201 (class 2606 OID 49211)
-- Name: topics topics_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.topics
    ADD CONSTRAINT topics_pkey PRIMARY KEY (id);


--
-- TOC entry 3203 (class 2606 OID 49213)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3212 (class 2606 OID 49244)
-- Name: comments comments_topic_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_topic_id_fkey FOREIGN KEY (topic_id) REFERENCES public.topics(id);


--
-- TOC entry 3213 (class 2606 OID 49249)
-- Name: comments comments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 3214 (class 2606 OID 49283)
-- Name: shared_topics shared_topics_topic_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shared_topics
    ADD CONSTRAINT shared_topics_topic_id_fkey FOREIGN KEY (topic_id) REFERENCES public.topics(id);


--
-- TOC entry 3216 (class 2606 OID 49293)
-- Name: shared_topics shared_topics_user_destination_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shared_topics
    ADD CONSTRAINT shared_topics_user_destination_id_fkey FOREIGN KEY (user_destination_id) REFERENCES public.users(id);


--
-- TOC entry 3215 (class 2606 OID 49288)
-- Name: shared_topics shared_topics_user_shared_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shared_topics
    ADD CONSTRAINT shared_topics_user_shared_id_fkey FOREIGN KEY (user_shared_id) REFERENCES public.users(id);


--
-- TOC entry 3208 (class 2606 OID 49214)
-- Name: themes themes_owner_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.themes
    ADD CONSTRAINT themes_owner_user_id_fkey FOREIGN KEY (owner_user_id) REFERENCES public.users(id);


--
-- TOC entry 3209 (class 2606 OID 49219)
-- Name: themes_properties themes_properties_theme_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.themes_properties
    ADD CONSTRAINT themes_properties_theme_id_fkey FOREIGN KEY (theme_id) REFERENCES public.themes(id);


--
-- TOC entry 3210 (class 2606 OID 49224)
-- Name: topics topics_owner_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.topics
    ADD CONSTRAINT topics_owner_user_id_fkey FOREIGN KEY (owner_user_id) REFERENCES public.users(id);


--
-- TOC entry 3211 (class 2606 OID 49229)
-- Name: topics topics_topic_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.topics
    ADD CONSTRAINT topics_topic_id_fkey FOREIGN KEY (topic_id) REFERENCES public.topics(id);


-- Completed on 2023-11-07 23:13:00

--
-- PostgreSQL database dump complete
--

