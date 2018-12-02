--
-- PostgreSQL database dump
--

-- Dumped from database version 11.0 (Debian 11.0-1.pgdg90+2)
-- Dumped by pg_dump version 11.0 (Debian 11.0-1.pgdg90+2)

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
-- Name: pyconcz; Type: SCHEMA; Schema: -; Owner: pyconcz
--

CREATE SCHEMA pyconcz;


ALTER SCHEMA pyconcz OWNER TO pyconcz;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: announcements_announcement; Type: TABLE; Schema: pyconcz; Owner: pyconcz
--

CREATE TABLE pyconcz.announcements_announcement (
    id integer NOT NULL,
    message text NOT NULL,
    is_public boolean NOT NULL,
    "position" smallint NOT NULL,
    CONSTRAINT announcements_announcement_position_check CHECK (("position" >= 0))
);


ALTER TABLE pyconcz.announcements_announcement OWNER TO pyconcz;

--
-- Name: announcements_announcement_id_seq; Type: SEQUENCE; Schema: pyconcz; Owner: pyconcz
--

CREATE SEQUENCE pyconcz.announcements_announcement_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pyconcz.announcements_announcement_id_seq OWNER TO pyconcz;

--
-- Name: announcements_announcement_id_seq; Type: SEQUENCE OWNED BY; Schema: pyconcz; Owner: pyconcz
--

ALTER SEQUENCE pyconcz.announcements_announcement_id_seq OWNED BY pyconcz.announcements_announcement.id;


--
-- Name: auth_group; Type: TABLE; Schema: pyconcz; Owner: pyconcz
--

CREATE TABLE pyconcz.auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE pyconcz.auth_group OWNER TO pyconcz;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: pyconcz; Owner: pyconcz
--

CREATE SEQUENCE pyconcz.auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pyconcz.auth_group_id_seq OWNER TO pyconcz;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: pyconcz; Owner: pyconcz
--

ALTER SEQUENCE pyconcz.auth_group_id_seq OWNED BY pyconcz.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: pyconcz; Owner: pyconcz
--

CREATE TABLE pyconcz.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE pyconcz.auth_group_permissions OWNER TO pyconcz;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: pyconcz; Owner: pyconcz
--

CREATE SEQUENCE pyconcz.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pyconcz.auth_group_permissions_id_seq OWNER TO pyconcz;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: pyconcz; Owner: pyconcz
--

ALTER SEQUENCE pyconcz.auth_group_permissions_id_seq OWNED BY pyconcz.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: pyconcz; Owner: pyconcz
--

CREATE TABLE pyconcz.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE pyconcz.auth_permission OWNER TO pyconcz;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: pyconcz; Owner: pyconcz
--

CREATE SEQUENCE pyconcz.auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pyconcz.auth_permission_id_seq OWNER TO pyconcz;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: pyconcz; Owner: pyconcz
--

ALTER SEQUENCE pyconcz.auth_permission_id_seq OWNED BY pyconcz.auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: pyconcz; Owner: pyconcz
--

CREATE TABLE pyconcz.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE pyconcz.auth_user OWNER TO pyconcz;

--
-- Name: auth_user_groups; Type: TABLE; Schema: pyconcz; Owner: pyconcz
--

CREATE TABLE pyconcz.auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE pyconcz.auth_user_groups OWNER TO pyconcz;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: pyconcz; Owner: pyconcz
--

CREATE SEQUENCE pyconcz.auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pyconcz.auth_user_groups_id_seq OWNER TO pyconcz;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: pyconcz; Owner: pyconcz
--

ALTER SEQUENCE pyconcz.auth_user_groups_id_seq OWNED BY pyconcz.auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: pyconcz; Owner: pyconcz
--

CREATE SEQUENCE pyconcz.auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pyconcz.auth_user_id_seq OWNER TO pyconcz;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: pyconcz; Owner: pyconcz
--

ALTER SEQUENCE pyconcz.auth_user_id_seq OWNED BY pyconcz.auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: pyconcz; Owner: pyconcz
--

CREATE TABLE pyconcz.auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE pyconcz.auth_user_user_permissions OWNER TO pyconcz;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: pyconcz; Owner: pyconcz
--

CREATE SEQUENCE pyconcz.auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pyconcz.auth_user_user_permissions_id_seq OWNER TO pyconcz;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: pyconcz; Owner: pyconcz
--

ALTER SEQUENCE pyconcz.auth_user_user_permissions_id_seq OWNED BY pyconcz.auth_user_user_permissions.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: pyconcz; Owner: pyconcz
--

CREATE TABLE pyconcz.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE pyconcz.django_admin_log OWNER TO pyconcz;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: pyconcz; Owner: pyconcz
--

CREATE SEQUENCE pyconcz.django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pyconcz.django_admin_log_id_seq OWNER TO pyconcz;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: pyconcz; Owner: pyconcz
--

ALTER SEQUENCE pyconcz.django_admin_log_id_seq OWNED BY pyconcz.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: pyconcz; Owner: pyconcz
--

CREATE TABLE pyconcz.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE pyconcz.django_content_type OWNER TO pyconcz;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: pyconcz; Owner: pyconcz
--

CREATE SEQUENCE pyconcz.django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pyconcz.django_content_type_id_seq OWNER TO pyconcz;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: pyconcz; Owner: pyconcz
--

ALTER SEQUENCE pyconcz.django_content_type_id_seq OWNED BY pyconcz.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: pyconcz; Owner: pyconcz
--

CREATE TABLE pyconcz.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE pyconcz.django_migrations OWNER TO pyconcz;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: pyconcz; Owner: pyconcz
--

CREATE SEQUENCE pyconcz.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pyconcz.django_migrations_id_seq OWNER TO pyconcz;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: pyconcz; Owner: pyconcz
--

ALTER SEQUENCE pyconcz.django_migrations_id_seq OWNED BY pyconcz.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: pyconcz; Owner: pyconcz
--

CREATE TABLE pyconcz.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE pyconcz.django_session OWNER TO pyconcz;

--
-- Name: django_site; Type: TABLE; Schema: pyconcz; Owner: pyconcz
--

CREATE TABLE pyconcz.django_site (
    id integer NOT NULL,
    domain character varying(100) NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE pyconcz.django_site OWNER TO pyconcz;

--
-- Name: django_site_id_seq; Type: SEQUENCE; Schema: pyconcz; Owner: pyconcz
--

CREATE SEQUENCE pyconcz.django_site_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pyconcz.django_site_id_seq OWNER TO pyconcz;

--
-- Name: django_site_id_seq; Type: SEQUENCE OWNED BY; Schema: pyconcz; Owner: pyconcz
--

ALTER SEQUENCE pyconcz.django_site_id_seq OWNED BY pyconcz.django_site.id;


--
-- Name: programme_slot; Type: TABLE; Schema: pyconcz; Owner: pyconcz
--

CREATE TABLE pyconcz.programme_slot (
    id integer NOT NULL,
    date timestamp with time zone NOT NULL,
    object_id integer,
    description character varying(100) NOT NULL,
    room smallint NOT NULL,
    content_type_id integer,
    CONSTRAINT programme_slot_object_id_check CHECK ((object_id >= 0)),
    CONSTRAINT programme_slot_room_check CHECK ((room >= 0))
);


ALTER TABLE pyconcz.programme_slot OWNER TO pyconcz;

--
-- Name: programme_slot_id_seq; Type: SEQUENCE; Schema: pyconcz; Owner: pyconcz
--

CREATE SEQUENCE pyconcz.programme_slot_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pyconcz.programme_slot_id_seq OWNER TO pyconcz;

--
-- Name: programme_slot_id_seq; Type: SEQUENCE OWNED BY; Schema: pyconcz; Owner: pyconcz
--

ALTER SEQUENCE pyconcz.programme_slot_id_seq OWNED BY pyconcz.programme_slot.id;


--
-- Name: programme_speaker; Type: TABLE; Schema: pyconcz; Owner: pyconcz
--

CREATE TABLE pyconcz.programme_speaker (
    id integer NOT NULL,
    full_name character varying(200) NOT NULL,
    bio text NOT NULL,
    twitter character varying(255) NOT NULL,
    github character varying(255) NOT NULL,
    email character varying(254) NOT NULL,
    photo character varying(100) NOT NULL,
    display_position smallint NOT NULL,
    is_public boolean NOT NULL,
    short_bio text NOT NULL,
    CONSTRAINT programme_speaker_display_position_check CHECK ((display_position >= 0))
);


ALTER TABLE pyconcz.programme_speaker OWNER TO pyconcz;

--
-- Name: programme_speaker_id_seq; Type: SEQUENCE; Schema: pyconcz; Owner: pyconcz
--

CREATE SEQUENCE pyconcz.programme_speaker_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pyconcz.programme_speaker_id_seq OWNER TO pyconcz;

--
-- Name: programme_speaker_id_seq; Type: SEQUENCE OWNED BY; Schema: pyconcz; Owner: pyconcz
--

ALTER SEQUENCE pyconcz.programme_speaker_id_seq OWNED BY pyconcz.programme_speaker.id;


--
-- Name: programme_speaker_talks; Type: TABLE; Schema: pyconcz; Owner: pyconcz
--

CREATE TABLE pyconcz.programme_speaker_talks (
    id integer NOT NULL,
    speaker_id integer NOT NULL,
    talk_id integer NOT NULL
);


ALTER TABLE pyconcz.programme_speaker_talks OWNER TO pyconcz;

--
-- Name: programme_speaker_talks_id_seq; Type: SEQUENCE; Schema: pyconcz; Owner: pyconcz
--

CREATE SEQUENCE pyconcz.programme_speaker_talks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pyconcz.programme_speaker_talks_id_seq OWNER TO pyconcz;

--
-- Name: programme_speaker_talks_id_seq; Type: SEQUENCE OWNED BY; Schema: pyconcz; Owner: pyconcz
--

ALTER SEQUENCE pyconcz.programme_speaker_talks_id_seq OWNED BY pyconcz.programme_speaker_talks.id;


--
-- Name: programme_speaker_workshops; Type: TABLE; Schema: pyconcz; Owner: pyconcz
--

CREATE TABLE pyconcz.programme_speaker_workshops (
    id integer NOT NULL,
    speaker_id integer NOT NULL,
    workshop_id integer NOT NULL
);


ALTER TABLE pyconcz.programme_speaker_workshops OWNER TO pyconcz;

--
-- Name: programme_speaker_workshops_id_seq; Type: SEQUENCE; Schema: pyconcz; Owner: pyconcz
--

CREATE SEQUENCE pyconcz.programme_speaker_workshops_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pyconcz.programme_speaker_workshops_id_seq OWNER TO pyconcz;

--
-- Name: programme_speaker_workshops_id_seq; Type: SEQUENCE OWNED BY; Schema: pyconcz; Owner: pyconcz
--

ALTER SEQUENCE pyconcz.programme_speaker_workshops_id_seq OWNED BY pyconcz.programme_speaker_workshops.id;


--
-- Name: programme_talk; Type: TABLE; Schema: pyconcz; Owner: pyconcz
--

CREATE TABLE pyconcz.programme_talk (
    id integer NOT NULL,
    title character varying(200) NOT NULL,
    abstract text NOT NULL,
    language character varying(2) NOT NULL,
    difficulty character varying(10) NOT NULL,
    video_id character varying(100) NOT NULL,
    is_backup boolean NOT NULL,
    is_keynote boolean NOT NULL,
    is_public boolean NOT NULL,
    private_note text NOT NULL
);


ALTER TABLE pyconcz.programme_talk OWNER TO pyconcz;

--
-- Name: programme_talk_id_seq; Type: SEQUENCE; Schema: pyconcz; Owner: pyconcz
--

CREATE SEQUENCE pyconcz.programme_talk_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pyconcz.programme_talk_id_seq OWNER TO pyconcz;

--
-- Name: programme_talk_id_seq; Type: SEQUENCE OWNED BY; Schema: pyconcz; Owner: pyconcz
--

ALTER SEQUENCE pyconcz.programme_talk_id_seq OWNED BY pyconcz.programme_talk.id;


--
-- Name: programme_workshop; Type: TABLE; Schema: pyconcz; Owner: pyconcz
--

CREATE TABLE pyconcz.programme_workshop (
    id integer NOT NULL,
    type character varying(10) NOT NULL,
    title character varying(200) NOT NULL,
    abstract text NOT NULL,
    language character varying(2) NOT NULL,
    difficulty character varying(10) NOT NULL,
    length character varying(2) NOT NULL,
    is_backup boolean NOT NULL,
    is_public boolean NOT NULL,
    private_note text NOT NULL,
    registration character varying(10) NOT NULL
);


ALTER TABLE pyconcz.programme_workshop OWNER TO pyconcz;

--
-- Name: programme_workshop_id_seq; Type: SEQUENCE; Schema: pyconcz; Owner: pyconcz
--

CREATE SEQUENCE pyconcz.programme_workshop_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pyconcz.programme_workshop_id_seq OWNER TO pyconcz;

--
-- Name: programme_workshop_id_seq; Type: SEQUENCE OWNED BY; Schema: pyconcz; Owner: pyconcz
--

ALTER SEQUENCE pyconcz.programme_workshop_id_seq OWNED BY pyconcz.programme_workshop.id;


--
-- Name: proposals_financialaid; Type: TABLE; Schema: pyconcz; Owner: pyconcz
--

CREATE TABLE pyconcz.proposals_financialaid (
    id integer NOT NULL,
    note text NOT NULL,
    date timestamp with time zone NOT NULL,
    accepted boolean NOT NULL,
    full_name character varying(200) NOT NULL,
    email character varying(254) NOT NULL,
    amount character varying(255) NOT NULL,
    purpose text NOT NULL,
    community_involvement text,
    python_involvement character varying(400)
);


ALTER TABLE pyconcz.proposals_financialaid OWNER TO pyconcz;

--
-- Name: proposals_financialaid_id_seq; Type: SEQUENCE; Schema: pyconcz; Owner: pyconcz
--

CREATE SEQUENCE pyconcz.proposals_financialaid_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pyconcz.proposals_financialaid_id_seq OWNER TO pyconcz;

--
-- Name: proposals_financialaid_id_seq; Type: SEQUENCE OWNED BY; Schema: pyconcz; Owner: pyconcz
--

ALTER SEQUENCE pyconcz.proposals_financialaid_id_seq OWNED BY pyconcz.proposals_financialaid.id;


--
-- Name: proposals_ranking; Type: TABLE; Schema: pyconcz; Owner: pyconcz
--

CREATE TABLE pyconcz.proposals_ranking (
    id integer NOT NULL,
    object_id integer NOT NULL,
    content_type_id integer NOT NULL,
    CONSTRAINT proposals_ranking_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE pyconcz.proposals_ranking OWNER TO pyconcz;

--
-- Name: proposals_ranking_id_seq; Type: SEQUENCE; Schema: pyconcz; Owner: pyconcz
--

CREATE SEQUENCE pyconcz.proposals_ranking_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pyconcz.proposals_ranking_id_seq OWNER TO pyconcz;

--
-- Name: proposals_ranking_id_seq; Type: SEQUENCE OWNED BY; Schema: pyconcz; Owner: pyconcz
--

ALTER SEQUENCE pyconcz.proposals_ranking_id_seq OWNED BY pyconcz.proposals_ranking.id;


--
-- Name: proposals_score; Type: TABLE; Schema: pyconcz; Owner: pyconcz
--

CREATE TABLE pyconcz.proposals_score (
    id integer NOT NULL,
    value numeric(2,1),
    note text NOT NULL,
    ranking_id integer NOT NULL,
    user_id integer NOT NULL,
    CONSTRAINT proposals_score_value_check CHECK ((value >= (0)::numeric))
);


ALTER TABLE pyconcz.proposals_score OWNER TO pyconcz;

--
-- Name: proposals_score_id_seq; Type: SEQUENCE; Schema: pyconcz; Owner: pyconcz
--

CREATE SEQUENCE pyconcz.proposals_score_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pyconcz.proposals_score_id_seq OWNER TO pyconcz;

--
-- Name: proposals_score_id_seq; Type: SEQUENCE OWNED BY; Schema: pyconcz; Owner: pyconcz
--

ALTER SEQUENCE pyconcz.proposals_score_id_seq OWNED BY pyconcz.proposals_score.id;


--
-- Name: proposals_talk; Type: TABLE; Schema: pyconcz; Owner: pyconcz
--

CREATE TABLE pyconcz.proposals_talk (
    id integer NOT NULL,
    note text NOT NULL,
    date timestamp with time zone NOT NULL,
    accepted boolean NOT NULL,
    full_name character varying(200) NOT NULL,
    email character varying(254) NOT NULL,
    bio text NOT NULL,
    twitter character varying(255) NOT NULL,
    github character varying(255) NOT NULL,
    photo character varying(100) NOT NULL,
    title character varying(200) NOT NULL,
    abstract text NOT NULL,
    language character varying(2) NOT NULL,
    difficulty character varying(10) NOT NULL,
    finaid_details text,
    needs_finaid boolean NOT NULL,
    final_note text,
    referral_link character varying(200) NOT NULL,
    is_backup boolean NOT NULL,
    is_keynote boolean NOT NULL
);


ALTER TABLE pyconcz.proposals_talk OWNER TO pyconcz;

--
-- Name: proposals_talk_id_seq; Type: SEQUENCE; Schema: pyconcz; Owner: pyconcz
--

CREATE SEQUENCE pyconcz.proposals_talk_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pyconcz.proposals_talk_id_seq OWNER TO pyconcz;

--
-- Name: proposals_talk_id_seq; Type: SEQUENCE OWNED BY; Schema: pyconcz; Owner: pyconcz
--

ALTER SEQUENCE pyconcz.proposals_talk_id_seq OWNED BY pyconcz.proposals_talk.id;


--
-- Name: proposals_workshop; Type: TABLE; Schema: pyconcz; Owner: pyconcz
--

CREATE TABLE pyconcz.proposals_workshop (
    id integer NOT NULL,
    note text NOT NULL,
    date timestamp with time zone NOT NULL,
    accepted boolean NOT NULL,
    full_name character varying(200) NOT NULL,
    email character varying(254) NOT NULL,
    bio text NOT NULL,
    twitter character varying(255) NOT NULL,
    github character varying(255) NOT NULL,
    photo character varying(100) NOT NULL,
    type character varying(10) NOT NULL,
    title character varying(200) NOT NULL,
    abstract text NOT NULL,
    language character varying(2) NOT NULL,
    difficulty character varying(10) NOT NULL,
    length character varying(2) NOT NULL,
    finaid_details text,
    needs_finaid boolean NOT NULL,
    final_note text,
    referral_link character varying(200) NOT NULL,
    requirements text,
    is_backup boolean NOT NULL
);


ALTER TABLE pyconcz.proposals_workshop OWNER TO pyconcz;

--
-- Name: proposals_workshop_id_seq; Type: SEQUENCE; Schema: pyconcz; Owner: pyconcz
--

CREATE SEQUENCE pyconcz.proposals_workshop_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pyconcz.proposals_workshop_id_seq OWNER TO pyconcz;

--
-- Name: proposals_workshop_id_seq; Type: SEQUENCE OWNED BY; Schema: pyconcz; Owner: pyconcz
--

ALTER SEQUENCE pyconcz.proposals_workshop_id_seq OWNED BY pyconcz.proposals_workshop.id;


--
-- Name: sponsors_sponsor; Type: TABLE; Schema: pyconcz; Owner: pyconcz
--

CREATE TABLE pyconcz.sponsors_sponsor (
    id integer NOT NULL,
    level smallint NOT NULL,
    name character varying(200) NOT NULL,
    logo character varying(100) NOT NULL,
    description text NOT NULL,
    link_url character varying(200) NOT NULL,
    published boolean NOT NULL,
    facebook character varying(200),
    twitter character varying(200),
    CONSTRAINT sponsors_sponsor_level_check CHECK ((level >= 0))
);


ALTER TABLE pyconcz.sponsors_sponsor OWNER TO pyconcz;

--
-- Name: sponsors_sponsor_id_seq; Type: SEQUENCE; Schema: pyconcz; Owner: pyconcz
--

CREATE SEQUENCE pyconcz.sponsors_sponsor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pyconcz.sponsors_sponsor_id_seq OWNER TO pyconcz;

--
-- Name: sponsors_sponsor_id_seq; Type: SEQUENCE OWNED BY; Schema: pyconcz; Owner: pyconcz
--

ALTER SEQUENCE pyconcz.sponsors_sponsor_id_seq OWNED BY pyconcz.sponsors_sponsor.id;


--
-- Name: team_organizer; Type: TABLE; Schema: pyconcz; Owner: pyconcz
--

CREATE TABLE pyconcz.team_organizer (
    id integer NOT NULL,
    full_name character varying(200) NOT NULL,
    email character varying(254) NOT NULL,
    twitter character varying(255) NOT NULL,
    github character varying(255) NOT NULL,
    photo character varying(100) NOT NULL,
    published boolean NOT NULL
);


ALTER TABLE pyconcz.team_organizer OWNER TO pyconcz;

--
-- Name: team_organizer_id_seq; Type: SEQUENCE; Schema: pyconcz; Owner: pyconcz
--

CREATE SEQUENCE pyconcz.team_organizer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pyconcz.team_organizer_id_seq OWNER TO pyconcz;

--
-- Name: team_organizer_id_seq; Type: SEQUENCE OWNED BY; Schema: pyconcz; Owner: pyconcz
--

ALTER SEQUENCE pyconcz.team_organizer_id_seq OWNED BY pyconcz.team_organizer.id;


--
-- Name: announcements_announcement id; Type: DEFAULT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.announcements_announcement ALTER COLUMN id SET DEFAULT nextval('pyconcz.announcements_announcement_id_seq'::regclass);


--
-- Name: auth_group id; Type: DEFAULT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.auth_group ALTER COLUMN id SET DEFAULT nextval('pyconcz.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('pyconcz.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.auth_permission ALTER COLUMN id SET DEFAULT nextval('pyconcz.auth_permission_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.auth_user ALTER COLUMN id SET DEFAULT nextval('pyconcz.auth_user_id_seq'::regclass);


--
-- Name: auth_user_groups id; Type: DEFAULT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('pyconcz.auth_user_groups_id_seq'::regclass);


--
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('pyconcz.auth_user_user_permissions_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.django_admin_log ALTER COLUMN id SET DEFAULT nextval('pyconcz.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.django_content_type ALTER COLUMN id SET DEFAULT nextval('pyconcz.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.django_migrations ALTER COLUMN id SET DEFAULT nextval('pyconcz.django_migrations_id_seq'::regclass);


--
-- Name: django_site id; Type: DEFAULT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.django_site ALTER COLUMN id SET DEFAULT nextval('pyconcz.django_site_id_seq'::regclass);


--
-- Name: programme_slot id; Type: DEFAULT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.programme_slot ALTER COLUMN id SET DEFAULT nextval('pyconcz.programme_slot_id_seq'::regclass);


--
-- Name: programme_speaker id; Type: DEFAULT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.programme_speaker ALTER COLUMN id SET DEFAULT nextval('pyconcz.programme_speaker_id_seq'::regclass);


--
-- Name: programme_speaker_talks id; Type: DEFAULT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.programme_speaker_talks ALTER COLUMN id SET DEFAULT nextval('pyconcz.programme_speaker_talks_id_seq'::regclass);


--
-- Name: programme_speaker_workshops id; Type: DEFAULT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.programme_speaker_workshops ALTER COLUMN id SET DEFAULT nextval('pyconcz.programme_speaker_workshops_id_seq'::regclass);


--
-- Name: programme_talk id; Type: DEFAULT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.programme_talk ALTER COLUMN id SET DEFAULT nextval('pyconcz.programme_talk_id_seq'::regclass);


--
-- Name: programme_workshop id; Type: DEFAULT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.programme_workshop ALTER COLUMN id SET DEFAULT nextval('pyconcz.programme_workshop_id_seq'::regclass);


--
-- Name: proposals_financialaid id; Type: DEFAULT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.proposals_financialaid ALTER COLUMN id SET DEFAULT nextval('pyconcz.proposals_financialaid_id_seq'::regclass);


--
-- Name: proposals_ranking id; Type: DEFAULT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.proposals_ranking ALTER COLUMN id SET DEFAULT nextval('pyconcz.proposals_ranking_id_seq'::regclass);


--
-- Name: proposals_score id; Type: DEFAULT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.proposals_score ALTER COLUMN id SET DEFAULT nextval('pyconcz.proposals_score_id_seq'::regclass);


--
-- Name: proposals_talk id; Type: DEFAULT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.proposals_talk ALTER COLUMN id SET DEFAULT nextval('pyconcz.proposals_talk_id_seq'::regclass);


--
-- Name: proposals_workshop id; Type: DEFAULT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.proposals_workshop ALTER COLUMN id SET DEFAULT nextval('pyconcz.proposals_workshop_id_seq'::regclass);


--
-- Name: sponsors_sponsor id; Type: DEFAULT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.sponsors_sponsor ALTER COLUMN id SET DEFAULT nextval('pyconcz.sponsors_sponsor_id_seq'::regclass);


--
-- Name: team_organizer id; Type: DEFAULT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.team_organizer ALTER COLUMN id SET DEFAULT nextval('pyconcz.team_organizer_id_seq'::regclass);


--
-- Data for Name: announcements_announcement; Type: TABLE DATA; Schema: pyconcz; Owner: pyconcz
--

COPY pyconcz.announcements_announcement (id, message, is_public, "position") FROM stdin;
6	🍕 Do you want pizza for the board game night? Make a mark on the paper near the entrance to the Main room! 🍕	f	2
4	Friday Board Game Night 🎲 is happening in the Main room after Lightning Talks ⚡️	f	4
8	Good morning! ☕️ 🍎	f	0
9	✨ Tweet about **#PyConCZ**! ✨  \r\nThree most liked posts get a **PyCharm** license.	f	0
7	Swag-caching! We hid some swag from our media partner JetBrains all around the venue. First find first served!	f	3
5	Register your lightning talks ⚡ Manually 🖋 Look for paper on a wall, on the left when entering the main room.	f	5
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: pyconcz; Owner: pyconcz
--

COPY pyconcz.auth_group (id, name) FROM stdin;
1	sponsors
2	team
3	proposals - no scoring
4	proposals
5	annoucements
6	programme
7	programme - talks & ws
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: pyconcz; Owner: pyconcz
--

COPY pyconcz.auth_group_permissions (id, group_id, permission_id) FROM stdin;
1	1	44
2	1	45
3	1	46
4	2	25
5	2	26
6	2	27
7	3	32
8	3	33
9	3	34
10	3	35
11	3	36
12	3	37
13	3	38
14	3	39
15	3	40
16	4	28
17	4	29
18	4	30
19	4	31
20	4	32
21	4	33
22	4	34
23	4	35
24	4	36
25	4	37
26	4	38
27	4	39
28	4	40
29	4	41
30	4	42
31	4	43
32	5	24
33	5	22
34	5	23
35	6	47
36	6	48
37	6	49
38	6	50
39	6	51
40	6	52
41	6	53
42	6	54
43	6	55
44	6	56
45	6	57
46	6	58
47	7	57
48	7	51
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: pyconcz; Owner: pyconcz
--

COPY pyconcz.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can add group	2	add_group
5	Can change group	2	change_group
6	Can delete group	2	delete_group
7	Can add user	3	add_user
8	Can change user	3	change_user
9	Can delete user	3	delete_user
10	Can add permission	4	add_permission
11	Can change permission	4	change_permission
12	Can delete permission	4	delete_permission
13	Can add content type	5	add_contenttype
14	Can change content type	5	change_contenttype
15	Can delete content type	5	delete_contenttype
16	Can add session	6	add_session
17	Can change session	6	change_session
18	Can delete session	6	delete_session
19	Can add site	7	add_site
20	Can change site	7	change_site
21	Can delete site	7	delete_site
22	Can add announcement	8	add_announcement
23	Can change announcement	8	change_announcement
24	Can delete announcement	8	delete_announcement
25	Can add organizer	9	add_organizer
26	Can change organizer	9	change_organizer
27	Can delete organizer	9	delete_organizer
28	Can add score	10	add_score
29	Can change score	10	change_score
30	Can delete score	10	delete_score
31	Can add score	10	can_add_score
32	Can add talk	11	add_talk
33	Can change talk	11	change_talk
34	Can delete talk	11	delete_talk
35	Can add workshop	12	add_workshop
36	Can change workshop	12	change_workshop
37	Can delete workshop	12	delete_workshop
38	Can add financial aid	13	add_financialaid
39	Can change financial aid	13	change_financialaid
40	Can delete financial aid	13	delete_financialaid
41	Can add ranking	14	add_ranking
42	Can change ranking	14	change_ranking
43	Can delete ranking	14	delete_ranking
44	Can add sponsor	15	add_sponsor
45	Can change sponsor	15	change_sponsor
46	Can delete sponsor	15	delete_sponsor
47	Can add speaker	16	add_speaker
48	Can change speaker	16	change_speaker
49	Can delete speaker	16	delete_speaker
50	Can add workshop	17	add_workshop
51	Can change workshop	17	change_workshop
52	Can delete workshop	17	delete_workshop
53	Can add slot	18	add_slot
54	Can change slot	18	change_slot
55	Can delete slot	18	delete_slot
56	Can add talk	19	add_talk
57	Can change talk	19	change_talk
58	Can delete talk	19	delete_talk
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: pyconcz; Owner: pyconcz
--

COPY pyconcz.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
15	<HASH>	2018-04-19 10:38:30.184392+00	f	olga			olgafomi4eva@gmail.com	t	t	2018-04-19 07:35:13+00
16	<HASH>	2018-04-19 10:59:51.404952+00	f	ivet	ivet		iveta@jelen.biz	t	t	2018-04-19 07:39:40+00
9	<HASH>	2018-05-17 20:42:39+00	f	veruu	veruu		veronicca114@gmail.com	t	t	2018-02-28 10:03:18+00
12	<HASH>	2018-03-22 18:45:33.35828+00	f	kvbik	kvbik			t	t	2018-03-01 13:19:05+00
11	<HASH>	2018-03-28 17:36:46.785084+00	f	honzakral	honza	kral		t	t	2018-03-01 13:13:58+00
10	<HASH>	2018-05-04 10:37:18.006083+00	f	aleszoulek	alesek		ales.zoulek@gmail.com	t	t	2018-02-28 10:16:42+00
2	<HASH>	2018-05-25 10:27:48.609963+00	f	daria	Bara	Diva	dariathedaria@gmail.com	t	t	2018-01-16 23:14:15+00
13	<HASH>	2018-03-11 17:09:19.857377+00	f	tricoder	tricoder			t	t	2018-03-01 18:18:04+00
8	<HASH>	2018-05-27 10:02:09.201305+00	f	frenzy	frenzy	madness	frenzy.madness@gmail.com	t	t	2018-02-28 10:02:01+00
14	<HASH>	2018-03-12 20:55:24.664744+00	f	whiskybar	jirik	barton		t	t	2018-03-12 20:53:48+00
5	<HASH>	2018-05-29 11:38:56.655652+00	f	kejbaly2	Chris		kejbaly2@gmail.com	t	t	2018-01-25 09:43:06+00
6	<HASH>	2018-05-31 12:57:35.735117+00	f	javor	javor	zeleny	mail@honzajavorek.cz	t	t	2018-02-28 09:56:23+00
7	<HASH>	2018-06-01 08:31:59+00	f	encukou	encukou		encukou@gmail.com	t	t	2018-02-28 10:00:38+00
17	<HASH>	2018-06-01 09:57:33.220375+00	f	anezkamll	Anežka	Muller	anezka.muller@gmail.com	t	t	2018-05-24 12:58:44+00
4	<HASH>	2018-06-07 11:42:30.40061+00	f	miro	Miro	Hroncok	miro@hroncok.cz	t	t	2018-01-16 23:28:39+00
3	<HASH>	2018-10-25 08:43:23.63857+00	f	benabraham	Dan	Srb	srbdan@gmail.com	t	t	2018-01-16 23:14:31+00
1	<HASH>	2018-11-05 13:18:06.410662+00	t	starenka	starenka	.	starenka0@gmail.com	t	t	2018-01-16 23:03:12+00
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: pyconcz; Owner: pyconcz
--

COPY pyconcz.auth_user_groups (id, user_id, group_id) FROM stdin;
1	3	1
2	3	2
3	3	3
4	2	1
5	2	2
6	2	3
7	4	1
8	4	2
9	4	4
10	5	1
11	6	4
12	6	5
13	7	4
14	8	4
15	9	4
16	10	4
17	11	4
18	12	4
19	13	4
20	14	4
21	4	6
22	3	6
23	10	6
24	2	6
25	9	6
26	15	7
27	16	7
28	17	5
29	3	5
30	2	5
31	9	5
32	7	5
33	4	5
34	7	6
35	7	7
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: pyconcz; Owner: pyconcz
--

COPY pyconcz.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
7	2	22
8	2	23
9	2	24
10	2	25
11	2	26
12	2	27
13	2	32
14	2	33
15	2	34
16	2	35
17	2	36
18	2	37
19	2	38
20	2	39
21	2	40
22	2	44
23	2	45
24	2	46
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: pyconcz; Owner: pyconcz
--

COPY pyconcz.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: pyconcz; Owner: pyconcz
--

COPY pyconcz.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	group
3	auth	user
4	auth	permission
5	contenttypes	contenttype
6	sessions	session
7	sites	site
8	announcements	announcement
9	team	organizer
10	proposals	score
11	proposals	talk
12	proposals	workshop
13	proposals	financialaid
14	proposals	ranking
15	sponsors	sponsor
16	programme	speaker
17	programme	workshop
18	programme	slot
19	programme	talk
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: pyconcz; Owner: pyconcz
--

COPY pyconcz.django_migrations (id, app, name, applied) FROM stdin;
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: pyconcz; Owner: pyconcz
--

COPY pyconcz.django_session (session_key, session_data, expire_date) FROM stdin;
\.


--
-- Data for Name: django_site; Type: TABLE DATA; Schema: pyconcz; Owner: pyconcz
--

COPY pyconcz.django_site (id, domain, name) FROM stdin;
1	example.com	example.com
\.


--
-- Data for Name: programme_slot; Type: TABLE DATA; Schema: pyconcz; Owner: pyconcz
--

COPY pyconcz.programme_slot (id, date, object_id, description, room, content_type_id) FROM stdin;
173	2018-06-02 11:00:00+00	\N	Lunch	1	\N
171	2018-06-01 11:00:00+00	\N	Lunch	2	\N
172	2018-06-01 14:05:00+00	\N	Coffee Break	1	\N
180	2018-06-01 16:00:00+00	\N	Lightning Talks	1	\N
197	2018-06-01 12:40:00+00	\N	Break	1	\N
192	2018-06-01 13:25:00+00	\N	Break	2	\N
237	2018-06-01 13:25:00+00	\N	Break	1	\N
238	2018-06-01 12:40:00+00	\N	Break	1	18
239	2018-06-02 13:25:00+00	\N	Break	1	18
195	2018-06-01 07:00:00+00	\N	Registration opens / Breakfast	2	\N
200	2018-06-02 07:00:00+00	\N	Registration opens / Breakfast	1	\N
201	2018-06-02 07:00:00+00	\N	Registration opens / Breakfast	2	\N
144	2018-06-01 09:40:00+00	28		2	19
143	2018-06-01 09:40:00+00	27		1	19
133	2018-06-01 09:00:00+00	6		1	19
196	2018-06-01 08:00:00+00	\N	Welcome to PyCon CZ	1	\N
193	2018-06-02 11:00:00+00	\N	Lunch	2	\N
179	2018-06-01 08:55:00+00	\N	Break	1	\N
178	2018-06-01 09:35:00+00	\N	Break	1	\N
177	2018-06-01 10:15:00+00	\N	Break	1	\N
241	2018-06-02 17:00:00+00	\N	Closing ceremony	1	\N
243	2018-06-02 17:20:00+00	\N	Afterparty!<br>Till you drop or 3 am<br>(whichever comes first).	1	\N
139	2018-06-01 10:25:00+00	20		2	19
126	2018-06-01 10:25:00+00	34		1	19
194	2018-06-01 07:00:00+00	\N	Registration opens / Breakfast	1	\N
247	2018-06-03 07:30:00+00	\N	Breakfast	20	\N
248	2018-06-03 07:30:00+00	\N	Breakfast	20	\N
242	2018-06-01 17:10:00+00	\N	board_game_night	1	\N
127	2018-06-02 08:15:00+00	32		1	19
148	2018-06-02 09:40:00+00	2		2	19
142	2018-06-01 08:15:00+00	31		1	19
153	2018-06-02 12:00:00+00	33		1	19
122	2018-06-01 12:00:00+00	30		1	19
152	2018-06-02 13:30:00+00	36		1	19
240	2018-06-03 15:00:00+00	\N	The End	1	\N
188	2018-06-01 08:55:00+00	\N	Break	2	\N
187	2018-06-01 09:35:00+00	\N	Break	2	\N
186	2018-06-01 10:15:00+00	\N	Break	2	\N
134	2018-06-01 09:00:00+00	9		2	19
183	2018-06-01 11:00:00+00	\N	Lunch	1	\N
155	2018-06-02 10:25:00+00	3		2	19
164	2018-06-01 07:00:00+00	13		50	17
150	2018-06-01 12:50:00+00	25		1	19
130	2018-06-01 12:50:00+00	4		2	19
154	2018-06-01 13:30:00+00	15		1	19
135	2018-06-01 13:30:00+00	11		2	19
176	2018-06-01 14:05:00+00	\N	Coffee Break	2	\N
151	2018-06-01 14:35:00+00	17		1	19
138	2018-06-01 14:35:00+00	21		2	19
175	2018-06-01 15:10:00+00	\N	Break	1	\N
190	2018-06-01 15:10:00+00	\N	Break	2	\N
149	2018-06-01 15:20:00+00	22		1	19
132	2018-06-01 15:20:00+00	1		2	19
174	2018-06-01 15:55:00+00	\N	Break	1	\N
202	2018-06-02 08:00:00+00	\N	Welcome to PyCon CZ	1	\N
203	2018-06-02 08:55:00+00	\N	Break	1	\N
204	2018-06-02 08:55:00+00	\N	Break	2	\N
146	2018-06-02 09:00:00+00	13		2	19
125	2018-06-02 09:00:00+00	7		1	19
131	2018-06-02 09:40:00+00	23		1	19
129	2018-06-02 10:25:00+00	24		1	19
205	2018-06-02 09:35:00+00	\N	Break	1	\N
206	2018-06-02 09:35:00+00	\N	Break	2	\N
207	2018-06-02 10:15:00+00	\N	Break	1	\N
208	2018-06-02 10:15:00+00	\N	Break	2	\N
141	2018-06-02 12:50:00+00	10		2	19
124	2018-06-02 12:50:00+00	16		1	19
209	2018-06-02 12:40:00+00	\N	Break	1	\N
210	2018-06-02 12:40:00+00	\N	Break	2	\N
212	2018-06-02 13:25:00+00	\N	Break	2	\N
128	2018-06-02 13:30:00+00	5		2	19
123	2018-06-02 14:35:00+00	12		1	19
137	2018-06-02 14:35:00+00	14		2	19
147	2018-06-02 15:20:00+00	26		1	19
140	2018-06-02 15:20:00+00	18		2	19
213	2018-06-02 14:05:00+00	\N	Coffee Break	1	\N
214	2018-06-02 14:05:00+00	\N	Coffee Break	2	\N
215	2018-06-02 15:10:00+00	\N	Break	1	\N
216	2018-06-02 15:10:00+00	\N	Break	2	\N
217	2018-06-02 15:55:00+00	\N	Break	1	\N
219	2018-06-02 16:00:00+00	\N	Lightning Talks	1	\N
170	2018-06-03 08:00:00+00	5		9	17
169	2018-06-03 12:00:00+00	12		9	17
168	2018-06-03 08:00:00+00	15		8	17
167	2018-06-03 12:00:00+00	8		7	17
166	2018-06-03 12:00:00+00	14		5	17
165	2018-06-03 08:00:00+00	6		6	17
163	2018-06-03 08:00:00+00	3		5	17
162	2018-06-03 12:00:00+00	9		10	17
161	2018-06-03 08:00:00+00	4		10	17
160	2018-06-03 08:00:00+00	11		7	17
159	2018-06-03 12:00:00+00	10		4	17
158	2018-06-03 08:00:00+00	2		4	17
157	2018-06-03 09:00:00+00	7		20	17
222	2018-06-03 12:00:00+00	7		20	17
244	2018-06-03 11:00:00+00	\N	Lunch	1	\N
246	2018-06-03 08:00:00+00	\N	Sprints	20	\N
245	2018-06-03 12:00:00+00	\N	Sprints	20	\N
156	2018-06-03 12:00:00+00	1		11	17
\.


--
-- Data for Name: programme_speaker; Type: TABLE DATA; Schema: pyconcz; Owner: pyconcz
--

COPY pyconcz.programme_speaker (id, full_name, bio, twitter, github, email, photo, display_position, is_public, short_bio) FROM stdin;
7	Ann Barcomb	I am a PhD candidate researching managing episodic (casual) contributions in free/libre and open source software communities. \r\n\r\nBefore becoming a researcher, I worked as a community manager and as a software developer, and contributed to free software projects, mostly in the areas of conference organization, mailing list summaries, and speaking at conferences. \r\n\r\nMy research topic is a long-term interest and a passion, and I combine academic findings with personal experience.	ae3nn		redacted@bro.cz	programme/pyconcz2018/ann-barcomb-01.jpg	111	t	
52	Petr Šimeček	I worked for ten years as a biostatistician. Now I'm trying to be a data scientist/quantitative analyst at Google and not to lose my mind. Most of my data look like a line with a bump in the middle (aka time series).	python_tip	simecek	redacted@bro.cz	programme/pyconcz2018/petr-simecek-01.jpg	111	t	
10	Igor Davydenko	I am a Python developer for last 11 years and I used to be a huge Flask fanboy, who trusted in Flask and its extensions. I created or maintained Flask-And-Redis, Flask-FlatPages, Flask-LazyViews, and Flask-Dropbox extensions.\r\n\r\nRecently I switched to Python 3 and Asyncio stack on backend and with React.js applications on frontend. Check my work on [rororo](https://github.com/playpauseandstop/rororo) project.\r\n\r\nI like making web applications and libraries for real world. I also like contributing to open source for all good things.	playpausenstop	playpauseandstop	redacted@bro.cz	programme/pyconcz2018/igor-davydenko-01.jpg	111	t	
13	Martin Javorek	Přes den vymýšlím jako analytik v bance nové systémy, v noci jsem podporou všech aktivit kolem programování dětí. \r\n\r\nVíce než 2 roky se věnuji studiu materiálů o programování dětí v jiných zemích, zkoumám novinky a píšu o nich. Jako technicko-administrativně-marketingová podpora pomáhám své ženě provozovat doma kroužky programování. Stal jsem se členem týmu projektu iMyšlení – podpora rozvoje informatického myšlení do škol.	programohrajeme	javorekm	redacted@bro.cz	programme/pyconcz2018/martin-javorek-01.jpg	111	t	
12	Robert Kuska	I am a software engineer at Kiwi.com. \r\n\r\nI used to know close to nothing about memory management until I decided to have a talk about it. Now I know a little bit more. \r\n\r\nIn my free time I embroider and ride a bike.	DasIstHerrKuska		redacted@bro.cz	programme/pyconcz2018/robert-kuska-01.jpg	111	t	
5	Stefan Behnel	I'm a long-time Python developer and probably best known in the community as a core developer of the [Cython](http://cython.org) and [lxml](http://lxml.de) projects.  \r\n\r\nI give trainings on Cython programming and enjoy telling people about it at conferences.			redacted@bro.cz	programme/pyconcz2018/stefan-behnel-01.jpg	111	t	
6	Tomáš Ehrlich	I'm a full-stack developer on a project which uses GraphQL - I'm dealing with this technology both from client and server perspective. \r\n\r\nEven after several months, I haven't lost the enthusiasm for this new technology and I consider it as a standard for implementing APIs in my projects.	tomas_ehrlich	tricoder42	redacted@bro.cz	programme/pyconcz2018/tomas-ehrlich-01.jpg	111	t	
3	Matěj Cepl	I was working for the last almost two years as a principal maintainer of the project M2Crypto on its reviving from the obsolescence it was before. \r\n\r\nOne of the main subprojects was porting it to be dual py2k-py3k compatible.	mcepl	mcepl	redacted@bro.cz	programme/pyconcz2018/matej-cepl-01.jpg	111	t	
4	Ondřej Kokeš	Economist by training, analyst and engineer by trade. \r\n\r\nI have been working with DataFrames over the past five years and faced issues scaling my workflows when dealing with data on the economy, energy, marketing, transactions, user behaviour, and a number of other areas, ranging from megabytes to _terabytes_ in size. \r\n\r\nI will try and outline the various ways one can tackle the issue of scale while keeping their usage patterns largely unchanged.	kondrej	kokes	redacted@bro.cz	programme/pyconcz2018/ondrej-kokes-03.jpg	111	t	
1	Małgorzata Niewiem	I am a graduate of Applied Computer Science with specialization in Geoinformatics and now I work as Python programmer in Kraków. \r\n\r\nI use Python to develop algorithms to monitor world from satellite images. I am currently working on new algorithms to assess risk of damage due to mining subsidence. \r\n\r\nAlso I am PhD student who loves scientific and technological challenges. I used any free moment on knowledge sharing – on conference and Python workshops. Privately admirer of the roller-skates, mountains and jelly beans.			redacted@bro.cz	programme/pyconcz2018/malgorzata-niewiem-01.jpg	111	t	
11	Tanya Tereshchenko	I'm a Software Engineer at Red Hat and a developer on [Pulp](https://pulpproject.org/) which is an open source Python project for managing Python packages among other types of software. \r\n\r\nI'm also open source enthusiast who also enjoys cycling, snowboarding and is interested in molecular biology.			redacted@bro.cz	programme/pyconcz2018/tanya-tereshchenko-01.jpg	111	t	
9	Thiago da Silva Alves	I like academic environments, so I am currently studying Computer Science at UTFPR and Masters in Information Systems at the Polytechnic Institute of Bragança - Portugal.\r\n\r\nAmong my main interests are artificial intelligence, bioinformatics and any other area with difficult problems to solve computationally.\r\n\r\nI am currently doing research with CIMO, where I use python to create tools that help researchers and beekeepers to preserve bees and increase their productivity. In my free time I also contribute with an AI group that I recently helped to create in the institution.		AvsThiago	redacted@bro.cz	programme/pyconcz2018/thiago-da-silva-alves-01.jpg	111	t	
23	Sasha Romijn	I've always been curious about many aspects of cryptography, both from a practical product development perspective, but also just out of interest. However, really didn't believe I could ever understand any of it. \r\n\r\nBy now, I know better and have found that many aspects really aren't that complicated. I'm also good at explaining these kinds of concepts.	mxsash	mxsasha	redacted@bro.cz	programme/pyconcz2018/sasha-romijn-01.jpg	111	t	
18	Rae Knowler	I'm a web developer in Zürich, where I develop product data APIs and work on Open Data projects. \r\n\r\nI am interested in the fascinating, comical and sometimes tragic results of attempting to cram the complexity of life and society into computer systems. \r\n\r\nIn my spare time, I read a lot of science fiction and hug cats.	RaeKnowler	bellisk	redacted@bro.cz	programme/pyconcz2018/rae-knowler-01.jpg	111	t	
17	Christian Heimes	I'm one of the maintainer of CPython's ssl module, contributor to _OpenSSL_, _PyOpenSSL_, and _PyCA Cryptography_. \r\n\r\nIn my day job at Red Hat, I'm a security engineer for identity management (freeIPA), public key infrastructure (Dogtag PKI), and related technologies.	ChristianHeimes	tiran	redacted@bro.cz	programme/pyconcz2018/christian-heimes-01.jpg	111	t	
34	Jáchym Čepický	Open source software for geospatial developer and advocate. Developer of server, desktop and web applications, using mostly Python. Open source software and open data promoter.	jachymc	jachym	redacted@bro.cz	programme/pyconcz2018/jachym-cepicky-01.jpg	111	t	
45	Gabriel Falcão	Python developer since 2006, creator of the Guake Terminal, Lettuce, HTTPretty and many other open-source libraries.\r\n\r\nI have been practicing test-driven python since 2008 and thought would be a great idea to create knock-off Python versions of Ruby test libraries such as RSpec and Cucumber.	gabrielfalcao	gabrielfalcao	redacted@bro.cz	programme/pyconcz2018/gabriel-falcao-01.jpg	111	t	
14	Stan Prokop	As a youngster I wanted to become a game developer, but (fortunately?) I happened to become a QA engineer, and I eventually transformed into a software engineer with strong testing background. \r\n\r\nMy past includes Centrum.cz, GoodData and Skype/Microsoft and I luckily end up between good folks at Accolade (not the game developer which no longer exists, but on-demand healthcare concierge). \r\n\r\nI have a wife, one kid, no dogs and no cats. I have no quirks. I just prefer to walk barefoot at home, in the office and sometimes outside.		prokopst	redacted@bro.cz	programme/pyconcz2018/stan-prokop-01.jpg	111	t	
20	Lukáš Kokoška	I've started my Python career with Python version 2.3 making SMS messaging and content management. As years passed I've worked on many projects in Seznam.cz and other companies.\r\n\r\nMy current title is Head of research and development and I'm working on topics like payment gateways, content repository, hi-perf messaging and HbbTV.	lukoko_name		redacted@bro.cz	programme/pyconcz2018/lukas-kokoska-01.jpg	111	t	
25	Claus Aichinger	I am a Data Scientist, instructor and (co)organizer of PyDays Vienna. \r\n\r\nI enjoy programming, computing and “structuring things” as well as learning and sharing insights and opinions.	clausaichinger	caichinger	redacted@bro.cz	programme/pyconcz2018/claus-aichinger-01.jpg	111	t	
15	Justin Mayer	I am an active open-source contributor and advocate for stronger security and privacy. \r\n\r\nMy latest projects include Monitorial.com, a solution for identifying and addressing potential security vulnerabilities, and Fortressa.com, which enables anyone to create their own private, self-contained VPN. I am the primary maintainer of the [Pelican](https://github.com/getpelican/pelican) static site generator, [Django-Elevate](https://github.com/getpelican/django-elevate), and various other open-source projects.\r\n\r\nI speak fluent Japanese and I can usually be found with a glass of Valpolicella in one hand, and Taleggio in the other. (Wine and cheese, respectively.)	jmayer	justinmayer	redacted@bro.cz	programme/pyconcz2018/justin-mayer-01.jpg	111	t	
22	Míla Votradovec	I am a developer with a passion for problem-solving, puzzles and guitar. I am a self-starter, who tried to complete formal education after years in a field. \r\n\r\nI have been working for corporates, small companies and startups. I still remember being completely fresh in the field. I was grateful for any guidance or advice, so I am trying to pay back by mentoring others. \r\n\r\nI currently live in London and work for [Snyk](https://snyk.io/), company which provides Security as a Service.	MilaVot	miiila	redacted@bro.cz	programme/pyconcz2018/mila-votradovec-01.jpg	111	t	
26	Ryan Kirkbride	I am currently in the middle of a practice-led PhD in Music researching communication and collaboration in live coding – the practice of generating live music using code.\r\n\r\nI developed a Python-driven live coding environment, called FoxDot, for live coding musical patterns with a focus on object-oriented programming and perform improvised melodic techno regularly under the stage name “Qirky”.	ryankirkbride26	Qirky	redacted@bro.cz	programme/pyconcz2018/ryan-kirkbride-01.jpg	111	t	
21	David Žihala	I am a PhD student from the University of Ostrava. I am mainly interested in alternative genetic codes, evolution, GTPases and molecular biology of unicellular eukaryotic organisms. \r\n\r\nI started coding in Python approximately 2 years ago and I basically love it. I contributed to many scientific projects just because of Python. I consider Python so great and useful that I started to teach other people how to code.  \r\n\r\nNow, we have official Python course in our department, we organize Python workshop for biologists “OstraPy” and we also have weekly meetings with pizza, where we discuss many topics, including Python.			redacted@bro.cz	programme/pyconcz2018/david-zihala-01.jpg	111	t	
28	Jirka Vejražka	I've been using Python for IT security purposes for 10+ years. I work as a cyber security expert in a global financial institution. \r\n\r\nI'm using (and writing) Python code for a wide range of tasks including offensive operations, low-level network code, distributed task management, knowledge management and internal auditing. Mostly harmless.	JirkaV	JirkaV	redacted@bro.cz	programme/pyconcz2018/jirka-vejrazka-01.jpg	111	t	
35	Justyna Janczyszyn	For the past 4 years I've been working closely with AWS while building back-ends with Python for mobile and web applications. I spoke about AWS and infrastructure as code at PyCon DE 2016 and PyCon Italia 2017.\r\n\r\nPassionate about automation, Recurse Center alumn, Django Girls mentor, digital nomad.\r\nCrazy about dogs, surfing and trampolines. Currently working at Mapbox as an API Maps Engineer.	JJanczyszyn	jjanczyszyn	redacted@bro.cz	programme/pyconcz2018/justyna-janczyszyn-01.jpg	111	t	
27	Petr Baudiš	I built machine learning based technologies for 10 years now, and build deep learning models for past couple of years.  \r\n\r\nSome of the interesting work I did is the Pachi Go program (used to be the best open source Go-playing program for many years) or the YodaQA open source question answering engine. I'm also Keras contributor.\r\n\r\nI co-founded and currently lead the R&D at Rossum.ai, a startup building Artificial Intelligence for document understanding.	xpasky	pasky	redacted@bro.cz	programme/pyconcz2018/petr-baudis.jpg	111	t	
30	Nick Lang	I have been working remote for almost 10 years for companies such as Docker, Elastic and freelancing. Some of it good and some of it bad. Mostly good though.\r\n\r\nI feel like through my experience others can learn if remote working is for them or not.	fxdgear	fxdgear	redacted@bro.cz	programme/pyconcz2018/keynoter-nick-lang_8AKvdAe.jpg	4	t	Nick has been working remotely for almost 10 years for companies such as Docker or Elastic, and also working freelance. He says that most of it was a positive experience, although not always!\r\n\r\nHe would like to share with the audience his experience and opinions whether working remotely may or may not be a good idea for them.
40	David Bečvařík	As a founder of Prague containers meetup and container enthusiast I often speak about this topic and already hosted similar workshop on our meetup. \r\n\r\nI want to show you that containers can be created/manipulated easily with Python and this can be easily exploited for a neat testing or even production deployment purposes. \r\n\r\nI'm very interested in demystifying containers and all kernel plumbings a show how you can benefit by knowing details about operating system you are using to host your Python applications.	dbecvarik	dbecvarik	redacted@bro.cz	programme/pyconcz2018/david-becvarik-01.jpg	111	t	
41	Alexander Todorov	I am a Senior QA engineer with lots of experience in test automation with Python. I am the project lead for Kiwi TCMS, maintainer of _pylint-django_ and contributor to pylint among other projects.	atodorov_	atodorov	redacted@bro.cz	programme/pyconcz2018/alexander-todorov-01.jpg	111	t	
44	Jeanne Trojan	I'm an Executive Communication Trainer and Coach. In addition to my usual work with multinational corporations, I've been active in the local tech community since 2009, helping people communicate - presenting, conducting meetings, interviewing and even just speaking to each other. \r\n\r\nI created my Networking for Geeks workshop in order to make meeting new people easier. I've done this workshop for GUG.CZ, DevFest, WebExpo and other smaller meet-ups and events. \r\n\r\nPeople that have attended my workshop have said that they feel much better about networking and they were able to use their new skills and confidence right away at the event. \r\nI love doing this workshop! :)	jmtcz		redacted@bro.cz	programme/pyconcz2018/jeanne-trojan-01.jpg	111	t	
38	Mikey Ariel	You might know me as That Docs Lady, and you won't be wrong! I spent the better part of the last 10 years documenting super-geeky enterprise software, most recently for OpenStack Platform at Red Hat. I'm is also on the global core team for Write the Docs, Django Girls alumni, and documentation coach for open-source projects.\r\n\r\nSince crash-landing on open-source planet in 2013, I presented talks and wrote articles about docs, DevOps, and community. I also run documentation workshops, hackfests, and sprints at developer conferences. I'm co-author of the Happiness Packets project, owner of the sporadic and erratic blog docsideofthemoon.com. I love music, dance, and coffee.	ThatDocsLady	ThatDocsLady	redacted@bro.cz	programme/pyconcz2018/mikey-ariel-01.jpg	111	t	
43	Ondřej Caletka	I'm an experienced speaker and an inexperienced Pythoner. I work for CESNET, Czech national research and education network operator as a Linux server admin and developer. \r\n\r\nI like things like IPv6, DNS, TLS, SSH, Public transportation or TV technologÿ. I also volunteer as a RIPE Atlas ambassador, distributing network probes through the country so anyone can measure the health of Czech Internet.	Oskar456	oskar456	redacted@bro.cz	programme/pyconcz2018/ondrej-caletka-01.jpg	111	t	
36	Karla Fejfarová	I'm a researcher at the Institute of Molecular Genetics by day and a Python girl by night (also early mornings, due to fast.ai fellowship and time difference between Prague and San Francisco). Most of my data look like a mouse skeleton. Deep learning is one of my data processing tools.	python_tip	karlafej	redacted@bro.cz	programme/pyconcz2018/karla-fejfarova-01.jpg	111	t	
24	Lukáš Hurych	I'm a product/marketing guy with development background (Python is my biggest love but I went through Ruby, PHP, Swift, Javascript, Java). \r\n\r\nStudy of psychology gave me great knowledge for marketing but the combination with Python is a killer for phishing, writing malware, hacking and all the fun stuff. I'm doing all this just as a hobby trying to test and protect our company and our team.	LukasHurych	LukasHurych	redacted@bro.cz	programme/pyconcz2018/lukas-hurych-01.jpg	111	t	
46	Michal Marušan	My origins come from data warehousing and business intelligence on massively parallel database engines but for more than last five years I've been working on numerous Big Data and Advanced Analytics projects with different customers mainly from Telco, Banking and Transportation industry.\r\n\r\nMy focus and passion is helping customers with implementation of new analytical methods into their business environments to drive data-driven decisions and generate new business insights both in the cloud and on-premises systems.\r\n\r\nI'm Cloud Solution Architect for Data & AI, part of STU unit at Microsoft.	mmatwt	michalmar	redacted@bro.cz	programme/pyconcz2018/michal-marusan-04.jpg	111	t	
50	Clément Verna	I have started contributing to the Fedora project 2 years ago by submitting PRs to some\r\nof the web applications maintained by the Fedora Infrastructure. I am now part of the \r\nFedora Engineering Team and work full time on python applications.	clemsverna	cverna	redacted@bro.cz	programme/pyconcz2018/clement-verna-01.jpg	111	t	
48	Daniel Kuchta	I'm currently the Head of Machine Learning Practice and a software engineer in GlobalLogic Slovakia where I lead the machine learning activities across the company. \r\n\r\nI'm responsible for development of the team, exploring new technologies and working on proof of concepts and projects involving machine learning. I was a speaker at Google DevFest Kosice 2017 and Machine Learning Meetups Kosice.	danonops		redacted@bro.cz	programme/pyconcz2018/daniel-kuchta-01.jpg	111	t	
53	Iva Javorková	Jsem programátorka a poslední 2 roky učím děti programovat. Mými kroužky již prošlo několik desítek dětí ve věku 7-14 let. Postupy, jak naučit děti programovat a hlavně informaticky myslet, testuji na vlastních dětech a následně ověřuji a dopilovávám v kroužcích. \r\n\r\nSpolečnými silami s manželem pořádáme ve své obci veřejné programovací akce pro děti [programohrani.cz](https://programohrani.cz/).	programohrajeme		redacted@bro.cz	programme/pyconcz2018/iva-javorkova-01.jpg	111	t	
39	Marcel Plch	I am a high school intern from Red Hat Python maintenance team in Brno.\r\n\r\nIn my free time, I like to learn new stuff. I also like to share skills that I consider lot easier to gain when explained by somebody else. Blender itself is one huge program that is practically incomprehensible when tried to be learned without help. It also has rich Python API not many people are aware of.		Traceur759	redacted@bro.cz	programme/pyconcz2018/marcel-plch-01.jpg	111	t	
8	Van Lindberg	I help companies with privacy and GDPR issues professionally. I'm around open source for more than 20 years, but his focus has always been on the side of “making communities work.” \r\n\r\nI'm also one of the few people that companies come to to help them understand and build sustainable open source communities.	VanL	VanL	redacted@bro.cz	programme/pyconcz2018/keynoter-van-lindberg_W407MW1.jpg	2	t	Van helps companies with privacy and GDPR issues professionally. He’s been around open source for more than 20 years, but his focus has always been on the side of “making communities work.” \r\n\r\nHe is also one of the few people that companies come to to help them understand and build sustainable open source communities.
47	Flavio Percoco	I worked on Big-Data-oriented applications, search engines, message systems, contributed to Orca, and created MouseTrap, a head-tracker application.\r\n\r\nI work in Red Hat now and spend most of my time hacking on containers and messaging technologies in the OpenStack community. \r\n\r\nI'm part of several technical communities and I serve as a Technical Committee member.	flaper87	flaper87	redacted@bro.cz	programme/pyconcz2018/keynoter-flavio-percoco-alt_YnAInUM.jpg	3	t	Flavio worked on Big-Data-oriented applications, search engines, message systems, contributed to Orca, and created MouseTrap, a head-tracker application.\r\n\r\nNow he works in Red Hat and spends most of his time hacking on containers and messaging technologies in the OpenStack community. He's part of several technical communitiesand serves as a Technical Committee member.
16	Petr Viktorin	During the day, I lead the Python Maintenance team at Red Hat.\r\n\r\nPersonally, I focus on teaching Python to others – and empowering others to teach as well. You might know me from a course or a workshop I helped prepare in some way.	encukou	encukou	redacted@bro.cz	programme/pyconcz2018/petr-viktorin-01.jpg	111	t	
33	Anastazie Sedláková	I am data scientist with passion for data visualization. I started my programming journey with R language. The possibility of easy data visualization was the last reason I kept returning to R. Once I discovered python library **Dash**, there was no turning back :)		anastazie	redacted@bro.cz	proposals/pyconcz2018/talks/Zidkova_reflex.jpg	111	t	
29	Dawn Kernagis	I'm a Research Scientist at the Institute for Human and Machine Cognition. My research is focused on human performance optimization and risk mitigation for humans in extreme environments, such as people working undersea, at altitude, and in space.\r\n \r\nBefore coming to IHMC two years ago, I completed my PhD and Postdoctoral training at Duke University, where I studied new ways to treat brain injury, genetic susceptibility to extreme environmental conditions, and novel cancer diagnostic methods.\r\n \r\nI have also been a diver with numerous underwater projects since 1993, including the mapping and record-setting exploration of some of the deepest underwater caves in the world. My experiences led me to induction into the Women Divers Hall of Fame in 2016. In 2016, I was also selected as one of 6 crew members to join NASA’s underwater mission, NEEMO.			redacted@bro.cz	programme/pyconcz2018/dawn-kernagis-01.jpg	111	f	
51	Lidia Lipinska	I'm a Ph.D. candidate at the Łódź University of Technology.  I'm a biotechnologist who likes working with bioreactors, learning languages and meeting new people.\r\n\r\nI learned Python myself to do my own data analysis and make nice plots for my Ph.D., but I got hooked and now I co-organize Łódź's PyData group meetups and use Python for data analysis and for fun.	lidkalee	lidkalee	redacted@bro.cz	programme/pyconcz2018/lidia-lipinska-01.jpg	111	t	
32	Sam Trojan	I'm 13 years old and learning how to program, so far in JavaScript and HTML as I'm creating my first web pages.	SamuelTrojan		redacted@bro.cz	programme/pyconcz2018/keynoter-sam-trojan-devfest_55SgzEa.jpg	5	t	Sam is only 13 years old but he is already learning how to program, so far in JavaScript as he’s creating his first web pages. We'll also have adults talking about teaching kids to program, but Sam will talk about it from kid's point of view.\r\n\r\nHe gave a lightning talk at DevFest CZ 2017 in Prague which was well received, so he has even some stage experience.
37	Igor Zubrycki	I’m a roboticist, finishing my Ph.D. at Lodz University of Technology, doing human-robot interaction experiments and using Python to prototype robots and my experiments.\r\n\r\nLidia and me and love teaching people new things and learning deeply about new things. We conducted workshops about DataScience, robotics, and prototyping using Python to various audiences. \r\n\r\nWe conducted a workshop about ROS and Python at PyCon PL 2017. We are also the organizers of PyData Łódź and Data Science Łódź groups.\r\n\r\nWe prepared our own robot of our own design for interactive art exhibition in Tate Modern in London.	IgorZub	AdoHaha	redacted@bro.cz	programme/pyconcz2018/igor-zubrycki-01.jpg	111	t	
31	Karen M. Sandler	I'm the executive director of the [Software Freedom Conservancy](https://sfconservancy.org/), which is the nonprofit home of over 40 projects, including Git, Samba, QEMU, Selenium and Inkscape (to name a few). \r\n\r\nI'm known as a cyborg lawyer for my advocacy for free software as a life-or-death issue, particularly in relation to the software on medical devices. Prior to joining Conservancy, I was the executive director of the GNOME Foundation. Before that, I was the general counsel of the Software Freedom Law Center. \r\n\r\nI co-organize Outreachy, the award-winning outreach program for women globally and for people of color who are underrepresented in tech. I'm also a pro bono counsel to the Free Software Foundation and GNOME.	o0karen0o		redacted@bro.cz	programme/pyconcz2018/keynoter-karen-m-sandler_3H51jBV.jpg	1	t	Karen is the executive director of the Software Freedom Conservancy, which is the nonprofit home of over 40 projects, including e.g. Git, Samba, QEMU, Selenium, and Inkscape. \r\n\r\nShe is known as a cyborg lawyer for her advocacy for free software as a life-or-death issue, particularly in relation to the software on medical devices.\r\n\r\nKaren co-organizes Outreachy, the award-winning outreach program for women and for people of color who are underrepresented in tech. She is a pro bono counsel to the FSF and GNOME.
42	Lumír Balhar	I'm a drummer, biker, firefighter and Red Hat Python software engineer. You might remember our talk from last year about teaching Python. I said that sharing knowledge and teaching people is healthy addictive and probably the best way how to use your knowledge. So I am here to do it and maintain the good feeling.	lumirbalhar	frenzymadness	redacted@bro.cz	programme/pyconcz2018/lumir-balhar-01.jpg	111	t	
2	Magda Zawora	I'm a woman around 40, mother of two and currently EU project manager with a [dozen years of professional experience](https://www.linkedin.com/in/magda-zawora/).\r\n\r\nAbout a year ago I started to learn Python with a goal to become a junior (yes!) Python developer in a reasonable period of time.		MagdaZawora	redacted@bro.cz	programme/pyconcz2018/magda-zawora-02.jpg	111	t	I will be telling my own story. But actually the topic relates to lots of people who decided to change the industry and start to work in IT. The process is becoming more and more popular. \r\n\r\nI'm a woman around 40, mother of two and currently EU project manager with a dozen years of professional experience. About a year ago I started to learn Python with a goal to become a junior (yes!) Python developer in a reasonable period of time.\r\n\r\n\r\nDuring this time I gathered experience which I think is worth sharing because a lot people can take advantage of it or, at least, be inspired. Python is considered to be the "entry language" so the process of changing the industry is in particular connected with Python community. \r\n\r\nI suppose conditions to change the profession in Czech Republic are simmilar to those in Poland, but in would be really interesting to talk about it and compare our experience.\r\n\r\nA month ago I had a talk during [Pykonik](http://pykonik.org/34/) Kraków Python community meetup. \r\n\r\nI have a blog telling in not a very serious way about my "transformation", unfortunately only in polish: https://early-bird.blog/.
54	Jan Pospíšil	I'm technical enthusiast and data professional with passions for IoT gadgets, IoT solutions, Big Data, Machine Learning, Cognitive Services, New Technologies (even bleeding edge), e-commerce, robotics, automation, coding, …\r\n \r\nI'd like to meet you for a chat about those topics and how you use them together with Azure services to boost your business.	pospanet	pospanet	redacted@bro.cz	programme/pyconcz2018/jan-pospisil-04.jpg	0	t	
\.


--
-- Data for Name: programme_speaker_talks; Type: TABLE DATA; Schema: pyconcz; Owner: pyconcz
--

COPY pyconcz.programme_speaker_talks (id, speaker_id, talk_id) FROM stdin;
1	1	1
2	2	2
3	3	3
4	4	4
5	5	5
6	6	6
7	7	7
9	9	9
10	10	10
11	11	11
12	12	12
13	13	13
14	14	14
15	15	15
16	16	16
17	17	17
18	18	18
20	20	20
21	21	21
22	22	22
23	23	23
24	24	24
25	25	25
26	26	26
27	27	27
28	28	28
29	29	29
30	8	30
31	30	31
32	31	32
33	32	33
34	47	31
35	48	34
37	50	36
38	53	13
43	8	8
\.


--
-- Data for Name: programme_speaker_workshops; Type: TABLE DATA; Schema: pyconcz; Owner: pyconcz
--

COPY pyconcz.programme_speaker_workshops (id, speaker_id, workshop_id) FROM stdin;
1	33	1
2	34	2
3	35	3
4	36	4
5	26	5
6	37	6
7	38	7
8	39	8
9	40	9
10	41	10
11	42	11
12	43	12
13	44	13
14	45	14
15	46	15
16	51	6
17	52	4
18	54	15
\.


--
-- Data for Name: programme_talk; Type: TABLE DATA; Schema: pyconcz; Owner: pyconcz
--

COPY pyconcz.programme_talk (id, title, abstract, language, difficulty, video_id, is_backup, is_keynote, is_public, private_note) FROM stdin;
28	Portscan all the things! (fast, distributed and effective)	A real world example of a port scanner written in pure Python as no existing tool fit the bill.\r\n\r\nQuick introduction to port scanning, example of a distributed Python code running on multiple systems across the globe and bypassing common portscan detection/prevention systems.\r\n\r\nPresentation slides can be found [here.](https://www.slideshare.net/JirkaV/portscan-all-the-things-pycon-cz-2018)	en	beginner	J6GfWn5cxTo	f	f	t	
18	Hypothesis: Property­-based testing for Python	We all know we should be writing tests, but coming up with tests for every edge case is hard work and you will inevitably miss some. Tell Hypothesis what kind of data your tests need and let it explore that space. When it finds a bug, it finds the simplest case where your code fails.\r\n\r\nIn this talk, I'll show you how to use Hypothesis in your projects to find more bugs than you would imagine.	en	beginner	SGicCC6OXgI	f	f	t	
25	Shipping Containers using Dunder Methods	In this talk, we delve into the world of container-related double underscore (dunder) methods which define an object’s behavior.\r\n\r\nWe will discover some of the most important dunder methods along the lines of the following two use cases:\r\n\r\n- How to extend a tuple to represent data? \r\n- How to implement a dict-like container for data handling?\r\n\r\nIn both cases we will try to quickly come up with implementations that not only serve our purpose, but also render easy-to-use containers mimicking already existing ones.	en	beginner	z9MDfaWep0w	f	f	t	
27	Machine Learning and Keras	What is needed for machines to automatically teach themselves to make decisions based on examples? Machine Learning is all the rage nowadays and may seem very magical, especially on “unstructured data” like texts, pictures or sounds.\r\n\r\nBut what is actually a “neural network” and do you need a PhD to build some?  Turns out that machine learning models are far less magical than they seem to be (at least when solving the more common tasks).  Even if your program will acquire magic powers in the eyes of your users.\r\n\r\nWe will unveil the dark secret of how neural networks actually look inside.  And to solve two real problems (related to text and pictures), we will actually build a couple of simple ones in the popular Python framework [Keras](https://keras.io).	en	beginner	LNUzWaukvcc	f	f	t	
34	Classifying cancer nodules with deep learning and Python	CT scan analysis is a tedious and difficult job even for highly-trained radiologists. It takes hours to go through the whole scan and not miss a single spot which could potentially be a malign cancer nodule. It takes years for novice radiologists to learn the craft and even then they tend to misclassify nodules which might later lead to incorrect treatment of the disease.\r\n\r\nWhile we can not improve the radiologist’s ability to detect and classify cancer nodules directly, we can leverage the power of machine learning algorithms we have today together with the data from the past and build a medical support decision system to advise the doctors and warn them, if there is a potentially dangerous nodule detected.\r\n\r\nWe decided to get our hands dirty and build such a system. After extensive research and understanding of the problem domain we obtained a labeled dataset which would later be used for the training of our models. The next step was to understand the data we have, uncover hidden biases and handling the data from different sources and formats. Afterwards, we build several models using technologies such as genetic algorithms, TensorFlow, Keras and Python and achieved great results. Be sure to come and I’ll tell you more about this amazing journey.	en	beginner	NzHCYY_CoGc	f	f	t	
11	Host Your Own PyPI & Create Reproducible Environments using Pulp	Even though software changes constantly under our feet, sometimes we want to keep an old version of a package or organize the packages we want to distribute in a certain way. Reproducible results require reproducible environments so it is important to take matters into your hands.\r\n\r\n[Pulp](https://pulpproject.org/) enables large and small organizations to fetch, upload, organize and distribute software packages in a consistent manner.\r\n\r\nIn this session, we will focus on how to manage Python packages with Pulp.\r\nWe will go over use cases like:\r\n\r\n- mirroring PyPI content\r\n- managing a carefully curated set of packages\r\n- promoting packages through your software development lifecycle\r\n- publish immutable snapshots, and rollback when things go wrong.\r\n\r\nStop by and share your use cases and experiences after the talk.	en	beginner	Rpb5zT5UZ-4	f	f	t	
26	Programming Music for Performance: Live coding with FoxDot	In this talk, I will introduce the topic of live coding – the interactive programming experience for generating sound and visuals but this talk will mainly focus on the audio side.\r\n\r\nLive coders use programming languages to describe rules for generating music but then re-write these rules while the program is running. By continually writing and re-writing these rules live coders creating a shifting musical experience that is always in flux. All of this happens live in front of an audience with the code projected for all to see.\r\n\r\nI will go on to discuss a few of the many tools that are available for live coding and showcase the FoxDot environment, which allows you to live code music using Python. I will talk about the motivation for developing FoxDot and describe some of its key features as well as how you can set it up yourself at home. \r\n\r\nThe talk will be concluded with a short demonstration that will be a partial explanation and partial performance.	en	beginner	XRNFBZlBeuI	f	f	t	
17	SSLError, now what?	TLS/SSL is the most important and widely-used protocol for secure and encrypted communication, e.g. HTTPS. It offers more than just encryption. TLS also ensures data integrity and strong authentication with X.509 certificates. But it provides merely a false sense of security if you use it wrong.\r\n\r\nHave you ever encountered SSLError while connecting to a server, but you didn’t understand what is going on? Are you running production code without TLS/SSL protection or with certificate validation disabled, because you couldn’t figure out how to make it work correctly?\r\n\r\nI’ll give you the rundown of the basic cryptographic building blocks, protocol handshake, inner structure of certificates, and PKI. You’ll learn about the best practices, debugging tools and tips how to diagnose TLS/SSL and how to deal with certificates.	en	beginner	fNIPLUVWhC0	f	f	t	
20	How to handle linear HbbTV broadcast with Python for 10 TV stations	DVB broadcast is linear, HTTP is not. HbbTV is a standard binding world of linear broadcast and stateless HTTP together. \r\n\r\nThere are many challenges to correctly handle web content in TVs, especially with a completely different approach from broadcasters.\r\n\r\nI will show you, how to serve advertisements and measure traffic to hundreds of thousands always connected devices on the single server. With just 40% of devices capable of WebSocket, you have to find ways to get performance elsewhere. Ad targeting and caping in shared memory for linear subscribers on 10+ years old devices with Python and uWSGI.	en	advanced	GTZ-aCOOgEY	f	f	t	
23	Everything I always wanted to know about crypto, but never thought I’d understand	For many years, I had entirely given up on ever understanding the slightest thing about cryptography. The amount required to understand even the most basic part seemed entirely dazzling. However, I’ve since learned it’s not nearly as hard as I thought to understand many of the important concepts.And this is what I want to share with you. \r\n\r\nFor this talk, you don’t need to know anything about cryptography, and almost no math knowledge. You’ll gain an understanding of what the different components are and how they interact. And learn to get a grasp of how a system works, without necessarily understanding the details of each individual part.\r\n\r\nIn this talk, I’ll take you through some of the underlying design principles of modern applications of cryptography. We’ll talk about what we’re trying to accomplish, which parts are involved, and how to prevent and understand common vulnerabilities. This will help you to make better choices when you implement cryptography in your products and will improve your understanding of how crypto is applied to things you already use.	en	beginner	htCTij3LXlo	f	f	t	
31	Lessons Learned from Working Remote	Working Remotely brings a whole new set of challenges. It can be rewarding, challenging, fun and exciting. But it can also be lonely, depressing and frustrating.\r\n\r\nWe'll focus on some of the negatives and on how you or your employer can work to combat them so you can sit and enjoy all the good that comes with remote working.\r\n\r\nThis talk dives into the lessons learned from an employee of Elastic, one from Red Hat and other companies that have distributed and remote teams.	en	beginner	jeEw5Qrb5eA	f	t	t	
1	GeoPython – how to save the world using Python	Remote sensing offers an increasingly wide array of imagery with comprehensive and consistent coverage of the earth's surface.This field grows every day as more satellites are launched and availability of data increases. Satellite images acquire at frequent intervals with a number of details has been used to monitor changes on the Earth. That monitoring can not only help us to see the beautiful world without leaving home but also see processes that occur on the earth to predict disaster situations. \r\n\r\nIn this talk, I am going to explore remote sensing and how it can be connected to Python. I will show how using GDAL, NumPy and OpenCV libraries to process satellite data to create full-scale information products. I will introduce some important algorithms used to change detection. \r\n\r\nThis talk is intended for Python developers who want to see how space technology answer critical questions for better decisions.	en	beginner	lgOzYDCml3c	f	f	t	
24	Dark Python: Social engineering and hacking with 70% success rate	In the course of the last few years I launched a lot of different attacks in our company (60+ teammates) and with some of them, I had a success rate of 70%. From getting people’s Facebook accounts or access to their LastPass accounts to custom written malware.\r\n\r\nThe threat that anyone can steal your customer data is a potential killer of any (financial) company. Being suspicious and aware of all potential phishing attacks and other traps is a must.\r\n\r\nIn this talk we will look at the practical (dark) examples I have executed and why Python was the best language of choice. From social engineering (sophisticated phishing attacks), custom malware, dropping nasty USB drives on the street to technical/network attacks.\r\n\r\nWhen you want to be really successful in doing social engineering you need to prepare the ultimate user experience. You can not make a mistake and you can not overlook little details (that usually happens if you develop your own apps/websites). Those little details make UX in your app/website awesome (if you are on the good side) but can be exploited pretty easily by the dark side.	en	beginner	sdvyUJrUwps	f	f	t	
6	GraphQL is the new black	REST is a standard for writing APIs, but there might be a better way. GraphQL is a query language which makes APIs more flexible and easier to evolve over time. It gives clients the power to ask for exactly what they need which results in optimized bandwidth, server usage but also allows writing declarative UIs. \r\n\r\nThe talk will compare GraphQL with REST API to show the differences and advantages as well as real examples. \r\n\r\nMinistry of Python warns: This talk might include a bit of JavaScript.	en	beginner	xSogeqdhCGg	f	f	t	
5	Cython to the Rescue	You just found that C library which solves that huge problem you have. It solves it completely, it's so fast, it's old, rock solid and well tested – and difficult to use, because it has that real-world, well aged C-API. Maybe even C++. So, you want to use it from Python, but there's no wrapper yet? Or worse, the existing wrapper is auto-generated and feels clumsy, slow and just as ugly to work with as C?\r\n\r\nGive Cython a try! It's the fastest way to make Python talk (to) native code, and a pleasure to work with as a general programming language.	en	advanced	dv_ScYgh8os	f	f	t	
7	Casual contribu­tors: who, why, and how	Increasingly, people want to contribute to projects casually. A number of factors have driven this change, such as distributed revision control, social coding platforms, and the general trend towards “new volunteerism.” To take advantage of these contributions, communities need to adapt to the needs and expectations of casual contributors. Yet at the same time, no community wants to invest more effort in inviting casual contributions than it receives in return. \r\n\r\nThis talk will cover the benefits of incorporating casual participants, the factors that influence their return and practices for engaging them. The material is based on the body of scientific research, my own research and my personal experience both as a community manager for a non-profit and as an open source contributor.	en	beginner	N9BWz420PeQ	f	f	t	
32	Cyborgs Unite!	When I discovered at a young age that I had a life threatening heart condition, the last thing I expected was to have to worry about software. Now, with a heart device implanted in my body, I have come to understand not only how vulnerable medical devices are but how we are making critical choices about software that will have huge societal impact. \r\n\r\nI will also touch on potential avenues for accountability, transparency, and access to remedies as we hurtle towards an Internet of Things built on proprietary source code that prevents us from knowing \r\nexactly how these vital devices work, what data they are collecting and to what ends, what their vulnerabilities might be, and the extent to which their closed, proprietary nature keeps us from developing societal mechanisms and review processes to keep us safe.	en	beginner	Z5mknpGpLVY	f	t	t	
16	Bytecodes and stacks: A look at CPython’s compiler and its execution model	So, you wrote some Python code. What needs to happen before it starts running? And once it's running, how does Python keep track of what it's doing?\r\n\r\nI'll talk about CPython's tokenization, parsing, bytecode and its serialization and cache, the stack-based virtual machine, line number tables, and code, frame and function objects. \r\n\r\nDon't worry if you've never heard of these concepts. While even experts should learn something new, the talk is aimed at anyone who's worked on a Python project or two.	en	beginner	rOU-W_J-zFE	f	f	t	
3	Wounded hero revived: Lessons learned from porting M2Crypto to Python 3	The purpose of this talk is to remind people about M2Crypto. After many years of very light almost non-maintenance only by the brave RHEL maintainer, I have taken over M2Crypto to port it to Py3k and hoped to be done in a month the most. Now, two years later, the merge finally happened and M2Crypto has another chance to survive in the world where Py3k compatibility is a necessity.\r\n\r\nThis presentation is about the experience of porting large project combining Python and C from 2.5 to Py3k compliance. I would like to describe the biggest problems and tools which helped me. The formers were (aside from plenty of lingering bugs) complete mess of using 'bytes' and 'str' in Py2k code. What helped a lot were PEP-484 annotations (working in Py2k in the comment form), compatibility macros which are actually present in Python since 2.6.	en	beginner	znF2wVjdb0k	f	f	t	
36	How does the Fedora Infra­struc­ture use Python	The Fedora Project relies on Python for its Infrastructure, almost all \r\napplications helping Fedora to be a successful Open Source Project are\r\ndeveloped using Python.\r\n\r\nThis talk will present the applications developed and maintained in Fedora\r\nand how they are deployed. The following topics will be developed: \r\n\r\n* Which applications for which problem\r\n* Which technologies (Web Framework, Message Bus, etc)\r\n* Python 2 vs Python 3 and migration Plan\r\n* Deployment (Ansible, Openshift)\r\n* Maintenance\r\n\r\nYou will also get all the information needed to start contributing to these\r\napplications and to join the Fedora Infrastructure team.	en	beginner	11MzIGhoJ68	f	f	t	
4	DataFrames: scaling up and out	DataFrames have become ubiquitous when it comes to fast analyses of complex data. They go beyond SQL by not adhering to a strict schema and offer a rich API, where you chain methods, which fosters exploratory analytics.\r\n\r\nWhile newcomers to Python usually learn about pandas early on, they sometimes struggle as their underlying data grow in size. Given the in-memory nature of pandas' storage system, one can usually only scale up. \r\n\r\nI'd like to outline several workflows for adapting to the ever-increasing size of datasets:\r\n\r\n- Changing application logic to handle streams rather than loading the whole dataset into memory. \r\n- Actually scaling up – locally by buying more memory and/or faster disk drives, or by deploying servers in the cloud and SSH tunneling to remote Jupyter instances.\r\n- Scaling your data source and utilizing pandas' SQL connector. This will help in other areas as well (e.g. direct connections in BI).\r\n- Using a distributed DataFrame engine – Dask or PySpark. These scale from laptops to large clusters, using the very same API the whole way through.\r\n\r\nI will cover the various differences between these approaches and will outline their set of upsides (e.g. scaling and performance) and downsides (DevOps difficulties, cost).	en	beginner	aJsdeIcU9HE	f	f	t	
2	Python developer wannabe: How to make a change in your life and get satisfaction	In my presentation I will treat my story as a case study. I’ll speak about my background, motivation, decision-making process, and finding self-confidence and belief that I can reach the goal. Hopefully not in a pompous or coach style, just to share a bit of inspiration and encouragement for people who feel the need to change something in their life.\r\nI’ll also provide audience with some pragmatic information – I will briefly recommend sources that I used and consider to be valuable, present pros and cons of programming bootcamps, and other helpful tools and events. I will also speak about how I planned the learning phase and what I managed to do during that period.\r\nFinally, I will explain how I organized my study having very limited amount of spare time and I’ll finish with a few thoughts and recommendations for people who think about or just started the process of change.	en	beginner	rA5tSLRJdFU	f	f	t	
10	Is asyncio stack ready for web development?	If you're developing web applications with Python you might have heard about asyncio stack (Python 3, asyncio, aiohttp, uvloop, etc.). It allows developers to create websites without using Django, Flask or other synchronous web frameworks. \r\n\r\nLet's talk about why asyncio stack became popular for web development among Pythonistas, especially in Eastern Europe (Ukraine, Russia, etc). I will tell you about projects that are using it and how they compare to more traditional ones.\r\n\r\nI will also talk about lessons learned from developing, testing and deploying application used to sign legal documents online in Ukraine: aiohttp.	en	beginner	FkoQJrGOUZg	f	f	t	
15	Use Multi-Factor Authentica­tion Everywhere Because Passwords Are Terrible	When we deploy web applications, users entrust their data to us and expect that we will protect it. Meanwhile, recent high-profile breaches have underscored the risks of username+password authentication, which is the default in Django and other Python web frameworks. One of the best ways to mitigate this risk and protect our users’ data is to add multi-factor authentication (MFA) capability to our applications: one-time passwords (TOTP), hardware keys (Yubikeys, U2F, etc.), email-based authentication etc.\r\n\r\nYou will learn how to implement U2F key and TOTP-based multi-factor authentication in your own Python-based web applications in just a few minutes.	en	beginner	cK-AH10xHYc	f	f	t	
14	How *not* to test software	In 1946, Grace Hopper found a bug trapped in a relay and coined the term bug. Except the term “bug” for an error was actually used before, for example in 1878 Thomas Edison in his letter to Theodore Puskas. Moreover, it wasn’t a true bug, it was a moth. And it wasn’t even Hopper who found the moth. Plenty of bugs in the bug’s story. \r\n\r\nSoftware testing is full of myths, mythical silver bullets and “good” and bad practices. In this talk, I’ll debunk myths, share bad practices and explain how good practices can turn out to be not so good when applied in the real world of software engineering. All with focus on our beloved Python.\r\n\r\nExamples are unit tests tightly coupled to implementation details, always unstable integration tests and targeting 100 % code coverage.	en	beginner	hYC7QUONnyo	f	f	t	
8	Privacy issues in Open Source: The GDPR and You	The GDPR goes into effect in May of this year, bringing with it a new set of privacy requirements for those doing business with anyone in the EU... and "doing business" is broad enough to include "working in open source."\r\n\r\nThis talk is about the intersection of GDPR requirements and how they apply to common situations like having signed commits, forking, having a mailing list, and other open source project basics. We'll discuss the issues and give some guidelines for working under the new law.	en	beginner	xT9Tgniew6I	t	f	t	
22	Security of your application is just a few clicks away	Every time you type `pip install -r requirements.txt`, you are putting your web application and user data at risk. Modern web applications are using dozens of 3rd party components, that are totally out of your control. You’ve already learned you should test your code, but I’ll do my best to convince you that you should test external code for the security vulnerabilities too.\r\n\r\nIn January, two biggest vulnerabilities, Meltdown and Spectre, were publicly disclosed. Those are the most known ones, but smaller vulnerabilities are published nearly every day. And all of them can be exploited and used to abuse your application. The attacker might try to take your application out, steal your user’s data or take advantage of your computer power.\r\n\r\nSince vulnerabilities are disclosed, they can be also mitigated. There are multiple vendors dealing with security testing and I’ll focus on the solutions for PyPI package scans. During the talk, I’ll show you how a vulnerability can be exploited, where and how it is reported (you’ll learn what the CVE is) and how you can secure your application using “GitHub’s security alerts for vulnerable dependencies” and [Snyk.io](https://snyk.io) on various levels (repository integration, CI server, CLI integration).	en	beginner	03FODN78s38	f	f	t	
21	How Python code is helping us to solve genetic codes	Genetic code is a set of rules which are telling us how the organisms translate information from mRNA into amino acids, the main parts of all proteins. Majority of organisms use so called standard genetic code. \r\n\r\nHowever, a growing list of exceptions described from various organisms revealed an unexpected evolutionary flexibility of this fundamental molecular mechanism. Our lab has recently contributed to this field by discovering three novel genetic code variants.\r\n\r\nThe first part of the presentation will provide a brief introduction to the topic of genetic codes and the second part will be dedicated to our new findings in the filed of alternative genetic codes and how Python help us with some of them.	en	beginner	d_SgNk52nBo	f	f	t	
33	Three Ways My Programming Teacher Rocks (and you can too)!	As I said in my DevFestCZ talk, most of the teenagers I know aren't interested in learning programming. We can probably blame the way programming is being taught. I think this should be changed and my programming teacher is a fantastic example of how to get kids excited about programming.\r\n \r\nIn this talk, I'll show you some good things that he does and I'll give you some tips that will help you rock too. I think you'll leave this talk with more ideas about how to teach teenagers programming in an interesting and effective way. This will be an interactive talk with a chance to ask questions and share your experience.	en	beginner	8YyWt6eYtNg	f	t	t	
12	Bits and bytes of Python memory management	Is it true that Python is not returning memory back to OS? What happens with variables which are no longer needed? How important is a garbage collector? How to trace and profile memory usage?\r\n\r\nLet's find out answers to these and maybe some more questions.\r\n\r\nTalk overview:\r\n\r\n- Introduction: Why do I need to care about memory management in Python? Objects in Python – what are they? \r\n- Memory management: How memory is being allocated at start/while running – blocks/pools/arenas? How is memory being freed – reference counting/garbage collector? Extras - small integer’s identity, sys.intern, sys.getsizeof, lists/dicts dynamic allocations. How to find cycles in variables referencing? \r\n- Tools for memory management: Overview of available tools for managing memory. How and why Instagram disabled/re-enabled garbage collector?	en	beginner	ALDUKcg6W9o	f	f	t	
13	*Proč* a *jak* učit děti programovat	Rádi bychom vám krátce nastínili proč a jak učit děti programovat.\r\n\r\n*Proč* bychom měli děti učit programovat i přesto, že ze všech nechceme mít programátory? *Proč* a *jak* se dnes učí programovat děti v jiných zemích Evropy a světa? Jak je na tom ČR a co se chystá. \r\n\r\n*Jak* začít. Jak rozjet svůj vlastní kroužek, i když třeba škola nemá počítačovou učebnu. Jak uspořádat jednorázovou programovací akci pro děti a rodiče. Jak rozvíjet informatické myšlení už u předškolních dětí, v čem, co a jak mohou programovat děti ze základní školy. Slasti a strasti lektorování kroužku programování pro děti.	cs	beginner	WHwD8AgpQG8	f	f	t	
9	Honeybee conservation with Python	In the apidologie research area, there is one task that obliges the researcher to classify and count the contents of each comb cell in each frame. With this task is possible to control the progression of brood, bees, and food reserves. Since each frame can have thousands of cells, in most cases this task is done by a human in an approximate way, making it error-prone. The automation of this process, using image analysis represents an evolution in this field.\r\n\r\nThe honey bee is the world’s most important pollinator of food crops. Almost one-third of the food that we consume each day relies on pollination done mainly by bees. So the creation of software that helps the preservation of this species has a direct impact on our lives.\r\n\r\nI am going to show you a few challenges we have faced, from creating comb cell detectors using OpenCV and Shapely, to developing models based on Deep Learning to classify the cell's content using the Caffe framework. With these models, we have obtained accuracy above 98% within eight different classes and solved the proposed problem.	en	advanced	zunVyo2-eJs	f	f	t	
30	Balloons, Projects, and Python: Building a Sustainable Community	A lot of people get started in open source by “scratching their own itch” – building something that they want for themselves. But starting the project isn't the hard part: it is keeping it going in a reasonable, sustainable way.\r\n \r\nI will be honest: creating and building a sustainable open community is hard. It involves giving up some control. It involves developing and exercising a different set of skills other than those needed for technical mastery. So how do you do it?\r\n\r\nI will start out with three stories about successful open communities, and explain how they were able to succeed. Then I will talk a little about why these communities work. It isn’t fairy dust. It isn’t even altruism. It’s economics, psychology, and communication. Finally, I will give some guidelines around how you can build your own sustainable community.	en	beginner	xT9Tgniew6I	f	t	t	
29	The Human Factor: Optimizing Life for People in Space	While the rate of spaceflight technology advancement continues to accelerate, there are still significant considerations when it comes to the health and safety of the ultimate product end-users: humans. \r\n\r\nLong-duration missions have allowed researchers to stratify the effects of living and working in space on humans. These impacts on our physiology and psychology range from negligible, to addressable and potentially mission-limiting. \r\n\r\nThis presentation will provide an overview of how living in space affects the human and what we are doing to optimize the health, safety, and performance of people in space.	en	beginner		f	f	t	
\.


--
-- Data for Name: programme_workshop; Type: TABLE DATA; Schema: pyconcz; Owner: pyconcz
--

COPY pyconcz.programme_workshop (id, type, title, abstract, language, difficulty, length, is_backup, is_public, private_note, registration) FROM stdin;
4	workshop	Deep Learning with Keras & Tensorflow: from Zero to Hero in 3 Hours	Deep Learning is everywhere. It beats us in Go and Chess, translates our texts between languages, turns steering wheels of self-driving cars and tags Not-Hotdogs on out photos.\r\n\r\nWe will introduce the basic concepts and demonstrate them on two examples: [dogs vs. cats image classification](https://www.kaggle.com/c/dogs-vs-cats) and [text generation from Nietzsche’s writings](http://karpathy.github.io/2015/05/21/rnn-effectiveness/). Moreover, we provide similar datasets for you to practice and, in the end, deploy the trained models as a simple API service.\r\n\r\nBecause we will be working in a cloud, all you need is a laptop and a decent web browser (not IE 6.0). Beginners are welcome. Ph.D. degree in machine learning definitely not needed. However, a familiarity with Jupyter Notebooks and some experience with numpy module might be useful (you can easily get it from [Udacity](https://www.udacity.com/)/[Datacamp](https://www.datacamp.com/)/… online materials).	en	beginner	2h	f	t		free
9	workshop	Self container­ized Python	You've probably noticed Docker and its hype. Containers changed the way how we develop and deploy applications. Were you ever curious how containers work and what they really are?\r\n\r\nIn this workshop, we will go through all the steps needed to self-containerize your Python application. We will learn how to interact with  Linux kernel syscalls using Python ctypes and we will develop a Python library you can extend and use, to simulate/create complex deployments of your application without any externals or native tools. Just Python interpreter.\r\n\r\nRequirements:\r\n\r\nLinux VM with Python 3.x install no other libraries required (even legacy Python2 should be enough, but it's secret :) ).	en	beginner	2h	f	t		free
14	workshop	From your editor to PyPI: Creating and Releasing robust Python packages	Whether you want to release python modules on PyPI or simply want to improve your efficiency to write python code, this workshop is for you.\r\n\r\nWe will start with a cookie-cutter template and create a library using test-driven-development, reach 100% of test coverage, learn how to document the code on the go and auto-generate Sphinx documentation.\r\n\r\nAt the end of the workshop, you will have a python module on PyPI, host the documentation on ReadTheDocs and have your tests run on Travis CI.\r\n\r\nPlease have installed: python 2.7 or 3.6 and cookie cutter.	en	beginner	1d	f	t		free
8	workshop	Blender Python API	Do you like graphics, 3D modeling, physics simulations, or have you just heard that these are possible in Blender, but the complexity of the program scared you away? Let's look at its API.\r\n\r\nPython API for Blender lets you do anything you would do in normal Blender. Just without the need to drag things around the screen and pressing god knows what combinations of keys.\r\n\r\nAnd even if you are a skilled Blender artist, you still may be interested, because you definitely do have some repetitive tasks you do on every project. Using this API, you can create your very own tools to solve these problems and keep your focus more on your work, not the repetitive tasks.	en	advanced	2h	f	t		free
15	workshop	Effective Image processing at Scale using TensorFlow / CNTK	Come to join us and try building end-to-end image processing scenario using popular deep learning frameworks TensorFlow and CNTK. It usually requires multiple tools, frameworks, and integration of different apps and steps to successfully go through a complex task in a team on a long-term project. \r\n\r\nWe will get you through whole life cycle data science experimentation - data wrangling and preparation, modeling (train locally on sample and training on the large dataset in a cloud) and deployment. We will use Machine Learning Workbench tool for data preparation, data science experiment management, code versioning, model management, run history, and notebook integration. Take advantage of the best open source frameworks, including TensorFlow, Cognitive Toolkit, Spark ML, and scikit-learn.\r\n\r\nBy the end of the workshop, you will know how to approach similar scenarios with the effective tooling and using state-of-the-art deep learning frameworks and leveraging productivity of your computer and power of cloud computing. You can keep all code artifacts and VM created during the workshop for later use.	en	advanced	2h	f	t		free
12	workshop	Analyzing results of RIPE Atlas measurements	RIPE Atlas is a worldwide network of small hardware probes measuring the health of the very fundamental parts of the Internet: reachability, round trip time variations, path changes (traceroute), DNS resolution. There are around 10000 probes deployed worldwide. Such amount of probes produces a big amount of data. Those data are publicly accessible in JSON format via a REST API.\r\n\r\nEven though there are a few ready-made visualizations for measurements, lots of valuable data are still hidden in the raw form. Fortunately, there is a Python-based CLI tool, which can be easily extended. In this workshop, we will try to give an overview of how the system works and then we'll try to create some extension to analyze some measurements.\r\n\r\nPlease bring your own computer with Python 3.x installed as well as your favorite text editor and your favorite virtualenv implementation. If you want to try the RIPE Atlas in advance, [register an account](https://atlas.ripe.net) and ask me for some credits so you can make your own measurements.	en	beginner	2h	f	t		free
7	sprint	The doc(tor) is in! *documenta­tion helpdesk*	Bring forth your broken README files, your cryptic API references, and your disheveled Wiki projects! \r\n\r\nThe documentation clinic will be open during the **sprints** and the doc(tor) will be available to advise and assist with whatever you'll be sprinting on: from choosing the right markup language and naming all the things, to proofreading and restructuring content and crafting contribution guidelines.\r\n\r\nOpen-source projects of all shapes and sizes are welcome!	en	beginner	1d	f	t		without
13	workshop	Networking for Geeks	One of the hardest things to do at an event is to lose the fear of talking to strangers and networking.\r\n\r\n- Why should I talk to people I don't know?\r\n- How do I introduce myself without feeling like a fool?\r\n- How can I break into a group?\r\n- What do I say after the introduction?\r\n\r\nThese and many more questions are answered in this workshop. And, you'll get lots of chances to practice. \r\nYou'll leave the workshop armed with strategies to network and with the confidence to use them!	en	beginner	1h	f	t		free
2	workshop	Dive into GIS with Python	Traditional Pycon.cz workshop, where we are going to have a brief introduction into the world of GIS and geospatial - get familiar with raster and vector representation, find out about cartographic projections and explain, why Greenland is bigger than Africa on Google maps, and how to deal with it. \r\n\r\nIn the second part, we shall put our hands on the code, read some data, modify the data (make some analysis using common libraries) and writhe them back to the file. Processing some of the really big data files using block-windows will also be part of the workshop.\r\n\r\n[More information about workshop on GitHub.](https://github.com/gismentors/geopython-english#for-the-workshop-participants)	en	beginner	2h	f	t		free
6	workshop	Rapid prototyping robotics with ROS and IPython	On this workshop, you will learn how to connect to and program robots using Python. \r\n\r\n- We will introduce you to the Robot Operating System, which is a widely used framework for prototyping robots with a great number ready to use robotic packages for various robotic skills. \r\n- You will learn how Ipython and Jupyter Notebook can be used to rapidly create applications that access robots in real-time and you will write yours on the program to control a real robot! \r\n- We will bring a set of robots connectable to ROS so that you could make them move and collect data for you. \r\n- You will see how Python can be used to do robotic stuff fast and see how powerful can be a Jupyter Notebook when using it with ROS.\r\n\r\n---\r\n\r\nBefore coming to this workshop, please install some software:\r\n\r\nThe [github repository for the workshop](https://github.com/lidkalee/ipython_robot_prototyping).\r\n\r\nWe will provide you with a virtual machine with Ubuntu 16.06 and ROS installed. You need to be able to run this virtual machine, to do so please install following:\r\n\r\n - Enable virtualization in BIOS\r\n - Install [VirtualBox for your operating system](https://www.virtualbox.org/wiki/Downloads)\r\n - Install [VM VirtualBox Extension Pack](https://www.virtualbox.org/wiki/Downloads)\r\n\r\nSome tips for the installation are available in [Getting_Started_with_virtual_environment.ipynb](https://github.com/lidkalee/ipython_robot_prototyping/blob/master/scripts/excercises/Getting_Started_with_virtual_environment.ipynb).\r\n\r\nYou need to have ~13 GB free space for the image.\r\n\r\nThe virtual machine will be provided in .ova (Open Virtualization Appliance) so it is theoretically possible to use it with other virtualization software, but we will not have time to provide support.\r\n\r\nSimilarly, if you have Ubuntu (16.04) installed, you can install ROS and Ipython robot prototyping package in your native system (the instruction is provided in the README file of the repository "manual install") but we will not have time to help you with that during the workshop.	en	beginner	2h	f	t		free
1	workshop	Dash for beautiful and easy data visualiza­tion	Dash is a Python library that makes creating a web application for data visualization easy. \r\n\r\nIn this workshop, we will create a visualization with publicly available data. We will use Pandas to crunch data, Plotly to visualize them and pinch of Dash to make the web app.\r\n\r\nThe workshop will take approximately 4 hours.\r\n\r\nSee [workshop's GitHub repository](https://github.com/anastazie/dash-pycon-2018) for more information.\r\n\r\nPlease have [these tools](https://github.com/anastazie/dash-pycon-2018#installation) installed.	en	beginner	xx	f	t		free
5	workshop	Introduction to live coding music with Python and Super­Collider	This workshop will introduce the idea of live coding; the practice of creating live music and visuals with code. \r\n\r\n- We'll start with a discussion about "liveness" in music and how code can be used to articulate musical thoughts for real-time performance before getting a brief overview of the history of live coding and some of the popular tools used in the field. \r\n- Then we'll get hands-on with some of the basics of the Python-based live coding environment called FoxDot. FoxDot is used for describing rules for music, which sends messages to the powerful audio-synthesis engine, SuperCollider, via Open Sound Control. \r\n- We'll then go through the basics of putting together a live coded performance.\r\n\r\nPre-requisites:\r\n\r\n- Python 2 or 3 (inc. Tkinter libraries)\r\n- [FoxDot](http://foxdot.org/) (available on PyPI)\r\n- [SuperCollider 3.8](https://supercollider.github.io/) or above\r\n- [More instructions...](https://gist.github.com/hroncok/fd302d5fc9cce4b117194100245768ad)	en	beginner	2h	f	t		free
3	workshop	Build your own serverless image sharing web-site with Lambda, API Gateway, DynamoDB and S3	Learn how to build your own image sharing website, like Instagram, using serverless technologies. During the workshop, you will build an entire end to end system that’s powered by AWS Lambda, API Gateway, S3, DynamoDB, Auth0 and much more.\r\n\r\nServerless lets developers concentrate on the business logic that makes their application unique without the need to worry about infrastructure and scaling. \r\n\r\nDuring the workshop, the participants will be able to build a working end to end application using Amazon Web Services and the Serverless Framework which will help automate the deployment process. The workshop will include a Github repository which will have all the code ready to use. The aim of the workshop is to make the participants understand how the presented technologies can be used together so that later they can use them in their own projects. Python will be used for the back-end (AWS Lambda).\r\n\r\nIn order for things to go smoothly on Sunday here are the things to prepare before the workshop:\r\n\r\n1. An AWS account. If you don't already have one, you can sign up for a free trial that includes everything needed for the workshop and a lot more.\r\n2. Node.js v6.5.0 or later.\r\n3. Serverless CLI. You can run `npm install -g serverless` to install it.\r\n4. [Set-up your Provider Credentials]( https://www.youtube.com/watch?v=HSd9uYj2LJA).\r\n5. If you're using Mac or Windows you'll need [Docker](https://www.docker.com/docker-mac https://www.docker.com/docker-windows).\r\n\r\nIt's important to set up the AWS account as soon as possible since it will be too late on the workshop day.	en	beginner	2h	f	t		free
11	workshop	Python-based home automation platform	In this workshop, we'll build a simple home automation platform based on software written mostly in Python. During the workshop, we'll install all necessary software components and configure them step by step, we'll also make your IoT temperature sensor and connect all the parts together.\r\n\r\nWe'll use:\r\n\r\n- NodeMCU ESP8266 board with MicroPython with Dallas DS18B20 as IoT temperature sensor\r\n- MQTT (Mosquitto) for communication\r\n- Home assistant for collection data, sending notifications, and some automation examples\r\n\r\nThe hardware – temperature sensor, IoT ESP8266 board, wires, micro USB cable, breadboard etc., will be ready for you and if you want, you can buy them after the workshop and take working setup with you for further experimentation.\r\n\r\nCheck out [prerequisites](https://github.com/frenzymadness/pyconcz18_workshop/blob/master/Workshop.md#prerequisites) for this workshop.	en	beginner	xx	f	t		free
10	workshop	Writing pylint plugins	Pylint is the most popular Python source code analyzer which looks for programming errors,\r\nhelps enforce a coding standard and sniffs for some code smells. It is possible to write\r\nplugins to add your own checks, for example, coding patterns that you have observed inside\r\nyour software and are generally a bad practice or rules which you would like to enforce\r\ninside of a particular project, e.g. class name and inheritance conventions.\r\n\r\nThis workshop will focus on  understanding how the pylint plugin works, how to examine\r\nAST tree of a piece of code and create a minimalistic plugin from scratch.\r\n\r\nRequirements:\r\n\r\n- Python 3.6 installed and running\r\n-  pylint >= 1.8 installed inside virtualenv\r\n-  Try to identify several patterns observed in a project you worked on, which are not detected by standard pylint checks so that you can write a plugin for them. An instructor will provide some patterns for you if you don't have such.\r\n\r\n[Slides](https://s3.amazonaws.com/atodorov/slides/pylint_plugins_pycon_cz_2018.pdf).	en	beginner	2h	f	t		free
\.


--
-- Data for Name: proposals_financialaid; Type: TABLE DATA; Schema: pyconcz; Owner: pyconcz
--

COPY pyconcz.proposals_financialaid (id, note, date, accepted, full_name, email, amount, purpose, community_involvement, python_involvement) FROM stdin;
\.


--
-- Data for Name: proposals_ranking; Type: TABLE DATA; Schema: pyconcz; Owner: pyconcz
--

COPY pyconcz.proposals_ranking (id, object_id, content_type_id) FROM stdin;
3	4	11
4	5	11
5	6	11
6	7	11
7	8	11
8	9	11
9	10	11
10	11	11
11	12	11
12	13	11
13	14	11
14	15	11
15	16	11
16	17	11
17	18	11
18	19	11
19	20	11
20	21	11
21	22	11
22	23	11
23	24	11
24	25	11
25	26	11
26	27	11
27	28	11
28	29	11
29	30	11
30	31	11
31	32	11
32	33	11
33	34	11
34	35	11
35	36	11
36	37	11
37	38	11
38	39	11
39	40	11
40	41	11
41	42	11
42	43	11
43	44	11
44	45	11
45	51	11
46	46	11
47	47	11
48	48	11
49	49	11
50	50	11
51	52	11
52	53	11
53	54	11
54	55	11
55	56	11
56	57	11
57	58	11
58	59	11
59	61	11
60	72	11
61	62	11
62	63	11
63	64	11
64	65	11
65	71	11
66	66	11
67	67	11
68	68	11
69	69	11
70	70	11
71	73	11
72	74	11
73	75	11
74	76	11
75	77	11
76	95	11
77	78	11
78	79	11
79	80	11
80	81	11
81	82	11
82	83	11
83	84	11
84	85	11
85	86	11
86	87	11
87	88	11
88	89	11
89	90	11
90	92	11
91	93	11
92	94	11
93	96	11
94	97	11
95	98	11
96	99	11
97	100	11
98	101	11
99	102	11
100	103	11
101	104	11
102	105	11
103	106	11
104	107	11
105	108	11
106	109	11
107	60	11
108	110	11
109	111	11
110	112	11
111	113	11
112	114	11
113	115	11
114	116	11
115	117	11
116	118	11
117	119	11
118	120	11
119	121	11
120	122	11
121	2	12
122	3	12
123	4	12
124	5	12
125	6	12
126	7	12
127	8	12
128	9	12
129	10	12
130	11	12
131	12	12
132	13	12
133	14	12
134	15	12
135	16	12
136	17	12
137	18	12
138	19	12
139	20	12
140	21	12
141	22	12
142	23	12
143	24	12
144	25	12
145	26	12
146	123	11
147	124	11
148	125	11
149	126	11
150	27	12
151	127	11
152	128	11
153	28	12
154	3	13
155	4	13
156	5	13
\.


--
-- Data for Name: proposals_score; Type: TABLE DATA; Schema: pyconcz; Owner: pyconcz
--

COPY pyconcz.proposals_score (id, value, note, ranking_id, user_id) FROM stdin;
\.


--
-- Data for Name: proposals_talk; Type: TABLE DATA; Schema: pyconcz; Owner: pyconcz
--

COPY pyconcz.proposals_talk (id, note, date, accepted, full_name, email, bio, twitter, github, photo, title, abstract, language, difficulty, finaid_details, needs_finaid, final_note, referral_link, is_backup, is_keynote) FROM stdin;
37		2018-02-19 20:24:05.600214+00	t	Clément Verna	redactede@bro.cz	I have started contributing to the Fedora project 2 years ago by submitting PRs to some\r\nof the web applications maintained by the Fedora Infrastructure. I am now part of the \r\nFedora Engineering Team and work full time on python applications.	clemsverna	cverna	proposals/pyconcz2018/talks/cverna.jpg	How does the Fedora Infrastructure use Python	The Fedora Project relies on Python for their Infrastructure, almost all \r\napplications helping Fedora to be a successful Open Source Project are\r\ndeveloped using Python.\r\n\r\nThis talk will present the applications developed and maintained in Fedora\r\nand how they are deployed. The following topics will be developed: \r\n\r\n* Which applications for which problem\r\n* Which technologies (Web Framework, Message Bus, etc)\r\n* Python 2 vs Python 3 and migration Plan\r\n* Deployment (Ansible, Openshift)\r\n* Maintenance\r\n\r\nYou will also get all the information needed to start contributing to these\r\napplication and join the Fedora Infrastructure team.	en	beginner		f			t	f
128	starenka: tohle daval loni, vybrali sme to a pak nemoh prijet. ten abstract loni byl zasadne delsi	2018-03-08 22:10:21+00	t	Claus Aichinger	redactede@bro.cz	I am a Data Scientist, instructor and (co)organizer of PyDays Vienna. I enjoy programming, computing and "structuring things" as well as learning and sharing insights and opinions.			proposals/pyconcz2018/talks/claus_br1pEDA.jpg	Shipping Containers using Dunder Methods	In this talk, we delve into the world of container-related double underscore (dunder) methods which define an object’s behavior.\r\n\r\nWe will discover some of the most important dunder methods along the lines of the following two use cases:\r\n- How to extend a tuple to represent data? \r\n- How to implement a dict-like container for data handling?\r\n\r\nIn both cases we will try to quickly come up with implementations that not only serve our purpose but also render easy-to-use containers mimicking already existing ones.	en	beginner		f		http://2017.pyconuk.org/sessions/talks/implementing-custom-containers/	f	f
51		2018-02-24 09:54:43.379+00	t	Magda Zawora	redactede@bro.cz	Because this is my own story:) But acctually the topic relates to lots of people who decided to change the industry and start to work in IT. The process is becomming more and more popular. \r\n\r\nI'm a woman around 40, mother of two and currently EU project manager with dozen years of professional experience. About a year ago I started to learn Python with a goal to become a junior (yes!) python developer in a reasonable period of time.\r\nhttps://www.linkedin.com/in/magda-zawora/\r\n\r\nDuring this time I gathered experience which I think is worth sharing because a lot people can take advantage of it or, at least, be inspired. Python is considered to be the "entry language" so the process of changing the industry is in particular connected with Python community. \r\n\r\nI suppose conditions to change the profession in Czech Republic are simmilar to those in Poland, but in would be really interesting to talk about it and compare our experience.\r\n\r\nA month ago I had a talk during Pykonik, a meetup of Kraków Python community. That was a valuable event for me and for participants who are interested in makeing the change or are at the beggining of the process.\r\nhttp://pykonik.org/34/\r\n\r\nI have a blog telling in not a very serious way about my "transformation", unfortunately only in polish: https://early-bird.blog/.		MagdaZawora	proposals/pyconcz2018/talks/mzawora_foto.jpeg	Python developer wannabe. My idea how to become a junior.	In my presentation I treat my story as a case study. \r\nI'm telling about my backgroud, motivation, process of makeing decision, finding self-confidence and belief that I can reach the goal.  \r\nThen I provide audience with couple of pragmatical information - I recommend sources that I used and consider to be valuable, present pros and cons programming bootcamps and tell about how I planned a phase of learning on my own and what I managed to do during that period. And I explain how I organized my learning having very limited amount of time.   \r\nI'm finishing with a few thoughts and recommendations for people who beggin the process of change.	en	beginner		f			f	f
41	Miro zkontaktuje a prejmenujeme na "porting to 3k, lessons learned, ci neco takeho"	2018-02-20 21:28:01.428417+00	t	Matěj Cepl	redactede@bro.cz	I was working for the last almost two years as a principal maintainer of the project M2Crypto on its reviving from the obsolescence it was before. One of the main subprojects was porting it to be dual py2k-py3k compatible.	mcepl	mcepl	proposals/pyconcz2018/talks/p20170319_1804202.jpg	Wounded hero revived: M2Crypto again	The purpose of this talk is to remind people about M2Crypto. After many years of very light almost non-maintenance only by the brave RHEL maintainer, I have took over M2Crypto to port it to py3k and hoped to be done in a month the most. Now, two years later, the merge finally happened and M2Crypto has another chance to survive in the world where py3k compatibility is a necessity.\r\n\r\nThis presentation is about experience of porting large project combining Python and C from 2.5 to py3k compliance. I would like to describe the biggest problems and tools which helped me. The former were (aside from plenty of lingering bugs) complete mess of using 'bytes' and 'str' in py2k code. What helped a lot were PEP-484 annotations (working in py2k in the comment form), compatibility macros which are actually present in Python since 2.6.	en	beginner		f			f	f
39		2018-02-20 16:58:56.328385+00	t	Małgorzata Niewiem	redactede@bro.cz	I am a graduate of Applied Computer Science with specialization in Geoinformatics and now I work as Python programmer in Kraków. I use Python to develop algorithms to monitor world from satellite images. I am currently working on new algorithms to assess risk of damage due to mining subsidence. Also I am PhD student who loves scientific and technological challenges. I used any free moment on knowledge sharing  - on conference and Python workshops. Privately admirer of the roller-skates, mountains and jelly beans.			proposals/pyconcz2018/talks/DSC_7900.JPG	GeoPython - how to save the world using Python	Remote sensing offers an increasingly wide array of imagery with comprehensive and consistent coverage of the earth's surface.This field grows every day as more satellites are launched and availability of data increases. Satellite images acquire at frequent intervals with amount of details has been used to monitor changes on the Earth. That monitoring can not only help us to see the beauty world without leaving home but also see processes that occur on the earth to predict disaster situations. \r\nIn this talk, I am going to explore remote sensing and how it can be connected to Python. I will show how using GDAL, NumPy and OpenCV libraries to process satellite data to create full-scale information products. I will introduce some important algorithms used to change detection. This talk is intended for Python developers who want to see how space technology answer critical questions for better decisions.	en	beginner		f		https://www.youtube.com/watch?v=JJHQUbC5jsk	f	f
52		2018-02-25 11:51:07.183375+00	t	Ondrej Kokes	redactede@bro.cz	Economist by training, analyst and engineer by trade. I have been working with DataFrames over the past five years and faced issues scaling my workflows when dealing with data on the economy, energy, marketing, transactions, user behaviour, and a number of other areas, ranging from megabytes to terabytes in size. I will try and outline the various ways one can tackle the issue of scale while keeping their usage patterns largely unchanged.	kondrej	kokes	proposals/pyconcz2018/talks/ondrej.jpeg	DataFrames: scaling up and out	DataFrames have become ubiquitous when it comes to fast analyses of complex data. They go beyond SQL by not adhering to a strict schema and offer a rich API, where you chain methods, which fosters exploratory analytics.\r\n\r\nWhile newcomers to Python usually learn about pandas early on, they sometimes struggle as their underlying data grow in size. Given the in-memory nature of pandas' storage system, one can usually only scale up. I'd like to outline several workflows for adapting to ever increasing size of datasets.\r\n\r\n1. Changing application logic to handle streams rather than loading the whole dataset into memory. \r\n2. Actually scaling up - locally by buying more memory and/or faster disk drives, or by deploying servers in the cloud and SSH tunnelling to remote Jupyter instances.\r\n3. Scaling your datasource and utilising pandas' SQL connector. This will help in other areas as well (e.g. direct connections in BI).\r\n4. Using a distributed DataFrame engine - dask or PySpark. These scale from laptops to large clusters, using the very same API the whole way through.\r\n\r\nI will cover the various differences between these approaches and will outline their set of upsides (e.g. scaling and performance) and downsides (DevOps difficulties, cost).	en	advanced		f			f	f
130		2018-03-14 22:36:17+00	t	Karen M. Sandler	redactede@bro.cz	Karen M. Sandler is the executive director of the Software Freedom Conservancy, which is the nonprofit home of over 40 projects, including Git, Samba, QEMU, Selenium and Inkscape (to name a few). Karen is known as a cyborg lawyer for her advocacy for free software as a life or death issue, particularly in relation to the software on medical devices. Prior to joining Conservancy, she was executive director of the GNOME Foundation. Before that, she was general counsel of the Software Freedom Law Center. Karen co-organizes Outreachy, the award-winning outreach program for women globally and for people of color who are underrepresented in US tech. She is also pro bono counsel to the FSF and GNOME. Karen is a recipient of the O’Reilly Open Source Award and cohost of the oggcast Free as in Freedom.	o0karen0o		proposals/pyconcz2018/talks/kms5.jpg	TBD	TBD	en	beginner		f			f	t
58		2018-02-27 07:02:24.589687+00	t	Stefan Behnel	redactede@bro.cz	I'm a long-time Python developer and probably best known in the community as a core developer of the Cython and lxml projects. I give trainings on Cython programming and enjoy telling people about it at conferences.			proposals/pyconcz2018/talks/kopf_sw.jpg	Cython to the Rescue	You just found that C library which solves that huge problem you have. It solves it completely, it's so fast, it's old, rock solid and well tested - and difficult to use, because it has that real-world, well aged C-API. Maybe even C++. So, you want to use it from Python, but there's no wrapper yet? Or worse, the existing wrapper is auto-generated and feels clumsy, slow and just as ugly to work with as C?\r\n\r\nGive Cython a try! It's the fastest way to make Python talk (to) native code, and a pleasure to work with as a general programming language.	en	advanced		f			f	f
74		2018-02-27 18:52:20.349467+00	t	Van Lindberg	redactede@bro.cz	I help companies with privacy and GDPR issues professionally and there are very few who understand how GDPR requirements intersect with open source community and big data issues.	VanL	VanL	proposals/pyconcz2018/talks/Headshot-gray-large.jpg	Privacy issues in Open Source: The GDPR and You	The GDPR goes into effect in May of this year, bringing with it a new set of privacy requirements for those doing business with anyone in the EU... and "doing business" is broad enough to include "working in open source."\r\n\r\nThis talk is about the intersection of GDPR requirements and how they apply to common situations like having signed commits, forking, having a mailing list, and other open source project basics. We'll discuss the issues and give some guidelines for working under the new law.	en	beginner		f			f	f
67		2018-02-27 14:36:43.298545+00	t	Tomáš Ehrlich	redactede@bro.cz	I'm a full-stack developer on a project which uses GraphQL - I'm dealing with this technology both from client and server perspective. Even after several months, I haven't lost the enthusiasm for this new technology and I consider it as a standard for implementing APIs in my projects.	tomas_ehrlich	tricoder42	proposals/pyconcz2018/talks/tomas_squared.JPG	GraphQL is the new black	REST is a standard for writing APIs, but there might be a better way. GraphQL is a query language which makes APIs more flexible and easier to evolve over time. It gives clients the power to ask for exactly what they need which results in optimized bandwidth, server usage but also allows writing declarative UIs. The talk will compare GraphQL with REST API to show the differences and advantages as well as real examples. Ministry of Python warns: This talk might include a bit of JavaScript.	en	beginner		f			f	f
66		2018-02-27 14:23:37.006351+00	t	Ann Barcomb	redactede@bro.cz	I am a PhD candidate researching managing episodic (casual) contributions in free/libre and open source software communities. Before becoming a researcher, I worked as a community manager and as a software developer, and contributed to free software projects, mostly in the areas of conference organization, mailing list summaries, and speaking at conferences. My research topic is a long-term interest and a passion, and I combine academic findings with personal experience.	ae3nn		proposals/pyconcz2018/talks/IMG_1178_1BWLR.jpg	Casual contributors: who, why, and how	Increasingly, people want to contribute to projects casually. A number of factors have driven this change, among them distributed revision control, social coding platforms, and the general trend toward “new volunteerism.” To take advantage of these contributions, communities need to adapt to the needs and expectations of casual contributors. Yet at the same time, no community wants to invest more effort in inviting casual contributions than it receives in return. This talk will cover the benefits of incorporating casual participants, the factors that influence their return, and practices for engaging them. The material draws on the body of scientific research, the speaker’s own research, and her personal experiences both as a community manager for a non-profit and as an open source contributor.	en	beginner		f		https://www.youtube.com/watch?v=dt_xDOZcJ1A	f	f
100		2018-02-28 20:31:47.774874+00	t	Thiago da Silva Alves	redactede@bro.cz	I like academic environments, so I am currently studying Computer Science at UTFPR and Masters in Information Systems at the Polytechnic Institute of Bragança - Portugal.\r\n\r\nAmong my main interests are artificial intelligence, bioinformatics and any other area with difficult problems to solve computationally.\r\n\r\nI am currently doing research with CIMO, where I use python to create tools that help researchers and beekeepers to preserve bees and increase their productivity. In my free time I also contribute with an AI group that I recently helped to create in the institution.		AvsThiago	proposals/pyconcz2018/talks/me_eIWMVlj.jpg	Honeybee conservation with Python	In the apidologie research area, there is one task that obliges the researcher to classify and count the contents of each comb cell in each frame. With this task is possible to control the progression of brood, bees, and food reserves. Since each frame can have thousands of cells, in most cases this task is done by a human in an approximate way, making it error prone. The automation of this process, using image analysis represents an evolution in this field.\r\n\r\nThe honey bee is the world’s most important pollinator of food crops. Almost one third of the food that we consume each day relies on pollination done mainly by bees. So the creation of softwares that helps the preservation of this especie has a direct impact in our lives.\r\n\r\nI am going to show you a few challenges we have faced, from creating comb cell detectors using OpenCV and Shapely, to developing models based on Deep Learning to classify the cells content using the Caffe framework. With these models, we have obtained accuracy above 98% within eight different classes and solved the proposed problem.	en	advanced		f			f	f
101		2018-02-28 20:43:04.141061+00	t	Igor Davydenko	redactede@bro.cz	I am Python developer for last 11 years, while using Python 3 and asyncio stack in production for last 3 years. Therefore I want to share my experience on how asyncio stack handles latest trends in web development for the audience.	playpausenstop	playpauseandstop	proposals/pyconcz2018/talks/Davydenko.jpg	Is asyncio stack ready for web development?	If you're developing web applications on Python you might heard about asyncio stack (Python3, asyncio, aiohttp, uvloop, etc) that allows other developers to gain same targets as you without using Django, Flask or other sync web framework. \r\n\r\nLet's talk about why asyncio stack became popular for web development between Pythonistas, especially in Eastern Europe countries (Ukraine, Russia, etc). Which projects built using it and how they compares to traditional web projects.\r\n\r\nI will also talk about lessons learned on developing, testing and deploying aiohttp application to production, aiohttp application which used to sign legal documents online in Ukraine.	en	beginner		f		https://www.youtube.com/watch?v=WCez3zbM2eU	f	f
106		2018-02-28 22:29:49.871285+00	t	Tanya Tereshchenko	redactede@bro.cz	Software Engineer at Red Hat and a developer on Pulp which is an open source Python project for  managing Python packages among other types of software. \r\nOpen source enthusiast and Python developer who also enjoys cycling, snowboarding and is interested in molecular biology.			proposals/pyconcz2018/talks/ttereshc_pulp2.jpg	Host Your Own PyPI & Create Reproducible Environments using Pulp	Even though software changes constantly under our feet, sometimes we want to keep an old version of a package or organize the packages we want to distribute in a certain way. Reproducible results require reproducible environments so it is important to take matters into your hands.\r\n\r\nPulp[0] enables large and small organizations to fetch, upload, organize, and distribute software packages in a consistent manner.\r\n\r\nIn this session we will focus on how to manage Python packages with Pulp.\r\nWe will go over use cases like:\r\n- mirroring PyPI content\r\n- managing a carefully curated set of packages\r\n- promoting packages through your software development life cycle\r\n- publish immutable snapshots, and rollback when things go wrong.\r\n\r\nStop by and share your use cases and experiences after the talk.\r\n\r\n[0] https://pulpproject.org/	en	beginner		f			f	f
123		2018-03-04 18:46:11.846998+00	t	Robert Kuska	redactede@bro.cz	I am a software engineer at Kiwi.com. I used to know close to nothing about memory management until I decided to have a talk about it. Now I know a little bit more. In my free time I embroider and cycle to Jozo's distaste.	@DasIstHerrKuska		proposals/pyconcz2018/talks/profile_MUgJ7v1.jpg	Bits and bytes of Python memory management	Is it true that python is not returning memory back to OS?\r\nWhat happens with variables which are no longer needed?\r\nHow important is garbage collector?\r\nHow to trace and profile memory usage?\r\nLet's find out answers to these and maybe some more questions.\r\n\r\n\r\nOverview:\r\nIntroduction:\r\nWhy do I need to care about memory management in python?\r\nObjects in python, what are they?\r\n\r\nMemory management:\r\nHow memory is being allocated at start/while running - blocks/pools/arenas\r\nHow is memory being freed - reference counting/garbage collector\r\nExtras - small integers identity, sys.intern, sys.getsizeof, list/dicts dynamic allocations\r\nHow to find cycles in variables referencing\r\n\r\nTools for memory management:\r\nOverview of available tools for managing memory\r\nHow and why instagram disabled/re-enabled garbage collector	en	beginner		f		https://www.youtube.com/watch?v=Y3J8vYL_Vro	f	f
75		2018-02-27 21:53:25.86067+00	t	Martin a Iva Javorkovi	redactede@bro.cz	Iva Javorková\r\nJsem programátorka a poslední 2 roky učím programovat děti. Mými kroužky již prošlo několik desítek dětí ve věku 7-14 let. Postupy, jak naučit děti programovat a hlavně informaticky myslet, testuji na vlastních dětech a následně ověřuji a dopilovávám v kroužcích.\r\n\r\nMartin Javorek\r\nPřes den vymýšlím jako analytik v bance nové systémy, v noci jsem podpora všech aktivit kolem programování dětí. Více než 2 roky se věnuji studiu materiálů o programování dětí v jiných zemích, zkoumám novinky a píšu o nich. Jako technicko-administrativně-marketingová podpora pomáhám mé ženě provozovat u nás doma kroužky programování. Stal jsem se členem týmu projektu PRIM - podpora rozvoje informatického myšlení do škol.\r\n\r\nSpolečnými silami oba pořádáme v naší obci veřejné programovací akce pro děti: https://programohrani.cz	programohrajeme		proposals/pyconcz2018/talks/P1000451_crop.JPG	PROČ a JAK učit děti programovat	Rádi bychom vám krátce nastínili proč a jak učit děti programovat.\r\n\r\nPROČ bychom měli děti učit programovat i přesto, že ze všech nechceme mít programátory? PROČ a JAK se dnes učí programovat děti v jiných zemích Evropy a světa? Jak je na tom ČR a co se chystá. \r\n\r\nJAK začít. Jak rozjet svůj vlastní kroužek, i když třeba škola nemá počítačovou učebnu. Jak uspořádat jednorázovou programovací akci pro děti a rodiče. Jak rozvíjet informatické myšlení už u předškolních dětí, v čem, co a jak mohou programovat děti ze základní školy. Slasti a strasti lektorování kroužku programování pro děti.	cs	beginner		f			f	f
97		2018-02-28 19:32:35.62118+00	t	Stan Prokop	redactede@bro.cz	As a youngster I wanted to become a game developer, but (fortunately?) I happened to become a QA engineer, and I eventually transformed into a software engineer with strong testing background. \r\n\r\nMy past includes Centrum.cz, GoodData and Skype/Microsoft and I luckily end up between good folks at Accolade (not the game developer which no longer exists, but on-demand healthcare concierge). \r\n\r\nI have wife, one kid, no dogs and no cats. I have no quirks. Just prefer to walk barefoot at home, in the office and sometimes outside.		prokopst	proposals/pyconcz2018/talks/stan.jpg	How NOT to test software	In 1946, Grace Hopper found a bug trapped in a relay and coined the term bug. Except the term "bug" for an error was actually used before, for example in 1878 Thomas Edison in his letter to Theodore Puskas. Moreover it wasn't a true bug, it was a moth. And it wasn't even Hopper who found the moth. Plenty of bugs in the bug's story. \r\n\r\nSoftware testing is full of myths, mythical silver bullets and "good" and bad practices. In this talk, I'll debunk myths, share bad practices and explain how good practices can turn out to be not so good when applied in the real world of software engineering. All with focus on our beloved Python. \r\n\r\nExamples are unit tests tightly coupled to implementation details, always unstable integration tests and targeting 100 % code coverage.	en	beginner		f			f	f
45		2018-02-22 12:33:20.458506+00	t	Lukáš Kokoška	redactede@bro.cz	I've started my Python career with version Python 2.3 making SMS messaging and content management. As years passed I've worked on many projects in Seznam.cz and other companies. My current title is Head of research and development and I'm working on topics like payment gateways, content repository, hi-perf messaging and HbbTV.	@lukoko_name		proposals/pyconcz2018/talks/lukoko_fotka.jpg	How to handle linear HbbTV broadcast with Python for 10 TV stations	DVB broadcast is linear, HTTP is not. HbbTV is standard binding world of linear broadcast and stateless HTTP together. \r\n\r\nThere are many challenges to correctly handle web content in TVs, especially with completely different approach from broadcasters.\r\n\r\nI will show you, how to serve advertisements and measure traffic to hundreds of thousands always connected devices on single server. With just 40% of devices capable of WebSocket, you have to find ways to get performance elsewhere. Ad targeting and caping in shared memory for linear subscribers on 10+ years old devices with Python and uWSGI.	en	advanced		f			f	f
102		2018-02-28 20:45:23.546144+00	t	Justin Mayer	redactede@bro.cz	I am an active open-source contributor and advocate for stronger security and privacy. My latest projects include Monitorial.com, a solution for identifying and addressing potential security vulnerabilities, and Fortressa.com, which enables anyone to create their own private, self-contained VPN. I am the primary maintainer of the Pelican static site generator, Django-Elevate, and various other open-source projects.\r\n\r\nhttps://github.com/getpelican/pelican\r\nhttps://github.com/justinmayer/django-elevate\r\n\r\nI speak fluent Japanese, graduated with honors from the University of California, Berkeley, and received my M.B.A. from the Wharton School of Business. I can usually be found with a glass of Valpolicella in one hand, and Taleggio in the other. (Wine and cheese, respectively.) 🍷 🧀	jmayer	justinmayer	proposals/pyconcz2018/talks/jm-headshot-alpha-grayscale-cropped-alt.jpg	Use Multi-Factor Authentication Everywhere Because Passwords Are Terrible	When we deploy web applications, users entrust their data to us and expect that we will protect it. Meanwhile, recent high-profile breaches have underscored the risks of username+password authentication, which is the default in Django and other Python web frameworks. One of the best ways to mitigate this risk and protect our users’ data is to add multi-factor authentication (MFA) capability to our applications.\r\n\r\nMFA can take various forms, including:\r\n\r\n* one-time passwords (TOTP)\r\n* hardware keys (Yubikeys, U2F, etc.)\r\n* email-based authentication\r\n\r\nThese factors can be used independently or in conjunction with one another to provide vastly greater security than the traditional username-plus-password combination.\r\n\r\nAttendees of this talk will walk away with a detailed understanding of:\r\n\r\n* why the traditional username-plus-password combination is failing us\r\n* how to enforce password safety, including checking via Pwned Passwords API\r\n* when email-based authentication is appropriate\r\n* overview of one-time passwords (OTP)\r\n* state of hardware keys in general, and FIDO U2F standard in particular\r\n* W3C Web Authentication standard (“webauthn”)\r\n\r\nMost importantly, attendees will learn how to implement U2F key and TOTP-based multi-factor authentication in their own Python-based web applications in just a few minutes.\r\n\r\nThis will include an overview of related open-source projects:\r\n\r\n* https://github.com/gavinwahl/django-u2f\r\n* https://bitbucket.org/psagers/django-otp\r\n* https://github.com/lionheart/pwnedpasswords\r\n* http://django-nopassword.readthedocs.io\r\n* https://github.com/aaronn/django-rest-framework-passwordless\r\n\r\nGiven how quickly a developer can add U2F and TOTP to a Python-based web application, attendees will hopefully leave this talk with the conviction that they will never again ship a project without support for multi-factor authentication. 🗝	en	beginner		f		https://www.youtube.com/watch?v=4DvLHgB9sGs	f	f
19		2018-02-09 12:36:38.014681+00	t	Petr Viktorin	redactede@bro.cz	During the day, I lead the Python Maintenance team at Red Hat.\r\n\r\nPersonally, I focus on teaching Python to others – and empowering others to teach as well. You might know me from a course or a workshop I helped prepare in some way.	encukou	encukou	proposals/pyconcz2018/talks/pviktori.png	Bytecodes and stacks: A look at CPython's compiler and its execution model	Bytecodes and stacks: A look at CPython's compiler and its execution model\r\n\r\nSo, you wrote some Python code. What needs to happen before it starts running? And once it's running, how does Python keep track of what it's doing?\r\n\r\nI'll talk about CPython's tokenization, parsing, bytecode and its serialization and caching, the stack-based virtual machine, line number tables and code, frame and function objects.\r\n\r\nDon't worry if you've never heard about these concepts. While even experts should learn something new, the talk is aimed at anyone who's worked on a Python project or two.	en	beginner		f		https://cz.pycon.org/2017/speakers/detail/talk/14	f	f
54		2018-02-25 18:29:44.59478+00	t	Christian Heimes	redactede@bro.cz	I'm one of the maintainer of CPython's ssl module, contributor to OpenSSL, PyOpenSSL, and PyCA Cryptography. In my day job at Red Hat, I'm a security engineer for identity management (freeIPA), public key infrastructure (Dogtag PKI), and related technologies.	ChristianHeimes	tiran	proposals/pyconcz2018/talks/importthis3_9HlImOI.jpg	SSLError, now what?	TLS/SSL is the most important and widely-used protocol for secure and encrypted communication, e.g. HTTPS. It offers more than just encryption. TLS also ensures data integrity and strong authentication with X.509 certificates. But it provides merely a false sense of security if you use it wrong.\r\n\r\nHave you ever encountered SSLError while connecting to a server, but you didn’t understand what is going on? Are you running production code without TLS/SSL protection or with cert validation disabled, because you couldn’t figure out how to make it work correctly?\r\n\r\nI’ll give you the rundown of the basic cryptographic building blocks, protocol handshake, inner structure of certificates, and PKI. You’ll learn about best practices, debugging tools and tips how to diagnose TLS/SSL and how to deal with certificates.	en	beginner		f			f	f
104		2018-02-28 21:04:07.512377+00	t	Rae Knowler	redactede@bro.cz	I'm a web developer in Zürich, where I develop product data APIs and work on Open Data projects. I am interested in the fascinating, comical and sometimes tragic results of attempting to cram the complexity of life and society into computer systems. In my spare time, I read a lot of science fiction and hug cats.	RaeKnowler	bellisk	proposals/pyconcz2018/talks/rae_with_computer.jpg	Hypothesis: Property-based testing for Python	We all know we should be writing tests--but coming up with tests for every edge case is hard work and you will inevitably miss some. Tell Hypothesis what kind of data your tests need and let it explore that space. When it finds a bug, it finds the simplest case where your code fails.\r\n\r\nIn this talk, I'll show you how to use Hypothesis in your projects to find more bugs than you would imagine.	en	beginner		f		https://vimeo.com/134190370	f	f
61		2018-02-27 11:09:35.980094+00	t	Margriet Groenendijk	redactede@bro.cz	I am a Developer Advocate and Data Scientist exploring ways to work with diverse data about which I write blogs and give talks. I am very proud of finally contributing to the open source project PixieDust after so many years of being a user of open-source software. My background is in climate science research where I explored large observational forest datasets and the output of global scale weather and climate models.	MargrietGr	MargrietGroenendijk	proposals/pyconcz2018/talks/Image_uploaded_from_iOS_9_edit.jpg	Navigating the Magical Data Visualisation Forest	Data visualisation is fun but can take up a lot of time, especially when you are exploring new data. The magic forest is much easier to navigate with PixieDust, a free open-source Python library that makes it quick and simple to explore data with any visualisation library without writing code in a Jupyter notebook. Learn how PixieDust takes out some of the coding, how to contribute, and how to make and share visualisations in seconds.\r\n\r\nThere are many different Python libraries available for data visualisation. These all have different philosophies, syntax and ways to create charts. To make charts in a Jupyter notebook in seconds, PixieDust integrates with any library and visualises data in a Pandas or Spark DataFrame. matplotlib, Bokeh, seaborn and Brunel are the renderers added so far, but there are many more! In this session you will learn how to find your way in the magical forest of visualisation libraries through examples creating charts, plots and maps of forest data. \r\n\r\nIn the final part of this session you will learn how you can contribute to PixieDust by adding new visualisation libraries or suggesting improvements for the existing ones. Let PixieDust be your compass to navigate the data visualisation forest!	en	beginner		f		https://www.youtube.com/watch?v=gBtiTLnzTU8	f	f
99		2018-02-28 20:17:42.502364+00	t	David Žihala	redactede@bro.cz	I am a PhD student from the University of Ostrava. I am mainly interested in alternative genetic codes, evolution, GTPases and molecular biology of unicellular eukaryotic organisms. I started coding in Python approximately 2 years ago and I basically love it. I contributed to many scientific projects just because of Python. I consider Python so great and useful that I started to teach other people how to code.  Now, we have official Python course in our department, we organize Python workshop for biologists 'OstraPy' and we also have weekly meetings with pizza, where we discuss many topics, including Python.			proposals/pyconcz2018/talks/avatar_R6YUiG6.png	How Python code is helping us to solve genetic codes	Genetic code is a set of rules which are telling us how the organisms translate information from mRNA into amino acids, the main parts of all proteins. Majority of organisms use so called standard genetic code. However, a growing list of exceptions described from various organisms revealed an unexpected evolutionary flexibility of this fundamental molecular mechanism. Our lab has recently contributed to this field by discovering three novel genetic code variants.\r\nThe first part of the presentation will provide a brief introduction to the topic of genetic codes and the second part will be dedicated to our new findings in the filed of alternative genetic codes and how Python help us with some of them.	en	beginner		f			f	f
35		2018-02-19 11:37:30.829754+00	t	Mila Votradovec	redactede@bro.cz	I am a developer with a passion for problem-solving, puzzles and guitar. I am a self-starter, who tried to complete formal education after years in a field. I have been working for corporates, small companies and startups. I still remember being completely fresh in the field. I was grateful for any guidance or advice, so I am trying to pay back by mentoring others. I currently live in London and work for https://snyk.io, company which provides Security as a Service.	MilaVot	miiila	proposals/pyconcz2018/talks/mila_photo.jpg	Security of your application is just a few clicks away	Every time you type `pip install -r requirements.txt`, you are putting your web application and user data at risk. Modern web applications are using dozens of 3rd party components, that are totally out of your control. You've already learned you should test your code, but I'll do my best to convince you that you should test external code for the security vulnerabilities too.\r\n\r\nIn January, two biggest vulnerabilities, Meltdown and Spectre, were publicly disclosed (you might remember whole internet restarting few days after). Those are the most known ones, but smaller vulnerabilities are published nearly every day. And all of them can be exploited and used to abuse your application. Attacker might try take your application out, steal your users data or take advantage of your compute power.\r\n\r\nSince vulnerabilities are disclosed, they can be also mitigated. There are multiple vendors dealing with security testing and I'll focus on the solutions for pypi package scans. During the talk, I'll show you how a vulnerability can be exploited, where and how it is reported (you'll learn what the CVE is) and how you can secure your application using `GitHub's security alerts for vulnerable dependencies` and `Snyk.io` on various levels (repository integration, CI server, CLI integration).	en	beginner		f		https://www.youtube.com/watch?v=Swl8lRe9YNI	f	f
13		2018-02-02 16:55:25.393601+00	t	Sasha Romijn	redactede@bro.cz	As the title and abstract say, I've always been curious about many aspects of cryptography, both from a practical product development perspective, but also just out of interest. However, really didn't believe I could ever understand any of it. By now, I know better and have found that many aspects really aren't that complicated. I'm also good at explaining these kinds of concepts.	mxsash	mxsasha	proposals/pyconcz2018/talks/201708_dcus-b_800px_aQKfWvf.jpg	Everything I always wanted to know about crypto, but never thought I'd understand	For many years, I had entirely given up on ever understanding the slightest thing about cryptography. The amount required to understand even the most basic part seemed entirely dazzling. However, I’ve since learned it’s not nearly as hard as I thought to understand many of the important concepts.\r\n\r\nAnd this is what I want to share with you. For this talk, you don’t need to know anything about cryptography, and almost no math knowledge. You’ll gain an understanding of what the different components are and how they interact. And learn to get a grasp for how a system works, without necessarily understanding the details of each individual part.\r\n\r\nIn this talk, I’ll take you through some of the underlying design principles of modern applications of cryptography. We’ll talk about what we’re trying to accomplish, which parts are involved, and how to prevent and understand common vulnerabilities. This will help you to make better choices when you implement cryptography in your products, and will improve your understanding of how crypto is applied to things you already use.	en	beginner		f		https://www.twilio.com/signal/london/schedule/zlWFFtNFE4WymoK8amA8a/healthy-minds-in-a-healthy-community	f	f
49		2018-02-23 20:07:26.664288+00	t	Lukáš Hurych	redactede@bro.cz	I'm a product/marketing guy with development background (Python is my biggest love but I went through Ruby, PHP, Swift, Javascript, Java). Study of psychology gave me great knowledge for marketing but the combination with Python is a killer for phishing, writing malware, hacking and all the fun stuff. I'm doing all this just as a hobby trying to test and protect our company and our team.	LukasHurych	LukasHurych	proposals/pyconcz2018/talks/12141113_10205160907397811_2009156475119368823_o.jpg	Dark Python: social engineering and hacking with 70% success rate	In the course of the last few years I launched a lot of different attacks in our company (60+ teammates) and with some of them, I had a success rate of 70%. From getting people’s Facebook accounts or access to their LastPass accounts to custom written malware.\r\n\r\nThe threat that anyone can steal your customer data is a potential killer of any (financial) company. Being suspicious and aware of all potential phishing attacks and other traps is a must.\r\n\r\nIn this talk we will look at the practical (dark) examples I have executed and why Python was the best language of choice. From social engineering (sophisticated phishing attacks), custom malware, dropping nasty USB drives on the street to technical/network attacks.\r\n\r\nWhen you want to be really successful in doing social engineering you need to prepare the ultimate user experience. You can not make a mistake and you can not overlook little details (that usually happens if you develop your own apps/websites). Those little details make UX in your app/website awesome (if you are on the good side) but can be exploited pretty easily by the dark side.	en	beginner		f		https://www.youtube.com/watch?v=pMVgj-vyVOw	f	f
68	starenka: ten talk sem nevidel (ted na pyconsk), ale nezavisle za mnou prislo cca 10 lidi a hustili do me, ze je to SUPER a ze to musime mit u nas.	2018-02-27 15:15:11+00	t	Ryan Kirkbride	redactede@bro.cz	I am currently in the middle of a practice-led PhD in Music researching communication and collaboration in live coding – the practice of generating live music using code. I developed a Python-driven live coding environment, called FoxDot, for live coding musical patterns with a focus on object-oriented programming and perform improvised melodic techno regularly under the stage name “Qirky”.	ryankirkbride26	Qirky	proposals/pyconcz2018/talks/lisbon_1.jpg	Programming Music for Performance: Live coding with FoxDot	In this talk I will introduce the topic of live coding; the interactive programming experience for generating sound and visuals but this talk will mainly focus on the audio side. Live coders use programming languages to describe rules for generating music but then re-write these rules while the program is running. By continually writing and re-writing these rules live coders creating a shifting musical experience that is always in flux. All of this happens live in front of audience with the code projected for all to see. \r\n\r\nI will go on to discuss a few of the many tools that are available for live coding and showcase the FoxDot environment, which allows you to live code music using Python. I will talk about the motivation for developing FoxDot and describe some of its key features as well as how you can set it up yourself at home. The talk will be concluded with a short demonstration that will be part explanation and part performance.	en	beginner		f		https://www.youtube.com/watch?v=_gksJ3emMps	f	f
122		2018-03-04 14:02:17.332991+00	t	Petr Baudis	redactede@bro.cz	I built machine learning based technologies for 10 years now, and build deep learning models for past couple of years.  Some of the interesting work I did is the Pachi Go program (used to be the best open source Go-playing program for many years) or the YodaQA open source question answering engine.  I'm co-founded and currently lead the R&D at Rossum.ai, a startup building Artificial Intelligence for document understanding.  And Keras contributor. :)	xpasky	pasky	proposals/pyconcz2018/talks/me_CRc6dFr.jpg	Machine Learning and Keras	What is needed for machines to automatically teach themselves to make decisions based on examples? Machine Learning is all the rage nowadays and may seem very magical, especially on "unstructured data" like texts, pictures or sounds.\r\n\r\nBut what is actually a "neural network" and do you need a PhD to build some?  Turns out that machine learning models are far less magical than they seem to be (at least when solving the more common tasks).  Even if your program will acquire magic powers in the eyes of your users.\r\n\r\nWe will unveil the dark secret of how neural networks actually look inside.  And to solve two real problems (related to text and pictures), we will actually build a couple of simple ones in the popular python framework "Keras".	en	beginner		f		https://www.youtube.com/watch?v=6fKG4wJ7uBk	f	f
79		2018-02-28 08:57:46.310777+00	t	Jirka Vejrazka	redactede@bro.cz	I've been using Python for IT security purposes for 10+ years	JirkaV	JirkaV	proposals/pyconcz2018/talks/jirka-twitter.jpg	Portscan all the things! (fast, distributed and effective)	A real world example of a port scanner written in pure Python as no existing tool fit the bill.\r\n\r\nQuick introduction to port scanning, example of a distributed Python code running on multiple systems across the globe and bypassing common portscan detection/prevention systems.	en	beginner		f			f	f
129		2018-03-14 22:33:16+00	t	Dawn Kernagis	redactede@bro.cz	Dawn Kernagis is a Research Scientist at the Institute for Human and Machine Cognition. Her research is focused on human performance optimization and risk mitigation for humans in extreme environments, such as people working undersea, at altitude, and in space.\r\n \r\nBefore coming to IHMC two years ago, Dawn completed her PhD and Postdoctoral training at Duke University, where she studied new ways to treat brain injury, genetic susceptibility to extreme environmental conditions, and novel cancer diagnostic methods.\r\n \r\nDawn has also been a diver with numerous underwater projects since 1993, including the mapping and record-setting exploration of some of the deepest underwater caves in the world. Her experiences led to her induction into the Women Divers Hall of Fame in 2016. In 2016, she was also selected as one of 6 crew members to join NASA’s underwater mission, NEEMO.			proposals/pyconcz2018/talks/28309147_10155786395371348_536469574_o.jpg	The Human Factor: Optimizing Life for People in Space	While the rate of spaceflight technology advancement continues to accelerate, there are still significant considerations when it comes to the health and safety of the ultimate product end-users: humans. Long-duration missions have allowed researchers to stratify the effects of living and working in space on humans. These impacts on our physiology and psychology range from negligible, to addressable, to potentially mission-limiting. This presentation will provide an overview of how living in space affects the human and what we are doing to optimize the health, safety, and performance of people in space.	en	beginner		f			f	f
73		2018-02-27 18:45:53+00	t	Van Lindberg	redactede@bro.cz	I've been around open source for more than 20 years, but my focus has always been on the side of "making communities work." I am also one of the few people that companies come to to help understand and build sustainable open source communities.\r\n\r\nI've seen both good and bad examples. The reasons why projects fail are varied, but they frequently come down to the relationship between the initial committers and the community they start to build. With a little work, almost any community can be successful.	VanL	VanL	proposals/pyconcz2018/talks/informal-headshot.jpg	Balloons, Projects, and Python: Building a Sustainable Community	A lot of people get started in open source by "scratching their own itch" - building something that they want for themselves. But starting the project isn't the hard part: it is keeping it going in a reasonable, sustainable way.\r\n \r\nI’ll be honest: creating and building a sustainable open community is hard. It involves giving up some control. It involves developing and exercising a different set of skills other than those needed for technical mastery. So how do you do it?\r\n\r\nI’ll start out with three stories about successful open communities, and how they were able to succeed. Then I will talk a little about why these communities work. It isn’t fairy dust. It isn’t even altruism. It’s economics, psychology, and communication. Finally, I will give some guidelines around how you can build your own sustainable community.	en	beginner		f			f	t
34		2018-02-19 00:20:47+00	t	Nick Lang	redactede@bro.cz	I have been working remote for almost 10 years for companies such as Docker, Elastic and freelancing. Some of it good and some of it bad. Mostly good though. \r\n\r\nI feel like through my experience others can learn if remote working is for them or not.	fxdgear	fxdgear	proposals/pyconcz2018/talks/nicklang.jpg	Lessons Learned from Working Remote	Working Remotely brings with it a whole new set of challenges. It can be rewarding, challenging, fun and exciting. But it can also be lonely and depressing and frustrating.\r\n\r\nWe will go over some of the bad parts and how to best combat them. Some strategies employers can implement to help alleviate problems for remote workers.\r\n\r\nThis talk dives into the lessons learned from Elastic and other companies that use distributed and remote teams.	en	beginner		f			f	t
30		2018-02-17 17:41:48+00	t	Sam Trojan	redactede@bro.cz	I'm 13 years old and I started learning how to program in September 2017 (HTML and JavaScript) so I have first-hand experience with my topic. \r\nI gave a Lightning Talk (Three Reasons Why Kids Aren't Interested in Programming) at DevFestCZ last year. I only had 24 hours to prepare and gave the talk without slides... I'm planning on having a lot more time to get ready for this one.\r\nI attended PyConCZ 2017 and really enjoyed meeting people and learning more about the world of IT. \r\nBTW my mom is Jeanne Trojan so I have an in-house Presentation Coach ;)	@SamuelTrojan		proposals/pyconcz2018/talks/SamuelTrojan.jpg	Three Ways My Programming Teacher Rocks (and you can too)!	As I said in my DevFestCZ talk, most of the teenagers I know aren't interested in learning programming. Some of the blame is probably because of the way it's being taught. \r\nI think this should be changed and my programming teacher is a fantastic example of how to get kids excited about programming. \r\nIn this talk, I'll show you some ways that he does it right and give you some examples that will help you rock, too. \r\nI think you'll leave this talk knowing more about how to teach teenagers programming in an interesting and effective way.\r\nThis will be an interactive talk with the chance to ask questions and share your experience, too.	en	beginner		f		https://www.youtube.com/watch?v=FPEWuTxus9w&list=PLeLtaVqZJQOZhpSx03f6vblMZSmsai2OJ&index=25	f	t
83		2018-02-28 11:48:51.407421+00	t	Daniel Kuchta	redactede@bro.cz	Daniel is currently the Head of Machine Learning Practice and a software engineer in GlobalLogic Slovakia where he leads the machine learning activities across the company. He is responsible for development of the team, exploring new technologies and working on proof of concepts and projects involving machine learning. He was a speaker at Google DevFest Kosice 2017 and Machine Learning Meetups Kosice.	@danonops		proposals/pyconcz2018/talks/Screen_Shot_2018-02-28_at_12.20.47.jpg	Classifying cancer nodules with deep learning and Python	CT scan analysis is a tedious and difficult job even for highly-trained radiologists. It takes hours to go through the whole scan and not miss a single spot which could potentially be a malign cancer nodule. It takes years for novice radiologists to learn the craft and even then they tend to misclassify nodules which might later lead to incorrect treatment of the disease.\r\n\r\nWhile we can not improve the radiologist’s ability to detect and classify cancer nodules directly we can leverage the power of machine learning algorithms we have today together with the data from the past and build a medical support decision system to advise the doctors and warn them if there is a potentially dangerous nodule detected.\r\n\r\nWe decided to get our hands dirty and build such a system. After extensive research and understanding of the problem domain we obtained a labeled dataset which would later be used for the training of our models. The next step was to understand the data we have, uncover hidden biases and handling the data from different sources and formats. Afterwards, we build several models using technologies such as genetic algorithms, TensorFlow, Keras and Python and achieved great results. Be sure to come and I’ll tell you more about this amazing journey.	en	beginner		f			f	f
\.


--
-- Data for Name: proposals_workshop; Type: TABLE DATA; Schema: pyconcz; Owner: pyconcz
--

COPY pyconcz.proposals_workshop (id, note, date, accepted, full_name, email, bio, twitter, github, photo, type, title, abstract, language, difficulty, length, finaid_details, needs_finaid, final_note, referral_link, requirements, is_backup) FROM stdin;
5		2018-02-15 19:35:35.302798+00	t	Anastazie Sedlakova	redactede@bro.cz	I am data scientist with passion for data visualization. I started my programming journey with R language. The possibility of easy data visualization was the last reason I kept returning to R. Once I discovered python library Dash, there was no turning back :)		anastazie	proposals/pyconcz2018/talks/Zidkova_reflex.jpg	workshop	Dash for beautiful and easy data visualization	Dash is python library that makes creating web application for data visualization easy. In this workshop we will create visualization with publicly available data. We will use Pandas to crunch data, Plotly to visualize them and pinch of Dash to make web app.\r\nWorkshop will take approximately 4 hours.	en	beginner	xx		f				f
28		2018-03-09 12:31:37.140244+00	t	Mikey Ariel	redactede@bro.cz	I am that docs lady! :)\r\n\r\nNote to organizers: It's not clear from this field whether the information will be used for a public bio, so please do tell me if you need something to post on the website. Otherwise, hi! :)	ThatDocsLady	ThatDocsLady	proposals/pyconcz2018/talks/_5DG6O7o_400x400.jpg	sprint	The doc(tor) is in! *documentation helpdesk*	Bring forth your broken README files, your cryptic API references, and your disheveled Wiki projects! \r\n\r\nThe documentation clinic will be open during the sprints and the doc(tor) will be available to advise and assist with whatever you'll be sprinting on: from choosing the right markup language and naming all the things, to proofreading and restructuring content and crafting contribution guidelines.\r\n\r\nOpen-source projects of all shapes and sizes are welcome!	en	beginner	1d		f			Please bring your own laptop and have your content accessible and ready to review.	f
4		2018-02-11 20:21:13.459179+00	t	Jáchym Čepický	redactede@bro.cz	Uh, oh, I should read the description earlier. I hope, this version will be better: I'm open source for geospatial software developer and advocate. I do not know, what to say more.	jachymc	jachym	proposals/pyconcz2018/talks/profil-pycon_3JDMmRq.jpg	workshop	Dive into GIS with Python.	Traditional Pycon.cz workshop, where we are going to have brief introduction into world of GIS and geospatial - get familiar with raster and vector representation, find out about cartographic projections and explain, why Greenland is bigger then Africa on Google maps, and how to deal with it. In the second part, we shall put our hands on the code, read some data, modify the data (make some analysis using common libraries) and writhe them back to the file. Processing some of really big data files using block-windows will also be part of the workshop.	en	beginner	2h		f			Attendees need:\r\n\r\n* Their own notebook\r\n* Install ready-to-go docker image https://github.com/GISMentors/geopython-docker along with the data and needed software.\r\n* Install QGIS (http://qgis.org) so you will be able to see some data too.	f
25		2018-03-01 23:29:58.292325+00	t	Justyna Janczyszyn	redactede@bro.cz	For the past 4 years I've been working closely with AWS while building back-ends with Python for mobile and web applications. I spoke about AWS and infrastructure as code at PyCon DE 2016 and PyCon Italia 2017.\r\nPassionate about automation, Recurse Center alumn, Django Girls mentor, digital nomad.\r\nCrazy about dogs, surfing and trampolines. Currently working at Mapbox as an API Maps Engineer.	JJanczyszyn	jjanczyszyn	proposals/pyconcz2018/talks/justyna-janczyszyn.jpg	workshop	Build your own serverless image sharing web-site with Lambda, API Gateway, DynamoDB and S3	Learn how to build your own image sharing website, like Instagram, using serverless technologies. During the workshop you will build an entire end to end system that’s powered by AWS Lambda, API Gateway, S3, DynamoDB, Auth0 and much more.\r\n\r\nServerless lets developers concentrate on the business logic that makes their application unique without the need to worry about infrastructure and scaling. During the workshop, the participants will be able to build a working end to end application using Amazon Web Services and the Serverless Framework which will help automate the deployment process. The workshop will include a Github repository which will have all the code ready to use. The aim of the workshop is to make the participants understand how the presented technologies can be used together so that later they can use them in their own projects. Python will be used for the back-end (AWS Lambda).	en	beginner	2h		f		https://www.youtube.com/watch?v=usMQIWcAjdU	1. An AWS account. If you don't already have one, you can sign up for a free trial that includes everything needed for the workshop and a lot more.\r\n2. Node.js v6.5.0 or later.\r\n3. Serverless CLI v1.9.0 or later. You can run npm install -g serverless to install it.\r\n4. Set-up your Provider Credentials. (Like shown here: https://www.youtube.com/watch?v=HSd9uYj2LJA)\r\n5. If you're using Mac or Windows -> Docker (https://www.docker.com/docker-mac https://www.docker.com/docker-windows)	f
11		2018-02-25 16:00:48.863753+00	t	Karla Fejfarová & Petr Šimeček	redactede@bro.cz	Karla is a researcher at the Institute of Molecular Genetics by day and a Python girl by night (also early mornings, due to fast.ai fellowship and time difference between Prague and San Francisco). Most of her data look like a mouse skeleton. Deep learning is one of her data processing tools.\r\n\r\nPetr is a data scientist / quantitative analyst at Google. Most of his data look like a line with a bump in the middle (aka time series).	python_tip	karlafej	proposals/pyconcz2018/talks/Karla_Fejfarova.jpg	workshop	Deep Learning with Keras & Tensorflow: from Zero to Hero in 3 Hours	Deep Learning is everywhere. It beats us in Go and Chess, translates our texts between languages, turns steering wheels of self-driving cars and tags Not-Hotdogs on out photos.\r\n\r\nWe will introduce the basic concepts and demonstrate them on two examples: dogs vs. cats image classification (https://www.kaggle.com/c/dogs-vs-cats) and text generation from Nietzsche’s writings (http://karpathy.github.io/2015/05/21/rnn-effectiveness/). Moreover, we provide similar datasets for you to practice and, at the end, deploy the trained models as a simple API service.\r\n\r\nBecause we will be working in a cloud, all you need is a laptop and a decent web browser (not IE 6.0). Beginners are welcome. PhD. degree in machine learning definitely not needed. However, a familiarity with Jupyter Notebooks and some experience with numpy module might be useful (you can easily get it from Udacity/Datacamp/… online materials).	en	beginner	2h		f		https://www.youtube.com/watch?v=DbqM4CBXleg	Participants are expected to have a laptop with a modern web browser.	f
24	.	2018-02-28 23:10:24+00	t	Ryan Kirkbride	redactede@bro.cz	I'm a laptop musician and use code to create music in real time. I've been developing a Python-driven environment for live coding music called FoxDot for 2 and a half years and have performed internationally with it. I'm currently in the middle of a practice-based PhD at the University of Leeds in the UK researching collaborative processes in live coding. FoxDot is maintained at http://github.com/qirky/FoxDot.	ryankirkbride26	Qirky	proposals/pyconcz2018/talks/lisbon_1_cIuPMFi.jpg	workshop	Introduction to live coding music with Python and SuperCollider	This workshop will introduce the idea of live coding; the practice of creating live music and visuals with code. We'll start with a discussion about "liveness" in music and how code can be used to articulate musical thoughts for real time performance before getting a brief overview of the history of live coding and some of the popular tools used in the field. Then we'll get hands on with some of the basics of the Python-based live coding environment called FoxDot. FoxDot is used for describing rules for music, which sends messages to the powerful audio-synthesis engine, SuperCollider, via Open Sound Control. We'll then go through the basics of putting together a live coded performance.\r\n\r\nPre-requisites\r\n--------------\r\n\r\nPython 2 or 3 (inc. Tkinter libraries)\r\nFoxDot (available on PyPI - more details at http://foxdot.org/)\r\nSuperCollider 3.8 or above (https://supercollider.github.io/)	en	beginner	2h		f		https://www.youtube.com/watch?v=_gksJ3emMps	I will require a projector	f
21		2018-02-28 21:45:55.280969+00	t	Igor Zubrycki, Lidia Lipinska	redactede@bro.cz	Lidia is a biotechnologist using Python and data science tools in her scientific work.\r\nIgor is a roboticist, finishing his Ph.D. at Lodz University of Technology, doing human-robot interaction experiments and using Python to prototype robots and his experiments\r\nWe love teaching people new things and learning deeply about new things. We conducted workshops about DataScience, robotics, and prototyping using python to various audiences. \r\n\r\nWe conducted a workshop about ROS and Python at PyCon PL 2017. We are also the organizers of PyData Łódź and Data Science Łódź groups.\r\n\r\nWhile submitting this proposal we were preparing for interactive art exhibition using a robot of our own design in Tate Modern in London.	IgorZub, lidkalee	AdoHaha, lidkalee	proposals/pyconcz2018/talks/igor.jpeg	workshop	Rapid prototyping robotics with ROS and IPython	On this workshop you will learn how to connect to and program robots using Python. We will introduce you to the Robot Operating System, which is a widely used framework for prototyping robots with a great number ready to use robotic packages for various robotic skills. You will learn how Ipython  and Jupyter Notebook can be used to rapidly create applications that access robots in real-time and you will write yours on the program to control a real robot! \r\nWe will bring a set of robots connectable to ROS so that you could make them move and collect data for you. \r\nYou will see how Python can be used to do robotic stuff fast and see how powerful can be a Jupyter Notebook when using it with ROS.	en	beginner	2h		f			None	f
20		2018-02-28 17:14:27.921802+00	t	Marcel Plch	redactede@bro.cz	I am a high school intern from Red Hat Python maintenance team in Brno.\r\nI study at high school (SŠIPF Brno) and in my free time, I like to learn new stuff. I also like to share skills that I consider lot easier to gain when explained by somebody else. Blender itself is one huge program that is practically incomprehensible when tried to be learned without help. It also has rich Python API not many people are aware of.\r\nI have already spoken about this topic at Pyvo in Brno and it received very positive feedback, this is why I would like to bring it to PyConCZ.		Traceur759	proposals/pyconcz2018/talks/photo.jpg	workshop	Blender Python API	Python API for Blender\r\nDo you like graphics, 3D modelling, physics simulations, or have you just heard that these are possible in Blender, but the complexity of the program scared you away? Let's look at its API.\r\nPython API for Blender lets you do anything you would do in normal Blender. Just without the need to drag things around the screen and pressing god knows what combinations of keys.\r\nAnd even if you are a skilled Blender artist, you still may be interested, because you definitely do have some repetitive tasks you do on every project. Using this API, you can create your very own tools to solve these problems and keep your focus more on your work, not the repetitive tasks.	en	advanced	2h		f			For attendees, newest version of Blender and Python installed is recommended.	f
17		2018-02-28 08:16:55.465727+00	t	David Bečvařík	redactede@bro.cz	As a founder of Prague containers meetup and container enthusiast I often speak about this topic and already hosted similar workshop on our meetup. I want to share that containers can be created/manipulated easily with Python and this can be easily exploited for a neat testing or even production deployment purposes. I'm very interested in demystifying containers and all kernel plumbings a show how you can benefit by knowing details about operating system you are using to host your Python applications.	dbecvarik	dbecvarik	proposals/pyconcz2018/talks/0.jpg	workshop	Self containerized python	You've probably noticed Docker and its hype. Containers changed the way how we develop and deploy applications. Were you ever curious how containers works and what they really are?\r\nIn this workshop we will go through all the steps needed to self-containerize your python application. We will learn how to interact with  Linux kernel syscalls using Python ctypes and we will develop a Python library you can extend and use, to simulate/create complex deployments of your application without any externals or native tools. Just Python interpreter.\r\nRequirements:\r\nLinux VM with Python 3.x install no other libraries required (even legacy Python2 should be enough, but its secret :) ).	en	beginner	2h		f			* laptop with linux VM (preferably Fedora based, or any distribution with user namespaces enabled)\r\n* python 3.x interpreter	f
6		2018-02-16 13:11:16.574209+00	t	Alexander Todorov	redactede@bro.cz	I am a Senior QA engineer with lots of experience in test automation with Python. I am the project lead for Kiwi TCMS, maintainer of pylint-django and contributor to pylint among other projects.	atodorov_	atodorov	proposals/pyconcz2018/talks/atodorov.jpg	workshop	Writing pylint plugins	Pylint is the most popular Python source code analyzer which looks for programming errors,\r\nhelps enforce a coding standard and sniffs for some code smells. It is possible to write\r\nplugins to add your own checks, for example coding patterns that you have observed inside\r\nyour software and are generally a bad practice or rules which you would like to enforce\r\ninside of a particular project, e.g. class name and inheritance conventions.\r\n\r\nThis workshop will focus on  understanding how a pylint plugin works, how to examine the\r\nAST tree of a piece of code and create a minimalistic plugin from scratch.\r\n\r\nRequirements:\r\n\r\n* Python 3.6 installed and running\r\n* pylint >= 1.8 installed inside virtualenv\r\n* Try to identify several patterns observed in a project you worked on, which are not detected by standard pylint checks so that you can write a plugin for them. Instructor will provide some patterns for you if you don't have such.	en	beginner	2h		f		https://www.youtube.com/playlist?list=PLFjlI7p-h1hxBP3cIjEqePSeoBDHud5Db		f
27		2018-03-06 08:21:08.144456+00	t	Lumír Balhar	redactede@bro.cz	Hi, I'm Lumír - drummer, biker, firefighter and Red Hat Python software engineer. You might remember our talk from last year about teaching Python. I said that sharing knowledge and teaching people is healthy addictive and probably the best way how to use your knowledge. So I am here to do it and maintain the good feeling.	lumirbalhar	frenzymadness	proposals/pyconcz2018/talks/4h9YARwc.jpg	workshop	Python-based home automation platform	In this workshop, we'll build a simple home automation platform based on software written mostly in Python. During the workshop, we'll install all necessary software components and configure them step by step, we'll also make your IoT temperature sensor and connect all the parts together.\r\n\r\nWe'll use:\r\n- NodeMCU ESP8266 board with MicroPython with Dallas DS18B20 as IoT temperature sensor\r\n- MQTT (mosquitto) for communication\r\n- Home assistant for collection data, sending notifications, and some automation examples\r\n\r\nHardware - temperature sensor, IoT ESP8266 board, wires, micro USB cable, breadboard etc. - will be ready for you and if you want, you can buy them after the workshop and take working setup with you for further experimentation.	en	beginner	xx		f			What you will need to bring:\r\n - Notebook\r\n - Linux installed (directly on your notebook or in a virtual machine)\r\n - Mosquitto will be installed from packages repositories - check availability in your Linux distribution here: https://mosquitto.org/download/\r\n - Python > 3.5 with pip and virtualenv modules\r\n - If you want to try sending notifications via Telegram, please set up your Telegram account in advance\r\n\r\nIf you want to use Linux in the virtual machine, make sure that is possible to:\r\n - Connect USB devices to a virtual machine\r\n - Connect virtual machine to the same network as a host system	f
7		2018-02-20 15:07:30.730572+00	t	Ondřej Caletka	redactede@bro.cz	I'm an experienced speaker and an inexperienced Pythoner. I work for CESNET, Czech national research and education network operator as a Linux server admin and developer. I like things like IPv6, DNS, TLS, SSH, Public transportation or TV technologÿ. I also volunteer as a RIPE Atlas ambassador, distributing network probes through the country so anyone can measure the health of Czech Internet.	Oskar456	oskar456	proposals/pyconcz2018/talks/ondrej-caletka-orig.jpg	workshop	Analyzing results of RIPE Atlas measurements	RIPE Atlas is a world-wide network of small hardware probes measuring the health of the very fundamental parts of the Internet: reachability, round trip time variations, path changes (traceroute), DNS resolution. There are around 10000 probes deployed world-wide. Such amount of probes produces a big amount of data. Those data are publicly accessible in JSON format via a REST API.\r\n\r\nEven though there are a few ready-made visualizations for measurements, lots of valuable data are still hidden in the raw form. Fortunately there is a Python based CLI tool, which can be easily extended. In this workshop, we will try to give an overview of how the system works and then we'll try to create some extension to analyze some measurements.\r\n\r\nPlease bring your own computer with Python 3.x installed as well as your favorite text editor and your favorite virtualenv implementation. If you want to try the RIPE Atlas in advance, register an account at atlas.ripe.net and ask me for some credits so you can make your own measurements.	en	beginner	2h		f		https://xn--ondej-kcb.caletka.cz/slidy/		f
3		2018-02-10 20:36:50.679455+00	t	Jeanne Trojan	redactede@bro.cz	I'm an Executive Communication Trainer and Coach. In addition to my usual work with multinational corporations, I've been active in the local tech community since 2009, helping people communicate - presenting, conducting meetings, interviewing and even just speaking to each other. \r\nI created my Networking for Geeks workshop in order to make meeting new people easier. I've done this workshop for GUG.CZ, DevFest, WebExpo and other smaller meet-ups and events. \r\nPeople that have attended my workshop have said that they feel much better about networking and they were able to use their new skills and confidence right away at the event. \r\nI love doing this workshop! :)	jmtcz		proposals/pyconcz2018/talks/_MG_1115c.jpg	workshop	Networking for Geeks	One of the hardest things to do at an event is to lose the fear of talking to strangers and networking.\r\n\r\nWhy should I talk to people I don't know?\r\nHow do I introduce myself without feeling like a fool?\r\nHow can I break into a group?\r\nWhat do I say after the introduction?\r\n\r\nThese and many more questions are answered in this workshop. And, you'll get lots of chances to practice. \r\nYou'll leave the workshop armed with strategies to network and with the confidence to use them!	en	beginner	1h		f		https://www.youtube.com/watch?v=tjOaOsuYeT0	The ideal time for this workshop is either at the Warm-Up party before the event or as part of the Opening. At WebExpo, for example, we had one full workshop right before the Warm-Up party and then a 10-minute version with everyone joining in as one of the opening keynotes. At DevFest, we had the workshop after lunch, but many people said it would have been better to meet people in the morning. \r\nI'm open to your ideas on the timing.	f
26		2018-03-01 23:47:58.795026+00	t	Gabriel Falcão	redactede@bro.cz	Python developer since 2006, creator of the Guake Terminal, Lettuce, HTTPretty and many other open-source libraries.\r\nHas been practicing test-driven python since 2008 and thought would be a great idea to create knock-off Python versions of Ruby test libraries such as RSpec and Cucumber.	gabrielfalcao	gabrielfalcao	proposals/pyconcz2018/talks/54914.jpeg	workshop	From your editor to PyPi: Creating and Releasing robust Python packages	Whether you want to release python modules on PyPi or simply want to improve your efficiency to write python code, this workshop is for you.\r\nWe will start from a cookie-cutter template and create a library using test-driven-development, reach 100% of test coverage, learn how to document the code on the go and auto-generate Sphinx documentation.\r\nAt the end of the workshop you will have a python module on PyPi, host the documentation on ReadTheDocs and have your tests run on Travis CI.\r\n\r\nPlease have installed: python 2.7 or 3.6 and cookie cutter.	en	beginner	1d		f			Attendees need to be totally comfortable with:\r\nusing a unix console, managing python dependencies with virtualenv and have at least tried to use the `unittest` module in python, even if frustratedly	f
8		2018-02-22 16:09:54.26813+00	t	Michal Marušan, Jan Pospíšil	redactede@bro.cz	We are technical enthusiast and data professionals with passions for IoT gadgets, IoT solutions, Big Data, Machine Learning, Cognitive Services, New Technologies (even bleeding edge), e-commerce, robotics, automation, coding, …\r\n \r\nWe'd like to meet you for a chat about those topics and how you use them together with Azure services to boost your business.	pospanet	pospanet	proposals/pyconcz2018/talks/Michal_and_Jan.JPG	workshop	Effective Image processing at Scale using TensorFlow / CNTK	Come to join us and try building end-to-end image processing scenario using popular deep learning frameworks TensorFlow and CNTK. It usually requires multiple tools, frameworks and integration of different apps and steps to successfully go through complex task in team on long-term project. \r\n\r\nWe will get you through whole life cycle data science experimentation - data wrangling and preparation, modelling (train locally on sample and training on large dataset in cloud) and deployment. We will use Machine Learning Workbench tool for data preparation, data science experiment management, code versioning, model management, run history, and notebook integration. Take advantage of the best open source frameworks, including TensorFlow, Cognitive Toolkit, Spark ML, and scikit-learn.\r\n\r\nBy the end of the workshop you will know how to approach similar scenarios with the effective tooling and using stat-of-the-art deep learning frameworks and leveraging productivity of your computer and power of cloud compute. You can keep all code artifacts and VM created during the workshop for later use.	en	advanced	2h		f			Nothing but own laptop/notebook (with no special specs).	f
\.


--
-- Data for Name: sponsors_sponsor; Type: TABLE DATA; Schema: pyconcz; Owner: pyconcz
--

COPY pyconcz.sponsors_sponsor (id, level, name, logo, description, link_url, published, facebook, twitter) FROM stdin;
7	3	Slush Pool	sponsors/pyconcz_2018/slushpool.svg	We are the very first Bitcoin mining pool in the world & Python runs the core of our heavily distributed mining software.	http://www.slushpool.com	t	https://www.facebook.com/MiningBitcoinCz/	https://twitter.com/slush_pool
6	7	Faculty of Information Technology CTU in Prague	sponsors/pyconcz_2018/faculty-of-information-technology.svg	The Faculty of Information Technology is the youngest faculty of the Czech Technical University in Prague. Its mission is to provide top technical education in the major fields of informatics, focusing on informatics and communication technologies at bachelor, master and doctoral level, and to conduct research and development comparable with that carried out at leading European faculties of information technology.	https://fit.cvut.cz/en	t	https://www.facebook.com/fitcvut/	https://twitter.com/FIT_CTU
3	2	Red Hat	sponsors/pyconcz_2018/red-hat_zwPzxIP.svg	Red Hat is the world's leading provider of open source, enterprise IT solutions. \r\n\r\nMore than 2 decades ago, Red Hat had a spark of an idea—a vision for developing software differently. We believed that collaboration with an ecosystem of IT leaders, open source advocates, developers, and partners could create a better foundation for the future of IT—Red Hat® Enterprise Linux®. But that was just the beginning. Today, we deliver a comprehensive portfolio of secure products and services using the same open, collaborative business model and an affordable, predictable subscription model. \r\n\r\nAnd Red Hat is HIRING! Visit [jobs.redhat.com](https://jobs.redhat.com) for more details.	http://jobs.redhat.com	t	https://www.facebook.com/RedHatCzech	https://twitter.com/redhatcz
19	3	Verotel.com	sponsors/pyconcz_2018/verotel.svg	Verotel is a leading Internet Payment Service Provider (IPSP) that has been enabling more than 50,000 high-risk webmasters with building their online businesses since 1998. Verotel understands the risks involved in supplying digital content and provides a PCI compliant solution. \r\n\r\nVerotel is the first high risk IPSP awarded with the official Payment Institute status. Processing all major credit cards and offering a fully PCI compliant solution, Verotel is the most trusted online payment processor in the business. Verotel's suite of online billing solutions is perfect for online businesses of any size. Our account offerings are specifically tailored to all payment processing needs: from the sole proprietor with a small website to larger merchants with a portfolio of online properties.	https://www.verotel.com/career	t	\N	\N
5	3	U+	sponsors/pyconcz_2018/usertech_yUgi8Vu.svg	U+ has offices in NYC, San Francisco and Prague and we usually work with big corporations in EU or startups in US. Helping to launch ideas into digital reality and building startups along the way. \r\n\r\nWe work on projects where we most of the time go through the whole cycle of testing out an innovation/startup idea, then build an MVP and then continue working on that. \r\n\r\nU+ is about 100 people and what we really want to do is build our own products/startups, ideally with our people, and that’s where U+Ventures comes handy.	https://u.plus	t	https://www.facebook.com/usertech/	https://twitter.com/usertech
1	6	Manning	sponsors/pyconcz_2018/manning-publications.svg	[Manning](https://www.manning.com/) is an independent publisher of computer books and video courses for software developers, engineers, architects, system administrators, managers and all who are professionally involved with the computer business. We also publish for students and young programmers, including occasionally for children. \r\n\r\nWe are an entirely virtual organization based on Shelter Island, New York, with many staff working from far-flung places like Manila and Zagreb.	https://www.manning.com	t	\N	\N
4	4	Slido	sponsors/pyconcz_2018/slido_7Df6qte.svg	Slido is an audience interaction platform for meetings and events. It allows event organizers to crowd-source the best questions for Q&A sessions, get instant feedback via live polls and share presentations with audiences in real-time. \r\n\r\nSince its foundation in 2012, Slido has helped to transform over 35 000 events, working with market-leading clients such as Netflix, Uber, Adobe or SXSW.	https://www.sli.do	t	https://www.facebook.com/slidoapp/	https://twitter.com/Slidoapp
16	3	Elastic	sponsors/pyconcz_2018/elastic.svg	Elastic builds software to make data usable in real time and at scale for search, logging, security, and analytics use cases. Founded in 2012, the company develops the open source Elastic Stack (Elasticsearch, Kibana, Beats, and Logstash), X-Pack (commercial features), and Elastic Cloud (a SaaS offering). \r\n\r\nLearn more at [elastic.co](https://elastic.co)	https://www.elastic.co	t	http://www.facebook.com/elastic.co	https://www.twitter.com/elastic
11	2	LMC	sponsors/pyconcz_2018/lmc_Na9bdBY.svg	LMC runs the largest job boards in the Czech Republic Jobs.cz and Prace.cz and many other services for online labour market and education. \r\n\r\nWhat’s interesting is that they have got tearoom with real teaman in their offices. And what’s more – they will bring it to PyCon!	http://www.lmc.eu	t	https://www.facebook.com/LMC.eu/	https://twitter.com/lmc_eu
8	9	Ubiquiti Networks, Inc.	sponsors/pyconcz_2018/ubiquity.primary.svg	Ubiquiti Networks, Inc. currently focuses on 3 main technologies: high-capacity distributed Internet access, unified information technology, and next-gen consumer electronics for home and personal use. \r\n\r\nThe majority of the company’s resources consist of entrepreneurial and de-centralized R&D teams. Ubiquiti does not employ a traditional direct salesforce, but instead drives brand awareness largely through the company’s user community where customers can interface directly with R&D, marketing, and support. \r\n\r\nWith over 70 million devices shipped in over 200 countries and territories in the world, Ubiquiti aims to connect everyone to everything, everywhere. Ubiquiti was founded by former Apple Engineer Robert Pera in 2005.	http://www.ubnt.com	t	https://www.facebook.com/Ubiquiti/	https://twitter.com/ubnt
9	6	JetBrains	sponsors/pyconcz_2018/jetbrains_khOHNd4.svg	JetBrains, creator of the best Java IDE – IntelliJ IDEA – is a technology-leading software vendor specializing in the creation of intelligent development tools.	https://www.jetbrains.com	t	https://www.facebook.com/JetBrains/	https://twitter.com/jetbrains
14	3	Microsoft	sponsors/pyconcz_2018/microsoft.svg	Microsoft is the leading platform and productivity company for the mobile-first, cloud-first world, and its mission is to empower every person and every organization on the planet to achieve more. Microsoft first opened its branch in the Czech Republic in 1992.	https://azure.microsoft.com/en-us/develop/python/	t	https://www.facebook.com/Microsoft/	https://twitter.com/Microsoft
2	2	Python Software Foundation	sponsors/pyconcz_2018/python-software-foundation_e2NXSht.svg	The mission of the Python Software Foundation is to promote, protect, and advance the Python programming language, and to support and facilitate the growth of a diverse and international community of Python programmers. \r\n\r\nThe majority of the PSF's work is focused on empowering and supporting people within the Python community. The PSF has active grant programs that support sprints, conferences, meetups, user groups, and Python development efforts all over the world. In addition, the PSF underwrites and runs PyCon US, the primary Python community conference. Being part of the PSF means being part of the Python community. \r\n\r\nRecently we changed the PSF to an open membership organization, so that everyone who uses and supports Python can join. Learn more [about membership](https://www.python.org/psf/membership).	https://www.python.org/psf/membership/	t	\N	https://twitter.com/ThePSF
12	4	Lynt	sponsors/pyconcz_2018/lynt.svg	The great pioneers of Lynt are bound by fate to do great things. They have harnessed the power of technology and have made available the advantages of marketing automation to all people. After being forged in the fires of destiny, the pinnacle of their creative endeavors, PPC Robot, was born! The ultimate tool from PPCers for PPCers.\r\n\r\nWe are a small team of people with big ideas - marketers, developers, and sysadmins. Our main quest is to make the highest performing PPC ads for our clients and to do as little manual work as possible. Modern technology, interdisciplinary skills, and community responsibility are our key ideals.\r\n\r\nPS: Looking for some new blood #python #django #pandas #docker #prometheus #vue.js #rabbitmq #redis	https://lynt.cz	t	\N	\N
17	6	OSWorld.pl	sponsors/pyconcz_2018/osworld.svg	Check us out at [https://osworld.pl/](https://osworld.pl/)	https://osworld.pl/	t	https://www.facebook.com/OSWorldPL/	https://twitter.com/OSWorldpl
18	3	Vistaprint	sponsors/pyconcz_2018/vistaprint.svg	Vistaprint empowers small business owners worldwide to market themselves professionally. Our wide range of quality products and affordable prices, along with design tools suited to every skill level and need, mean everyone can create the customized materials they need to get their message across. Twenty years, millions of customers, and even more orders later, we’ve greatly expanded our offerings and advanced our technology to help our customers promote their business. \r\n\r\nVistaprint is a place for people who don’t settle, who challenge the status quo and never stop asking how to do things better. Technology and design are always evolving and we’re continually finding ways to redefine the way they work together. Step into our world and take a look around. You might be surprised to find yourself surrounded by ambitious and energetic people, just like you, who challenge and inspire you every day. Join us at our brand-new Prague office to discover this for yourself!	http://vistaprint.com	t	https://www.facebook.com/Vistaprint/	https://twitter.com/Vistaprint
15	3	MSD IT	sponsors/pyconcz_2018/msd_P4oJByc.svg	We invent for the single greatest purpose: LIFE\r\n\r\nMSD helps invent the cures that improve lives. At our IT hub in Prague, we are applying technology and data science know-how to health care. There is real value in what we do. We are working to impact people, animals, and their healthcare providers in a positive way. Embark on a career where you can advance—technology, health, and yourself.	http://www.msdit.cz	t	\N	\N
13	4	Imper	sponsors/pyconcz_2018/imper_iQ7XeRk.svg	Imper delivers new B2B opportunities and customers thanks to smart data and artificial intelligence.\r\n\r\nSmart data are not static databases, but up-to-date information, which will tell you who your customer is and help you to find more. They are able to determine who has shown interest in your products or services and even who needs them currently or is going to need them. They can measure what brings in new customers and what, on the other hand, does not.\r\nThe purpose of our data is not to look for or create a customer’s interest, but to measure and\r\nidentify their needs and whether they are being met. Thus we do not only provide data, but actually\r\nalso new opportunities.\r\n\r\nThousands of companies build their business and marketing on our data. We deliver high-quality\r\ninformation which can become the foundation of your company’s business and marketing as well.\r\n\r\nAnd yes, we are [hiring](https://imper.cz/kontakt/#kariera) #python #postgres #elastic	https://imper.cz	t	https://cs-cz.facebook.com/imper.cz/	https://twitter.com/informace
\.


--
-- Data for Name: team_organizer; Type: TABLE DATA; Schema: pyconcz; Owner: pyconcz
--

COPY pyconcz.team_organizer (id, full_name, email, twitter, github, photo, published) FROM stdin;
1	starenka	starenka0@gmail.com	starenka	starenka	team/pyconcz2018/starenka-400.jpg	t
2	Honza Javorek		honzajavorek	honzajavorek	team/pyconcz2018/honza-javorek-600.jpg	t
3	Honza Král		HonzaKral	HonzaKral	team/pyconcz2018/honza-kral-460.jpg	t
5	Bára Drbohlavová		baradrb	BaraDrb	team/pyconcz2018/bara-drbohlavova-512.jpg	t
6	Miro Hrončok		hroncok	hroncok	team/pyconcz2018/miro-hroncok-600.jpg	t
7	Chris Ward		kejbaly2	kejbaly2	team/pyconcz2018/chris-ward-460.jpg	t
9	Iva Fingerová	fingerova.iva@gmail.com	IvaFingerova	ivafingerova	team/pyconcz2018/iva.jpeg	t
4	Daniel Srb	srb.dan@gmail.com	benabraham	benabraham	team/pyconcz2018/daniel-srb-600.jpg	t
10	Max Kovykov		luminaar	Luminar_	team/pyconcz2018/max-kovykov-627_VfnfCD6.jpg	t
\.


--
-- Name: announcements_announcement_id_seq; Type: SEQUENCE SET; Schema: pyconcz; Owner: pyconcz
--

SELECT pg_catalog.setval('pyconcz.announcements_announcement_id_seq', 9, true);


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: pyconcz; Owner: pyconcz
--

SELECT pg_catalog.setval('pyconcz.auth_group_id_seq', 7, true);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: pyconcz; Owner: pyconcz
--

SELECT pg_catalog.setval('pyconcz.auth_group_permissions_id_seq', 48, true);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: pyconcz; Owner: pyconcz
--

SELECT pg_catalog.setval('pyconcz.auth_permission_id_seq', 58, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: pyconcz; Owner: pyconcz
--

SELECT pg_catalog.setval('pyconcz.auth_user_groups_id_seq', 35, true);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: pyconcz; Owner: pyconcz
--

SELECT pg_catalog.setval('pyconcz.auth_user_id_seq', 17, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: pyconcz; Owner: pyconcz
--

SELECT pg_catalog.setval('pyconcz.auth_user_user_permissions_id_seq', 24, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: pyconcz; Owner: pyconcz
--

SELECT pg_catalog.setval('pyconcz.django_admin_log_id_seq', 1154, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: pyconcz; Owner: pyconcz
--

SELECT pg_catalog.setval('pyconcz.django_content_type_id_seq', 19, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: pyconcz; Owner: pyconcz
--

SELECT pg_catalog.setval('pyconcz.django_migrations_id_seq', 52, true);


--
-- Name: django_site_id_seq; Type: SEQUENCE SET; Schema: pyconcz; Owner: pyconcz
--

SELECT pg_catalog.setval('pyconcz.django_site_id_seq', 1, true);


--
-- Name: programme_slot_id_seq; Type: SEQUENCE SET; Schema: pyconcz; Owner: pyconcz
--

SELECT pg_catalog.setval('pyconcz.programme_slot_id_seq', 248, true);


--
-- Name: programme_speaker_id_seq; Type: SEQUENCE SET; Schema: pyconcz; Owner: pyconcz
--

SELECT pg_catalog.setval('pyconcz.programme_speaker_id_seq', 54, true);


--
-- Name: programme_speaker_talks_id_seq; Type: SEQUENCE SET; Schema: pyconcz; Owner: pyconcz
--

SELECT pg_catalog.setval('pyconcz.programme_speaker_talks_id_seq', 43, true);


--
-- Name: programme_speaker_workshops_id_seq; Type: SEQUENCE SET; Schema: pyconcz; Owner: pyconcz
--

SELECT pg_catalog.setval('pyconcz.programme_speaker_workshops_id_seq', 24, true);


--
-- Name: programme_talk_id_seq; Type: SEQUENCE SET; Schema: pyconcz; Owner: pyconcz
--

SELECT pg_catalog.setval('pyconcz.programme_talk_id_seq', 41, true);


--
-- Name: programme_workshop_id_seq; Type: SEQUENCE SET; Schema: pyconcz; Owner: pyconcz
--

SELECT pg_catalog.setval('pyconcz.programme_workshop_id_seq', 21, true);


--
-- Name: proposals_financialaid_id_seq; Type: SEQUENCE SET; Schema: pyconcz; Owner: pyconcz
--

SELECT pg_catalog.setval('pyconcz.proposals_financialaid_id_seq', 5, true);


--
-- Name: proposals_ranking_id_seq; Type: SEQUENCE SET; Schema: pyconcz; Owner: pyconcz
--

SELECT pg_catalog.setval('pyconcz.proposals_ranking_id_seq', 156, true);


--
-- Name: proposals_score_id_seq; Type: SEQUENCE SET; Schema: pyconcz; Owner: pyconcz
--

SELECT pg_catalog.setval('pyconcz.proposals_score_id_seq', 1047, true);


--
-- Name: proposals_talk_id_seq; Type: SEQUENCE SET; Schema: pyconcz; Owner: pyconcz
--

SELECT pg_catalog.setval('pyconcz.proposals_talk_id_seq', 131, true);


--
-- Name: proposals_workshop_id_seq; Type: SEQUENCE SET; Schema: pyconcz; Owner: pyconcz
--

SELECT pg_catalog.setval('pyconcz.proposals_workshop_id_seq', 28, true);


--
-- Name: sponsors_sponsor_id_seq; Type: SEQUENCE SET; Schema: pyconcz; Owner: pyconcz
--

SELECT pg_catalog.setval('pyconcz.sponsors_sponsor_id_seq', 19, true);


--
-- Name: team_organizer_id_seq; Type: SEQUENCE SET; Schema: pyconcz; Owner: pyconcz
--

SELECT pg_catalog.setval('pyconcz.team_organizer_id_seq', 10, true);


--
-- Name: announcements_announcement announcements_announcement_pkey; Type: CONSTRAINT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.announcements_announcement
    ADD CONSTRAINT announcements_announcement_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: django_site django_site_domain_a2e37b91_uniq; Type: CONSTRAINT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.django_site
    ADD CONSTRAINT django_site_domain_a2e37b91_uniq UNIQUE (domain);


--
-- Name: django_site django_site_pkey; Type: CONSTRAINT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.django_site
    ADD CONSTRAINT django_site_pkey PRIMARY KEY (id);


--
-- Name: programme_slot programme_slot_pkey; Type: CONSTRAINT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.programme_slot
    ADD CONSTRAINT programme_slot_pkey PRIMARY KEY (id);


--
-- Name: programme_speaker programme_speaker_pkey; Type: CONSTRAINT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.programme_speaker
    ADD CONSTRAINT programme_speaker_pkey PRIMARY KEY (id);


--
-- Name: programme_speaker_talks programme_speaker_talks_pkey; Type: CONSTRAINT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.programme_speaker_talks
    ADD CONSTRAINT programme_speaker_talks_pkey PRIMARY KEY (id);


--
-- Name: programme_speaker_talks programme_speaker_talks_speaker_id_talk_id_dd663368_uniq; Type: CONSTRAINT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.programme_speaker_talks
    ADD CONSTRAINT programme_speaker_talks_speaker_id_talk_id_dd663368_uniq UNIQUE (speaker_id, talk_id);


--
-- Name: programme_speaker_workshops programme_speaker_worksh_speaker_id_workshop_id_939c55e8_uniq; Type: CONSTRAINT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.programme_speaker_workshops
    ADD CONSTRAINT programme_speaker_worksh_speaker_id_workshop_id_939c55e8_uniq UNIQUE (speaker_id, workshop_id);


--
-- Name: programme_speaker_workshops programme_speaker_workshops_pkey; Type: CONSTRAINT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.programme_speaker_workshops
    ADD CONSTRAINT programme_speaker_workshops_pkey PRIMARY KEY (id);


--
-- Name: programme_talk programme_talk_pkey; Type: CONSTRAINT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.programme_talk
    ADD CONSTRAINT programme_talk_pkey PRIMARY KEY (id);


--
-- Name: programme_workshop programme_workshop_pkey; Type: CONSTRAINT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.programme_workshop
    ADD CONSTRAINT programme_workshop_pkey PRIMARY KEY (id);


--
-- Name: proposals_financialaid proposals_financialaid_pkey; Type: CONSTRAINT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.proposals_financialaid
    ADD CONSTRAINT proposals_financialaid_pkey PRIMARY KEY (id);


--
-- Name: proposals_ranking proposals_ranking_content_type_id_object_id_10c1f533_uniq; Type: CONSTRAINT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.proposals_ranking
    ADD CONSTRAINT proposals_ranking_content_type_id_object_id_10c1f533_uniq UNIQUE (content_type_id, object_id);


--
-- Name: proposals_ranking proposals_ranking_pkey; Type: CONSTRAINT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.proposals_ranking
    ADD CONSTRAINT proposals_ranking_pkey PRIMARY KEY (id);


--
-- Name: proposals_score proposals_score_pkey; Type: CONSTRAINT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.proposals_score
    ADD CONSTRAINT proposals_score_pkey PRIMARY KEY (id);


--
-- Name: proposals_talk proposals_talk_pkey; Type: CONSTRAINT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.proposals_talk
    ADD CONSTRAINT proposals_talk_pkey PRIMARY KEY (id);


--
-- Name: proposals_workshop proposals_workshop_pkey; Type: CONSTRAINT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.proposals_workshop
    ADD CONSTRAINT proposals_workshop_pkey PRIMARY KEY (id);


--
-- Name: sponsors_sponsor sponsors_sponsor_pkey; Type: CONSTRAINT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.sponsors_sponsor
    ADD CONSTRAINT sponsors_sponsor_pkey PRIMARY KEY (id);


--
-- Name: team_organizer team_organizer_pkey; Type: CONSTRAINT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.team_organizer
    ADD CONSTRAINT team_organizer_pkey PRIMARY KEY (id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: pyconcz; Owner: pyconcz
--

CREATE INDEX auth_group_name_a6ea08ec_like ON pyconcz.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: pyconcz; Owner: pyconcz
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON pyconcz.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: pyconcz; Owner: pyconcz
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON pyconcz.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: pyconcz; Owner: pyconcz
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON pyconcz.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: pyconcz; Owner: pyconcz
--

CREATE INDEX auth_user_groups_group_id_97559544 ON pyconcz.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: pyconcz; Owner: pyconcz
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON pyconcz.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: pyconcz; Owner: pyconcz
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON pyconcz.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: pyconcz; Owner: pyconcz
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON pyconcz.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: pyconcz; Owner: pyconcz
--

CREATE INDEX auth_user_username_6821ab7c_like ON pyconcz.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: pyconcz; Owner: pyconcz
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON pyconcz.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: pyconcz; Owner: pyconcz
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON pyconcz.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: pyconcz; Owner: pyconcz
--

CREATE INDEX django_session_expire_date_a5c62663 ON pyconcz.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: pyconcz; Owner: pyconcz
--

CREATE INDEX django_session_session_key_c0390e0f_like ON pyconcz.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: django_site_domain_a2e37b91_like; Type: INDEX; Schema: pyconcz; Owner: pyconcz
--

CREATE INDEX django_site_domain_a2e37b91_like ON pyconcz.django_site USING btree (domain varchar_pattern_ops);


--
-- Name: programme_slot_content_type_id_0bbbe20b; Type: INDEX; Schema: pyconcz; Owner: pyconcz
--

CREATE INDEX programme_slot_content_type_id_0bbbe20b ON pyconcz.programme_slot USING btree (content_type_id);


--
-- Name: programme_speaker_talks_speaker_id_0eb8aaa1; Type: INDEX; Schema: pyconcz; Owner: pyconcz
--

CREATE INDEX programme_speaker_talks_speaker_id_0eb8aaa1 ON pyconcz.programme_speaker_talks USING btree (speaker_id);


--
-- Name: programme_speaker_talks_talk_id_530a3903; Type: INDEX; Schema: pyconcz; Owner: pyconcz
--

CREATE INDEX programme_speaker_talks_talk_id_530a3903 ON pyconcz.programme_speaker_talks USING btree (talk_id);


--
-- Name: programme_speaker_workshops_speaker_id_ea950c80; Type: INDEX; Schema: pyconcz; Owner: pyconcz
--

CREATE INDEX programme_speaker_workshops_speaker_id_ea950c80 ON pyconcz.programme_speaker_workshops USING btree (speaker_id);


--
-- Name: programme_speaker_workshops_workshop_id_028876d6; Type: INDEX; Schema: pyconcz; Owner: pyconcz
--

CREATE INDEX programme_speaker_workshops_workshop_id_028876d6 ON pyconcz.programme_speaker_workshops USING btree (workshop_id);


--
-- Name: proposals_ranking_content_type_id_20b2cb62; Type: INDEX; Schema: pyconcz; Owner: pyconcz
--

CREATE INDEX proposals_ranking_content_type_id_20b2cb62 ON pyconcz.proposals_ranking USING btree (content_type_id);


--
-- Name: proposals_score_ranking_id_9b036408; Type: INDEX; Schema: pyconcz; Owner: pyconcz
--

CREATE INDEX proposals_score_ranking_id_9b036408 ON pyconcz.proposals_score USING btree (ranking_id);


--
-- Name: proposals_score_user_id_d14e708c; Type: INDEX; Schema: pyconcz; Owner: pyconcz
--

CREATE INDEX proposals_score_user_id_d14e708c ON pyconcz.proposals_score USING btree (user_id);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES pyconcz.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES pyconcz.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES pyconcz.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES pyconcz.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES pyconcz.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES pyconcz.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES pyconcz.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES pyconcz.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk; Type: FK CONSTRAINT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk FOREIGN KEY (user_id) REFERENCES pyconcz.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES pyconcz.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: programme_slot programme_slot_content_type_id_0bbbe20b_fk_django_co; Type: FK CONSTRAINT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.programme_slot
    ADD CONSTRAINT programme_slot_content_type_id_0bbbe20b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES pyconcz.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: programme_speaker_talks programme_speaker_ta_speaker_id_0eb8aaa1_fk_programme; Type: FK CONSTRAINT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.programme_speaker_talks
    ADD CONSTRAINT programme_speaker_ta_speaker_id_0eb8aaa1_fk_programme FOREIGN KEY (speaker_id) REFERENCES pyconcz.programme_speaker(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: programme_speaker_talks programme_speaker_talks_talk_id_530a3903_fk_programme_talk_id; Type: FK CONSTRAINT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.programme_speaker_talks
    ADD CONSTRAINT programme_speaker_talks_talk_id_530a3903_fk_programme_talk_id FOREIGN KEY (talk_id) REFERENCES pyconcz.programme_talk(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: programme_speaker_workshops programme_speaker_wo_speaker_id_ea950c80_fk_programme; Type: FK CONSTRAINT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.programme_speaker_workshops
    ADD CONSTRAINT programme_speaker_wo_speaker_id_ea950c80_fk_programme FOREIGN KEY (speaker_id) REFERENCES pyconcz.programme_speaker(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: programme_speaker_workshops programme_speaker_wo_workshop_id_028876d6_fk_programme; Type: FK CONSTRAINT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.programme_speaker_workshops
    ADD CONSTRAINT programme_speaker_wo_workshop_id_028876d6_fk_programme FOREIGN KEY (workshop_id) REFERENCES pyconcz.programme_workshop(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: proposals_ranking proposals_ranking_content_type_id_20b2cb62_fk_django_co; Type: FK CONSTRAINT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.proposals_ranking
    ADD CONSTRAINT proposals_ranking_content_type_id_20b2cb62_fk_django_co FOREIGN KEY (content_type_id) REFERENCES pyconcz.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: proposals_score proposals_score_ranking_id_9b036408_fk_proposals_ranking_id; Type: FK CONSTRAINT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.proposals_score
    ADD CONSTRAINT proposals_score_ranking_id_9b036408_fk_proposals_ranking_id FOREIGN KEY (ranking_id) REFERENCES pyconcz.proposals_ranking(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: proposals_score proposals_score_user_id_d14e708c_fk_auth_user_id; Type: FK CONSTRAINT; Schema: pyconcz; Owner: pyconcz
--

ALTER TABLE ONLY pyconcz.proposals_score
    ADD CONSTRAINT proposals_score_user_id_d14e708c_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES pyconcz.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

