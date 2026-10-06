--
-- PostgreSQL database dump
--

\restrict mZ8NK4Bd8IvdqQ79Z0idP9KQy8neVknH2TqD0rQzy8IdkWxxz8teqp18Np86tFZ

-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.6

-- Started on 2026-10-06 02:43:13

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
-- TOC entry 4965 (class 0 OID 49252)
-- Dependencies: 224
-- Data for Name: deporte; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.deporte VALUES (1, 'Fútbol 7', 'Partidos en cancha sintética con arcos medianos');
INSERT INTO public.deporte VALUES (2, 'Básquetbol', 'Partidos 5 vs 5 en cancha reglamentaria');
INSERT INTO public.deporte VALUES (3, 'Vóley', 'Voleibol mixto en losa o playa');
INSERT INTO public.deporte VALUES (4, 'Tenis', 'Modalidad singles o dobles en arcilla o cemento');


--
-- TOC entry 4961 (class 0 OID 49214)
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
-- TOC entry 4963 (class 0 OID 49240)
-- Dependencies: 222
-- Data for Name: organizador; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.organizador VALUES (4, 'Organización Deportiva Lima Sur', '987654321', 'Activo');
INSERT INTO public.organizador VALUES (5, 'Pichangas Miraflores FC', '912345678', 'Activo');


--
-- TOC entry 4967 (class 0 OID 49263)
-- Dependencies: 226
-- Data for Name: ubicacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ubicacion VALUES (1, 'Complejo Deportivo Miraflores, Av. del Ejército 1300', 'Lima', -12.12, -77.04);
INSERT INTO public.ubicacion VALUES (2, 'Sede UPC San Miguel, Av. La Marina 2810', 'Lima', -12.08, -77.09);
INSERT INTO public.ubicacion VALUES (3, 'Club San Isidro, Av. Pezet 400', 'Lima', -12.10, -77.04);


--
-- TOC entry 4969 (class 0 OID 49273)
-- Dependencies: 228
-- Data for Name: actividad; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.actividad VALUES (1, 5, 1, 1, 'Fútbol 7 en Miraflores', 'Pichanga amistosa para nivel intermedio. Traer polo oscuro.', '2026-10-15 19:00:00', 14, 'Disponible');
INSERT INTO public.actividad VALUES (2, 4, 2, 2, 'Básquet en San Miguel', 'Pichanga de fin de semana, categoría libre.', '2026-10-16 16:00:00', 10, 'Disponible');
INSERT INTO public.actividad VALUES (3, 5, 4, 3, 'Dobles de Tenis en San Isidro', 'Buscamos pareja de nivel avanzado para partido de dobles.', '2026-10-18 18:30:00', 4, 'Disponible');
INSERT INTO public.actividad VALUES (7, 4, 1, 1, 'Pichanga Nocturna de Futbol 7', 'Partido amistoso en grass sintetico. Traer camiseta blanca o negra.', '2026-10-18 20:30:00', 14, 'Disponible');


--
-- TOC entry 4972 (class 0 OID 57405)
-- Dependencies: 231
-- Data for Name: auditoria; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4962 (class 0 OID 49229)
-- Dependencies: 221
-- Data for Name: jugador; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.jugador VALUES (1, 'Intermedio', '2000-05-14', 'Activo');
INSERT INTO public.jugador VALUES (2, 'Intermedio', '2001-08-22', 'Activo');
INSERT INTO public.jugador VALUES (3, 'Principiante', '1999-11-03', 'Activo');


--
-- TOC entry 4970 (class 0 OID 49303)
-- Dependencies: 229
-- Data for Name: participacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.participacion VALUES (2, 1, '2026-09-30 11:56:06.05713', 'Confirmado');
INSERT INTO public.participacion VALUES (3, 1, '2026-09-30 11:56:06.05713', 'En Espera');
INSERT INTO public.participacion VALUES (1, 2, '2026-09-30 11:56:06.05713', 'Confirmado');
INSERT INTO public.participacion VALUES (1, 1, '2026-10-06 02:06:55.673352', 'Confirmado');


--
-- TOC entry 4978 (class 0 OID 0)
-- Dependencies: 227
-- Name: actividad_actividad_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.actividad_actividad_id_seq', 7, true);


--
-- TOC entry 4979 (class 0 OID 0)
-- Dependencies: 230
-- Name: auditoria_auditoria_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auditoria_auditoria_id_seq', 1, false);


--
-- TOC entry 4980 (class 0 OID 0)
-- Dependencies: 223
-- Name: deporte_deporte_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.deporte_deporte_id_seq', 4, true);


--
-- TOC entry 4981 (class 0 OID 0)
-- Dependencies: 225
-- Name: ubicacion_ubicacion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ubicacion_ubicacion_id_seq', 3, true);


--
-- TOC entry 4982 (class 0 OID 0)
-- Dependencies: 219
-- Name: usuario_usuario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuario_usuario_id_seq', 9, true);


-- Completed on 2026-10-06 02:43:14

--
-- PostgreSQL database dump complete
--

\unrestrict mZ8NK4Bd8IvdqQ79Z0idP9KQy8neVknH2TqD0rQzy8IdkWxxz8teqp18Np86tFZ

