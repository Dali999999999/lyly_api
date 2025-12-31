--
-- PostgreSQL database dump
--

\restrict HQ1M8fQrr4CP8NMKqVT1ygZ9oigAzXeP3FbLutNU0Eq8ayuveKCfIjHP6JmmaHK

-- Dumped from database version 17.7
-- Dumped by pg_dump version 18.1

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

ALTER TABLE IF EXISTS ONLY public.reviews_review DROP CONSTRAINT IF EXISTS reviews_review_user_id_875caff2_fk_accounts_user_id;
ALTER TABLE IF EXISTS ONLY public.reviews_review DROP CONSTRAINT IF EXISTS reviews_review_product_id_ce2fa4c6_fk_catalog_product_id;
ALTER TABLE IF EXISTS ONLY public.orders_orderitem DROP CONSTRAINT IF EXISTS orders_orderitem_product_id_afe4254a_fk_catalog_product_id;
ALTER TABLE IF EXISTS ONLY public.orders_orderitem DROP CONSTRAINT IF EXISTS orders_orderitem_order_id_fe61a34d_fk_orders_order_id;
ALTER TABLE IF EXISTS ONLY public.orders_order DROP CONSTRAINT IF EXISTS orders_order_user_id_e9b59eb1_fk_accounts_user_id;
ALTER TABLE IF EXISTS ONLY public.django_admin_log DROP CONSTRAINT IF EXISTS django_admin_log_user_id_c564eba6_fk_accounts_user_id;
ALTER TABLE IF EXISTS ONLY public.django_admin_log DROP CONSTRAINT IF EXISTS django_admin_log_content_type_id_c4bce8eb_fk_django_co;
ALTER TABLE IF EXISTS ONLY public.core_heroimage DROP CONSTRAINT IF EXISTS core_heroimage_settings_id_3a237f1b_fk_core_sitesettings_id;
ALTER TABLE IF EXISTS ONLY public.catalog_productimage DROP CONSTRAINT IF EXISTS catalog_productimage_product_id_1f42dd8c_fk_catalog_product_id;
ALTER TABLE IF EXISTS ONLY public.catalog_product DROP CONSTRAINT IF EXISTS catalog_product_category_id_35bf920b_fk_catalog_category_id;
ALTER TABLE IF EXISTS ONLY public.auth_permission DROP CONSTRAINT IF EXISTS auth_permission_content_type_id_2f476e4b_fk_django_co;
ALTER TABLE IF EXISTS ONLY public.auth_group_permissions DROP CONSTRAINT IF EXISTS auth_group_permissions_group_id_b120cbf9_fk_auth_group_id;
ALTER TABLE IF EXISTS ONLY public.auth_group_permissions DROP CONSTRAINT IF EXISTS auth_group_permissio_permission_id_84c5c92e_fk_auth_perm;
ALTER TABLE IF EXISTS ONLY public.accounts_user_user_permissions DROP CONSTRAINT IF EXISTS accounts_user_user_p_user_id_e4f0a161_fk_accounts_;
ALTER TABLE IF EXISTS ONLY public.accounts_user_user_permissions DROP CONSTRAINT IF EXISTS accounts_user_user_p_permission_id_113bb443_fk_auth_perm;
ALTER TABLE IF EXISTS ONLY public.accounts_user_groups DROP CONSTRAINT IF EXISTS accounts_user_groups_user_id_52b62117_fk_accounts_user_id;
ALTER TABLE IF EXISTS ONLY public.accounts_user_groups DROP CONSTRAINT IF EXISTS accounts_user_groups_group_id_bd11a704_fk_auth_group_id;
DROP INDEX IF EXISTS public.reviews_review_user_id_875caff2;
DROP INDEX IF EXISTS public.reviews_review_product_id_ce2fa4c6;
DROP INDEX IF EXISTS public.orders_orderitem_product_id_afe4254a;
DROP INDEX IF EXISTS public.orders_orderitem_order_id_fe61a34d;
DROP INDEX IF EXISTS public.orders_order_user_id_e9b59eb1;
DROP INDEX IF EXISTS public.orders_order_status_445594e5_like;
DROP INDEX IF EXISTS public.orders_order_status_445594e5;
DROP INDEX IF EXISTS public.orders_order_created_at_20b8d253;
DROP INDEX IF EXISTS public.django_session_session_key_c0390e0f_like;
DROP INDEX IF EXISTS public.django_session_expire_date_a5c62663;
DROP INDEX IF EXISTS public.django_admin_log_user_id_c564eba6;
DROP INDEX IF EXISTS public.django_admin_log_content_type_id_c4bce8eb;
DROP INDEX IF EXISTS public.coupons_coupon_code_40174643_like;
DROP INDEX IF EXISTS public.core_heroimage_settings_id_3a237f1b;
DROP INDEX IF EXISTS public.catalog_productimage_product_id_1f42dd8c;
DROP INDEX IF EXISTS public.catalog_product_slug_f37848b0_like;
DROP INDEX IF EXISTS public.catalog_product_price_1347cb30;
DROP INDEX IF EXISTS public.catalog_product_is_new_b0bab2b8;
DROP INDEX IF EXISTS public.catalog_product_is_featured_4286e684;
DROP INDEX IF EXISTS public.catalog_product_created_at_ea90ae72;
DROP INDEX IF EXISTS public.catalog_product_category_id_35bf920b;
DROP INDEX IF EXISTS public.catalog_category_slug_dbf63ad0_like;
DROP INDEX IF EXISTS public.auth_permission_content_type_id_2f476e4b;
DROP INDEX IF EXISTS public.auth_group_permissions_permission_id_84c5c92e;
DROP INDEX IF EXISTS public.auth_group_permissions_group_id_b120cbf9;
DROP INDEX IF EXISTS public.auth_group_name_a6ea08ec_like;
DROP INDEX IF EXISTS public.accounts_user_user_permissions_user_id_e4f0a161;
DROP INDEX IF EXISTS public.accounts_user_user_permissions_permission_id_113bb443;
DROP INDEX IF EXISTS public.accounts_user_groups_user_id_52b62117;
DROP INDEX IF EXISTS public.accounts_user_groups_group_id_bd11a704;
DROP INDEX IF EXISTS public.accounts_user_email_b2644a56_like;
ALTER TABLE IF EXISTS ONLY public.shipping_deliveryzone DROP CONSTRAINT IF EXISTS shipping_deliveryzone_pkey;
ALTER TABLE IF EXISTS ONLY public.reviews_review DROP CONSTRAINT IF EXISTS reviews_review_product_id_user_id_96befe71_uniq;
ALTER TABLE IF EXISTS ONLY public.reviews_review DROP CONSTRAINT IF EXISTS reviews_review_pkey;
ALTER TABLE IF EXISTS ONLY public.orders_orderitem DROP CONSTRAINT IF EXISTS orders_orderitem_pkey;
ALTER TABLE IF EXISTS ONLY public.orders_order DROP CONSTRAINT IF EXISTS orders_order_pkey;
ALTER TABLE IF EXISTS ONLY public.django_session DROP CONSTRAINT IF EXISTS django_session_pkey;
ALTER TABLE IF EXISTS ONLY public.django_migrations DROP CONSTRAINT IF EXISTS django_migrations_pkey;
ALTER TABLE IF EXISTS ONLY public.django_content_type DROP CONSTRAINT IF EXISTS django_content_type_pkey;
ALTER TABLE IF EXISTS ONLY public.django_content_type DROP CONSTRAINT IF EXISTS django_content_type_app_label_model_76bd3d3b_uniq;
ALTER TABLE IF EXISTS ONLY public.django_admin_log DROP CONSTRAINT IF EXISTS django_admin_log_pkey;
ALTER TABLE IF EXISTS ONLY public.coupons_coupon DROP CONSTRAINT IF EXISTS coupons_coupon_pkey;
ALTER TABLE IF EXISTS ONLY public.coupons_coupon DROP CONSTRAINT IF EXISTS coupons_coupon_code_key;
ALTER TABLE IF EXISTS ONLY public.core_sitesettings DROP CONSTRAINT IF EXISTS core_sitesettings_pkey;
ALTER TABLE IF EXISTS ONLY public.core_heroimage DROP CONSTRAINT IF EXISTS core_heroimage_pkey;
ALTER TABLE IF EXISTS ONLY public.catalog_productimage DROP CONSTRAINT IF EXISTS catalog_productimage_pkey;
ALTER TABLE IF EXISTS ONLY public.catalog_product DROP CONSTRAINT IF EXISTS catalog_product_slug_key;
ALTER TABLE IF EXISTS ONLY public.catalog_product DROP CONSTRAINT IF EXISTS catalog_product_pkey;
ALTER TABLE IF EXISTS ONLY public.catalog_category DROP CONSTRAINT IF EXISTS catalog_category_slug_key;
ALTER TABLE IF EXISTS ONLY public.catalog_category DROP CONSTRAINT IF EXISTS catalog_category_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_permission DROP CONSTRAINT IF EXISTS auth_permission_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_permission DROP CONSTRAINT IF EXISTS auth_permission_content_type_id_codename_01ab375a_uniq;
ALTER TABLE IF EXISTS ONLY public.auth_group DROP CONSTRAINT IF EXISTS auth_group_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_group_permissions DROP CONSTRAINT IF EXISTS auth_group_permissions_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_group_permissions DROP CONSTRAINT IF EXISTS auth_group_permissions_group_id_permission_id_0cd325b0_uniq;
ALTER TABLE IF EXISTS ONLY public.auth_group DROP CONSTRAINT IF EXISTS auth_group_name_key;
ALTER TABLE IF EXISTS ONLY public.accounts_user_user_permissions DROP CONSTRAINT IF EXISTS accounts_user_user_permissions_pkey;
ALTER TABLE IF EXISTS ONLY public.accounts_user_user_permissions DROP CONSTRAINT IF EXISTS accounts_user_user_permi_user_id_permission_id_2ab516c2_uniq;
ALTER TABLE IF EXISTS ONLY public.accounts_user DROP CONSTRAINT IF EXISTS accounts_user_pkey;
ALTER TABLE IF EXISTS ONLY public.accounts_user_groups DROP CONSTRAINT IF EXISTS accounts_user_groups_user_id_group_id_59c0b32f_uniq;
ALTER TABLE IF EXISTS ONLY public.accounts_user_groups DROP CONSTRAINT IF EXISTS accounts_user_groups_pkey;
ALTER TABLE IF EXISTS ONLY public.accounts_user DROP CONSTRAINT IF EXISTS accounts_user_email_key;
DROP TABLE IF EXISTS public.shipping_deliveryzone;
DROP TABLE IF EXISTS public.reviews_review;
DROP TABLE IF EXISTS public.orders_orderitem;
DROP TABLE IF EXISTS public.orders_order;
DROP TABLE IF EXISTS public.django_session;
DROP TABLE IF EXISTS public.django_migrations;
DROP TABLE IF EXISTS public.django_content_type;
DROP TABLE IF EXISTS public.django_admin_log;
DROP TABLE IF EXISTS public.coupons_coupon;
DROP TABLE IF EXISTS public.core_sitesettings;
DROP TABLE IF EXISTS public.core_heroimage;
DROP TABLE IF EXISTS public.catalog_productimage;
DROP TABLE IF EXISTS public.catalog_product;
DROP TABLE IF EXISTS public.catalog_category;
DROP TABLE IF EXISTS public.auth_permission;
DROP TABLE IF EXISTS public.auth_group_permissions;
DROP TABLE IF EXISTS public.auth_group;
DROP TABLE IF EXISTS public.accounts_user_user_permissions;
DROP TABLE IF EXISTS public.accounts_user_groups;
DROP TABLE IF EXISTS public.accounts_user;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: accounts_user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.accounts_user (
    id bigint NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    email character varying(254) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    phone_number character varying(15),
    is_active boolean NOT NULL,
    is_staff boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    role character varying(10) NOT NULL,
    avatar character varying(100),
    is_email_verified boolean NOT NULL,
    otp_code character varying(6),
    otp_created_at timestamp with time zone
);


--
-- Name: accounts_user_groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.accounts_user_groups (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    group_id integer NOT NULL
);


--
-- Name: accounts_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.accounts_user_groups ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.accounts_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: accounts_user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.accounts_user ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.accounts_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: accounts_user_user_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.accounts_user_user_permissions (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    permission_id integer NOT NULL
);


--
-- Name: accounts_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.accounts_user_user_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.accounts_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.auth_group ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.auth_group_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.auth_permission ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: catalog_category; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.catalog_category (
    id bigint NOT NULL,
    name character varying(100) NOT NULL,
    slug character varying(50) NOT NULL,
    image character varying(100),
    description text NOT NULL,
    deleted_at timestamp with time zone,
    is_deleted boolean NOT NULL
);


--
-- Name: catalog_category_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.catalog_category ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.catalog_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: catalog_product; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.catalog_product (
    id bigint NOT NULL,
    name character varying(200) NOT NULL,
    slug character varying(50) NOT NULL,
    description text NOT NULL,
    price numeric(10,2) NOT NULL,
    stock integer NOT NULL,
    ingredients text NOT NULL,
    calories integer,
    is_active boolean NOT NULL,
    is_featured boolean NOT NULL,
    is_new boolean NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    category_id bigint NOT NULL,
    deleted_at timestamp with time zone,
    is_deleted boolean NOT NULL,
    CONSTRAINT catalog_product_stock_check CHECK ((stock >= 0))
);


--
-- Name: catalog_product_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.catalog_product ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.catalog_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: catalog_productimage; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.catalog_productimage (
    id bigint NOT NULL,
    image character varying(100) NOT NULL,
    is_main boolean NOT NULL,
    created_at timestamp with time zone NOT NULL,
    product_id bigint NOT NULL
);


--
-- Name: catalog_productimage_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.catalog_productimage ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.catalog_productimage_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: core_heroimage; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.core_heroimage (
    id bigint NOT NULL,
    image character varying(100) NOT NULL,
    "order" integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    settings_id bigint NOT NULL,
    CONSTRAINT core_heroimage_order_check CHECK (("order" >= 0))
);


--
-- Name: core_heroimage_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.core_heroimage ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.core_heroimage_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: core_sitesettings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.core_sitesettings (
    id bigint NOT NULL,
    shop_name character varying(255) NOT NULL,
    contact_email character varying(254) NOT NULL,
    background_color character varying(7) NOT NULL,
    primary_color character varying(7) NOT NULL,
    secondary_color character varying(7) NOT NULL
);


--
-- Name: core_sitesettings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.core_sitesettings ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.core_sitesettings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: coupons_coupon; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.coupons_coupon (
    id bigint NOT NULL,
    code character varying(50) NOT NULL,
    discount_percent integer NOT NULL,
    expiry_date timestamp with time zone,
    is_active boolean NOT NULL,
    usage_count integer NOT NULL,
    max_uses integer,
    CONSTRAINT coupons_coupon_discount_percent_check CHECK ((discount_percent >= 0)),
    CONSTRAINT coupons_coupon_max_uses_check CHECK ((max_uses >= 0)),
    CONSTRAINT coupons_coupon_usage_count_check CHECK ((usage_count >= 0))
);


--
-- Name: coupons_coupon_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.coupons_coupon ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.coupons_coupon_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id bigint NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.django_admin_log ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.django_content_type ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.django_migrations ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


--
-- Name: orders_order; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.orders_order (
    id bigint NOT NULL,
    full_name character varying(255) NOT NULL,
    email character varying(254),
    phone character varying(50),
    shipping_address_json jsonb NOT NULL,
    total_amount numeric(10,2) NOT NULL,
    status character varying(50) NOT NULL,
    payment_method character varying(50) NOT NULL,
    payment_status character varying(50) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    user_id bigint,
    is_viewed boolean NOT NULL
);


--
-- Name: orders_order_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.orders_order ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.orders_order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: orders_orderitem; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.orders_orderitem (
    id bigint NOT NULL,
    product_name character varying(255) NOT NULL,
    quantity integer NOT NULL,
    price numeric(10,2) NOT NULL,
    order_id bigint NOT NULL,
    product_id bigint,
    CONSTRAINT orders_orderitem_quantity_check CHECK ((quantity >= 0))
);


--
-- Name: orders_orderitem_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.orders_orderitem ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.orders_orderitem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: reviews_review; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.reviews_review (
    id bigint NOT NULL,
    rating integer NOT NULL,
    comment text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    product_id bigint NOT NULL,
    user_id bigint NOT NULL,
    deleted_at timestamp with time zone,
    is_deleted boolean NOT NULL,
    CONSTRAINT reviews_review_rating_check CHECK ((rating >= 0))
);


--
-- Name: reviews_review_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.reviews_review ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.reviews_review_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: shipping_deliveryzone; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.shipping_deliveryzone (
    id bigint NOT NULL,
    name character varying(100) NOT NULL,
    city character varying(100) NOT NULL,
    price integer NOT NULL,
    estimated_time character varying(50),
    is_active boolean NOT NULL,
    created_at timestamp with time zone NOT NULL,
    CONSTRAINT shipping_deliveryzone_price_check CHECK ((price >= 0))
);


--
-- Name: shipping_deliveryzone_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.shipping_deliveryzone ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.shipping_deliveryzone_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: accounts_user; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.accounts_user (id, password, last_login, is_superuser, email, first_name, last_name, phone_number, is_active, is_staff, date_joined, role, avatar, is_email_verified, otp_code, otp_created_at) FROM stdin;
1	pbkdf2_sha256$720000$ubIKpwbpeIzPqStDqn8aKx$Ka3lHhyYr71ML5hreZsRf78/zdFy9NksdeRm2xCczOE=	\N	f	dalinigba@gmail.com	Amen	Dalini	\N	t	f	2025-12-22 19:42:45.536756+00	client		f	\N	\N
2	pbkdf2_sha256$720000$UxVl7R3B1zt9jvrP368Gnb$1j/LiqDtO0RfBwBpksgjbDr5adMGUEt7bX2kGI+ONLQ=	\N	t	daligba83@gmail.com	Dalini	GBAGUIDI	\N	t	t	2025-12-21 12:54:32.357662+00	admin		t	\N	\N
\.


--
-- Data for Name: accounts_user_groups; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.accounts_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: accounts_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.accounts_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add content type	4	add_contenttype
14	Can change content type	4	change_contenttype
15	Can delete content type	4	delete_contenttype
16	Can view content type	4	view_contenttype
17	Can add session	5	add_session
18	Can change session	5	change_session
19	Can delete session	5	delete_session
20	Can view session	5	view_session
21	Can add user	6	add_user
22	Can change user	6	change_user
23	Can delete user	6	delete_user
24	Can view user	6	view_user
25	Can add category	7	add_category
26	Can change category	7	change_category
27	Can delete category	7	delete_category
28	Can view category	7	view_category
29	Can add product	8	add_product
30	Can change product	8	change_product
31	Can delete product	8	delete_product
32	Can view product	8	view_product
33	Can add product image	9	add_productimage
34	Can change product image	9	change_productimage
35	Can delete product image	9	delete_productimage
36	Can view product image	9	view_productimage
37	Can add site settings	10	add_sitesettings
38	Can change site settings	10	change_sitesettings
39	Can delete site settings	10	delete_sitesettings
40	Can view site settings	10	view_sitesettings
41	Can add hero image	11	add_heroimage
42	Can change hero image	11	change_heroimage
43	Can delete hero image	11	delete_heroimage
44	Can view hero image	11	view_heroimage
45	Can add order	12	add_order
46	Can change order	12	change_order
47	Can delete order	12	delete_order
48	Can view order	12	view_order
49	Can add order item	13	add_orderitem
50	Can change order item	13	change_orderitem
51	Can delete order item	13	delete_orderitem
52	Can view order item	13	view_orderitem
53	Can add review	14	add_review
54	Can change review	14	change_review
55	Can delete review	14	delete_review
56	Can view review	14	view_review
57	Can add coupon	15	add_coupon
58	Can change coupon	15	change_coupon
59	Can delete coupon	15	delete_coupon
60	Can view coupon	15	view_coupon
61	Can add delivery zone	16	add_deliveryzone
62	Can change delivery zone	16	change_deliveryzone
63	Can delete delivery zone	16	delete_deliveryzone
64	Can view delivery zone	16	view_deliveryzone
\.


--
-- Data for Name: catalog_category; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.catalog_category (id, name, slug, image, description, deleted_at, is_deleted) FROM stdin;
1	Pains	pain			\N	f
2	Pâtisseries	patisseries			\N	f
3	Viennoiseries	viennoiseries			\N	f
\.


--
-- Data for Name: catalog_product; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.catalog_product (id, name, slug, description, price, stock, ingredients, calories, is_active, is_featured, is_new, created_at, updated_at, category_id, deleted_at, is_deleted) FROM stdin;
1	Pain de Campagne	pain-de-campagne	Pain rustique à la croûte épaisse et foncée, fabriqué avec un mélange de farines de blé et de seigle pour un goût authentique et caractériel. Sa mie dense et alvéolée, légèrement acidulée grâce à un levain naturel, offre une excellente conservation sur plusieurs jours. La farine sur la croûte témoigne de son façonnage artisanal. Ce pain de terroir aux saveurs profondes et complexes est idéal pour accompagner fromages, charcuteries et plats mijotés. Son poids généreux de 800g en fait un pain familial par excellence.	1000.00	20	Farine de blé, Farine de seigle, Eau, Levain naturel, Sel	\N	f	f	f	2025-12-31 16:58:12.967366+00	2025-12-31 16:58:12.967381+00	1	\N	f
2	Éclair au Café	eclair-au-cafe	Variation sophistiquée de l'éclair traditionnel, garni d'une crème mousseline au café préparée avec un expresso corsé de qualité. La pâte à choux dorée et craquante contraste délicieusement avec la douceur de la crème au café. Le glaçage fondant au café, délicatement parfumé et brillant, peut être décoré d'un grain de café pour une touche finale élégante. Cette pâtisserie offre un équilibre subtil entre l'amertume du café et la douceur de la crème, séduisant les amateurs de saveurs raffinées.	700.00	35	Farine de blé, Œufs, Beurre, Lait, Café expresso, Sucre, Crème liquide	\N	f	f	f	2025-12-31 17:00:29.146835+00	2025-12-31 17:00:29.146847+00	2	\N	f
3	Éclair au Chocolat	eclair-au-chocolat	Pâtisserie emblématique composée d'une pâte à choux allongée et légère, fourrée d'une crème pâtissière au chocolat onctueuse et intense. Le dessus est recouvert d'un glaçage au chocolat noir brillant et lisse, offrant une présentation élégante. La pâte à choux croustillante à l'extérieur révèle un intérieur creux rempli généreusement de crème veloutée. Ce grand classique de la pâtisserie française combine parfaitement les textures et l'intensité du chocolat, pour une gourmandise raffinée de 12-13cm de longueur.	1000.00	35	Farine de blé, Œufs, Beurre, Lait, Chocolat noir, Sucre, Crème liquide	\N	f	t	f	2025-12-31 17:01:33.909798+00	2025-12-31 17:01:33.90981+00	2	\N	f
4	Tarte au Citron	tarte-au-citron	Tarte raffinée composée d'une pâte sablée croustillante garnie d'une crème au citron intense et acidulée, préparée avec du jus de citron frais et du zeste pour une explosion de saveurs. Le tout est surmonté d'une meringue italienne légère et aérienne, délicatement torchée au chalumeau pour obtenir des pointes dorées. L'équilibre parfait entre l'acidité vive du citron, la douceur de la meringue et le croquant de la pâte fait de cette tarte un dessert élégant et rafraîchissant, idéal en toute saison.	1500.00	40	Farine de blé, Beurre, Citrons, Œufs, Sucre, Crème liquide	\N	f	f	f	2025-12-31 17:02:51.060779+00	2025-12-31 17:02:51.060792+00	2	\N	f
5	Tarte aux Fraises	tarte-aux-fraises	Tarte gourmande et colorée composée d'un fond de pâte sucrée dorée, garnie d'une crème pâtissière à la vanille légère et onctueuse ou d'une crème mousseline, puis généreusement recouverte de fraises fraîches juteuses disposées en rosace. Les fraises sont délicatement nappées d'un glaçage transparent brillant qui sublime leur couleur rouge éclatante. Cette tarte printanière et estivale célèbre la fraîcheur du fruit, offrant une harmonie parfaite entre la douceur de la crème et l'acidité sucrée des fraises de saison.	1500.00	30	Farine de blé, Beurre, Fraises fraîches, Crème pâtissière, Sucre, Œufs, Nappage	\N	f	f	f	2025-12-31 17:03:36.713575+00	2025-12-31 17:03:36.713586+00	2	\N	f
6	Paris-Brest	paris-brest	Pâtisserie en forme de couronne créée en 1910 en hommage à la célèbre course cycliste Paris-Brest. Composée d'une pâte à choux en anneau parsemée d'amandes effilées, elle est généreusement garnie d'une crème mousseline pralinée onctueuse au goût intense de noisettes caramélisées. La texture croustillante de la pâte contraste magnifiquement avec la crème soyeuse et le croquant des éclats de pralin. Saupoudrée de sucre glace, cette création emblématique de la pâtisserie française offre une expérience gustative riche et raffinée.	1000.00	25	Farine de blé, Œufs, Beurre, Lait, Praliné noisette, Sucre, Amandes effilées	\N	f	f	f	2025-12-31 17:04:19.646894+00	2025-12-31 17:04:19.64692+00	2	\N	f
7	Mille-Feuille	mille-feuille	Chef-d'œuvre de la pâtisserie française composé de trois couches de pâte feuilletée ultra-fine et caramélisée, alternées avec deux généreuses couches de crème pâtissière à la vanille onctueuse. Le dessus est traditionnellement recouvert d'un glaçage blanc au fondant strié de lignes de chocolat noir formant un motif décoratif caractéristique. Chaque bouchée offre un contraste saisissant entre le croustillant du feuilletage et la douceur crémeuse de la garniture. Ce classique intemporel requiert une technique précise et représente l'excellence de la pâtisserie artisanale.	1200.00	25	Farine de blé, Beurre, Crème pâtissière, Sucre glace, Chocolat, Œufs, Vanille	\N	f	t	f	2025-12-31 17:05:08.389636+00	2025-12-31 17:05:08.389647+00	2	\N	f
8	Baguette Tradition	baguette-tradition	Baguette française authentique préparée selon les règles strictes du pain tradition : farine de blé, eau, sel et levure uniquement, sans additifs. Sa croûte fine et craquante d'un doré profond contraste avec une mie crémeuse aux alvéoles irrégulières et généreuses. Cuite sur sole, elle développe des arômes complexes de noisette et de céréales grillées. Sa longueur classique de 65cm et son poids de 250g en font le pain quotidien par excellence, parfait pour accompagner tous vos repas.	700.00	35	Farine de blé, Eau, Sel, Levure	\N	f	f	f	2025-12-31 17:06:08.215723+00	2025-12-31 17:06:08.215735+00	1	\N	f
9	Pain Complet	pain-complet	Pain nutritif élaboré exclusivement avec de la farine complète de blé, conservant l'intégralité du grain incluant le son et le germe. Sa mie dense et humide, parsemée de petites particules de son, offre une texture agréablement moelleuse et une saveur prononcée de céréales. Riche en fibres, minéraux et vitamines, ce pain santé possède une croûte épaisse et croquante. Son goût authentique légèrement sucré et sa valeur nutritionnelle en font le choix idéal pour une alimentation équilibrée au quotidien.	1000.00	20	Farine complète de blé, Eau, Levure, Sel, Miel	\N	f	f	f	2025-12-31 17:07:34.891405+00	2025-12-31 17:07:34.891421+00	1	\N	f
10	Pain aux Céréales	pain-aux-cereales	Pain gourmand et nutritif généreusement garni d'un mélange de graines variées : tournesol, lin, sésame, pavot et flocons d'avoine. Sa croûte dorée est parsemée de ces graines croquantes qui apportent des notes toastées. La mie moelleuse intègre également des céréales, offrant une texture intéressante et des saveurs complexes. Riche en oméga-3 et en protéines végétales, ce pain alliant plaisir et bienfaits nutritionnels se marie parfaitement avec du fromage frais, de l'avocat ou du saumon fumé.	300.00	75	Farine de blé, Graines de tournesol, Graines de lin, Sésame, Flocons d'avoine, Eau, Sel	\N	f	f	f	2025-12-31 17:08:19.311255+00	2025-12-31 17:08:19.311268+00	1	\N	f
11	Fougasse	fougasse	Pain plat provençal caractérisé par ses découpes artistiques en forme de feuille, créant des ouvertures typiques qui permettent une cuisson uniforme et croustillante. Généreusement arrosée d'huile d'olive extra-vierge et agrémentée d'herbes de Provence (thym, romarin, origan), notre fougasse peut également être garnie d'olives noires, de lardons ou de fromage selon les variations. Sa texture à la fois moelleuse et légèrement croquante, ses arômes méditerranéens ensoleillés en font un accompagnement idéal pour les apéritifs et les salades estivales.	2000.00	15	Farine de blé, Huile d'olive, Eau, Herbes de Provence, Levure, Sel	\N	f	f	f	2025-12-31 17:09:08.392072+00	2025-12-31 17:09:08.392086+00	1	\N	f
12	Croissant Beurre	croissant-beurre	Véritable croissant artisanal au beurre de tradition française, caractérisé par sa forme de croissant de lune parfaite et ses couches feuilletées dorées et croustillantes. Fabriqué avec du beurre pur (minimum 25%), notre croissant révèle une mie alvéolée et moelleuse à l'intérieur, contrastant délicieusement avec son extérieur craquant. Son arôme beurré et sa texture aérienne en font le compagnon idéal du petit-déjeuner. Chaque croissant est façonné à la main et cuit le matin même pour garantir une fraîcheur incomparable.	300.00	50	Farine de blé, Beurre, Eau, Sucre, Levure, Sel, Œufs	\N	f	f	f	2025-12-31 17:10:23.064044+00	2025-12-31 17:10:23.064054+00	3	\N	f
13	Chausson aux Pommes	chausson-aux-pommes	Chausson feuilleté garni d'une compote de pommes maison parfumée à la vanille et à la cannelle. Cette viennoiserie en forme de demi-lune est préparée avec des pommes fraîches cuisinées lentement pour obtenir une texture onctueuse et fondante. La pâte feuilletée croustillante et dorée enveloppe généreusement cette garniture fruitée légèrement sucrée. Légèrement saupoudré de sucre glace, ce chausson traditionnel allie gourmandise et authenticité, rappelant les goûters d'enfance.	500.00	35	Farine de blé, Beurre, Pommes, Sucre, Cannelle, Vanille, Œufs	\N	f	f	f	2025-12-31 17:11:07.341749+00	2025-12-31 17:11:07.341764+00	3	\N	f
14	Brioche	brioche	Brioche moelleuse et aérienne, enrichie en beurre et en œufs, offrant une mie filante d'un jaune doré caractéristique. Sa croûte fine et brillante, obtenue grâce à une dorure à l'œuf, contraste avec son intérieur d'une douceur incomparable. Légèrement sucrée avec des notes de vanille, notre brioche se distingue par sa texture soyeuse qui fond délicatement en bouche. Parfaite nature, toastée avec du beurre, ou en pain perdu, elle incarne l'excellence de la viennoiserie française traditionnelle.	500.00	100	Farine de blé, Beurre, Œufs, Sucre, Lait, Levure, Sel	\N	f	f	f	2025-12-31 17:11:47.936071+00	2025-12-31 17:11:47.936086+00	3	\N	f
15	Pain au Chocolat	pain-au-chocolat	Délicieuse viennoiserie rectangulaire composée d'une pâte feuilletée au beurre enroulée autour de deux barres de chocolat noir de qualité supérieure. Notre pain au chocolat offre un équilibre parfait entre le croustillant de sa pâte dorée et le fondant du chocolat qui reste légèrement coulant après cuisson. Chaque bouchée dévoile des couches successives de pâte légère imprégnées de la richesse du chocolat. Idéal pour un goûter gourmand ou un petit-déjeuner énergisant.	500.00	35	Farine de blé, Beurre, Chocolat noir, Eau, Sucre, Levure, Sel	\N	f	f	f	2025-12-31 17:12:34.203269+00	2025-12-31 17:12:34.203306+00	3	\N	f
16	Pain aux Raisins	pain-aux-raisins	Viennoiserie en spirale composée d'une pâte feuilletée levée garnie d'une onctueuse crème pâtissière à la vanille et parsemée de raisins secs moelleux. La forme en escargot révèle des couches successives de pâte beurrée alternant avec la crème crémeuse. Les raisins, préalablement réhydratés, apportent une douceur fruitée qui contraste avec la richesse de la crème. Glacé légèrement au sirop, ce classique de la boulangerie française offre une expérience gustative généreuse et réconfortante.	1500.00	20	Farine de blé, Beurre, Crème pâtissière, Raisins secs, Sucre, Levure, Œufs	\N	f	t	f	2025-12-31 17:13:48.659681+00	2025-12-31 17:13:48.659693+00	3	\N	f
\.


--
-- Data for Name: catalog_productimage; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.catalog_productimage (id, image, is_main, created_at, product_id) FROM stdin;
1	media/products/Google_AI_Studio_2025-12-22T20_32_20.728Z_rcxkgf	f	2025-12-31 16:58:16.63599+00	1
2	media/products/Google_AI_Studio_2025-12-22T20_41_54.853Z_rvuqks	f	2025-12-31 17:00:31.087136+00	2
3	media/products/Google_AI_Studio_2025-12-22T20_39_48.742Z_jotskq	f	2025-12-31 17:01:35.721485+00	3
4	media/products/Google_AI_Studio_2025-12-22T20_47_37.005Z_rbhkha	f	2025-12-31 17:02:53.193968+00	4
5	media/products/Google_AI_Studio_2025-12-22T20_49_11.948Z_ho5cll	f	2025-12-31 17:03:38.311641+00	5
6	media/products/Google_AI_Studio_2025-12-22T20_50_53.624Z_gjjm9a	f	2025-12-31 17:04:21.319888+00	6
7	media/products/Google_AI_Studio_2025-12-22T20_43_24.213Z_edse5i	f	2025-12-31 17:05:10.170491+00	7
8	media/products/Google_AI_Studio_2025-12-22T20_29_55.985Z_jgpult	f	2025-12-31 17:06:09.63359+00	8
9	media/products/Google_AI_Studio_2025-12-22T20_34_47.901Z_aamq72	f	2025-12-31 17:07:36.177408+00	9
10	media/products/Google_AI_Studio_2025-12-22T20_36_07.809Z_ngu5db	f	2025-12-31 17:08:21.2419+00	10
11	media/products/Google_AI_Studio_2025-12-22T20_37_43.834Z_yt0dfg	f	2025-12-31 17:09:10.391184+00	11
12	media/products/Croissant_Beurre5_hfyryc	f	2025-12-31 17:10:24.441211+00	12
13	media/products/Google_AI_Studio_2025-12-22T20_22_02.095Z_kyyos4	f	2025-12-31 17:11:08.739198+00	13
14	media/products/Google_AI_Studio_2025-12-22T20_25_59.733Z_mmaikh	f	2025-12-31 17:11:49.247058+00	14
15	media/products/Google_AI_Studio_2025-12-22T20_18_53.658Z_jdt23d	f	2025-12-31 17:12:35.439921+00	15
16	media/products/Google_AI_Studio_2025-12-22T20_27_32.161Z_jx5v7j	f	2025-12-31 17:13:50.630365+00	16
\.


--
-- Data for Name: core_heroimage; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.core_heroimage (id, image, "order", created_at, settings_id) FROM stdin;
1	media/hero_images/Google_AI_Studio_2025-12-24T13_16_42.399Z_xztwbw	0	2025-12-31 16:49:10.751021+00	1
\.


--
-- Data for Name: core_sitesettings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.core_sitesettings (id, shop_name, contact_email, background_color, primary_color, secondary_color) FROM stdin;
1	Lyly's Bakery	contact@lylys.com	#fbf7f0	#c5874a	#b96c3d
\.


--
-- Data for Name: coupons_coupon; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.coupons_coupon (id, code, discount_percent, expiry_date, is_active, usage_count, max_uses) FROM stdin;
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	contenttypes	contenttype
5	sessions	session
6	accounts	user
7	catalog	category
8	catalog	product
9	catalog	productimage
10	core	sitesettings
11	core	heroimage
12	orders	order
13	orders	orderitem
14	reviews	review
15	coupons	coupon
16	shipping	deliveryzone
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2025-12-29 20:55:49.889756+00
2	contenttypes	0002_remove_content_type_name	2025-12-29 20:55:51.384679+00
3	auth	0001_initial	2025-12-29 20:55:56.16456+00
4	auth	0002_alter_permission_name_max_length	2025-12-29 20:55:57.077289+00
5	auth	0003_alter_user_email_max_length	2025-12-29 20:55:57.672478+00
6	auth	0004_alter_user_username_opts	2025-12-29 20:55:58.570342+00
7	auth	0005_alter_user_last_login_null	2025-12-29 20:55:59.451946+00
8	auth	0006_require_contenttypes_0002	2025-12-29 20:56:00.364152+00
9	auth	0007_alter_validators_add_error_messages	2025-12-29 20:56:01.268346+00
10	auth	0008_alter_user_username_max_length	2025-12-29 20:56:02.149424+00
11	auth	0009_alter_user_last_name_max_length	2025-12-29 20:56:03.078848+00
12	auth	0010_alter_group_name_max_length	2025-12-29 20:56:04.608206+00
13	auth	0011_update_proxy_permissions	2025-12-29 20:56:05.234701+00
14	auth	0012_alter_user_first_name_max_length	2025-12-29 20:56:06.134517+00
15	accounts	0001_initial	2025-12-29 20:56:11.87888+00
16	accounts	0002_user_avatar	2025-12-29 20:56:12.766128+00
17	accounts	0003_user_is_email_verified_user_otp_code_and_more	2025-12-29 20:56:14.880737+00
18	admin	0001_initial	2025-12-29 20:56:17.543298+00
19	admin	0002_logentry_remove_auto_add	2025-12-29 20:56:17.864399+00
20	admin	0003_logentry_add_action_flag_choices	2025-12-29 20:56:18.754733+00
21	catalog	0001_initial	2025-12-29 20:56:22.963325+00
22	catalog	0002_category_deleted_at_category_is_deleted_and_more	2025-12-29 20:56:25.404721+00
23	catalog	0003_alter_product_created_at_alter_product_is_featured_and_more	2025-12-29 20:56:27.517756+00
24	core	0001_initial	2025-12-29 20:56:29.94503+00
25	core	0002_sitesettings_background_color_and_more	2025-12-29 20:56:32.338054+00
26	coupons	0001_initial	2025-12-29 20:56:34.16615+00
27	orders	0001_initial	2025-12-29 20:56:42.885035+00
28	orders	0002_alter_order_email	2025-12-29 20:56:43.784803+00
29	orders	0003_order_is_viewed	2025-12-29 20:56:45.303474+00
30	orders	0004_alter_order_created_at_alter_order_status	2025-12-29 20:56:47.118163+00
31	reviews	0001_initial	2025-12-29 20:56:50.124552+00
32	reviews	0002_review_deleted_at_review_is_deleted	2025-12-29 20:56:51.643921+00
33	sessions	0001_initial	2025-12-29 20:56:53.743339+00
34	shipping	0001_initial	2025-12-29 20:56:54.631104+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
\.


--
-- Data for Name: orders_order; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.orders_order (id, full_name, email, phone, shipping_address_json, total_amount, status, payment_method, payment_status, created_at, updated_at, user_id, is_viewed) FROM stdin;
\.


--
-- Data for Name: orders_orderitem; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.orders_orderitem (id, product_name, quantity, price, order_id, product_id) FROM stdin;
\.


--
-- Data for Name: reviews_review; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.reviews_review (id, rating, comment, created_at, product_id, user_id, deleted_at, is_deleted) FROM stdin;
\.


--
-- Data for Name: shipping_deliveryzone; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.shipping_deliveryzone (id, name, city, price, estimated_time, is_active, created_at) FROM stdin;
\.


--
-- Name: accounts_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.accounts_user_groups_id_seq', 1, false);


--
-- Name: accounts_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.accounts_user_id_seq', 2, true);


--
-- Name: accounts_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.accounts_user_user_permissions_id_seq', 1, false);


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 64, true);


--
-- Name: catalog_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.catalog_category_id_seq', 3, true);


--
-- Name: catalog_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.catalog_product_id_seq', 16, true);


--
-- Name: catalog_productimage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.catalog_productimage_id_seq', 16, true);


--
-- Name: core_heroimage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.core_heroimage_id_seq', 1, true);


--
-- Name: core_sitesettings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.core_sitesettings_id_seq', 1, false);


--
-- Name: coupons_coupon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.coupons_coupon_id_seq', 1, false);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1, false);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 16, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 34, true);


--
-- Name: orders_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.orders_order_id_seq', 1, false);


--
-- Name: orders_orderitem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.orders_orderitem_id_seq', 1, false);


--
-- Name: reviews_review_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.reviews_review_id_seq', 1, false);


--
-- Name: shipping_deliveryzone_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.shipping_deliveryzone_id_seq', 1, false);


--
-- Name: accounts_user accounts_user_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.accounts_user
    ADD CONSTRAINT accounts_user_email_key UNIQUE (email);


--
-- Name: accounts_user_groups accounts_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_pkey PRIMARY KEY (id);


--
-- Name: accounts_user_groups accounts_user_groups_user_id_group_id_59c0b32f_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_user_id_group_id_59c0b32f_uniq UNIQUE (user_id, group_id);


--
-- Name: accounts_user accounts_user_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.accounts_user
    ADD CONSTRAINT accounts_user_pkey PRIMARY KEY (id);


--
-- Name: accounts_user_user_permissions accounts_user_user_permi_user_id_permission_id_2ab516c2_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_permi_user_id_permission_id_2ab516c2_uniq UNIQUE (user_id, permission_id);


--
-- Name: accounts_user_user_permissions accounts_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: catalog_category catalog_category_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.catalog_category
    ADD CONSTRAINT catalog_category_pkey PRIMARY KEY (id);


--
-- Name: catalog_category catalog_category_slug_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.catalog_category
    ADD CONSTRAINT catalog_category_slug_key UNIQUE (slug);


--
-- Name: catalog_product catalog_product_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.catalog_product
    ADD CONSTRAINT catalog_product_pkey PRIMARY KEY (id);


--
-- Name: catalog_product catalog_product_slug_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.catalog_product
    ADD CONSTRAINT catalog_product_slug_key UNIQUE (slug);


--
-- Name: catalog_productimage catalog_productimage_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.catalog_productimage
    ADD CONSTRAINT catalog_productimage_pkey PRIMARY KEY (id);


--
-- Name: core_heroimage core_heroimage_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.core_heroimage
    ADD CONSTRAINT core_heroimage_pkey PRIMARY KEY (id);


--
-- Name: core_sitesettings core_sitesettings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.core_sitesettings
    ADD CONSTRAINT core_sitesettings_pkey PRIMARY KEY (id);


--
-- Name: coupons_coupon coupons_coupon_code_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coupons_coupon
    ADD CONSTRAINT coupons_coupon_code_key UNIQUE (code);


--
-- Name: coupons_coupon coupons_coupon_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coupons_coupon
    ADD CONSTRAINT coupons_coupon_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: orders_order orders_order_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders_order
    ADD CONSTRAINT orders_order_pkey PRIMARY KEY (id);


--
-- Name: orders_orderitem orders_orderitem_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders_orderitem
    ADD CONSTRAINT orders_orderitem_pkey PRIMARY KEY (id);


--
-- Name: reviews_review reviews_review_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews_review
    ADD CONSTRAINT reviews_review_pkey PRIMARY KEY (id);


--
-- Name: reviews_review reviews_review_product_id_user_id_96befe71_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews_review
    ADD CONSTRAINT reviews_review_product_id_user_id_96befe71_uniq UNIQUE (product_id, user_id);


--
-- Name: shipping_deliveryzone shipping_deliveryzone_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping_deliveryzone
    ADD CONSTRAINT shipping_deliveryzone_pkey PRIMARY KEY (id);


--
-- Name: accounts_user_email_b2644a56_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX accounts_user_email_b2644a56_like ON public.accounts_user USING btree (email varchar_pattern_ops);


--
-- Name: accounts_user_groups_group_id_bd11a704; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX accounts_user_groups_group_id_bd11a704 ON public.accounts_user_groups USING btree (group_id);


--
-- Name: accounts_user_groups_user_id_52b62117; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX accounts_user_groups_user_id_52b62117 ON public.accounts_user_groups USING btree (user_id);


--
-- Name: accounts_user_user_permissions_permission_id_113bb443; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX accounts_user_user_permissions_permission_id_113bb443 ON public.accounts_user_user_permissions USING btree (permission_id);


--
-- Name: accounts_user_user_permissions_user_id_e4f0a161; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX accounts_user_user_permissions_user_id_e4f0a161 ON public.accounts_user_user_permissions USING btree (user_id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: catalog_category_slug_dbf63ad0_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX catalog_category_slug_dbf63ad0_like ON public.catalog_category USING btree (slug varchar_pattern_ops);


--
-- Name: catalog_product_category_id_35bf920b; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX catalog_product_category_id_35bf920b ON public.catalog_product USING btree (category_id);


--
-- Name: catalog_product_created_at_ea90ae72; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX catalog_product_created_at_ea90ae72 ON public.catalog_product USING btree (created_at);


--
-- Name: catalog_product_is_featured_4286e684; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX catalog_product_is_featured_4286e684 ON public.catalog_product USING btree (is_featured);


--
-- Name: catalog_product_is_new_b0bab2b8; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX catalog_product_is_new_b0bab2b8 ON public.catalog_product USING btree (is_new);


--
-- Name: catalog_product_price_1347cb30; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX catalog_product_price_1347cb30 ON public.catalog_product USING btree (price);


--
-- Name: catalog_product_slug_f37848b0_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX catalog_product_slug_f37848b0_like ON public.catalog_product USING btree (slug varchar_pattern_ops);


--
-- Name: catalog_productimage_product_id_1f42dd8c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX catalog_productimage_product_id_1f42dd8c ON public.catalog_productimage USING btree (product_id);


--
-- Name: core_heroimage_settings_id_3a237f1b; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX core_heroimage_settings_id_3a237f1b ON public.core_heroimage USING btree (settings_id);


--
-- Name: coupons_coupon_code_40174643_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX coupons_coupon_code_40174643_like ON public.coupons_coupon USING btree (code varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: orders_order_created_at_20b8d253; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX orders_order_created_at_20b8d253 ON public.orders_order USING btree (created_at);


--
-- Name: orders_order_status_445594e5; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX orders_order_status_445594e5 ON public.orders_order USING btree (status);


--
-- Name: orders_order_status_445594e5_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX orders_order_status_445594e5_like ON public.orders_order USING btree (status varchar_pattern_ops);


--
-- Name: orders_order_user_id_e9b59eb1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX orders_order_user_id_e9b59eb1 ON public.orders_order USING btree (user_id);


--
-- Name: orders_orderitem_order_id_fe61a34d; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX orders_orderitem_order_id_fe61a34d ON public.orders_orderitem USING btree (order_id);


--
-- Name: orders_orderitem_product_id_afe4254a; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX orders_orderitem_product_id_afe4254a ON public.orders_orderitem USING btree (product_id);


--
-- Name: reviews_review_product_id_ce2fa4c6; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX reviews_review_product_id_ce2fa4c6 ON public.reviews_review USING btree (product_id);


--
-- Name: reviews_review_user_id_875caff2; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX reviews_review_user_id_875caff2 ON public.reviews_review USING btree (user_id);


--
-- Name: accounts_user_groups accounts_user_groups_group_id_bd11a704_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_group_id_bd11a704_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user_groups accounts_user_groups_user_id_52b62117_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_user_id_52b62117_fk_accounts_user_id FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user_user_permissions accounts_user_user_p_permission_id_113bb443_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_p_permission_id_113bb443_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user_user_permissions accounts_user_user_p_user_id_e4f0a161_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_p_user_id_e4f0a161_fk_accounts_ FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: catalog_product catalog_product_category_id_35bf920b_fk_catalog_category_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.catalog_product
    ADD CONSTRAINT catalog_product_category_id_35bf920b_fk_catalog_category_id FOREIGN KEY (category_id) REFERENCES public.catalog_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: catalog_productimage catalog_productimage_product_id_1f42dd8c_fk_catalog_product_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.catalog_productimage
    ADD CONSTRAINT catalog_productimage_product_id_1f42dd8c_fk_catalog_product_id FOREIGN KEY (product_id) REFERENCES public.catalog_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_heroimage core_heroimage_settings_id_3a237f1b_fk_core_sitesettings_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.core_heroimage
    ADD CONSTRAINT core_heroimage_settings_id_3a237f1b_fk_core_sitesettings_id FOREIGN KEY (settings_id) REFERENCES public.core_sitesettings(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_accounts_user_id FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_order orders_order_user_id_e9b59eb1_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders_order
    ADD CONSTRAINT orders_order_user_id_e9b59eb1_fk_accounts_user_id FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_orderitem orders_orderitem_order_id_fe61a34d_fk_orders_order_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders_orderitem
    ADD CONSTRAINT orders_orderitem_order_id_fe61a34d_fk_orders_order_id FOREIGN KEY (order_id) REFERENCES public.orders_order(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_orderitem orders_orderitem_product_id_afe4254a_fk_catalog_product_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders_orderitem
    ADD CONSTRAINT orders_orderitem_product_id_afe4254a_fk_catalog_product_id FOREIGN KEY (product_id) REFERENCES public.catalog_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: reviews_review reviews_review_product_id_ce2fa4c6_fk_catalog_product_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews_review
    ADD CONSTRAINT reviews_review_product_id_ce2fa4c6_fk_catalog_product_id FOREIGN KEY (product_id) REFERENCES public.catalog_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: reviews_review reviews_review_user_id_875caff2_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews_review
    ADD CONSTRAINT reviews_review_user_id_875caff2_fk_accounts_user_id FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

\unrestrict HQ1M8fQrr4CP8NMKqVT1ygZ9oigAzXeP3FbLutNU0Eq8ayuveKCfIjHP6JmmaHK

