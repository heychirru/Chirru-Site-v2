--
-- PostgreSQL database dump
--

\restrict VQKzS5myrJ98lXTX1YYT8Xn5waDBw8u6KDL4fjxZVPDudhRE5gE6xH0SovTnoAj

-- Dumped from database version 17.11
-- Dumped by pg_dump version 17.11

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

ALTER TABLE ONLY public.refresh_tokens DROP CONSTRAINT refresh_tokens_user_id_fkey;
ALTER TABLE ONLY public.project_technology_map DROP CONSTRAINT project_tag_map_tag_id_fkey;
ALTER TABLE ONLY public.project_technology_map DROP CONSTRAINT project_tag_map_project_id_fkey;
ALTER TABLE ONLY public.project_skills DROP CONSTRAINT project_skills_skill_id_fkey;
ALTER TABLE ONLY public.project_skills DROP CONSTRAINT project_skills_project_id_fkey;
ALTER TABLE ONLY public.project_case_studies DROP CONSTRAINT project_case_studies_project_id_fkey;
ALTER TABLE ONLY public.analytics_events DROP CONSTRAINT analytics_events_project_id_fkey;
DROP INDEX public.idx_social_links_visible_order;
DROP INDEX public.idx_resume_active;
DROP INDEX public.idx_refresh_tokens_user;
DROP INDEX public.idx_refresh_tokens_expiry;
DROP INDEX public.idx_projects_featured_order;
DROP INDEX public.idx_project_technology_map_technology;
DROP INDEX public.idx_project_technology_map_project;
DROP INDEX public.idx_notifications_read_created;
DROP INDEX public.idx_messages_read_created;
DROP INDEX public.idx_media_assets_folder_created;
DROP INDEX public.idx_experience_order;
DROP INDEX public.idx_education_order;
DROP INDEX public.idx_certifications_order;
DROP INDEX public.idx_audit_logs_user_email;
DROP INDEX public.idx_audit_logs_created_at;
DROP INDEX public.idx_analytics_type_created;
DROP INDEX public.idx_analytics_project_created;
DROP INDEX public.flyway_schema_history_s_idx;
ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
ALTER TABLE ONLY public.social_links DROP CONSTRAINT social_links_pkey;
ALTER TABLE ONLY public.skills DROP CONSTRAINT skills_pkey;
ALTER TABLE ONLY public.skills DROP CONSTRAINT skills_name_key;
ALTER TABLE ONLY public.site_settings DROP CONSTRAINT site_settings_setting_key_key;
ALTER TABLE ONLY public.site_settings DROP CONSTRAINT site_settings_pkey;
ALTER TABLE ONLY public.seo_settings DROP CONSTRAINT seo_settings_pkey;
ALTER TABLE ONLY public.seo_settings DROP CONSTRAINT seo_settings_page_key_key;
ALTER TABLE ONLY public.resume_versions DROP CONSTRAINT resume_versions_pkey;
ALTER TABLE ONLY public.refresh_tokens DROP CONSTRAINT refresh_tokens_token_hash_key;
ALTER TABLE ONLY public.refresh_tokens DROP CONSTRAINT refresh_tokens_pkey;
ALTER TABLE ONLY public.projects DROP CONSTRAINT projects_pkey;
ALTER TABLE ONLY public.technologies DROP CONSTRAINT project_tags_pkey;
ALTER TABLE ONLY public.technologies DROP CONSTRAINT project_tags_name_key;
ALTER TABLE ONLY public.project_technology_map DROP CONSTRAINT project_tag_map_pkey;
ALTER TABLE ONLY public.project_skills DROP CONSTRAINT project_skills_pkey;
ALTER TABLE ONLY public.project_case_studies DROP CONSTRAINT project_case_studies_pkey;
ALTER TABLE ONLY public.profile DROP CONSTRAINT profile_pkey;
ALTER TABLE ONLY public.notifications DROP CONSTRAINT notifications_pkey;
ALTER TABLE ONLY public.messages DROP CONSTRAINT messages_pkey;
ALTER TABLE ONLY public.media_assets DROP CONSTRAINT media_assets_public_id_key;
ALTER TABLE ONLY public.media_assets DROP CONSTRAINT media_assets_pkey;
ALTER TABLE ONLY public.flyway_schema_history DROP CONSTRAINT flyway_schema_history_pk;
ALTER TABLE ONLY public.experience DROP CONSTRAINT experience_pkey;
ALTER TABLE ONLY public.education DROP CONSTRAINT education_pkey;
ALTER TABLE ONLY public.certifications DROP CONSTRAINT certifications_pkey;
ALTER TABLE ONLY public.audit_logs DROP CONSTRAINT audit_logs_pkey;
ALTER TABLE ONLY public.analytics_events DROP CONSTRAINT analytics_events_pkey;
ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.technologies ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.social_links ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.skills ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.site_settings ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.seo_settings ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.resume_versions ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.refresh_tokens ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.projects ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.profile ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.notifications ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.messages ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.media_assets ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.experience ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.education ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.certifications ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.audit_logs ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.analytics_events ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE public.users_id_seq;
DROP TABLE public.users;
DROP SEQUENCE public.social_links_id_seq;
DROP TABLE public.social_links;
DROP SEQUENCE public.skills_id_seq;
DROP TABLE public.skills;
DROP SEQUENCE public.site_settings_id_seq;
DROP TABLE public.site_settings;
DROP SEQUENCE public.seo_settings_id_seq;
DROP TABLE public.seo_settings;
DROP SEQUENCE public.resume_versions_id_seq;
DROP TABLE public.resume_versions;
DROP SEQUENCE public.refresh_tokens_id_seq;
DROP TABLE public.refresh_tokens;
DROP SEQUENCE public.projects_id_seq;
DROP TABLE public.projects;
DROP TABLE public.project_technology_map;
DROP SEQUENCE public.project_tags_id_seq;
DROP TABLE public.technologies;
DROP TABLE public.project_skills;
DROP TABLE public.project_case_studies;
DROP SEQUENCE public.profile_id_seq;
DROP TABLE public.profile;
DROP SEQUENCE public.notifications_id_seq;
DROP TABLE public.notifications;
DROP SEQUENCE public.messages_id_seq;
DROP TABLE public.messages;
DROP SEQUENCE public.media_assets_id_seq;
DROP TABLE public.media_assets;
DROP TABLE public.flyway_schema_history;
DROP SEQUENCE public.experience_id_seq;
DROP TABLE public.experience;
DROP SEQUENCE public.education_id_seq;
DROP TABLE public.education;
DROP SEQUENCE public.certifications_id_seq;
DROP TABLE public.certifications;
DROP SEQUENCE public.audit_logs_id_seq;
DROP TABLE public.audit_logs;
DROP SEQUENCE public.analytics_events_id_seq;
DROP TABLE public.analytics_events;
DROP SCHEMA public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: analytics_events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.analytics_events (
    id bigint NOT NULL,
    event_type character varying(50) NOT NULL,
    path character varying(1000),
    project_id bigint,
    referrer character varying(1000),
    country character varying(100),
    device character varying(50),
    visitor_hash character varying(128),
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: analytics_events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.analytics_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: analytics_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.analytics_events_id_seq OWNED BY public.analytics_events.id;


--
-- Name: audit_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.audit_logs (
    id bigint NOT NULL,
    user_email character varying(255),
    action character varying(80) NOT NULL,
    resource character varying(120),
    http_method character varying(10),
    path character varying(2048),
    ip_address character varying(64),
    success boolean NOT NULL,
    details character varying(500),
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: audit_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.audit_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: audit_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.audit_logs_id_seq OWNED BY public.audit_logs.id;


--
-- Name: certifications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.certifications (
    id bigint NOT NULL,
    name character varying(250) NOT NULL,
    issuer character varying(200),
    issue_date date,
    credential_url character varying(1000),
    image_url character varying(1000),
    display_order integer DEFAULT 0 NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    image_public_id character varying(500)
);


--
-- Name: certifications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.certifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: certifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.certifications_id_seq OWNED BY public.certifications.id;


--
-- Name: education; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.education (
    id bigint NOT NULL,
    institution character varying(250) NOT NULL,
    degree character varying(200) NOT NULL,
    field character varying(200),
    description text,
    start_date date,
    end_date date,
    display_order integer DEFAULT 0 NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: education_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.education_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: education_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.education_id_seq OWNED BY public.education.id;


--
-- Name: experience; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.experience (
    id bigint NOT NULL,
    company character varying(200) NOT NULL,
    "position" character varying(200) NOT NULL,
    description text,
    start_date date NOT NULL,
    end_date date,
    current boolean DEFAULT false NOT NULL,
    display_order integer DEFAULT 0 NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: experience_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.experience_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: experience_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.experience_id_seq OWNED BY public.experience.id;


--
-- Name: flyway_schema_history; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


--
-- Name: media_assets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.media_assets (
    id bigint NOT NULL,
    folder character varying(100) NOT NULL,
    resource_type character varying(30) NOT NULL,
    public_id character varying(500) NOT NULL,
    url character varying(2000) NOT NULL,
    original_filename character varying(500),
    mime_type character varying(150),
    bytes bigint,
    width integer,
    height integer,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: media_assets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.media_assets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: media_assets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.media_assets_id_seq OWNED BY public.media_assets.id;


--
-- Name: messages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.messages (
    id bigint NOT NULL,
    name character varying(150) NOT NULL,
    email character varying(255) NOT NULL,
    subject character varying(255),
    message text NOT NULL,
    read boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.messages_id_seq OWNED BY public.messages.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.notifications (
    id bigint NOT NULL,
    type character varying(80) NOT NULL,
    title character varying(255) NOT NULL,
    body text,
    link character varying(1000),
    read boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.notifications_id_seq OWNED BY public.notifications.id;


--
-- Name: profile; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.profile (
    id bigint NOT NULL,
    name character varying(150) NOT NULL,
    headline character varying(255),
    bio text,
    email character varying(255),
    phone character varying(50),
    location character varying(150),
    github_url character varying(500),
    linkedin_url character varying(500),
    resume_url character varying(500),
    image_url character varying(1000),
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    image_public_id character varying(500),
    resume_public_id character varying(500),
    open_to_work boolean DEFAULT true NOT NULL
);


--
-- Name: profile_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.profile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: profile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.profile_id_seq OWNED BY public.profile.id;


--
-- Name: project_case_studies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.project_case_studies (
    project_id bigint NOT NULL,
    overview text,
    problem text,
    solution text,
    features text,
    architecture text,
    challenges text,
    results text,
    content text,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: project_skills; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.project_skills (
    project_id bigint NOT NULL,
    skill_id bigint NOT NULL
);


--
-- Name: technologies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.technologies (
    id bigint NOT NULL,
    name character varying(80) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: project_tags_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.project_tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: project_tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.project_tags_id_seq OWNED BY public.technologies.id;


--
-- Name: project_technology_map; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.project_technology_map (
    project_id bigint NOT NULL,
    technology_id bigint NOT NULL
);


--
-- Name: projects; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.projects (
    id bigint NOT NULL,
    title character varying(200) NOT NULL,
    description text NOT NULL,
    image_url character varying(1000),
    github_url character varying(500),
    live_url character varying(500),
    featured boolean DEFAULT false NOT NULL,
    display_order integer DEFAULT 0 NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    image_public_id character varying(500)
);


--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.projects_id_seq OWNED BY public.projects.id;


--
-- Name: refresh_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.refresh_tokens (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    token_hash character varying(128) NOT NULL,
    expires_at timestamp with time zone NOT NULL,
    revoked boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.refresh_tokens_id_seq OWNED BY public.refresh_tokens.id;


--
-- Name: resume_versions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resume_versions (
    id bigint NOT NULL,
    title character varying(200) NOT NULL,
    url character varying(2000) NOT NULL,
    public_id character varying(500),
    version_label character varying(80),
    active boolean DEFAULT false NOT NULL,
    download_count bigint DEFAULT 0 NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: resume_versions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.resume_versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: resume_versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.resume_versions_id_seq OWNED BY public.resume_versions.id;


--
-- Name: seo_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.seo_settings (
    id bigint NOT NULL,
    page_key character varying(100) NOT NULL,
    title character varying(255),
    description character varying(500),
    keywords character varying(1000),
    canonical_url character varying(1000),
    og_image_url character varying(1000),
    no_index boolean DEFAULT false NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: seo_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.seo_settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: seo_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.seo_settings_id_seq OWNED BY public.seo_settings.id;


--
-- Name: site_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.site_settings (
    id bigint NOT NULL,
    setting_key character varying(100) NOT NULL,
    setting_value text,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: site_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.site_settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: site_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.site_settings_id_seq OWNED BY public.site_settings.id;


--
-- Name: skills; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.skills (
    id bigint NOT NULL,
    name character varying(100) NOT NULL,
    category character varying(100),
    icon character varying(255),
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: skills_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.skills_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: skills_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.skills_id_seq OWNED BY public.skills.id;


--
-- Name: social_links; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.social_links (
    id bigint NOT NULL,
    platform character varying(80) NOT NULL,
    label character varying(120),
    url character varying(1000) NOT NULL,
    icon character varying(255),
    display_order integer DEFAULT 0 NOT NULL,
    visible boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: social_links_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.social_links_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: social_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.social_links_id_seq OWNED BY public.social_links.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying(255) NOT NULL,
    password_hash character varying(255) NOT NULL,
    role character varying(30) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: analytics_events id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.analytics_events ALTER COLUMN id SET DEFAULT nextval('public.analytics_events_id_seq'::regclass);


--
-- Name: audit_logs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audit_logs ALTER COLUMN id SET DEFAULT nextval('public.audit_logs_id_seq'::regclass);


--
-- Name: certifications id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.certifications ALTER COLUMN id SET DEFAULT nextval('public.certifications_id_seq'::regclass);


--
-- Name: education id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.education ALTER COLUMN id SET DEFAULT nextval('public.education_id_seq'::regclass);


--
-- Name: experience id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.experience ALTER COLUMN id SET DEFAULT nextval('public.experience_id_seq'::regclass);


--
-- Name: media_assets id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.media_assets ALTER COLUMN id SET DEFAULT nextval('public.media_assets_id_seq'::regclass);


--
-- Name: messages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.messages ALTER COLUMN id SET DEFAULT nextval('public.messages_id_seq'::regclass);


--
-- Name: notifications id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications ALTER COLUMN id SET DEFAULT nextval('public.notifications_id_seq'::regclass);


--
-- Name: profile id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profile ALTER COLUMN id SET DEFAULT nextval('public.profile_id_seq'::regclass);


--
-- Name: projects id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects ALTER COLUMN id SET DEFAULT nextval('public.projects_id_seq'::regclass);


--
-- Name: refresh_tokens id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('public.refresh_tokens_id_seq'::regclass);


--
-- Name: resume_versions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resume_versions ALTER COLUMN id SET DEFAULT nextval('public.resume_versions_id_seq'::regclass);


--
-- Name: seo_settings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.seo_settings ALTER COLUMN id SET DEFAULT nextval('public.seo_settings_id_seq'::regclass);


--
-- Name: site_settings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.site_settings ALTER COLUMN id SET DEFAULT nextval('public.site_settings_id_seq'::regclass);


--
-- Name: skills id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.skills ALTER COLUMN id SET DEFAULT nextval('public.skills_id_seq'::regclass);


--
-- Name: social_links id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.social_links ALTER COLUMN id SET DEFAULT nextval('public.social_links_id_seq'::regclass);


--
-- Name: technologies id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.technologies ALTER COLUMN id SET DEFAULT nextval('public.project_tags_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: analytics_events; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.analytics_events (id, event_type, path, project_id, referrer, country, device, visitor_hash, created_at) FROM stdin;
2	page_view	/	\N	\N	\N	desktop	v_a37aar4j9mu9upa21	2026-09-26 03:26:57.173717+00
1	page_view	/	\N	\N	\N	desktop	v_a37aar4j9mu9upa21	2026-09-26 03:26:57.173733+00
3	page_view	/	\N	\N	\N	desktop	v_a37aar4j9mu9upa21	2026-09-26 03:27:12.916107+00
4	page_view	/	\N	\N	\N	desktop	v_a37aar4j9mu9upa21	2026-09-26 03:27:12.929666+00
5	page_view	/	\N	\N	\N	desktop	v_a37aar4j9mu9upa21	2026-09-26 03:36:44.353225+00
6	page_view	/	\N	\N	\N	desktop	v_a37aar4j9mu9upa21	2026-09-26 03:36:44.353292+00
7	page_view	/	\N	\N	\N	desktop	v_a37aar4j9mu9upa21	2026-09-26 03:36:56.006468+00
8	page_view	/	\N	\N	\N	desktop	v_a37aar4j9mu9upa21	2026-09-26 03:36:56.008767+00
9	page_view	/	\N	http://localhost:3000/	\N	desktop	v_a37aar4j9mu9upa21	2026-09-26 03:50:57.282599+00
10	page_view	/	\N	http://localhost:3000/	\N	desktop	v_a37aar4j9mu9upa21	2026-09-26 03:50:57.298398+00
11	page_view	/	\N	http://localhost:3000/	\N	desktop	v_a37aar4j9mu9upa21	2026-09-26 03:54:47.299907+00
12	page_view	/	\N	http://localhost:3000/	\N	desktop	v_a37aar4j9mu9upa21	2026-09-26 03:54:47.310543+00
13	page_view	/	\N	http://localhost:3000/	\N	desktop	v_a37aar4j9mu9upa21	2026-09-26 03:58:34.32075+00
14	page_view	/	\N	http://localhost:3000/	\N	desktop	v_a37aar4j9mu9upa21	2026-09-26 03:58:34.329022+00
15	page_view	/	\N	http://localhost:3000/	\N	desktop	v_a37aar4j9mu9upa21	2026-09-26 03:58:40.610296+00
16	page_view	/	\N	http://localhost:3000/	\N	desktop	v_a37aar4j9mu9upa21	2026-09-26 03:58:40.610956+00
17	page_view	/	\N	http://localhost:3000/	\N	desktop	v_a37aar4j9mu9upa21	2026-09-26 03:58:43.830302+00
18	page_view	/	\N	http://localhost:3000/	\N	desktop	v_a37aar4j9mu9upa21	2026-09-26 03:58:43.831597+00
19	page_view	/	\N	\N	\N	desktop	v_a37aar4j9mu9upa21	2026-09-26 04:05:47.986754+00
20	page_view	/	\N	\N	\N	desktop	v_a37aar4j9mu9upa21	2026-09-26 04:05:48.028752+00
21	resume_download	/	\N	\N	\N	desktop	v_a37aar4j9mu9upa21	2026-09-26 04:07:08.341802+00
22	page_view	/	\N	\N	\N	tablet	v_a37aar4j9mu9upa21	2026-09-26 04:07:18.81793+00
23	page_view	/	\N	\N	\N	tablet	v_a37aar4j9mu9upa21	2026-09-26 04:07:18.820327+00
24	page_view	/	\N	\N	\N	desktop	v_a37aar4j9mu9upa21	2026-09-26 04:09:14.291116+00
25	page_view	/	\N	\N	\N	desktop	v_a37aar4j9mu9upa21	2026-09-26 04:09:14.301922+00
26	page_view	/	\N	\N	\N	desktop	v_a37aar4j9mu9upa21	2026-09-26 04:10:03.968234+00
27	page_view	/	\N	\N	\N	desktop	v_a37aar4j9mu9upa21	2026-09-26 04:10:03.987392+00
28	page_view	/	\N	\N	\N	desktop	v_a37aar4j9mu9upa21	2026-09-26 04:11:18.151723+00
29	page_view	/	\N	\N	\N	desktop	v_a37aar4j9mu9upa21	2026-09-26 04:11:18.16106+00
30	page_view	/	\N	http://localhost:3000/	\N	desktop	v_a37aar4j9mu9upa21	2026-09-26 04:11:18.530238+00
31	page_view	/	\N	http://localhost:3000/	\N	desktop	v_a37aar4j9mu9upa21	2026-09-26 04:11:18.53648+00
32	page_view	/	\N	http://localhost:3000/	\N	desktop	v_a37aar4j9mu9upa21	2026-09-26 04:12:56.637926+00
33	page_view	/	\N	http://localhost:3000/	\N	desktop	v_a37aar4j9mu9upa21	2026-09-26 04:12:56.652088+00
34	page_view	/	\N	http://localhost:3000/	\N	desktop	v_a37aar4j9mu9upa21	2026-09-26 04:12:57.135511+00
35	page_view	/	\N	http://localhost:3000/	\N	desktop	v_a37aar4j9mu9upa21	2026-09-26 04:12:57.142889+00
36	page_view	/	\N	\N	\N	desktop	v_a37aar4j9mu9upa21	2026-09-26 04:15:18.60906+00
37	page_view	/	\N	\N	\N	desktop	v_a37aar4j9mu9upa21	2026-09-26 04:15:18.620095+00
38	page_view	/	\N	\N	\N	desktop	v_a37aar4j9mu9upa21	2026-09-26 04:18:48.501436+00
39	page_view	/	\N	\N	\N	desktop	v_a37aar4j9mu9upa21	2026-09-26 04:18:48.523526+00
40	page_view	/	\N	\N	\N	desktop	v_urcvbpwh8mu9kgf5h	2026-09-26 04:20:19.835718+00
41	page_view	/	\N	\N	\N	desktop	v_urcvbpwh8mu9kgf5h	2026-09-26 04:20:19.83706+00
43	page_view	/	\N	\N	\N	desktop	v_urcvbpwh8mu9kgf5h	2026-09-26 04:20:23.86338+00
42	page_view	/	\N	\N	\N	desktop	v_urcvbpwh8mu9kgf5h	2026-09-26 04:20:23.863381+00
45	page_view	/	\N	\N	\N	mobile	v_urcvbpwh8mu9kgf5h	2026-09-26 04:20:31.690493+00
44	page_view	/	\N	\N	\N	mobile	v_urcvbpwh8mu9kgf5h	2026-09-26 04:20:31.690503+00
46	page_view	/	\N	\N	\N	mobile	v_urcvbpwh8mu9kgf5h	2026-09-26 04:21:07.451126+00
47	page_view	/	\N	\N	\N	mobile	v_urcvbpwh8mu9kgf5h	2026-09-26 04:21:07.451126+00
48	page_view	/	\N	\N	\N	desktop	v_a37aar4j9mu9upa21	2026-09-26 04:21:16.889607+00
49	page_view	/	\N	\N	\N	desktop	v_a37aar4j9mu9upa21	2026-09-26 04:21:16.899343+00
50	page_view	/	\N	\N	\N	mobile	v_urcvbpwh8mu9kgf5h	2026-09-26 04:26:11.557446+00
51	page_view	/	\N	\N	\N	mobile	v_urcvbpwh8mu9kgf5h	2026-09-26 04:26:11.557419+00
52	page_view	/	\N	\N	\N	desktop	v_a37aar4j9mu9upa21	2026-09-26 04:27:46.277748+00
53	page_view	/	\N	\N	\N	desktop	v_a37aar4j9mu9upa21	2026-09-26 04:27:46.278228+00
54	resume_download	/	\N	\N	\N	desktop	v_a37aar4j9mu9upa21	2026-09-26 04:27:47.339468+00
55	page_view	/	\N	\N	\N	tablet	v_a37aar4j9mu9upa21	2026-09-26 04:32:53.320047+00
56	page_view	/	\N	\N	\N	tablet	v_a37aar4j9mu9upa21	2026-09-26 04:32:53.32006+00
57	page_view	/	\N	\N	\N	tablet	v_urcvbpwh8mu9kgf5h	2026-09-26 05:03:09.030489+00
58	page_view	/	\N	\N	\N	tablet	v_urcvbpwh8mu9kgf5h	2026-09-26 05:03:09.030488+00
59	page_view	/	\N	\N	\N	mobile	v_urcvbpwh8mu9kgf5h	2026-09-26 05:03:13.531947+00
60	page_view	/	\N	\N	\N	mobile	v_urcvbpwh8mu9kgf5h	2026-09-26 05:03:13.533215+00
61	page_view	/	\N	\N	\N	desktop	v_urcvbpwh8mu9kgf5h	2026-10-01 04:00:46.395985+00
62	page_view	/	\N	\N	\N	desktop	v_urcvbpwh8mu9kgf5h	2026-10-01 04:00:46.395987+00
63	resume_download	/	\N	\N	\N	desktop	v_urcvbpwh8mu9kgf5h	2026-10-01 04:01:19.702824+00
64	page_view	/	\N	\N	\N	desktop	v_a37aar4j9mu9upa21	2026-10-01 04:48:15.39169+00
65	page_view	/	\N	\N	\N	desktop	v_a37aar4j9mu9upa21	2026-10-01 04:48:15.40985+00
66	page_view	/	\N	\N	\N	desktop	v_a37aar4j9mu9upa21	2026-10-01 05:00:23.781437+00
67	page_view	/	\N	\N	\N	desktop	v_a37aar4j9mu9upa21	2026-10-01 05:00:23.781481+00
68	page_view	/education	\N	\N	\N	desktop	v_a37aar4j9mu9upa21	2026-10-01 05:00:35.991155+00
69	page_view	/education	\N	\N	\N	desktop	v_a37aar4j9mu9upa21	2026-10-01 05:00:35.992525+00
\.


--
-- Data for Name: audit_logs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.audit_logs (id, user_email, action, resource, http_method, path, ip_address, success, details, created_at) FROM stdin;
1	chiranjit809@gmail.com	LOGIN_SUCCESS	AUTH	POST	/api/v2/auth/login	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:11:57.268719+00
2	chiranjit809@gmail.com	MESSAGES	AdminPortfolioController	GET	/api/v2/admin/messages	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:23:37.937256+00
3	chiranjit809@gmail.com	EXPERIENCE	AdminPortfolioController	GET	/api/v2/admin/experience	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:23:37.936247+00
4	chiranjit809@gmail.com	PROFILE	AdminPortfolioController	GET	/api/v2/admin/profile	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:23:37.940588+00
5	chiranjit809@gmail.com	EDUCATION	AdminPortfolioController	GET	/api/v2/admin/education	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:23:37.972167+00
6	chiranjit809@gmail.com	PROJECTS	AdminPortfolioController	GET	/api/v2/admin/projects	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:23:37.979479+00
8	chiranjit809@gmail.com	CERTIFICATIONS	AdminPortfolioController	GET	/api/v2/admin/certifications	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:23:37.985934+00
7	chiranjit809@gmail.com	SKILLS	AdminPortfolioController	GET	/api/v2/admin/skills	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:23:37.985934+00
9	chiranjit809@gmail.com	DASHBOARD	AdminPortfolioController	GET	/api/v2/admin/dashboard	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:23:38.199423+00
10	chiranjit809@gmail.com	PROFILE	AdminPortfolioController	GET	/api/v2/admin/profile	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:23:43.047889+00
11	chiranjit809@gmail.com	SKILLS	AdminPortfolioController	GET	/api/v2/admin/skills	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:23:43.056287+00
12	chiranjit809@gmail.com	MESSAGES	AdminPortfolioController	GET	/api/v2/admin/messages	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:23:43.059553+00
13	chiranjit809@gmail.com	PROJECTS	AdminPortfolioController	GET	/api/v2/admin/projects	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:23:43.061378+00
14	chiranjit809@gmail.com	DASHBOARD	AdminPortfolioController	GET	/api/v2/admin/dashboard	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:23:43.066723+00
15	chiranjit809@gmail.com	EXPERIENCE	AdminPortfolioController	GET	/api/v2/admin/experience	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:23:43.069959+00
16	chiranjit809@gmail.com	EDUCATION	AdminPortfolioController	GET	/api/v2/admin/education	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:23:43.081275+00
17	chiranjit809@gmail.com	CERTIFICATIONS	AdminPortfolioController	GET	/api/v2/admin/certifications	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:23:43.085274+00
18	chiranjit809@gmail.com	PROFILE	AdminPortfolioController	GET	/api/v2/admin/profile	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:25:14.614315+00
19	chiranjit809@gmail.com	SKILLS	AdminPortfolioController	GET	/api/v2/admin/skills	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:25:14.616116+00
20	chiranjit809@gmail.com	MESSAGES	AdminPortfolioController	GET	/api/v2/admin/messages	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:25:14.617407+00
21	chiranjit809@gmail.com	PROJECTS	AdminPortfolioController	GET	/api/v2/admin/projects	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:25:14.622655+00
22	chiranjit809@gmail.com	DASHBOARD	AdminPortfolioController	GET	/api/v2/admin/dashboard	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:25:14.629204+00
23	chiranjit809@gmail.com	EXPERIENCE	AdminPortfolioController	GET	/api/v2/admin/experience	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:25:14.637965+00
25	chiranjit809@gmail.com	EDUCATION	AdminPortfolioController	GET	/api/v2/admin/education	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:25:14.651463+00
24	chiranjit809@gmail.com	CERTIFICATIONS	AdminPortfolioController	GET	/api/v2/admin/certifications	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:25:14.651463+00
26	chiranjit809@gmail.com	PROFILE	AdminPortfolioController	GET	/api/v2/admin/profile	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:25:21.910865+00
27	chiranjit809@gmail.com	MESSAGES	AdminPortfolioController	GET	/api/v2/admin/messages	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:25:21.916314+00
28	chiranjit809@gmail.com	PROJECTS	AdminPortfolioController	GET	/api/v2/admin/projects	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:25:21.920833+00
29	chiranjit809@gmail.com	EXPERIENCE	AdminPortfolioController	GET	/api/v2/admin/experience	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:25:21.922732+00
30	chiranjit809@gmail.com	SKILLS	AdminPortfolioController	GET	/api/v2/admin/skills	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:25:21.923237+00
31	chiranjit809@gmail.com	DASHBOARD	AdminPortfolioController	GET	/api/v2/admin/dashboard	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:25:21.927926+00
32	chiranjit809@gmail.com	EDUCATION	AdminPortfolioController	GET	/api/v2/admin/education	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:25:21.946827+00
33	chiranjit809@gmail.com	CERTIFICATIONS	AdminPortfolioController	GET	/api/v2/admin/certifications	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:25:21.949044+00
34	chiranjit809@gmail.com	EXPERIENCE	AdminPortfolioController	GET	/api/v2/admin/experience	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:25:47.883153+00
36	chiranjit809@gmail.com	SKILLS	AdminPortfolioController	GET	/api/v2/admin/skills	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:25:47.860843+00
35	chiranjit809@gmail.com	PROJECTS	AdminPortfolioController	GET	/api/v2/admin/projects	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:25:47.871925+00
37	chiranjit809@gmail.com	PROFILE	AdminPortfolioController	GET	/api/v2/admin/profile	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:25:47.860843+00
38	chiranjit809@gmail.com	MESSAGES	AdminPortfolioController	GET	/api/v2/admin/messages	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:25:47.860843+00
39	chiranjit809@gmail.com	EDUCATION	AdminPortfolioController	GET	/api/v2/admin/education	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:25:47.954176+00
40	chiranjit809@gmail.com	CERTIFICATIONS	AdminPortfolioController	GET	/api/v2/admin/certifications	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:25:47.955209+00
41	chiranjit809@gmail.com	DASHBOARD	AdminPortfolioController	GET	/api/v2/admin/dashboard	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:25:48.109008+00
42	chiranjit809@gmail.com	UPDATEPROFILE	AdminPortfolioController	PUT	/api/v2/admin/profile	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:26:00.050584+00
43	chiranjit809@gmail.com	PROFILE	AdminPortfolioController	GET	/api/v2/admin/profile	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:26:00.106521+00
44	chiranjit809@gmail.com	UPDATEPROFILE	AdminPortfolioController	PUT	/api/v2/admin/profile	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:26:01.308559+00
45	chiranjit809@gmail.com	PROFILE	AdminPortfolioController	GET	/api/v2/admin/profile	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:26:01.330078+00
46	chiranjit809@gmail.com	LOGIN_SUCCESS	AUTH	POST	/api/v2/auth/login	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:29:59.482238+00
47	chiranjit809@gmail.com	PROFILE	AdminPortfolioController	GET	/api/v2/admin/profile	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:29:59.710918+00
48	chiranjit809@gmail.com	MESSAGES	AdminPortfolioController	GET	/api/v2/admin/messages	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:29:59.720522+00
49	chiranjit809@gmail.com	SKILLS	AdminPortfolioController	GET	/api/v2/admin/skills	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:29:59.725032+00
50	chiranjit809@gmail.com	PROJECTS	AdminPortfolioController	GET	/api/v2/admin/projects	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:29:59.727539+00
51	chiranjit809@gmail.com	DASHBOARD	AdminPortfolioController	GET	/api/v2/admin/dashboard	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:29:59.728732+00
52	chiranjit809@gmail.com	EXPERIENCE	AdminPortfolioController	GET	/api/v2/admin/experience	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:29:59.732836+00
59	chiranjit809@gmail.com	DASHBOARD	AdminPortfolioController	GET	/api/v2/admin/dashboard	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:30:03.265434+00
53	chiranjit809@gmail.com	EDUCATION	AdminPortfolioController	GET	/api/v2/admin/education	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:29:59.738853+00
55	chiranjit809@gmail.com	PROFILE	AdminPortfolioController	GET	/api/v2/admin/profile	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:30:03.242297+00
60	chiranjit809@gmail.com	EXPERIENCE	AdminPortfolioController	GET	/api/v2/admin/experience	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:30:03.272916+00
54	chiranjit809@gmail.com	CERTIFICATIONS	AdminPortfolioController	GET	/api/v2/admin/certifications	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:29:59.745899+00
56	chiranjit809@gmail.com	PROJECTS	AdminPortfolioController	GET	/api/v2/admin/projects	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:30:03.250352+00
62	chiranjit809@gmail.com	CERTIFICATIONS	AdminPortfolioController	GET	/api/v2/admin/certifications	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:30:03.277111+00
57	chiranjit809@gmail.com	SKILLS	AdminPortfolioController	GET	/api/v2/admin/skills	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:30:03.252467+00
58	chiranjit809@gmail.com	MESSAGES	AdminPortfolioController	GET	/api/v2/admin/messages	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:30:03.256325+00
61	chiranjit809@gmail.com	EDUCATION	AdminPortfolioController	GET	/api/v2/admin/education	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:30:03.276449+00
63	chiranjit809@gmail.com	LOGIN_SUCCESS	AUTH	POST	/api/v2/auth/login	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:38:26.063907+00
64	chiranjit809@gmail.com	MESSAGES	AdminPortfolioController	GET	/api/v2/admin/messages	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:38:26.211913+00
65	chiranjit809@gmail.com	SKILLS	AdminPortfolioController	GET	/api/v2/admin/skills	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:38:26.212918+00
66	chiranjit809@gmail.com	PROFILE	AdminPortfolioController	GET	/api/v2/admin/profile	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:38:26.211913+00
67	chiranjit809@gmail.com	PROJECTS	AdminPortfolioController	GET	/api/v2/admin/projects	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:38:26.215942+00
68	chiranjit809@gmail.com	EXPERIENCE	AdminPortfolioController	GET	/api/v2/admin/experience	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:38:26.224728+00
69	chiranjit809@gmail.com	DASHBOARD	AdminPortfolioController	GET	/api/v2/admin/dashboard	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:38:26.226062+00
71	chiranjit809@gmail.com	EDUCATION	AdminPortfolioController	GET	/api/v2/admin/education	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:38:26.229789+00
70	chiranjit809@gmail.com	CERTIFICATIONS	AdminPortfolioController	GET	/api/v2/admin/certifications	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:38:26.229789+00
72	chiranjit809@gmail.com	EXPERIENCE	AdminPortfolioController	GET	/api/v2/admin/experience	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:39:02.909147+00
73	chiranjit809@gmail.com	PROFILE	AdminPortfolioController	GET	/api/v2/admin/profile	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:39:04.142741+00
74	chiranjit809@gmail.com	EDUCATION	AdminPortfolioController	GET	/api/v2/admin/education	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:39:04.141958+00
75	chiranjit809@gmail.com	MESSAGES	AdminPortfolioController	GET	/api/v2/admin/messages	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:39:04.142741+00
76	chiranjit809@gmail.com	SKILLS	AdminPortfolioController	GET	/api/v2/admin/skills	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:39:04.142741+00
77	chiranjit809@gmail.com	PROJECTS	AdminPortfolioController	GET	/api/v2/admin/projects	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:39:04.147212+00
78	chiranjit809@gmail.com	DASHBOARD	AdminPortfolioController	GET	/api/v2/admin/dashboard	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:39:04.156528+00
79	chiranjit809@gmail.com	CERTIFICATIONS	AdminPortfolioController	GET	/api/v2/admin/certifications	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:39:04.165082+00
80	chiranjit809@gmail.com	SKILLS	AdminPortfolioController	GET	/api/v2/admin/skills	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:39:05.813091+00
81	chiranjit809@gmail.com	PROFILE	AdminPortfolioController	GET	/api/v2/admin/profile	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:39:05.813091+00
82	chiranjit809@gmail.com	EXPERIENCE	AdminPortfolioController	GET	/api/v2/admin/experience	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:39:05.824597+00
83	chiranjit809@gmail.com	PROJECTS	AdminPortfolioController	GET	/api/v2/admin/projects	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:39:05.825384+00
84	chiranjit809@gmail.com	MESSAGES	AdminPortfolioController	GET	/api/v2/admin/messages	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:39:05.82782+00
85	chiranjit809@gmail.com	DASHBOARD	AdminPortfolioController	GET	/api/v2/admin/dashboard	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:39:05.84031+00
86	chiranjit809@gmail.com	CERTIFICATIONS	AdminPortfolioController	GET	/api/v2/admin/certifications	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:39:05.851439+00
87	chiranjit809@gmail.com	EDUCATION	AdminPortfolioController	GET	/api/v2/admin/education	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:39:05.851439+00
88	chiranjit809@gmail.com	DELETEMESSAGE	AdminPortfolioController	DELETE	/api/v2/admin/messages/3	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:39:35.047129+00
89	chiranjit809@gmail.com	MESSAGES	AdminPortfolioController	GET	/api/v2/admin/messages	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:39:35.082873+00
90	chiranjit809@gmail.com	DASHBOARD	AdminPortfolioController	GET	/api/v2/admin/dashboard	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:39:35.126378+00
91	chiranjit809@gmail.com	DELETEMESSAGE	AdminPortfolioController	DELETE	/api/v2/admin/messages/1	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:39:37.190892+00
92	chiranjit809@gmail.com	MESSAGES	AdminPortfolioController	GET	/api/v2/admin/messages	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:39:37.214065+00
93	chiranjit809@gmail.com	DASHBOARD	AdminPortfolioController	GET	/api/v2/admin/dashboard	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:39:37.262865+00
94	chiranjit809@gmail.com	DELETEMESSAGE	AdminPortfolioController	DELETE	/api/v2/admin/messages/2	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:39:39.239389+00
95	chiranjit809@gmail.com	MESSAGES	AdminPortfolioController	GET	/api/v2/admin/messages	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:39:39.260748+00
96	chiranjit809@gmail.com	DASHBOARD	AdminPortfolioController	GET	/api/v2/admin/dashboard	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:39:39.302624+00
97	chiranjit809@gmail.com	EXPERIENCE	AdminPortfolioController	GET	/api/v2/admin/experience	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:39:45.048069+00
99	chiranjit809@gmail.com	CERTIFICATIONS	AdminPortfolioController	GET	/api/v2/admin/certifications	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:39:45.058711+00
98	chiranjit809@gmail.com	SKILLS	AdminPortfolioController	GET	/api/v2/admin/skills	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:39:45.058711+00
100	chiranjit809@gmail.com	EDUCATION	AdminPortfolioController	GET	/api/v2/admin/education	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:39:45.058711+00
101	chiranjit809@gmail.com	PROFILE	AdminPortfolioController	GET	/api/v2/admin/profile	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:39:45.062938+00
102	chiranjit809@gmail.com	PROJECTS	AdminPortfolioController	GET	/api/v2/admin/projects	0:0:0:0:0:0:0:1	t	\N	2026-09-26 07:39:45.066141+00
105	chiranjit809@gmail.com	LOGIN_SUCCESS	AUTH	POST	/api/v2/auth/login	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:17:41.786236+00
106	chiranjit809@gmail.com	PROFILE	AdminPortfolioController	GET	/api/v2/admin/profile	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:17:42.160555+00
108	chiranjit809@gmail.com	EXPERIENCE	AdminPortfolioController	GET	/api/v2/admin/experience	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:17:42.159464+00
107	chiranjit809@gmail.com	SKILLS	AdminPortfolioController	GET	/api/v2/admin/skills	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:17:42.160555+00
109	chiranjit809@gmail.com	EDUCATION	AdminPortfolioController	GET	/api/v2/admin/education	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:17:42.185163+00
110	chiranjit809@gmail.com	PROJECTS	AdminPortfolioController	GET	/api/v2/admin/projects	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:17:42.193036+00
111	chiranjit809@gmail.com	CERTIFICATIONS	AdminPortfolioController	GET	/api/v2/admin/certifications	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:17:42.197476+00
112	chiranjit809@gmail.com	MESSAGES	AdminPortfolioController	GET	/api/v2/admin/messages	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:17:42.198015+00
113	chiranjit809@gmail.com	DASHBOARD	AdminPortfolioController	GET	/api/v2/admin/dashboard	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:17:42.440939+00
116	chiranjit809@gmail.com	PROJECTS	AdminPortfolioController	GET	/api/v2/admin/projects	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:17:55.748421+00
121	chiranjit809@gmail.com	CERTIFICATIONS	AdminPortfolioController	GET	/api/v2/admin/certifications	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:17:55.787233+00
114	chiranjit809@gmail.com	MESSAGES	AdminPortfolioController	GET	/api/v2/admin/messages	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:17:55.732477+00
115	chiranjit809@gmail.com	PROFILE	AdminPortfolioController	GET	/api/v2/admin/profile	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:17:55.735436+00
117	chiranjit809@gmail.com	SKILLS	AdminPortfolioController	GET	/api/v2/admin/skills	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:17:55.759024+00
120	chiranjit809@gmail.com	EDUCATION	AdminPortfolioController	GET	/api/v2/admin/education	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:17:55.775625+00
118	chiranjit809@gmail.com	EXPERIENCE	AdminPortfolioController	GET	/api/v2/admin/experience	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:17:55.762928+00
119	chiranjit809@gmail.com	DASHBOARD	AdminPortfolioController	GET	/api/v2/admin/dashboard	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:17:55.76607+00
122	chiranjit809@gmail.com	UPDATEPROFILE	AdminPortfolioController	PUT	/api/v2/admin/profile	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:18:13.387107+00
123	chiranjit809@gmail.com	PROFILE	AdminPortfolioController	GET	/api/v2/admin/profile	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:18:13.416922+00
124	chiranjit809@gmail.com	UPDATEPROFILE	AdminPortfolioController	PUT	/api/v2/admin/profile	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:18:16.33133+00
125	chiranjit809@gmail.com	PROFILE	AdminPortfolioController	GET	/api/v2/admin/profile	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:18:16.372088+00
126	chiranjit809@gmail.com	UPDATEPROFILE	AdminPortfolioController	PUT	/api/v2/admin/profile	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:18:49.677831+00
127	chiranjit809@gmail.com	PROFILE	AdminPortfolioController	GET	/api/v2/admin/profile	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:18:49.708531+00
128	chiranjit809@gmail.com	UPDATEPROFILE	AdminPortfolioController	PUT	/api/v2/admin/profile	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:29:26.973623+00
129	chiranjit809@gmail.com	PROFILE	AdminPortfolioController	GET	/api/v2/admin/profile	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:29:27.038952+00
130	chiranjit809@gmail.com	MESSAGES	AdminPortfolioController	GET	/api/v2/admin/messages	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:30:23.533042+00
131	chiranjit809@gmail.com	PROFILE	AdminPortfolioController	GET	/api/v2/admin/profile	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:30:23.534265+00
132	chiranjit809@gmail.com	SKILLS	AdminPortfolioController	GET	/api/v2/admin/skills	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:30:23.535278+00
133	chiranjit809@gmail.com	PROJECTS	AdminPortfolioController	GET	/api/v2/admin/projects	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:30:23.54196+00
134	chiranjit809@gmail.com	EXPERIENCE	AdminPortfolioController	GET	/api/v2/admin/experience	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:30:23.554983+00
135	chiranjit809@gmail.com	EDUCATION	AdminPortfolioController	GET	/api/v2/admin/education	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:30:23.573513+00
136	chiranjit809@gmail.com	CERTIFICATIONS	AdminPortfolioController	GET	/api/v2/admin/certifications	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:30:23.574308+00
137	chiranjit809@gmail.com	DASHBOARD	AdminPortfolioController	GET	/api/v2/admin/dashboard	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:30:23.796805+00
138	chiranjit809@gmail.com	PROFILE	AdminPortfolioController	GET	/api/v2/admin/profile	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:31:08.764421+00
139	chiranjit809@gmail.com	EDUCATION	AdminPortfolioController	GET	/api/v2/admin/education	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:31:08.765125+00
140	chiranjit809@gmail.com	DASHBOARD	AdminPortfolioController	GET	/api/v2/admin/dashboard	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:31:08.78146+00
141	chiranjit809@gmail.com	PROFILE	AdminPortfolioController	GET	/api/v2/admin/profile	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:31:51.544586+00
142	chiranjit809@gmail.com	EDUCATION	AdminPortfolioController	GET	/api/v2/admin/education	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:31:51.564426+00
143	chiranjit809@gmail.com	DASHBOARD	AdminPortfolioController	GET	/api/v2/admin/dashboard	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:31:51.571189+00
144	chiranjit809@gmail.com	PROFILE	AdminPortfolioController	GET	/api/v2/admin/profile	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:31:58.973803+00
145	chiranjit809@gmail.com	EDUCATION	AdminPortfolioController	GET	/api/v2/admin/education	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:31:59.022794+00
146	chiranjit809@gmail.com	DASHBOARD	AdminPortfolioController	GET	/api/v2/admin/dashboard	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:31:59.059288+00
147	chiranjit809@gmail.com	EDUCATION	AdminPortfolioController	GET	/api/v2/admin/education	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:31:59.358428+00
148	chiranjit809@gmail.com	PROFILE	AdminPortfolioController	GET	/api/v2/admin/profile	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:31:59.358428+00
149	chiranjit809@gmail.com	DASHBOARD	AdminPortfolioController	GET	/api/v2/admin/dashboard	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:31:59.369597+00
150	chiranjit809@gmail.com	PROFILE	AdminPortfolioController	GET	/api/v2/admin/profile	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:31:59.72169+00
151	chiranjit809@gmail.com	EDUCATION	AdminPortfolioController	GET	/api/v2/admin/education	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:31:59.728455+00
152	chiranjit809@gmail.com	DASHBOARD	AdminPortfolioController	GET	/api/v2/admin/dashboard	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:31:59.740726+00
153	chiranjit809@gmail.com	EDUCATION	AdminPortfolioController	GET	/api/v2/admin/education	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:32:22.373252+00
154	chiranjit809@gmail.com	PROFILE	AdminPortfolioController	GET	/api/v2/admin/profile	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:32:22.373252+00
155	chiranjit809@gmail.com	DASHBOARD	AdminPortfolioController	GET	/api/v2/admin/dashboard	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:32:22.602265+00
156	chiranjit809@gmail.com	LOGIN_SUCCESS	AUTH	POST	/api/v2/auth/login	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:40:18.316859+00
157	chiranjit809@gmail.com	PROFILE	AdminPortfolioController	GET	/api/v2/admin/profile	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:40:18.501754+00
158	chiranjit809@gmail.com	MESSAGES	AdminPortfolioController	GET	/api/v2/admin/messages	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:40:18.506327+00
159	chiranjit809@gmail.com	SKILLS	AdminPortfolioController	GET	/api/v2/admin/skills	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:40:18.508489+00
160	chiranjit809@gmail.com	PROJECTS	AdminPortfolioController	GET	/api/v2/admin/projects	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:40:18.513123+00
161	chiranjit809@gmail.com	DASHBOARD	AdminPortfolioController	GET	/api/v2/admin/dashboard	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:40:18.531277+00
162	chiranjit809@gmail.com	EXPERIENCE	AdminPortfolioController	GET	/api/v2/admin/experience	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:40:18.536501+00
163	chiranjit809@gmail.com	EDUCATION	AdminPortfolioController	GET	/api/v2/admin/education	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:40:18.541225+00
164	chiranjit809@gmail.com	CERTIFICATIONS	AdminPortfolioController	GET	/api/v2/admin/certifications	0:0:0:0:0:0:0:1	t	\N	2026-10-01 03:40:18.541225+00
165	chiranjit809@gmail.com	LOGIN_SUCCESS	AUTH	POST	/api/v2/auth/login	0:0:0:0:0:0:0:1	t	\N	2026-10-01 04:57:01.611074+00
167	chiranjit809@gmail.com	MESSAGES	AdminPortfolioController	GET	/api/v2/admin/messages	0:0:0:0:0:0:0:1	t	\N	2026-10-01 04:57:02.917222+00
166	chiranjit809@gmail.com	EXPERIENCE	AdminPortfolioController	GET	/api/v2/admin/experience	0:0:0:0:0:0:0:1	t	\N	2026-10-01 04:57:02.91559+00
168	chiranjit809@gmail.com	PROFILE	AdminPortfolioController	GET	/api/v2/admin/profile	0:0:0:0:0:0:0:1	t	\N	2026-10-01 04:57:02.923588+00
169	chiranjit809@gmail.com	SKILLS	AdminPortfolioController	GET	/api/v2/admin/skills	0:0:0:0:0:0:0:1	t	\N	2026-10-01 04:57:02.957537+00
170	chiranjit809@gmail.com	PROJECTS	AdminPortfolioController	GET	/api/v2/admin/projects	0:0:0:0:0:0:0:1	t	\N	2026-10-01 04:57:02.960928+00
171	chiranjit809@gmail.com	EDUCATION	AdminPortfolioController	GET	/api/v2/admin/education	0:0:0:0:0:0:0:1	t	\N	2026-10-01 04:57:02.963205+00
172	chiranjit809@gmail.com	CERTIFICATIONS	AdminPortfolioController	GET	/api/v2/admin/certifications	0:0:0:0:0:0:0:1	t	\N	2026-10-01 04:57:02.966637+00
173	chiranjit809@gmail.com	DASHBOARD	AdminPortfolioController	GET	/api/v2/admin/dashboard	0:0:0:0:0:0:0:1	t	\N	2026-10-01 04:57:03.208088+00
174	chiranjit809@gmail.com	PROFILE	AdminPortfolioController	GET	/api/v2/admin/profile	0:0:0:0:0:0:0:1	t	\N	2026-10-01 04:57:47.303649+00
175	chiranjit809@gmail.com	DASHBOARD	AdminPortfolioController	GET	/api/v2/admin/dashboard	0:0:0:0:0:0:0:1	t	\N	2026-10-01 04:57:47.313796+00
176	chiranjit809@gmail.com	PROJECTS	AdminPortfolioController	GET	/api/v2/admin/projects	0:0:0:0:0:0:0:1	t	\N	2026-10-01 04:57:47.350013+00
177	chiranjit809@gmail.com	MESSAGES	AdminPortfolioController	GET	/api/v2/admin/messages	0:0:0:0:0:0:0:1	t	\N	2026-10-01 04:57:47.350013+00
178	chiranjit809@gmail.com	EXPERIENCE	AdminPortfolioController	GET	/api/v2/admin/experience	0:0:0:0:0:0:0:1	t	\N	2026-10-01 04:57:47.351084+00
179	chiranjit809@gmail.com	SKILLS	AdminPortfolioController	GET	/api/v2/admin/skills	0:0:0:0:0:0:0:1	t	\N	2026-10-01 04:57:47.353872+00
180	chiranjit809@gmail.com	CERTIFICATIONS	AdminPortfolioController	GET	/api/v2/admin/certifications	0:0:0:0:0:0:0:1	t	\N	2026-10-01 04:57:47.354934+00
181	chiranjit809@gmail.com	EDUCATION	AdminPortfolioController	GET	/api/v2/admin/education	0:0:0:0:0:0:0:1	t	\N	2026-10-01 04:57:47.354934+00
182	chiranjit809@gmail.com	PROFILE	AdminPortfolioController	GET	/api/v2/admin/profile	0:0:0:0:0:0:0:1	t	\N	2026-10-01 05:06:25.240481+00
183	chiranjit809@gmail.com	EXPERIENCE	AdminPortfolioController	GET	/api/v2/admin/experience	0:0:0:0:0:0:0:1	t	\N	2026-10-01 05:06:25.246272+00
184	chiranjit809@gmail.com	PROJECTS	AdminPortfolioController	GET	/api/v2/admin/projects	0:0:0:0:0:0:0:1	t	\N	2026-10-01 05:06:25.246272+00
185	chiranjit809@gmail.com	MESSAGES	AdminPortfolioController	GET	/api/v2/admin/messages	0:0:0:0:0:0:0:1	t	\N	2026-10-01 05:06:25.246846+00
186	chiranjit809@gmail.com	SKILLS	AdminPortfolioController	GET	/api/v2/admin/skills	0:0:0:0:0:0:0:1	t	\N	2026-10-01 05:06:25.248585+00
187	chiranjit809@gmail.com	DASHBOARD	AdminPortfolioController	GET	/api/v2/admin/dashboard	0:0:0:0:0:0:0:1	t	\N	2026-10-01 05:06:25.251599+00
188	chiranjit809@gmail.com	EDUCATION	AdminPortfolioController	GET	/api/v2/admin/education	0:0:0:0:0:0:0:1	t	\N	2026-10-01 05:06:25.262422+00
189	chiranjit809@gmail.com	CERTIFICATIONS	AdminPortfolioController	GET	/api/v2/admin/certifications	0:0:0:0:0:0:0:1	t	\N	2026-10-01 05:06:25.265128+00
190	chiranjit809@gmail.com	PROFILE	AdminPortfolioController	GET	/api/v2/admin/profile	0:0:0:0:0:0:0:1	t	\N	2026-10-01 05:06:56.017523+00
191	chiranjit809@gmail.com	MESSAGES	AdminPortfolioController	GET	/api/v2/admin/messages	0:0:0:0:0:0:0:1	t	\N	2026-10-01 05:06:56.021798+00
192	chiranjit809@gmail.com	PROJECTS	AdminPortfolioController	GET	/api/v2/admin/projects	0:0:0:0:0:0:0:1	t	\N	2026-10-01 05:06:56.024018+00
193	chiranjit809@gmail.com	DASHBOARD	AdminPortfolioController	GET	/api/v2/admin/dashboard	0:0:0:0:0:0:0:1	t	\N	2026-10-01 05:06:56.024018+00
194	chiranjit809@gmail.com	SKILLS	AdminPortfolioController	GET	/api/v2/admin/skills	0:0:0:0:0:0:0:1	t	\N	2026-10-01 05:06:56.024018+00
195	chiranjit809@gmail.com	EXPERIENCE	AdminPortfolioController	GET	/api/v2/admin/experience	0:0:0:0:0:0:0:1	t	\N	2026-10-01 05:06:56.024572+00
196	chiranjit809@gmail.com	EDUCATION	AdminPortfolioController	GET	/api/v2/admin/education	0:0:0:0:0:0:0:1	t	\N	2026-10-01 05:06:56.035411+00
197	chiranjit809@gmail.com	CERTIFICATIONS	AdminPortfolioController	GET	/api/v2/admin/certifications	0:0:0:0:0:0:0:1	t	\N	2026-10-01 05:06:56.037002+00
198	chiranjit809@gmail.com	PROFILE	AdminPortfolioController	GET	/api/v2/admin/profile	0:0:0:0:0:0:0:1	t	\N	2026-10-01 05:08:40.42435+00
199	chiranjit809@gmail.com	DASHBOARD	AdminPortfolioController	GET	/api/v2/admin/dashboard	0:0:0:0:0:0:0:1	t	\N	2026-10-01 05:08:40.443391+00
200	chiranjit809@gmail.com	MESSAGES	AdminPortfolioController	GET	/api/v2/admin/messages	0:0:0:0:0:0:0:1	t	\N	2026-10-01 05:08:40.499225+00
201	chiranjit809@gmail.com	SKILLS	AdminPortfolioController	GET	/api/v2/admin/skills	0:0:0:0:0:0:0:1	t	\N	2026-10-01 05:08:40.499225+00
202	chiranjit809@gmail.com	PROJECTS	AdminPortfolioController	GET	/api/v2/admin/projects	0:0:0:0:0:0:0:1	t	\N	2026-10-01 05:08:40.503115+00
203	chiranjit809@gmail.com	EXPERIENCE	AdminPortfolioController	GET	/api/v2/admin/experience	0:0:0:0:0:0:0:1	t	\N	2026-10-01 05:08:40.508865+00
204	chiranjit809@gmail.com	EDUCATION	AdminPortfolioController	GET	/api/v2/admin/education	0:0:0:0:0:0:0:1	t	\N	2026-10-01 05:08:40.511067+00
205	chiranjit809@gmail.com	CERTIFICATIONS	AdminPortfolioController	GET	/api/v2/admin/certifications	0:0:0:0:0:0:0:1	t	\N	2026-10-01 05:08:40.511067+00
206	chiranjit809@gmail.com	PROFILE	AdminPortfolioController	GET	/api/v2/admin/profile	0:0:0:0:0:0:0:1	t	\N	2026-10-01 05:11:44.485183+00
207	chiranjit809@gmail.com	DASHBOARD	AdminPortfolioController	GET	/api/v2/admin/dashboard	0:0:0:0:0:0:0:1	t	\N	2026-10-01 05:11:44.497703+00
208	chiranjit809@gmail.com	LOGIN_SUCCESS	AUTH	POST	/api/v2/auth/login	0:0:0:0:0:0:0:1	t	\N	2026-10-01 05:15:59.673471+00
209	chiranjit809@gmail.com	MESSAGES	AdminPortfolioController	GET	/api/v2/admin/messages	0:0:0:0:0:0:0:1	t	\N	2026-10-01 05:15:59.920295+00
210	chiranjit809@gmail.com	SKILLS	AdminPortfolioController	GET	/api/v2/admin/skills	0:0:0:0:0:0:0:1	t	\N	2026-10-01 05:15:59.924163+00
211	chiranjit809@gmail.com	PROFILE	AdminPortfolioController	GET	/api/v2/admin/profile	0:0:0:0:0:0:0:1	t	\N	2026-10-01 05:15:59.94489+00
212	chiranjit809@gmail.com	EXPERIENCE	AdminPortfolioController	GET	/api/v2/admin/experience	0:0:0:0:0:0:0:1	t	\N	2026-10-01 05:15:59.946397+00
213	chiranjit809@gmail.com	PROJECTS	AdminPortfolioController	GET	/api/v2/admin/projects	0:0:0:0:0:0:0:1	t	\N	2026-10-01 05:15:59.966018+00
215	chiranjit809@gmail.com	CERTIFICATIONS	AdminPortfolioController	GET	/api/v2/admin/certifications	0:0:0:0:0:0:0:1	t	\N	2026-10-01 05:15:59.972604+00
214	chiranjit809@gmail.com	EDUCATION	AdminPortfolioController	GET	/api/v2/admin/education	0:0:0:0:0:0:0:1	t	\N	2026-10-01 05:15:59.972604+00
216	chiranjit809@gmail.com	DASHBOARD	AdminPortfolioController	GET	/api/v2/admin/dashboard	0:0:0:0:0:0:0:1	t	\N	2026-10-01 05:16:00.226054+00
217	chiranjit809@gmail.com	PROFILE	AdminPortfolioController	GET	/api/v2/admin/profile	0:0:0:0:0:0:0:1	t	\N	2026-10-01 05:16:04.901816+00
218	chiranjit809@gmail.com	DASHBOARD	AdminPortfolioController	GET	/api/v2/admin/dashboard	0:0:0:0:0:0:0:1	t	\N	2026-10-01 05:16:04.916697+00
219	chiranjit809@gmail.com	MESSAGES	AdminPortfolioController	GET	/api/v2/admin/messages	0:0:0:0:0:0:0:1	t	\N	2026-10-01 05:16:04.919473+00
220	chiranjit809@gmail.com	SKILLS	AdminPortfolioController	GET	/api/v2/admin/skills	0:0:0:0:0:0:0:1	t	\N	2026-10-01 05:16:04.922295+00
221	chiranjit809@gmail.com	PROJECTS	AdminPortfolioController	GET	/api/v2/admin/projects	0:0:0:0:0:0:0:1	t	\N	2026-10-01 05:16:04.931253+00
222	chiranjit809@gmail.com	EXPERIENCE	AdminPortfolioController	GET	/api/v2/admin/experience	0:0:0:0:0:0:0:1	t	\N	2026-10-01 05:16:04.935783+00
223	chiranjit809@gmail.com	EDUCATION	AdminPortfolioController	GET	/api/v2/admin/education	0:0:0:0:0:0:0:1	t	\N	2026-10-01 05:16:04.944563+00
224	chiranjit809@gmail.com	CERTIFICATIONS	AdminPortfolioController	GET	/api/v2/admin/certifications	0:0:0:0:0:0:0:1	t	\N	2026-10-01 05:16:04.95529+00
225	chiranjit809@gmail.com	MESSAGES	AdminPortfolioController	GET	/api/v2/admin/messages	0:0:0:0:0:0:0:1	t	\N	2026-10-01 05:16:37.384296+00
226	chiranjit809@gmail.com	EDUCATION	AdminPortfolioController	GET	/api/v2/admin/education	0:0:0:0:0:0:0:1	t	\N	2026-10-01 05:16:43.198665+00
227	chiranjit809@gmail.com	EXPERIENCE	AdminPortfolioController	GET	/api/v2/admin/experience	0:0:0:0:0:0:0:1	t	\N	2026-10-01 05:16:43.204979+00
228	chiranjit809@gmail.com	PROFILE	AdminPortfolioController	GET	/api/v2/admin/profile	0:0:0:0:0:0:0:1	t	\N	2026-10-01 05:16:43.208088+00
229	chiranjit809@gmail.com	SKILLS	AdminPortfolioController	GET	/api/v2/admin/skills	0:0:0:0:0:0:0:1	t	\N	2026-10-01 05:16:43.209608+00
230	chiranjit809@gmail.com	PROJECTS	AdminPortfolioController	GET	/api/v2/admin/projects	0:0:0:0:0:0:0:1	t	\N	2026-10-01 05:16:43.214402+00
231	chiranjit809@gmail.com	DASHBOARD	AdminPortfolioController	GET	/api/v2/admin/dashboard	0:0:0:0:0:0:0:1	t	\N	2026-10-01 05:16:43.227442+00
232	chiranjit809@gmail.com	CERTIFICATIONS	AdminPortfolioController	GET	/api/v2/admin/certifications	0:0:0:0:0:0:0:1	t	\N	2026-10-01 05:16:43.24029+00
\.


--
-- Data for Name: certifications; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.certifications (id, name, issuer, issue_date, credential_url, image_url, display_order, created_at, updated_at, image_public_id) FROM stdin;
\.


--
-- Data for Name: education; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.education (id, institution, degree, field, description, start_date, end_date, display_order, created_at, updated_at) FROM stdin;
5	ST. Mary's Technical Campus Kolkata 	Diploma in Mechanical Engineering 	\N	\N	\N	\N	0	2026-09-08 10:11:51.994007+00	2026-09-08 10:11:51.994007+00
6	Siliguri Institute of Technology 	B.Tech in Computer Science and Engineering 	\N	\N	\N	\N	0	2026-09-08 10:12:37.640245+00	2026-09-08 10:12:37.640245+00
\.


--
-- Data for Name: experience; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.experience (id, company, "position", description, start_date, end_date, current, display_order, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
1	1	create portfolio schema	SQL	V1__create_portfolio_schema.sql	-501231527	chirru	2026-09-26 08:43:40.659121	44	t
2	2	create refresh tokens	SQL	V2__create_refresh_tokens.sql	-833765450	chirru	2026-09-26 08:43:40.7333	10	t
3	4	add cloudinary public ids	SQL	V4__add_cloudinary_public_ids.sql	-666306444	chirru	2026-09-26 08:43:40.761217	18	t
4	5	create audit logs	SQL	V5__create_audit_logs.sql	-451004300	chirru	2026-09-26 08:43:40.808855	10	t
5	6	add portfolio management features	SQL	V6__add_portfolio_management_features.sql	34326608	chirru	2026-09-26 08:43:40.842904	46	t
6	7	remove slugs add project technologies	SQL	V7__remove_slugs_add_project_technologies.sql	-1925488549	chirru	2026-09-26 08:43:40.909357	11	t
7	8	add open to work	SQL	V8__add_open_to_work.sql	-1383142904	chirru	2026-09-26 08:43:40.940424	3	t
8	9	seed portfolio data	SQL	V9__seed_portfolio_data.sql	1349936976	chirru	2026-09-26 08:43:40.958485	15	t
9	10	fix profile resume data	SQL	V10__fix_profile_resume_data.sql	1747941821	chirru	2026-09-26 08:43:40.991539	4	t
10	11	seed media assets	SQL	V11__seed_media_assets.sql	-1022369547	chirru	2026-09-26 09:18:23.230917	26	t
11	12	update profile image url to media proxy	SQL	V12__update_profile_image_url_to_media_proxy.sql	-1698795272	chirru	2026-10-01 10:37:20.069215	12	t
\.


--
-- Data for Name: media_assets; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.media_assets (id, folder, resource_type, public_id, url, original_filename, mime_type, bytes, width, height, created_at) FROM stdin;
1	resume	raw	chirru-portfolio/resume/Cv.pdf	https://res.cloudinary.com/rnplcrmq/raw/upload/v1790045816/chirru-portfolio/resume/Cv.pdf	Cv.pdf	application/pdf	184899	\N	\N	2026-09-26 03:48:23.246132+00
2	profile	image	chirru-portfolio/profile/profile	https://res.cloudinary.com/rnplcrmq/image/upload/v1790045813/chirru-portfolio/profile/profile.jpg	profile.jpg	image/jpeg	362078	\N	\N	2026-09-26 03:48:23.246132+00
5	projects	image	chirru-portfolio/projects/social-media-dashboard	https://res.cloudinary.com/rnplcrmq/image/upload/v1790138123/chirru-portfolio/projects/social-media-dashboard.webp	social-media-dashboard.webp	image/webp	13370	\N	\N	2026-09-26 03:48:23.246132+00
7	projects	image	chirru-portfolio/projects/student-grade-tracker	https://res.cloudinary.com/rnplcrmq/image/upload/v1790138469/chirru-portfolio/projects/student-grade-tracker.webp	student-grade-tracker.webp	image/webp	13572	\N	\N	2026-09-26 03:48:23.246132+00
\.


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.messages (id, name, email, subject, message, read, created_at) FROM stdin;
4	Tester	test@example.com	Hello	Testing contact form	f	2026-10-01 04:37:48.539781+00
5	Tester	test@example.com	Hello	Testing contact form	f	2026-10-01 04:54:34.299562+00
6	Tester	test@example.com	Hello	Testing contact form	f	2026-10-01 05:07:28.308399+00
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.notifications (id, type, title, body, link, read, created_at) FROM stdin;
\.


--
-- Data for Name: profile; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.profile (id, name, headline, bio, email, phone, location, github_url, linkedin_url, resume_url, image_url, created_at, updated_at, image_public_id, resume_public_id, open_to_work) FROM stdin;
1	Chiranjit Das	Wanna be a Java Backend Developer	Hi! I'm Chiranjit Das, a passionate Backend Developer With a strong foundation in modern web development and an eye for detail, I create elegant, user-friendly web solutions tailored to meet client needs.\n\nMy journey into tech began from a non-IT background, and I've embraced every challenge to hone my skills in development, problem-solving, and teamwork. I'm always eager to learn and explore new technologies to deliver cutting-edge web experiences.\n\nWhen I'm not coding, you can find me reading, gaming, or exploring the great outdoors. I'm always up for a chat, so feel free to reach out if you have any questions or just want to say hi!\n\nWhen I'm not in full-on developer mode, you can find me hovering around on Instagram, witnessing the journey of early startups or enjoying some free time. You can follow me on Instagram where I share tech-related bites and build in public, or you can follow me on GitHub.	chirru26@gmail.com	\N	India	https://github.com/heychirru	https://www.linkedin.com/in/heychirru26	/api/v2/media/1	/api/v2/media/2	2026-09-23 03:49:42.432038+00	2026-10-01 03:29:26.855646+00	chirru-portfolio/profile/profile	chirru-portfolio/resume/Cv.pdf	t
\.


--
-- Data for Name: project_case_studies; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.project_case_studies (project_id, overview, problem, solution, features, architecture, challenges, results, content, updated_at) FROM stdin;
\.


--
-- Data for Name: project_skills; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.project_skills (project_id, skill_id) FROM stdin;
\.


--
-- Data for Name: project_technology_map; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.project_technology_map (project_id, technology_id) FROM stdin;
\.


--
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.projects (id, title, description, image_url, github_url, live_url, featured, display_order, created_at, updated_at, image_public_id) FROM stdin;
1	Social Media Dashboard	A comprehensive social media management dashboard with analytics, From Instagram.	/api/v2/media/5	https://github.com/heychirru/Social-Media-Dashboard	\N	t	0	2026-09-23 04:37:59.434937+00	2026-09-23 04:37:59.434937+00	chirru-portfolio/projects/social-media-dashboard
2	Student Grade Tracker	A Simple Student Grade Tracker Application Made With Java GUI.	/api/v2/media/7	https://github.com/heychirru/ATM-Simulator-System	\N	t	0	2026-09-23 04:39:30.465199+00	2026-09-23 04:41:13.053086+00	chirru-portfolio/projects/student-grade-tracker
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.refresh_tokens (id, user_id, token_hash, expires_at, revoked, created_at) FROM stdin;
1	1	5176953a856eb79a470210e6639c0a69ebdd2efb615b48842a26bf5f956f6518	2026-10-03 07:11:57.007831+00	t	2026-09-26 07:11:57.052165+00
2	1	d4fa37d53740c940b8e92189c4bc0abfd2f589108017c89587fa8e0ce065ea14	2026-10-03 07:29:59.389025+00	f	2026-09-26 07:29:59.390211+00
3	1	946beffa2b1b2e822af8ece4e2dbab8ba3df2a8403eb35673300c6194dcc34ef	2026-10-03 07:38:26.057222+00	f	2026-09-26 07:38:26.057222+00
4	1	542bd5ae966362262eb3b92f1908260c68ca9f08df3b7a51faf04558645ae919	2026-10-08 03:17:41.627984+00	t	2026-10-01 03:17:41.635641+00
5	1	cdf8f865b284d4bbeeb0ab743f7b83c5792bd1dc54dcfa2f52148c01ecd1f6ff	2026-10-08 03:40:18.265874+00	f	2026-10-01 03:40:18.266548+00
6	1	40278d9855beb822fc1072c5fe6b9b7802059319eb0b55bae00afcaaf99725e4	2026-10-08 04:57:01.324898+00	t	2026-10-01 04:57:01.35154+00
7	1	67ae6cf8d68ed84954d8083386a9f740bd9f4301a51e0cd7e42c38672ad8d08f	2026-10-08 05:15:59.606065+00	f	2026-10-01 05:15:59.608228+00
\.


--
-- Data for Name: resume_versions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resume_versions (id, title, url, public_id, version_label, active, download_count, created_at) FROM stdin;
\.


--
-- Data for Name: seo_settings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.seo_settings (id, page_key, title, description, keywords, canonical_url, og_image_url, no_index, updated_at) FROM stdin;
1	home	Chiranjit Das | Java & Backend Developer	Official portfolio of Chiranjit Das, Java & Backend Software Engineer specializing in Spring Boot, REST APIs, Microservices, and scalable web applications.	Java, Spring Boot, Backend Developer, PostgreSQL, REST APIs, Microservices, Cloudinary	/	/og-image.jpg	f	2026-09-26 03:13:40.964521+00
\.


--
-- Data for Name: site_settings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.site_settings (id, setting_key, setting_value, updated_at) FROM stdin;
\.


--
-- Data for Name: skills; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.skills (id, name, category, icon, created_at, updated_at) FROM stdin;
1	Java	Backend	coffee	2026-09-26 03:13:40.964521+00	2026-09-26 03:13:40.964521+00
2	Spring Boot	Backend	zap	2026-09-26 03:13:40.964521+00	2026-09-26 03:13:40.964521+00
3	PostgreSQL	Databases	database	2026-09-26 03:13:40.964521+00	2026-09-26 03:13:40.964521+00
4	Hibernate / JPA	Backend	layers	2026-09-26 03:13:40.964521+00	2026-09-26 03:13:40.964521+00
5	REST APIs	Backend	network	2026-09-26 03:13:40.964521+00	2026-09-26 03:13:40.964521+00
6	Microservices	Backend	server	2026-09-26 03:13:40.964521+00	2026-09-26 03:13:40.964521+00
7	JWT Security	Backend	lock	2026-09-26 03:13:40.964521+00	2026-09-26 03:13:40.964521+00
8	Docker	DevOps	container	2026-09-26 03:13:40.964521+00	2026-09-26 03:13:40.964521+00
9	React	Frontend	layout	2026-09-26 03:13:40.964521+00	2026-09-26 03:13:40.964521+00
10	JavaScript	Frontend	code	2026-09-26 03:13:40.964521+00	2026-09-26 03:13:40.964521+00
11	Maven	Tools	package	2026-09-26 03:13:40.964521+00	2026-09-26 03:13:40.964521+00
12	Git & GitHub	Tools	git-branch	2026-09-26 03:13:40.964521+00	2026-09-26 03:13:40.964521+00
\.


--
-- Data for Name: social_links; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.social_links (id, platform, label, url, icon, display_order, visible, created_at, updated_at) FROM stdin;
1	GitHub	GitHub	https://github.com/heychirru	github	1	t	2026-09-26 03:13:40.964521+00	2026-09-26 03:13:40.964521+00
2	LinkedIn	LinkedIn	https://www.linkedin.com/in/heychirru26	linkedin	2	t	2026-09-26 03:13:40.964521+00	2026-09-26 03:13:40.964521+00
3	instagram	Instagram	https://www.instagram.com/chir.ru_26t	instagram	3	t	2026-09-06 05:49:18.779911+00	2026-09-06 05:49:18.779911+00
4	twitter	 X	https://www.x.com/chir_ru26	twitter	4	t	2026-09-19 05:49:28.500483+00	2026-09-19 05:49:28.500483+00
\.


--
-- Data for Name: technologies; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.technologies (id, name, created_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (id, email, password_hash, role, created_at, updated_at) FROM stdin;
1	chiranjit809@gmail.com	$2a$12$JYw0X1Pfm99msbXWcagS..fMbIbqHCT/w3NDwESriNV5GypImsrOC	ADMIN	2026-09-26 03:13:44.211094+00	2026-09-26 03:13:44.211094+00
\.


--
-- Name: analytics_events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.analytics_events_id_seq', 69, true);


--
-- Name: audit_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.audit_logs_id_seq', 232, true);


--
-- Name: certifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.certifications_id_seq', 1, false);


--
-- Name: education_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.education_id_seq', 1, false);


--
-- Name: experience_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.experience_id_seq', 1, false);


--
-- Name: media_assets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.media_assets_id_seq', 7, true);


--
-- Name: messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.messages_id_seq', 6, true);


--
-- Name: notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.notifications_id_seq', 1, false);


--
-- Name: profile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.profile_id_seq', 1, false);


--
-- Name: project_tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.project_tags_id_seq', 1, false);


--
-- Name: projects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.projects_id_seq', 1, false);


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.refresh_tokens_id_seq', 7, true);


--
-- Name: resume_versions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.resume_versions_id_seq', 1, false);


--
-- Name: seo_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.seo_settings_id_seq', 1, true);


--
-- Name: site_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.site_settings_id_seq', 1, false);


--
-- Name: skills_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.skills_id_seq', 12, true);


--
-- Name: social_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.social_links_id_seq', 2, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- Name: analytics_events analytics_events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.analytics_events
    ADD CONSTRAINT analytics_events_pkey PRIMARY KEY (id);


--
-- Name: audit_logs audit_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT audit_logs_pkey PRIMARY KEY (id);


--
-- Name: certifications certifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.certifications
    ADD CONSTRAINT certifications_pkey PRIMARY KEY (id);


--
-- Name: education education_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.education
    ADD CONSTRAINT education_pkey PRIMARY KEY (id);


--
-- Name: experience experience_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.experience
    ADD CONSTRAINT experience_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: media_assets media_assets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.media_assets
    ADD CONSTRAINT media_assets_pkey PRIMARY KEY (id);


--
-- Name: media_assets media_assets_public_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.media_assets
    ADD CONSTRAINT media_assets_public_id_key UNIQUE (public_id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: profile profile_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profile
    ADD CONSTRAINT profile_pkey PRIMARY KEY (id);


--
-- Name: project_case_studies project_case_studies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_case_studies
    ADD CONSTRAINT project_case_studies_pkey PRIMARY KEY (project_id);


--
-- Name: project_skills project_skills_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_skills
    ADD CONSTRAINT project_skills_pkey PRIMARY KEY (project_id, skill_id);


--
-- Name: project_technology_map project_tag_map_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_technology_map
    ADD CONSTRAINT project_tag_map_pkey PRIMARY KEY (project_id, technology_id);


--
-- Name: technologies project_tags_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.technologies
    ADD CONSTRAINT project_tags_name_key UNIQUE (name);


--
-- Name: technologies project_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.technologies
    ADD CONSTRAINT project_tags_pkey PRIMARY KEY (id);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_token_hash_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_hash_key UNIQUE (token_hash);


--
-- Name: resume_versions resume_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resume_versions
    ADD CONSTRAINT resume_versions_pkey PRIMARY KEY (id);


--
-- Name: seo_settings seo_settings_page_key_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.seo_settings
    ADD CONSTRAINT seo_settings_page_key_key UNIQUE (page_key);


--
-- Name: seo_settings seo_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.seo_settings
    ADD CONSTRAINT seo_settings_pkey PRIMARY KEY (id);


--
-- Name: site_settings site_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.site_settings
    ADD CONSTRAINT site_settings_pkey PRIMARY KEY (id);


--
-- Name: site_settings site_settings_setting_key_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.site_settings
    ADD CONSTRAINT site_settings_setting_key_key UNIQUE (setting_key);


--
-- Name: skills skills_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.skills
    ADD CONSTRAINT skills_name_key UNIQUE (name);


--
-- Name: skills skills_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.skills
    ADD CONSTRAINT skills_pkey PRIMARY KEY (id);


--
-- Name: social_links social_links_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.social_links
    ADD CONSTRAINT social_links_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX flyway_schema_history_s_idx ON public.flyway_schema_history USING btree (success);


--
-- Name: idx_analytics_project_created; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_analytics_project_created ON public.analytics_events USING btree (project_id, created_at DESC);


--
-- Name: idx_analytics_type_created; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_analytics_type_created ON public.analytics_events USING btree (event_type, created_at DESC);


--
-- Name: idx_audit_logs_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_audit_logs_created_at ON public.audit_logs USING btree (created_at);


--
-- Name: idx_audit_logs_user_email; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_audit_logs_user_email ON public.audit_logs USING btree (user_email);


--
-- Name: idx_certifications_order; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_certifications_order ON public.certifications USING btree (display_order);


--
-- Name: idx_education_order; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_education_order ON public.education USING btree (display_order);


--
-- Name: idx_experience_order; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_experience_order ON public.experience USING btree (display_order);


--
-- Name: idx_media_assets_folder_created; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_media_assets_folder_created ON public.media_assets USING btree (folder, created_at DESC);


--
-- Name: idx_messages_read_created; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_messages_read_created ON public.messages USING btree (read, created_at DESC);


--
-- Name: idx_notifications_read_created; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_notifications_read_created ON public.notifications USING btree (read, created_at DESC);


--
-- Name: idx_project_technology_map_project; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_project_technology_map_project ON public.project_technology_map USING btree (project_id);


--
-- Name: idx_project_technology_map_technology; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_project_technology_map_technology ON public.project_technology_map USING btree (technology_id);


--
-- Name: idx_projects_featured_order; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_projects_featured_order ON public.projects USING btree (featured, display_order);


--
-- Name: idx_refresh_tokens_expiry; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_refresh_tokens_expiry ON public.refresh_tokens USING btree (expires_at);


--
-- Name: idx_refresh_tokens_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_refresh_tokens_user ON public.refresh_tokens USING btree (user_id);


--
-- Name: idx_resume_active; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_resume_active ON public.resume_versions USING btree (active, created_at DESC);


--
-- Name: idx_social_links_visible_order; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_social_links_visible_order ON public.social_links USING btree (visible, display_order);


--
-- Name: analytics_events analytics_events_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.analytics_events
    ADD CONSTRAINT analytics_events_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id) ON DELETE SET NULL;


--
-- Name: project_case_studies project_case_studies_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_case_studies
    ADD CONSTRAINT project_case_studies_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id) ON DELETE CASCADE;


--
-- Name: project_skills project_skills_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_skills
    ADD CONSTRAINT project_skills_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id) ON DELETE CASCADE;


--
-- Name: project_skills project_skills_skill_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_skills
    ADD CONSTRAINT project_skills_skill_id_fkey FOREIGN KEY (skill_id) REFERENCES public.skills(id) ON DELETE CASCADE;


--
-- Name: project_technology_map project_tag_map_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_technology_map
    ADD CONSTRAINT project_tag_map_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id) ON DELETE CASCADE;


--
-- Name: project_technology_map project_tag_map_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_technology_map
    ADD CONSTRAINT project_tag_map_tag_id_fkey FOREIGN KEY (technology_id) REFERENCES public.technologies(id) ON DELETE CASCADE;


--
-- Name: refresh_tokens refresh_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.refresh_tokens
    ADD CONSTRAINT refresh_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict VQKzS5myrJ98lXTX1YYT8Xn5waDBw8u6KDL4fjxZVPDudhRE5gE6xH0SovTnoAj

