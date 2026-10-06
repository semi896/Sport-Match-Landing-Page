--
-- PostgreSQL database dump
--

\restrict s1VgJZS3r9M9b5AAJPKfkudehDvREzRaJtMU6uYcf6CCPTbebpvsEUo8MuZupPt

-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.6

-- Started on 2026-10-06 03:15:20

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 4991 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 228 (class 1259 OID 49273)
-- Name: actividad; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.actividad (
    actividad_id bigint NOT NULL,
    usuario_id bigint CONSTRAINT actividad_organizador_id_not_null NOT NULL,
    deporte_id bigint NOT NULL,
    ubicacion_id bigint NOT NULL,
    nombre character varying(255) NOT NULL,
    descripcion character varying(255),
    fecha_hora timestamp without time zone NOT NULL,
    cupos integer CONSTRAINT actividad_cupo_not_null NOT NULL,
    estado character varying(255) DEFAULT 'Disponible'::character varying NOT NULL
);


ALTER TABLE public.actividad OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 49272)
-- Name: actividad_actividad_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.actividad_actividad_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.actividad_actividad_id_seq OWNER TO postgres;

--
-- TOC entry 4992 (class 0 OID 0)
-- Dependencies: 227
-- Name: actividad_actividad_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.actividad_actividad_id_seq OWNED BY public.actividad.actividad_id;


--
-- TOC entry 231 (class 1259 OID 57405)
-- Name: auditoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auditoria (
    auditoria_id bigint NOT NULL,
    usuario_id bigint NOT NULL,
    accion character varying(255),
    tabla character varying(255),
    registro_id bigint,
    fecha_hora timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    descripcion character varying(255),
    estado character varying(255)
);


ALTER TABLE public.auditoria OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 57404)
-- Name: auditoria_auditoria_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auditoria_auditoria_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.auditoria_auditoria_id_seq OWNER TO postgres;

--
-- TOC entry 4993 (class 0 OID 0)
-- Dependencies: 230
-- Name: auditoria_auditoria_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auditoria_auditoria_id_seq OWNED BY public.auditoria.auditoria_id;


--
-- TOC entry 224 (class 1259 OID 49252)
-- Name: deporte; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.deporte (
    deporte_id bigint NOT NULL,
    nombre character varying(255) NOT NULL,
    descripcion character varying(255)
);


ALTER TABLE public.deporte OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 49251)
-- Name: deporte_deporte_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.deporte_deporte_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.deporte_deporte_id_seq OWNER TO postgres;

--
-- TOC entry 4994 (class 0 OID 0)
-- Dependencies: 223
-- Name: deporte_deporte_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.deporte_deporte_id_seq OWNED BY public.deporte.deporte_id;


--
-- TOC entry 221 (class 1259 OID 49229)
-- Name: jugador; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jugador (
    usuario_id bigint NOT NULL,
    nivel character varying(255),
    fecha_nacimiento date,
    estado character varying(255) DEFAULT 'Activo'::character varying NOT NULL
);


ALTER TABLE public.jugador OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 49240)
-- Name: organizador; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.organizador (
    usuario_id bigint NOT NULL,
    organizacion character varying(255),
    telefono character varying(255),
    estado character varying(255) DEFAULT 'Activo'::character varying NOT NULL
);


ALTER TABLE public.organizador OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 49303)
-- Name: participacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.participacion (
    usuario_id bigint CONSTRAINT participacion_jugador_id_not_null NOT NULL,
    actividad_id bigint NOT NULL,
    fecha_inscripcion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    estado character varying(255) DEFAULT 'En Espera'::character varying NOT NULL
);


ALTER TABLE public.participacion OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 49263)
-- Name: ubicacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ubicacion (
    ubicacion_id bigint NOT NULL,
    direccion character varying(255) NOT NULL,
    ciudad character varying(255) NOT NULL,
    latitud numeric(38,2),
    longitud numeric(38,2)
);


ALTER TABLE public.ubicacion OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 49262)
-- Name: ubicacion_ubicacion_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ubicacion_ubicacion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ubicacion_ubicacion_id_seq OWNER TO postgres;

--
-- TOC entry 4995 (class 0 OID 0)
-- Dependencies: 225
-- Name: ubicacion_ubicacion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ubicacion_ubicacion_id_seq OWNED BY public.ubicacion.ubicacion_id;


--
-- TOC entry 220 (class 1259 OID 49214)
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario (
    usuario_id bigint NOT NULL,
    nombre character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    contrasena character varying(255) NOT NULL,
    fecha_registro timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    estado character varying(255) DEFAULT 'Activo'::character varying NOT NULL
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 49213)
-- Name: usuario_usuario_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuario_usuario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuario_usuario_id_seq OWNER TO postgres;

--
-- TOC entry 4996 (class 0 OID 0)
-- Dependencies: 219
-- Name: usuario_usuario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuario_usuario_id_seq OWNED BY public.usuario.usuario_id;


--
-- TOC entry 4794 (class 2604 OID 65651)
-- Name: actividad actividad_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actividad ALTER COLUMN actividad_id SET DEFAULT nextval('public.actividad_actividad_id_seq'::regclass);


--
-- TOC entry 4798 (class 2604 OID 65608)
-- Name: auditoria auditoria_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auditoria ALTER COLUMN auditoria_id SET DEFAULT nextval('public.auditoria_auditoria_id_seq'::regclass);


--
-- TOC entry 4792 (class 2604 OID 65633)
-- Name: deporte deporte_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deporte ALTER COLUMN deporte_id SET DEFAULT nextval('public.deporte_deporte_id_seq'::regclass);


--
-- TOC entry 4793 (class 2604 OID 65643)
-- Name: ubicacion ubicacion_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ubicacion ALTER COLUMN ubicacion_id SET DEFAULT nextval('public.ubicacion_ubicacion_id_seq'::regclass);


--
-- TOC entry 4787 (class 2604 OID 65597)
-- Name: usuario usuario_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario ALTER COLUMN usuario_id SET DEFAULT nextval('public.usuario_usuario_id_seq'::regclass);


--
-- TOC entry 4982 (class 0 OID 49273)
-- Dependencies: 228
-- Data for Name: actividad; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.actividad VALUES (1, 5, 1, 1, 'Fútbol 7 en Miraflores', 'Pichanga amistosa para nivel intermedio. Traer polo oscuro.', '2026-10-15 19:00:00', 14, 'Disponible');
INSERT INTO public.actividad VALUES (2, 4, 2, 2, 'Básquet en San Miguel', 'Pichanga de fin de semana, categoría libre.', '2026-10-16 16:00:00', 10, 'Disponible');
INSERT INTO public.actividad VALUES (3, 5, 4, 3, 'Dobles de Tenis en San Isidro', 'Buscamos pareja de nivel avanzado para partido de dobles.', '2026-10-18 18:30:00', 4, 'Disponible');
INSERT INTO public.actividad VALUES (7, 4, 1, 1, 'Pichanga Nocturna de Futbol 7', 'Partido amistoso en grass sintetico. Traer camiseta blanca o negra.', '2026-10-18 20:30:00', 14, 'Disponible');


--
-- TOC entry 4985 (class 0 OID 57405)
-- Dependencies: 231
-- Data for Name: auditoria; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4978 (class 0 OID 49252)
-- Dependencies: 224
-- Data for Name: deporte; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.deporte VALUES (1, 'Fútbol 7', 'Partidos en cancha sintética con arcos medianos');
INSERT INTO public.deporte VALUES (2, 'Básquetbol', 'Partidos 5 vs 5 en cancha reglamentaria');
INSERT INTO public.deporte VALUES (3, 'Vóley', 'Voleibol mixto en losa o playa');
INSERT INTO public.deporte VALUES (4, 'Tenis', 'Modalidad singles o dobles en arcilla o cemento');


--
-- TOC entry 4975 (class 0 OID 49229)
-- Dependencies: 221
-- Data for Name: jugador; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.jugador VALUES (1, 'Intermedio', '2000-05-14', 'Activo');
INSERT INTO public.jugador VALUES (2, 'Intermedio', '2001-08-22', 'Activo');
INSERT INTO public.jugador VALUES (3, 'Principiante', '1999-11-03', 'Activo');


--
-- TOC entry 4976 (class 0 OID 49240)
-- Dependencies: 222
-- Data for Name: organizador; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.organizador VALUES (4, 'Organización Deportiva Lima Sur', '987654321', 'Activo');
INSERT INTO public.organizador VALUES (5, 'Pichangas Miraflores FC', '912345678', 'Activo');


--
-- TOC entry 4983 (class 0 OID 49303)
-- Dependencies: 229
-- Data for Name: participacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.participacion VALUES (2, 1, '2026-09-30 11:56:06.05713', 'Confirmado');
INSERT INTO public.participacion VALUES (3, 1, '2026-09-30 11:56:06.05713', 'En Espera');
INSERT INTO public.participacion VALUES (1, 2, '2026-09-30 11:56:06.05713', 'Confirmado');
INSERT INTO public.participacion VALUES (1, 1, '2026-10-06 02:06:55.673352', 'Confirmado');


--
-- TOC entry 4980 (class 0 OID 49263)
-- Dependencies: 226
-- Data for Name: ubicacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ubicacion VALUES (1, 'Complejo Deportivo Miraflores, Av. del Ejército 1300', 'Lima', -12.12, -77.04);
INSERT INTO public.ubicacion VALUES (2, 'Sede UPC San Miguel, Av. La Marina 2810', 'Lima', -12.08, -77.09);
INSERT INTO public.ubicacion VALUES (3, 'Club San Isidro, Av. Pezet 400', 'Lima', -12.10, -77.04);


--
-- TOC entry 4974 (class 0 OID 49214)
-- Dependencies: 220
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.usuario VALUES (1, 'Mateo Rivas', 'mateo.rivas@gmail.com', 'hash_pass_123', '2026-09-30 11:55:34.751374', 'Activo');
INSERT INTO public.usuario VALUES (2, 'Lucía Paredes', 'lucia.paredes@gmail.com', 'hash_pass_456', '2026-09-30 11:55:34.751374', 'Activo');
INSERT INTO public.usuario VALUES (3, 'Diego Quispe', 'diego.quispe@gmail.com', 'hash_pass_789', '2026-09-30 11:55:34.751374', 'Activo');
INSERT INTO public.usuario VALUES (4, 'Valeria Cornejo', 'valeria.cornejo@gmail.com', 'hash_pass_organizador', '2026-09-30 11:55:34.751374', 'Activo');
INSERT INTO public.usuario VALUES (5, 'Marco Rivas', 'marco.rivas@gmail.com', 'hash_pass_club', '2026-09-30 11:55:34.751374', 'Activo');
INSERT INTO public.usuario VALUES (8, 'Carlos Mendoza', 'carlos.mendoza@sportmatch.pe', 'claveSegura123', '2026-10-06 01:48:14.884993', 'Activo');
INSERT INTO public.usuario VALUES (9, 'Valeria Rios', 'valeria.rios@sportmatch.pe', 'valeriaPass456', '2026-10-06 01:49:25.195186', 'Activo');


--
-- TOC entry 4997 (class 0 OID 0)
-- Dependencies: 227
-- Name: actividad_actividad_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.actividad_actividad_id_seq', 7, true);


--
-- TOC entry 4998 (class 0 OID 0)
-- Dependencies: 230
-- Name: auditoria_auditoria_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auditoria_auditoria_id_seq', 1, false);


--
-- TOC entry 4999 (class 0 OID 0)
-- Dependencies: 223
-- Name: deporte_deporte_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.deporte_deporte_id_seq', 4, true);


--
-- TOC entry 5000 (class 0 OID 0)
-- Dependencies: 225
-- Name: ubicacion_ubicacion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ubicacion_ubicacion_id_seq', 3, true);


--
-- TOC entry 5001 (class 0 OID 0)
-- Dependencies: 219
-- Name: usuario_usuario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuario_usuario_id_seq', 9, true);


--
-- TOC entry 4813 (class 2606 OID 65653)
-- Name: actividad actividad_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actividad
    ADD CONSTRAINT actividad_pkey PRIMARY KEY (actividad_id);


--
-- TOC entry 4817 (class 2606 OID 65610)
-- Name: auditoria auditoria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auditoria
    ADD CONSTRAINT auditoria_pkey PRIMARY KEY (auditoria_id);


--
-- TOC entry 4809 (class 2606 OID 65635)
-- Name: deporte deporte_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deporte
    ADD CONSTRAINT deporte_pkey PRIMARY KEY (deporte_id);


--
-- TOC entry 4805 (class 2606 OID 65620)
-- Name: jugador jugador_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jugador
    ADD CONSTRAINT jugador_pkey PRIMARY KEY (usuario_id);


--
-- TOC entry 4807 (class 2606 OID 65627)
-- Name: organizador organizador_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizador
    ADD CONSTRAINT organizador_pkey PRIMARY KEY (usuario_id);


--
-- TOC entry 4815 (class 2606 OID 65665)
-- Name: participacion participacion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participacion
    ADD CONSTRAINT participacion_pkey PRIMARY KEY (usuario_id, actividad_id);


--
-- TOC entry 4811 (class 2606 OID 65645)
-- Name: ubicacion ubicacion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ubicacion
    ADD CONSTRAINT ubicacion_pkey PRIMARY KEY (ubicacion_id);


--
-- TOC entry 4801 (class 2606 OID 65761)
-- Name: usuario usuario_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_email_key UNIQUE (email);


--
-- TOC entry 4803 (class 2606 OID 65599)
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (usuario_id);


--
-- TOC entry 4820 (class 2606 OID 65692)
-- Name: actividad fk_actividad_deporte; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actividad
    ADD CONSTRAINT fk_actividad_deporte FOREIGN KEY (deporte_id) REFERENCES public.deporte(deporte_id) ON DELETE RESTRICT;


--
-- TOC entry 4821 (class 2606 OID 65687)
-- Name: actividad fk_actividad_organizador; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actividad
    ADD CONSTRAINT fk_actividad_organizador FOREIGN KEY (usuario_id) REFERENCES public.organizador(usuario_id) ON DELETE CASCADE;


--
-- TOC entry 4822 (class 2606 OID 65697)
-- Name: actividad fk_actividad_ubicacion; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actividad
    ADD CONSTRAINT fk_actividad_ubicacion FOREIGN KEY (ubicacion_id) REFERENCES public.ubicacion(ubicacion_id) ON DELETE RESTRICT;


--
-- TOC entry 4825 (class 2606 OID 65672)
-- Name: auditoria fk_auditoria_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auditoria
    ADD CONSTRAINT fk_auditoria_usuario FOREIGN KEY (usuario_id) REFERENCES public.usuario(usuario_id) ON DELETE CASCADE;


--
-- TOC entry 4818 (class 2606 OID 65677)
-- Name: jugador fk_jugador_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jugador
    ADD CONSTRAINT fk_jugador_usuario FOREIGN KEY (usuario_id) REFERENCES public.usuario(usuario_id) ON DELETE CASCADE;


--
-- TOC entry 4819 (class 2606 OID 65682)
-- Name: organizador fk_organizador_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizador
    ADD CONSTRAINT fk_organizador_usuario FOREIGN KEY (usuario_id) REFERENCES public.usuario(usuario_id) ON DELETE CASCADE;


--
-- TOC entry 4823 (class 2606 OID 65707)
-- Name: participacion fk_participacion_actividad; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participacion
    ADD CONSTRAINT fk_participacion_actividad FOREIGN KEY (actividad_id) REFERENCES public.actividad(actividad_id) ON DELETE CASCADE;


--
-- TOC entry 4824 (class 2606 OID 65702)
-- Name: participacion fk_participacion_jugador; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participacion
    ADD CONSTRAINT fk_participacion_jugador FOREIGN KEY (usuario_id) REFERENCES public.jugador(usuario_id) ON DELETE CASCADE;


-- Completed on 2026-10-06 03:15:20

--
-- PostgreSQL database dump complete
--

\unrestrict s1VgJZS3r9M9b5AAJPKfkudehDvREzRaJtMU6uYcf6CCPTbebpvsEUo8MuZupPt

