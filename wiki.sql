--
-- PostgreSQL database dump
--

-- Dumped from database version 11.12
-- Dumped by pg_dump version 11.12

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

SET default_with_oids = false;

--
-- Name: analytics; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.analytics (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    config json NOT NULL
);


ALTER TABLE public.analytics OWNER TO wikijs;

--
-- Name: apiKeys; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."apiKeys" (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    key text NOT NULL,
    expiration character varying(255) NOT NULL,
    "isRevoked" boolean DEFAULT false NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL
);


ALTER TABLE public."apiKeys" OWNER TO wikijs;

--
-- Name: apiKeys_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public."apiKeys_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."apiKeys_id_seq" OWNER TO wikijs;

--
-- Name: apiKeys_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public."apiKeys_id_seq" OWNED BY public."apiKeys".id;


--
-- Name: assetData; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."assetData" (
    id integer NOT NULL,
    data bytea NOT NULL
);


ALTER TABLE public."assetData" OWNER TO wikijs;

--
-- Name: assetFolders; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."assetFolders" (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    "parentId" integer
);


ALTER TABLE public."assetFolders" OWNER TO wikijs;

--
-- Name: assetFolders_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public."assetFolders_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."assetFolders_id_seq" OWNER TO wikijs;

--
-- Name: assetFolders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public."assetFolders_id_seq" OWNED BY public."assetFolders".id;


--
-- Name: assets; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.assets (
    id integer NOT NULL,
    filename character varying(255) NOT NULL,
    hash character varying(255) NOT NULL,
    ext character varying(255) NOT NULL,
    kind text DEFAULT 'binary'::text NOT NULL,
    mime character varying(255) DEFAULT 'application/octet-stream'::character varying NOT NULL,
    "fileSize" integer,
    metadata json,
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL,
    "folderId" integer,
    "authorId" integer,
    CONSTRAINT assets_kind_check CHECK ((kind = ANY (ARRAY['binary'::text, 'image'::text])))
);


ALTER TABLE public.assets OWNER TO wikijs;

--
-- Name: COLUMN assets."fileSize"; Type: COMMENT; Schema: public; Owner: wikijs
--

COMMENT ON COLUMN public.assets."fileSize" IS 'In kilobytes';


--
-- Name: assets_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public.assets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.assets_id_seq OWNER TO wikijs;

--
-- Name: assets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public.assets_id_seq OWNED BY public.assets.id;


--
-- Name: authentication; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.authentication (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    config json NOT NULL,
    "selfRegistration" boolean DEFAULT false NOT NULL,
    "domainWhitelist" json NOT NULL,
    "autoEnrollGroups" json NOT NULL,
    "order" integer DEFAULT 0 NOT NULL,
    "strategyKey" character varying(255) DEFAULT ''::character varying NOT NULL,
    "displayName" character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.authentication OWNER TO wikijs;

--
-- Name: brute; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.brute (
    key character varying(255),
    "firstRequest" bigint,
    "lastRequest" bigint,
    lifetime bigint,
    count integer
);


ALTER TABLE public.brute OWNER TO wikijs;

--
-- Name: commentProviders; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."commentProviders" (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    config json NOT NULL
);


ALTER TABLE public."commentProviders" OWNER TO wikijs;

--
-- Name: comments; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.comments (
    id integer NOT NULL,
    content text NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL,
    "pageId" integer,
    "authorId" integer,
    render text DEFAULT ''::text NOT NULL,
    name character varying(255) DEFAULT ''::character varying NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    ip character varying(255) DEFAULT ''::character varying NOT NULL,
    "replyTo" integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.comments OWNER TO wikijs;

--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public.comments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comments_id_seq OWNER TO wikijs;

--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public.comments_id_seq OWNED BY public.comments.id;


--
-- Name: editors; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.editors (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    config json NOT NULL
);


ALTER TABLE public.editors OWNER TO wikijs;

--
-- Name: groups; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.groups (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    permissions json NOT NULL,
    "pageRules" json NOT NULL,
    "isSystem" boolean DEFAULT false NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL,
    "redirectOnLogin" character varying(255) DEFAULT '/'::character varying NOT NULL
);


ALTER TABLE public.groups OWNER TO wikijs;

--
-- Name: groups_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public.groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.groups_id_seq OWNER TO wikijs;

--
-- Name: groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public.groups_id_seq OWNED BY public.groups.id;


--
-- Name: locales; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.locales (
    code character varying(5) NOT NULL,
    strings json,
    "isRTL" boolean DEFAULT false NOT NULL,
    name character varying(255) NOT NULL,
    "nativeName" character varying(255) NOT NULL,
    availability integer DEFAULT 0 NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL
);


ALTER TABLE public.locales OWNER TO wikijs;

--
-- Name: loggers; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.loggers (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    level character varying(255) DEFAULT 'warn'::character varying NOT NULL,
    config json
);


ALTER TABLE public.loggers OWNER TO wikijs;

--
-- Name: migrations; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    name character varying(255),
    batch integer,
    migration_time timestamp with time zone
);


ALTER TABLE public.migrations OWNER TO wikijs;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.migrations_id_seq OWNER TO wikijs;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: migrations_lock; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.migrations_lock (
    index integer NOT NULL,
    is_locked integer
);


ALTER TABLE public.migrations_lock OWNER TO wikijs;

--
-- Name: migrations_lock_index_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public.migrations_lock_index_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.migrations_lock_index_seq OWNER TO wikijs;

--
-- Name: migrations_lock_index_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public.migrations_lock_index_seq OWNED BY public.migrations_lock.index;


--
-- Name: navigation; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.navigation (
    key character varying(255) NOT NULL,
    config json
);


ALTER TABLE public.navigation OWNER TO wikijs;

--
-- Name: pageHistory; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."pageHistory" (
    id integer NOT NULL,
    path character varying(255) NOT NULL,
    hash character varying(255) NOT NULL,
    title character varying(255) NOT NULL,
    description character varying(255),
    "isPrivate" boolean DEFAULT false NOT NULL,
    "isPublished" boolean DEFAULT false NOT NULL,
    "publishStartDate" character varying(255),
    "publishEndDate" character varying(255),
    action character varying(255) DEFAULT 'updated'::character varying,
    "pageId" integer,
    content text,
    "contentType" character varying(255) NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "editorKey" character varying(255),
    "localeCode" character varying(5),
    "authorId" integer,
    "versionDate" character varying(255) DEFAULT ''::character varying NOT NULL,
    extra json DEFAULT '{}'::json NOT NULL
);


ALTER TABLE public."pageHistory" OWNER TO wikijs;

--
-- Name: pageHistoryTags; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."pageHistoryTags" (
    id integer NOT NULL,
    "pageId" integer,
    "tagId" integer
);


ALTER TABLE public."pageHistoryTags" OWNER TO wikijs;

--
-- Name: pageHistoryTags_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public."pageHistoryTags_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."pageHistoryTags_id_seq" OWNER TO wikijs;

--
-- Name: pageHistoryTags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public."pageHistoryTags_id_seq" OWNED BY public."pageHistoryTags".id;


--
-- Name: pageHistory_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public."pageHistory_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."pageHistory_id_seq" OWNER TO wikijs;

--
-- Name: pageHistory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public."pageHistory_id_seq" OWNED BY public."pageHistory".id;


--
-- Name: pageLinks; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."pageLinks" (
    id integer NOT NULL,
    path character varying(255) NOT NULL,
    "localeCode" character varying(5) NOT NULL,
    "pageId" integer
);


ALTER TABLE public."pageLinks" OWNER TO wikijs;

--
-- Name: pageLinks_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public."pageLinks_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."pageLinks_id_seq" OWNER TO wikijs;

--
-- Name: pageLinks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public."pageLinks_id_seq" OWNED BY public."pageLinks".id;


--
-- Name: pageTags; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."pageTags" (
    id integer NOT NULL,
    "pageId" integer,
    "tagId" integer
);


ALTER TABLE public."pageTags" OWNER TO wikijs;

--
-- Name: pageTags_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public."pageTags_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."pageTags_id_seq" OWNER TO wikijs;

--
-- Name: pageTags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public."pageTags_id_seq" OWNED BY public."pageTags".id;


--
-- Name: pageTree; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."pageTree" (
    id integer NOT NULL,
    path character varying(255) NOT NULL,
    depth integer NOT NULL,
    title character varying(255) NOT NULL,
    "isPrivate" boolean DEFAULT false NOT NULL,
    "isFolder" boolean DEFAULT false NOT NULL,
    "privateNS" character varying(255),
    parent integer,
    "pageId" integer,
    "localeCode" character varying(5),
    ancestors json
);


ALTER TABLE public."pageTree" OWNER TO wikijs;

--
-- Name: pages; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.pages (
    id integer NOT NULL,
    path character varying(255) NOT NULL,
    hash character varying(255) NOT NULL,
    title character varying(255) NOT NULL,
    description character varying(255),
    "isPrivate" boolean DEFAULT false NOT NULL,
    "isPublished" boolean DEFAULT false NOT NULL,
    "privateNS" character varying(255),
    "publishStartDate" character varying(255),
    "publishEndDate" character varying(255),
    content text,
    render text,
    toc json,
    "contentType" character varying(255) NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL,
    "editorKey" character varying(255),
    "localeCode" character varying(5),
    "authorId" integer,
    "creatorId" integer,
    extra json DEFAULT '{}'::json NOT NULL
);


ALTER TABLE public.pages OWNER TO wikijs;

--
-- Name: pages_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public.pages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pages_id_seq OWNER TO wikijs;

--
-- Name: pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public.pages_id_seq OWNED BY public.pages.id;


--
-- Name: renderers; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.renderers (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    config json
);


ALTER TABLE public.renderers OWNER TO wikijs;

--
-- Name: searchEngines; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."searchEngines" (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    config json
);


ALTER TABLE public."searchEngines" OWNER TO wikijs;

--
-- Name: sessions; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.sessions (
    sid character varying(255) NOT NULL,
    sess json NOT NULL,
    expired timestamp with time zone NOT NULL
);


ALTER TABLE public.sessions OWNER TO wikijs;

--
-- Name: settings; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.settings (
    key character varying(255) NOT NULL,
    value json,
    "updatedAt" character varying(255) NOT NULL
);


ALTER TABLE public.settings OWNER TO wikijs;

--
-- Name: storage; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.storage (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    mode character varying(255) DEFAULT 'push'::character varying NOT NULL,
    config json,
    "syncInterval" character varying(255),
    state json
);


ALTER TABLE public.storage OWNER TO wikijs;

--
-- Name: tags; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.tags (
    id integer NOT NULL,
    tag character varying(255) NOT NULL,
    title character varying(255),
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL
);


ALTER TABLE public.tags OWNER TO wikijs;

--
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public.tags_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tags_id_seq OWNER TO wikijs;

--
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public.tags_id_seq OWNED BY public.tags.id;


--
-- Name: userAvatars; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."userAvatars" (
    id integer NOT NULL,
    data bytea NOT NULL
);


ALTER TABLE public."userAvatars" OWNER TO wikijs;

--
-- Name: userGroups; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."userGroups" (
    id integer NOT NULL,
    "userId" integer,
    "groupId" integer
);


ALTER TABLE public."userGroups" OWNER TO wikijs;

--
-- Name: userGroups_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public."userGroups_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."userGroups_id_seq" OWNER TO wikijs;

--
-- Name: userGroups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public."userGroups_id_seq" OWNED BY public."userGroups".id;


--
-- Name: userKeys; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."userKeys" (
    id integer NOT NULL,
    kind character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "validUntil" character varying(255) NOT NULL,
    "userId" integer
);


ALTER TABLE public."userKeys" OWNER TO wikijs;

--
-- Name: userKeys_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public."userKeys_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."userKeys_id_seq" OWNER TO wikijs;

--
-- Name: userKeys_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public."userKeys_id_seq" OWNED BY public."userKeys".id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    "providerId" character varying(255),
    password character varying(255),
    "tfaIsActive" boolean DEFAULT false NOT NULL,
    "tfaSecret" character varying(255),
    "jobTitle" character varying(255) DEFAULT ''::character varying,
    location character varying(255) DEFAULT ''::character varying,
    "pictureUrl" character varying(255),
    timezone character varying(255) DEFAULT 'America/New_York'::character varying NOT NULL,
    "isSystem" boolean DEFAULT false NOT NULL,
    "isActive" boolean DEFAULT false NOT NULL,
    "isVerified" boolean DEFAULT false NOT NULL,
    "mustChangePwd" boolean DEFAULT false NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL,
    "providerKey" character varying(255) DEFAULT 'local'::character varying NOT NULL,
    "localeCode" character varying(5) DEFAULT 'en'::character varying NOT NULL,
    "defaultEditor" character varying(255) DEFAULT 'markdown'::character varying NOT NULL,
    "lastLoginAt" character varying(255),
    "dateFormat" character varying(255) DEFAULT ''::character varying NOT NULL,
    appearance character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.users OWNER TO wikijs;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO wikijs;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: apiKeys id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."apiKeys" ALTER COLUMN id SET DEFAULT nextval('public."apiKeys_id_seq"'::regclass);


--
-- Name: assetFolders id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."assetFolders" ALTER COLUMN id SET DEFAULT nextval('public."assetFolders_id_seq"'::regclass);


--
-- Name: assets id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.assets ALTER COLUMN id SET DEFAULT nextval('public.assets_id_seq'::regclass);


--
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);


--
-- Name: groups id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.groups ALTER COLUMN id SET DEFAULT nextval('public.groups_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: migrations_lock index; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.migrations_lock ALTER COLUMN index SET DEFAULT nextval('public.migrations_lock_index_seq'::regclass);


--
-- Name: pageHistory id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageHistory" ALTER COLUMN id SET DEFAULT nextval('public."pageHistory_id_seq"'::regclass);


--
-- Name: pageHistoryTags id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageHistoryTags" ALTER COLUMN id SET DEFAULT nextval('public."pageHistoryTags_id_seq"'::regclass);


--
-- Name: pageLinks id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageLinks" ALTER COLUMN id SET DEFAULT nextval('public."pageLinks_id_seq"'::regclass);


--
-- Name: pageTags id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageTags" ALTER COLUMN id SET DEFAULT nextval('public."pageTags_id_seq"'::regclass);


--
-- Name: pages id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.pages ALTER COLUMN id SET DEFAULT nextval('public.pages_id_seq'::regclass);


--
-- Name: tags id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.tags ALTER COLUMN id SET DEFAULT nextval('public.tags_id_seq'::regclass);


--
-- Name: userGroups id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."userGroups" ALTER COLUMN id SET DEFAULT nextval('public."userGroups_id_seq"'::regclass);


--
-- Name: userKeys id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."userKeys" ALTER COLUMN id SET DEFAULT nextval('public."userKeys_id_seq"'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: analytics; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.analytics (key, "isEnabled", config) FROM stdin;
azureinsights	f	{"instrumentationKey":""}
baidutongji	f	{"propertyTrackingId":""}
countly	f	{"appKey":"","serverUrl":""}
elasticapm	f	{"serverUrl":"http://apm.example.com:8200","serviceName":"wiki-js","environment":""}
fathom	f	{"host":"","siteId":""}
fullstory	f	{"org":""}
google	f	{"propertyTrackingId":""}
gtm	f	{"containerTrackingId":""}
hotjar	f	{"siteId":""}
matomo	f	{"siteId":1,"serverHost":"https://example.matomo.cloud"}
newrelic	f	{"licenseKey":"","appId":""}
statcounter	f	{"projectId":"","securityToken":""}
yandex	f	{"tagNumber":""}
\.


--
-- Data for Name: apiKeys; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."apiKeys" (id, name, key, expiration, "isRevoked", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: assetData; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."assetData" (id, data) FROM stdin;
\.


--
-- Data for Name: assetFolders; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."assetFolders" (id, name, slug, "parentId") FROM stdin;
\.


--
-- Data for Name: assets; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.assets (id, filename, hash, ext, kind, mime, "fileSize", metadata, "createdAt", "updatedAt", "folderId", "authorId") FROM stdin;
\.


--
-- Data for Name: authentication; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.authentication (key, "isEnabled", config, "selfRegistration", "domainWhitelist", "autoEnrollGroups", "order", "strategyKey", "displayName") FROM stdin;
local	t	{}	f	{"v":[]}	{"v":[]}	0	local	Local
\.


--
-- Data for Name: brute; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.brute (key, "firstRequest", "lastRequest", lifetime, count) FROM stdin;
\.


--
-- Data for Name: commentProviders; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."commentProviders" (key, "isEnabled", config) FROM stdin;
commento	f	{"instanceUrl":"https://cdn.commento.io"}
default	t	{"akismet":"","minDelay":30}
disqus	f	{"accountName":""}
\.


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.comments (id, content, "createdAt", "updatedAt", "pageId", "authorId", render, name, email, ip, "replyTo") FROM stdin;
\.


--
-- Data for Name: editors; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.editors (key, "isEnabled", config) FROM stdin;
api	f	{}
ckeditor	f	{}
code	f	{}
markdown	t	{}
redirect	f	{}
wysiwyg	f	{}
\.


--
-- Data for Name: groups; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.groups (id, name, permissions, "pageRules", "isSystem", "createdAt", "updatedAt", "redirectOnLogin") FROM stdin;
1	Administrators	["manage:system"]	[]	t	2021-04-07T19:45:26.054Z	2021-04-07T19:45:26.054Z	/
2	Guests	["read:pages","read:assets","read:comments"]	[{"id":"guest","roles":["read:pages","read:assets","read:comments"],"match":"START","deny":false,"path":"","locales":[]}]	t	2021-04-07T19:45:26.065Z	2021-04-07T19:45:26.065Z	/
\.


--
-- Data for Name: locales; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.locales (code, strings, "isRTL", name, "nativeName", availability, "createdAt", "updatedAt") FROM stdin;
en	{"common":{"footer":{"poweredBy":"Powered by","copyright":"© {{year}} {{company}}. All rights reserved.","license":"Content is available under the {{license}}, by {{company}}."},"actions":{"save":"Save","cancel":"Cancel","download":"Download","upload":"Upload","discard":"Discard","clear":"Clear","create":"Create","edit":"Edit","delete":"Delete","refresh":"Refresh","saveChanges":"Save Changes","proceed":"Proceed","ok":"OK","add":"Add","apply":"Apply","browse":"Browse...","close":"Close","page":"Page","discardChanges":"Discard Changes","move":"Move","rename":"Rename","optimize":"Optimize","preview":"Preview","properties":"Properties","insert":"Insert","fetch":"Fetch","generate":"Generate","confirm":"Confirm","copy":"Copy","returnToTop":"Return to top","exit":"Exit","select":"Select","convert":"Convert"},"newpage":{"title":"This page does not exist yet.","subtitle":"Would you like to create it now?","create":"Create Page","goback":"Go back"},"unauthorized":{"title":"Unauthorized","action":{"view":"You cannot view this page.","source":"You cannot view the page source.","history":"You cannot view the page history.","edit":"You cannot edit the page.","create":"You cannot create the page.","download":"You cannot download the page content.","downloadVersion":"You cannot download the content for this page version.","sourceVersion":"You cannot view the source of this version of the page."},"goback":"Go Back","login":"Login As..."},"notfound":{"gohome":"Home","title":"Not Found","subtitle":"This page does not exist."},"welcome":{"title":"Welcome to your wiki!","subtitle":"Let's get started and create the home page.","createhome":"Create Home Page"},"header":{"home":"Home","newPage":"New Page","currentPage":"Current Page","view":"View","edit":"Edit","history":"History","viewSource":"View Source","move":"Move / Rename","delete":"Delete","assets":"Assets","imagesFiles":"Images & Files","search":"Search...","admin":"Administration","account":"Account","myWiki":"My Wiki","profile":"Profile","logout":"Logout","login":"Login","searchHint":"Type at least 2 characters to start searching...","searchLoading":"Searching...","searchNoResult":"No pages matching your query.","searchResultsCount":"Found {{total}} results","searchDidYouMean":"Did you mean...","searchClose":"Close","searchCopyLink":"Copy Search Link","language":"Language","browseTags":"Browse by Tags","siteMap":"Site Map","pageActions":"Page Actions","duplicate":"Duplicate","convert":"Convert"},"page":{"lastEditedBy":"Last edited by","unpublished":"Unpublished","editPage":"Edit Page","toc":"Table of Contents","bookmark":"Bookmark","share":"Share","printFormat":"Print Format","delete":"Delete Page","deleteTitle":"Are you sure you want to delete page {{title}}?","deleteSubtitle":"The page can be restored from the administration area.","viewingSource":"Viewing source of page {{path}}","returnNormalView":"Return to Normal View","id":"ID {{id}}","published":"Published","private":"Private","global":"Global","loading":"Loading Page...","viewingSourceVersion":"Viewing source as of {{date}} of page {{path}}","versionId":"Version ID {{id}}","unpublishedWarning":"This page is not published.","tags":"Tags","tagsMatching":"Pages matching tags","convert":"Convert Page","convertTitle":"Select the editor you want to use going forward for the page {{title}}:","convertSubtitle":"The page content will be converted into the format of the newly selected editor. Note that some formatting or non-rendered content may be lost as a result of the conversion. A snapshot will be added to the page history and can be restored at any time."},"error":{"unexpected":"An unexpected error occurred."},"password":{"veryWeak":"Very Weak","weak":"Weak","average":"Average","strong":"Strong","veryStrong":"Very Strong"},"user":{"search":"Search User","searchPlaceholder":"Search Users..."},"duration":{"every":"Every","minutes":"Minute(s)","hours":"Hour(s)","days":"Day(s)","months":"Month(s)","years":"Year(s)"},"outdatedBrowserWarning":"Your browser is outdated. Upgrade to a {{modernBrowser}}.","modernBrowser":"modern browser","license":{"none":"None","ccby":" Creative Commons Attribution License","ccbysa":"Creative Commons Attribution-ShareAlike License","ccbynd":"Creative Commons Attribution-NoDerivs License","ccbync":"Creative Commons Attribution-NonCommercial License","ccbyncsa":"Creative Commons Attribution-NonCommercial-ShareAlike License","ccbyncnd":"Creative Commons Attribution-NonCommercial-NoDerivs License","cc0":"Public Domain","alr":"All Rights Reserved"},"sidebar":{"browse":"Browse","mainMenu":"Main Menu","currentDirectory":"Current Directory","root":"(root)"},"comments":{"title":"Comments","newPlaceholder":"Write a new comment...","fieldName":"Your Name","fieldEmail":"Your Email Address","markdownFormat":"Markdown Format","postComment":"Post Comment","loading":"Loading comments...","postingAs":"Posting as {{name}}","beFirst":"Be the first to comment.","none":"No comments yet.","updateComment":"Update Comment","deleteConfirmTitle":"Confirm Delete","deleteWarn":"Are you sure you want to permanently delete this comment?","deletePermanentWarn":"This action cannot be undone!","modified":"modified {{reldate}}","postSuccess":"New comment posted successfully.","contentMissingError":"Comment is empty or too short!","updateSuccess":"Comment was updated successfully.","deleteSuccess":"Comment was deleted successfully.","viewDiscussion":"View Discussion","newComment":"New Comment","fieldContent":"Comment Content","sdTitle":"Talk"},"pageSelector":{"createTitle":"Select New Page Location","moveTitle":"Move / Rename Page Location","selectTitle":"Select a Page","virtualFolders":"Virtual Folders","pages":"Pages","folderEmptyWarning":"This folder is empty."}},"auth":{"loginRequired":"Login required","fields":{"emailUser":"Email / Username","password":"Password","email":"Email Address","verifyPassword":"Verify Password","name":"Name","username":"Username"},"actions":{"login":"Log In","register":"Register"},"errors":{"invalidLogin":"Invalid Login","invalidLoginMsg":"The email or password is invalid.","invalidUserEmail":"Invalid User Email","loginError":"Login error","notYetAuthorized":"You have not been authorized to login to this site yet.","tooManyAttempts":"Too many attempts!","tooManyAttemptsMsg":"You've made too many failed attempts in a short period of time, please try again {{time}}.","userNotFound":"User not found"},"providers":{"local":"Local","windowslive":"Microsoft Account","azure":"Azure Active Directory","google":"Google ID","facebook":"Facebook","github":"GitHub","slack":"Slack","ldap":"LDAP / Active Directory"},"tfa":{"title":"Two Factor Authentication","subtitle":"Security code required:","placeholder":"XXXXXX","verifyToken":"Verify"},"registerTitle":"Create an account","switchToLogin":{"text":"Already have an account? {{link}}","link":"Login instead"},"loginUsingStrategy":"Login using {{strategy}}","forgotPasswordLink":"Forgot your password?","orLoginUsingStrategy":"or login using...","switchToRegister":{"text":"Don't have an account yet? {{link}}","link":"Create an account"},"invalidEmailUsername":"Enter a valid email / username.","invalidPassword":"Enter a valid password.","loginSuccess":"Login Successful! Redirecting...","signingIn":"Signing In...","genericError":"Authentication is unavailable.","registerSubTitle":"Fill-in the form below to create your account.","pleaseWait":"Please wait","registerSuccess":"Account created successfully!","registering":"Creating account...","missingEmail":"Missing email address.","invalidEmail":"Email address is invalid.","missingPassword":"Missing password.","passwordTooShort":"Password is too short.","passwordNotMatch":"Both passwords do not match.","missingName":"Name is missing.","nameTooShort":"Name is too short.","nameTooLong":"Name is too long.","forgotPasswordCancel":"Cancel","sendResetPassword":"Reset Password","forgotPasswordSubtitle":"Enter your email address to receive the instructions to reset your password:","registerCheckEmail":"Check your emails to activate your account.","changePwd":{"subtitle":"Choose a new password","instructions":"You must choose a new password:","newPasswordPlaceholder":"New Password","newPasswordVerifyPlaceholder":"Verify New Password","proceed":"Change Password","loading":"Changing password..."},"forgotPasswordLoading":"Requesting password reset...","forgotPasswordSuccess":"Check your emails for password reset instructions!","selectAuthProvider":"Select Authentication Provider","enterCredentials":"Enter your credentials","forgotPasswordTitle":"Forgot your password","tfaFormTitle":"Enter the security code generated from your trusted device:","tfaSetupTitle":"Your administrator has required Two-Factor Authentication (2FA) to be enabled on your account.","tfaSetupInstrFirst":"1) Scan the QR code below from your mobile 2FA application:","tfaSetupInstrSecond":"2) Enter the security code generated from your trusted device:"},"admin":{"dashboard":{"title":"Dashboard","subtitle":"Wiki.js","pages":"Pages","users":"Users","groups":"Groups","versionLatest":"You are running the latest version.","versionNew":"A new version is available: {{version}}","contributeSubtitle":"Wiki.js is a free and open source project. There are several ways you can contribute to the project.","contributeHelp":"We need your help!","contributeLearnMore":"Learn More","recentPages":"Recent Pages","mostPopularPages":"Most Popular Pages","lastLogins":"Last Logins"},"general":{"title":"General","subtitle":"Main settings of your wiki","siteInfo":"Site Info","siteBranding":"Site Branding","general":"General","siteUrl":"Site URL","siteUrlHint":"Full URL to your wiki, without the trailing slash. (e.g. https://wiki.example.com)","siteTitle":"Site Title","siteTitleHint":"Displayed in the top bar and appended to all pages meta title.","logo":"Logo","uploadLogo":"Upload Logo","uploadClear":"Clear","uploadSizeHint":"An image of {{size}} pixels is recommended for best results.","uploadTypesHint":"{{typeList}} or {{lastType}} files only","footerCopyright":"Footer Copyright","companyName":"Company / Organization Name","companyNameHint":"Name to use when displaying copyright notice in the footer. Leave empty to hide.","siteDescription":"Site Description","siteDescriptionHint":"Default description when none is provided for a page.","metaRobots":"Meta Robots","metaRobotsHint":"Default: Index, Follow. Can also be set on a per-page basis.","logoUrl":"Logo URL","logoUrlHint":"Specify an image to use as the logo. SVG, PNG, JPG are supported, in a square ratio, 34x34 pixels or larger. Click the button on the right to upload a new image.","contentLicense":"Content License","contentLicenseHint":"License shown in the footer of all content pages.","siteTitleInvalidChars":"Site Title contains invalid characters.","saveSuccess":"Site configuration saved successfully."},"locale":{"title":"Locale","subtitle":"Set localization options for your wiki","settings":"Locale Settings","namespacing":"Multilingual Namespacing","downloadTitle":"Download Locale","base":{"labelWithNS":"Base Locale","hint":"All UI text elements will be displayed in selected language.","label":"Site Locale"},"autoUpdate":{"label":"Update Automatically","hintWithNS":"Automatically download updates to all namespaced locales enabled below.","hint":"Automatically download updates to this locale as they become available."},"namespaces":{"label":"Multilingual Namespaces","hint":"Enables multiple language versions of the same page."},"activeNamespaces":{"label":"Active Namespaces","hint":"List of locales enabled for multilingual namespacing. The base locale defined above will always be included regardless of this selection."},"namespacingPrefixWarning":{"title":"The locale code will be prefixed to all paths. (e.g. /{{langCode}}/page-name)","subtitle":"Paths without a locale code will be automatically redirected to the base locale defined above."},"sideload":"Sideload Locale Package","sideloadHelp":"If you are not connected to the internet or cannot download locale files using the method above, you can instead sideload packages manually by uploading them below.","code":"Code","name":"Name","nativeName":"Native Name","rtl":"RTL","availability":"Availability","download":"Download"},"stats":{"title":"Statistics"},"theme":{"title":"Theme","subtitle":"Modify the look & feel of your wiki","siteTheme":"Site Theme","siteThemeHint":"Themes affect how content pages are displayed. Other site sections (such as the editor or admin area) are not affected.","darkMode":"Dark Mode","darkModeHint":"Not recommended for accessibility. May not be supported by all themes.","codeInjection":"Code Injection","cssOverride":"CSS Override","cssOverrideHint":"CSS code to inject after system default CSS. Consider using custom themes if you have a large amount of css code. Injecting too much CSS code will result in poor page load performance! CSS will automatically be minified.","headHtmlInjection":"Head HTML Injection","headHtmlInjectionHint":"HTML code to be injected just before the closing head tag. Usually for script tags.","bodyHtmlInjection":"Body HTML Injection","bodyHtmlInjectionHint":"HTML code to be injected just before the closing body tag.","downloadThemes":"Download Themes","iconset":"Icon Set","iconsetHint":"Set of icons to use for the sidebar navigation.","downloadName":"Name","downloadAuthor":"Author","downloadDownload":"Download","cssOverrideWarning":"{{caution}} When adding styles for page content, you must scope them to the {{cssClass}} class. Omitting this could break the layout of the editor!","cssOverrideWarningCaution":"CAUTION:","options":"Theme Options"},"groups":{"title":"Groups"},"users":{"title":"Users","active":"Active","inactive":"Inactive","verified":"Verified","unverified":"Unverified","edit":"Edit User","id":"ID {{id}}","basicInfo":"Basic Info","email":"Email","displayName":"Display Name","authentication":"Authentication","authProvider":"Provider","password":"Password","changePassword":"Change Password","newPassword":"New Password","tfa":"Two Factor Authentication (2FA)","toggle2FA":"Toggle 2FA","authProviderId":"Provider Id","groups":"User Groups","noGroupAssigned":"This user is not assigned to any group yet. You must assign at least 1 group to a user.","selectGroup":"Select Group...","groupAssign":"Assign","extendedMetadata":"Extended Metadata","location":"Location","jobTitle":"Job Title","timezone":"Timezone","userUpdateSuccess":"User updated successfully.","userAlreadyAssignedToGroup":"User is already assigned to this group!","deleteConfirmTitle":"Delete User?","deleteConfirmText":"Are you sure you want to delete user {{username}}?","updateUser":"Update User","groupAssignNotice":"Note that you cannot assign users to the Administrators or Guests groups from this panel.","deleteConfirmForeignNotice":"Note that you cannot delete a user that already created content. You must instead either deactivate the user or delete all content that was created by that user.","userVerifySuccess":"User has been verified successfully.","userActivateSuccess":"User has been activated successfully.","userDeactivateSuccess":"User deactivated successfully.","deleteConfirmReplaceWarn":"Any content (pages, uploads, comments, etc.) that was created by this user will be reassigned to the user selected below. It is recommended to create a dummy target user (e.g. Deleted User) if you don't want the content to be reassigned to any current active user.","userTFADisableSuccess":"2FA was disabled successfully.","userTFAEnableSuccess":"2FA was enabled successfully."},"auth":{"title":"Authentication","subtitle":"Configure the authentication settings of your wiki","strategies":"Strategies","globalAdvSettings":"Global Advanced Settings","jwtAudience":"JWT Audience","jwtAudienceHint":"Audience URN used in JWT issued upon login. Usually your domain name. (e.g. urn:your.domain.com)","tokenExpiration":"Token Expiration","tokenExpirationHint":"The expiration period of a token until it must be renewed. (default: 30m)","tokenRenewalPeriod":"Token Renewal Period","tokenRenewalPeriodHint":"The maximum period a token can be renewed when expired. (default: 14d)","strategyState":"This strategy is {{state}} {{locked}}","strategyStateActive":"active","strategyStateInactive":"not active","strategyStateLocked":"and cannot be disabled.","strategyConfiguration":"Strategy Configuration","strategyNoConfiguration":"This strategy has no configuration options you can modify.","registration":"Registration","selfRegistration":"Allow self-registration","selfRegistrationHint":"Allow any user successfully authorized by the strategy to access the wiki.","domainsWhitelist":"Limit to specific email domains","domainsWhitelistHint":"A list of domains authorized to register. The user email address domain must match one of these to gain access.","autoEnrollGroups":"Assign to group","autoEnrollGroupsHint":"Automatically assign new users to these groups.","security":"Security","force2fa":"Force all users to use Two-Factor Authentication (2FA)","force2faHint":"Users will be required to setup 2FA the first time they login and cannot be disabled by the user.","configReference":"Configuration Reference","configReferenceSubtitle":"Some strategies may require some configuration values to be set on your provider. These are provided for reference only and may not be needed by the current strategy.","siteUrlNotSetup":"You must set a valid {{siteUrl}} first! Click on {{general}} in the left sidebar.","allowedWebOrigins":"Allowed Web Origins","callbackUrl":"Callback URL / Redirect URI","loginUrl":"Login URL","logoutUrl":"Logout URL","tokenEndpointAuthMethod":"Token Endpoint Authentication Method","refreshSuccess":"List of strategies has been refreshed.","saveSuccess":"Authentication configuration saved successfully.","activeStrategies":"Active Strategies","addStrategy":"Add Strategy","strategyIsEnabled":"Active","strategyIsEnabledHint":"Are users able to login using this strategy?","displayName":"Display Name","displayNameHint":"The title shown to the end user for this authentication strategy."},"editor":{"title":"Editor"},"logging":{"title":"Logging"},"rendering":{"title":"Rendering","subtitle":"Configure the page rendering pipeline"},"search":{"title":"Search Engine","subtitle":"Configure the search capabilities of your wiki","rebuildIndex":"Rebuild Index","searchEngine":"Search Engine","engineConfig":"Engine Configuration","engineNoConfig":"This engine has no configuration options you can modify.","listRefreshSuccess":"List of search engines has been refreshed.","configSaveSuccess":"Search engine configuration saved successfully.","indexRebuildSuccess":"Index rebuilt successfully."},"storage":{"title":"Storage","subtitle":"Set backup and sync targets for your content","targets":"Targets","status":"Status","lastSync":"Last synchronization {{time}}","lastSyncAttempt":"Last attempt was {{time}}","errorMsg":"Error Message","noTarget":"You don't have any active storage target.","targetConfig":"Target Configuration","noConfigOption":"This storage target has no configuration options you can modify.","syncDirection":"Sync Direction","syncDirectionSubtitle":"Choose how content synchronization is handled for this storage target.","syncDirBi":"Bi-directional","syncDirPush":"Push to target","syncDirPull":"Pull from target","unsupported":"Unsupported","syncDirBiHint":"In bi-directional mode, content is first pulled from the storage target. Any newer content overwrites local content. New content since last sync is then pushed to the storage target, overwriting any content on target if present.","syncDirPushHint":"Content is always pushed to the storage target, overwriting any existing content. This is safest choice for backup scenarios.","syncDirPullHint":"Content is always pulled from the storage target, overwriting any local content which already exists. This choice is usually reserved for single-use content import. Caution with this option as any local content will always be overwritten!","syncSchedule":"Sync Schedule","syncScheduleHint":"For performance reasons, this storage target synchronize changes on an interval-based schedule, instead of on every change. Define at which interval should the synchronization occur.","syncScheduleCurrent":"Currently set to every {{schedule}}.","syncScheduleDefault":"The default is every {{schedule}}.","actions":"Actions","actionRun":"Run","targetState":"This storage target is {{state}}","targetStateActive":"active","targetStateInactive":"inactive","actionsInactiveWarn":"You must enable this storage target and apply changes before you can run actions."},"api":{"title":"API Access","subtitle":"Manage keys to access the API","enabled":"API Enabled","disabled":"API Disabled","enableButton":"Enable API","disableButton":"Disable API","newKeyButton":"New API Key","headerName":"Name","headerKeyEnding":"Key Ending","headerExpiration":"Expiration","headerCreated":"Created","headerLastUpdated":"Last Updated","headerRevoke":"Revoke","noKeyInfo":"No API keys have been generated yet.","revokeConfirm":"Revoke API Key?","revokeConfirmText":"Are you sure you want to revoke key {{name}}? This action cannot be undone!","revoke":"Revoke","refreshSuccess":"List of API keys has been refreshed.","revokeSuccess":"The key has been revoked successfully.","newKeyTitle":"New API Key","newKeySuccess":"API key created successfully.","newKeyNameError":"Name is missing or invalid.","newKeyGroupError":"You must select a group.","newKeyGuestGroupError":"The guests group cannot be used for API keys.","newKeyNameHint":"Purpose of this key","newKeyName":"Name","newKeyExpiration":"Expiration","newKeyExpirationHint":"You can still revoke a key anytime regardless of the expiration.","newKeyPermissionScopes":"Permission Scopes","newKeyFullAccess":"Full Access","newKeyGroupPermissions":"or use group permissions...","newKeyGroup":"Group","newKeyGroupHint":"The API key will have the same permissions as the selected group.","expiration30d":"30 days","expiration90d":"90 days","expiration180d":"180 days","expiration1y":"1 year","expiration3y":"3 years","newKeyCopyWarn":"Copy the key shown below as {{bold}}","newKeyCopyWarnBold":"it will NOT be shown again","toggleStateEnabledSuccess":"API has been enabled successfully.","toggleStateDisabledSuccess":"API has been disabled successfully."},"system":{"title":"System Info","subtitle":"Information about your system","hostInfo":"Host Information","currentVersion":"Current Version","latestVersion":"Latest Version","published":"Published","os":"Operating System","hostname":"Hostname","cpuCores":"CPU Cores","totalRAM":"Total RAM","workingDirectory":"Working Directory","configFile":"Configuration File","ramUsage":"RAM Usage: {{used}} / {{total}}","dbPartialSupport":"Your database version is not fully supported. Some functionality may be limited or not work as expected.","refreshSuccess":"System Info has been refreshed."},"utilities":{"title":"Utilities","subtitle":"Maintenance and miscellaneous tools","tools":"Tools","authTitle":"Authentication","authSubtitle":"Various tools for authentication / users","cacheTitle":"Flush Cache","cacheSubtitle":"Flush cache of various components","graphEndpointTitle":"GraphQL Endpoint","graphEndpointSubtitle":"Change the GraphQL endpoint for Wiki.js","importv1Title":"Import from Wiki.js 1.x","importv1Subtitle":"Migrate data from a previous 1.x installation","telemetryTitle":"Telemetry","telemetrySubtitle":"Enable/Disable telemetry or reset the client ID","contentTitle":"Content","contentSubtitle":"Various tools for pages"},"dev":{"title":"Developer Tools","flags":{"title":"Flags"},"graphiql":{"title":"GraphiQL"},"voyager":{"title":"Voyager"}},"contribute":{"title":"Contribute to Wiki.js","subtitle":"Help support Wiki.js development and operations","fundOurWork":"Fund our work","spreadTheWord":"Spread the word","talkToFriends":"Talk to your friends and colleagues about how awesome Wiki.js is!","followUsOnTwitter":"Follow us on {{0}}.","submitAnIdea":"Submit an idea or vote on a proposed one on the {{0}}.","submitAnIdeaLink":"feature requests board","foundABug":"Found a bug? Submit an issue on {{0}}.","helpTranslate":"Help translate Wiki.js in your language. Let us know on {{0}}.","makeADonation":"Make a donation","contribute":"Contribute","openCollective":"Wiki.js is also part of the Open Collective initiative, a transparent fund that goes toward community resources. You can contribute financially by making a monthly or one-time donation:","needYourHelp":"We need your help to keep improving the software and run the various associated services (e.g. hosting and networking).","openSource":"Wiki.js is a free and open-source software brought to you with {{0}} by {{1}} and {{2}}.","openSourceContributors":"contributors","tshirts":"You can also buy Wiki.js t-shirts to support the project financially:","shop":"Wiki.js Shop","becomeAPatron":"Become a Patron","patreon":"Become a backer or sponsor via Patreon (goes directly into supporting lead developer Nicolas Giard's goal of working full-time on Wiki.js)","paypal":"Make a one-time or recurring donation via Paypal:","ethereum":"We accept donations using Ethereum:","github":"Become a sponsor via GitHub Sponsors (goes directly into supporting lead developer Nicolas Giard's goal of working full-time on Wiki.js)","becomeASponsor":"Become a Sponsor"},"nav":{"site":"Site","users":"Users","modules":"Modules","system":"System"},"pages":{"title":"Pages"},"navigation":{"title":"Navigation","subtitle":"Manage the site navigation","link":"Link","divider":"Divider","header":"Header","label":"Label","icon":"Icon","targetType":"Target Type","target":"Target","noSelectionText":"Select a navigation item on the left.","untitled":"Untitled {{kind}}","navType":{"external":"External Link","home":"Home","page":"Page","searchQuery":"Search Query","externalblank":"External Link (New Window)"},"edit":"Edit {{kind}}","delete":"Delete {{kind}}","saveSuccess":"Navigation saved successfully.","noItemsText":"Click the Add button to add your first navigation item.","emptyList":"Navigation is empty","visibilityMode":{"all":"Visible to everyone","restricted":"Visible to select groups..."},"selectPageButton":"Select Page...","mode":"Navigation Mode","modeSiteTree":{"title":"Site Tree","description":"Classic Tree-based Navigation"},"modeCustom":{"title":"Custom Navigation","description":"Static Navigation Menu + Site Tree Button"},"modeNone":{"title":"None","description":"Disable Site Navigation"},"copyFromLocale":"Copy from locale...","sourceLocale":"Source Locale","sourceLocaleHint":"The locale from which navigation items will be copied from.","copyFromLocaleInfoText":"Select the locale from which items will be copied from. Items will be appended to the current list of items in the active locale.","modeStatic":{"title":"Static Navigation","description":"Static Navigation Menu Only"}},"mail":{"title":"Mail","subtitle":"Configure mail settings","configuration":"Configuration","dkim":"DKIM (optional)","test":"Send a test email","testRecipient":"Recipient Email Address","testSend":"Send Email","sender":"Sender","senderName":"Sender Name","senderEmail":"Sender Email","smtp":"SMTP Settings","smtpHost":"Host","smtpPort":"Port","smtpPortHint":"Usually 465 (recommended), 587 or 25.","smtpTLS":"Secure (TLS)","smtpTLSHint":"Should be enabled when using port 465, otherwise turned off (587 or 25).","smtpUser":"Username","smtpPwd":"Password","dkimHint":"DKIM (DomainKeys Identified Mail) provides a layer of security on all emails sent from Wiki.js by providing the means for recipients to validate the domain name and ensure the message authenticity.","dkimUse":"Use DKIM","dkimDomainName":"Domain Name","dkimKeySelector":"Key Selector","dkimPrivateKey":"Private Key","dkimPrivateKeyHint":"Private key for the selector in PEM format","testHint":"Send a test email to ensure your SMTP configuration is working.","saveSuccess":"Configuration saved successfully.","sendTestSuccess":"A test email was sent successfully.","smtpVerifySSL":"Verify SSL Certificate","smtpVerifySSLHint":"Some hosts requires SSL certificate checking to be disabled. Leave enabled for proper security."},"webhooks":{"title":"Webhooks","subtitle":"Manage webhooks to external services"},"adminArea":"Administration Area","analytics":{"title":"Analytics","subtitle":"Add analytics and tracking tools to your wiki","providers":"Providers","providerConfiguration":"Provider Configuration","providerNoConfiguration":"This provider has no configuration options you can modify.","refreshSuccess":"List of providers refreshed successfully.","saveSuccess":"Analytics configuration saved successfully"},"comments":{"title":"Comments","provider":"Provider","subtitle":"Add discussions to your wiki pages","providerConfig":"Provider Configuration","providerNoConfig":"This provider has no configuration options you can modify."},"tags":{"title":"Tags","subtitle":"Manage page tags","emptyList":"No tags to display.","edit":"Edit Tag","tag":"Tag","label":"Label","date":"Created {{created}} and last updated {{updated}}.","delete":"Delete this tag","noSelectionText":"Select a tag from the list on the left.","noItemsText":"Add a tag to a page to get started.","refreshSuccess":"Tags have been refreshed.","deleteSuccess":"Tag deleted successfully.","saveSuccess":"Tag has been saved successfully.","filter":"Filter...","viewLinkedPages":"View Linked Pages","deleteConfirm":"Delete Tag?","deleteConfirmText":"Are you sure you want to delete tag {{tag}}? The tag will also be unlinked from all pages."},"ssl":{"title":"SSL","subtitle":"Manage SSL configuration","provider":"Provider","providerHint":"Select Custom Certificate if you have your own certificate already.","domain":"Domain","domainHint":"Enter the fully qualified domain pointing to your wiki. (e.g. wiki.example.com)","providerOptions":"Provider Options","providerDisabled":"Disabled","providerLetsEncrypt":"Let's Encrypt","providerCustomCertificate":"Custom Certificate","ports":"Ports","httpPort":"HTTP Port","httpPortHint":"Non-SSL port the server will listen to for HTTP requests. Usually 80 or 3000.","httpsPort":"HTTPS Port","httpsPortHint":"SSL port the server will listen to for HTTPS requests. Usually 443.","httpPortRedirect":"Redirect HTTP requests to HTTPS","httpPortRedirectHint":"Will automatically redirect any requests on the HTTP port to HTTPS.","writableConfigFileWarning":"Note that your config file must be writable in order to persist ports configuration.","renewCertificate":"Renew Certificate","status":"Certificate Status","expiration":"Certificate Expiration","subscriberEmail":"Subscriber Email","currentState":"Current State","httpPortRedirectTurnOn":"Turn On","httpPortRedirectTurnOff":"Turn Off","renewCertificateLoadingTitle":"Renewing Certificate...","renewCertificateLoadingSubtitle":"Do not leave this page.","renewCertificateSuccess":"Certificate renewed successfully.","httpPortRedirectSaveSuccess":"HTTP Redirection changed successfully."},"security":{"title":"Security","maxUploadSize":"Max Upload Size","maxUploadBatch":"Max Files per Upload","maxUploadBatchHint":"How many files can be uploaded in a single batch?","maxUploadSizeHint":"The maximum size for a single file.","maxUploadSizeSuffix":"bytes","maxUploadBatchSuffix":"files","uploads":"Uploads","uploadsInfo":"These settings only affect Wiki.js. If you're using a reverse-proxy (e.g. nginx, apache, Cloudflare), you must also change its settings to match.","subtitle":"Configure security settings","login":"Login","loginScreen":"Login Screen","jwt":"JWT Configuration","bypassLogin":"Bypass Login Screen","bypassLoginHint":"Should the user be redirected automatically to the first authentication provider.","loginBgUrl":"Login Background Image URL","loginBgUrlHint":"Specify an image to use as the login background. PNG and JPG are supported, 1920x1080 recommended. Leave empty for default. Click the button on the right to upload a new image. Note that the Guests group must have read-access to the selected image!","hideLocalLogin":"Hide Local Authentication Provider","hideLocalLoginHint":"Don't show the local authentication provider on the login screen. Add ?all to the URL to temporarily use it.","loginSecurity":"Security","enforce2fa":"Enforce 2FA","enforce2faHint":"Force all users to use Two-Factor Authentication when using an authentication provider with a user / password form."},"extensions":{"title":"Extensions","subtitle":"Install extensions for extra functionality"}},"editor":{"page":"Page","save":{"processing":"Rendering","pleaseWait":"Please wait...","createSuccess":"Page created successfully.","error":"An error occurred while creating the page","updateSuccess":"Page updated successfully.","saved":"Saved"},"props":{"pageProperties":"Page Properties","pageInfo":"Page Info","title":"Title","shortDescription":"Short Description","shortDescriptionHint":"Shown below the title","pathCategorization":"Path & Categorization","locale":"Locale","path":"Path","pathHint":"Do not include any leading or trailing slashes.","tags":"Tags","tagsHint":"Use tags to categorize your pages and make them easier to find.","publishState":"Publishing State","publishToggle":"Published","publishToggleHint":"Unpublished pages are still visible to users with write permissions on this page.","publishStart":"Publish starting on...","publishStartHint":"Leave empty for no start date","publishEnd":"Publish ending on...","publishEndHint":"Leave empty for no end date","info":"Info","scheduling":"Scheduling","social":"Social","categorization":"Categorization","socialFeatures":"Social Features","allowComments":"Allow Comments","allowCommentsHint":"Enable commenting abilities on this page.","allowRatings":"Allow Ratings","displayAuthor":"Display Author Info","displaySharingBar":"Display Sharing Toolbar","displaySharingBarHint":"Show a toolbar with buttons to share and print this page","displayAuthorHint":"Show the page author along with the last edition time.","allowRatingsHint":"Enable rating capabilities on this page.","scripts":"Scripts","css":"CSS","cssHint":"CSS will automatically be minified upon saving. Do not include surrounding style tags, only the actual CSS code.","styles":"Styles","html":"HTML","htmlHint":"You must surround your javascript code with HTML script tags."},"unsaved":{"title":"Discard Unsaved Changes?","body":"You have unsaved changes. Are you sure you want to leave the editor and discard any modifications you made since the last save?"},"select":{"title":"Which editor do you want to use for this page?","cannotChange":"This cannot be changed once the page is created.","customView":"or create a custom view?"},"assets":{"title":"Assets","newFolder":"New Folder","folderName":"Folder Name","folderNameNamingRules":"Must follow the asset folder {{namingRules}}.","folderNameNamingRulesLink":"naming rules","folderEmpty":"This asset folder is empty.","fileCount":"{{count}} files","headerId":"ID","headerFilename":"Filename","headerType":"Type","headerFileSize":"File Size","headerAdded":"Added","headerActions":"Actions","uploadAssets":"Upload Assets","uploadAssetsDropZone":"Browse or Drop files here...","fetchImage":"Fetch Remote Image","imageAlign":"Image Alignment","renameAsset":"Rename Asset","renameAssetSubtitle":"Enter the new name for this asset:","deleteAsset":"Delete Asset","deleteAssetConfirm":"Are you sure you want to delete asset","deleteAssetWarn":"This action cannot be undone!","refreshSuccess":"List of assets refreshed successfully.","uploadFailed":"File upload failed.","folderCreateSuccess":"Asset folder created successfully.","renameSuccess":"Asset renamed successfully.","deleteSuccess":"Asset deleted successfully.","noUploadError":"You must choose a file to upload first!"},"backToEditor":"Back to Editor","markup":{"bold":"Bold","italic":"Italic","strikethrough":"Strikethrough","heading":"Heading {{level}}","subscript":"Subscript","superscript":"Superscript","blockquote":"Blockquote","blockquoteInfo":"Info Blockquote","blockquoteSuccess":"Success Blockquote","blockquoteWarning":"Warning Blockquote","blockquoteError":"Error Blockquote","unorderedList":"Unordered List","orderedList":"Ordered List","inlineCode":"Inline Code","keyboardKey":"Keyboard Key","horizontalBar":"Horizontal Bar","togglePreviewPane":"Hide / Show Preview Pane","insertLink":"Insert Link","insertAssets":"Insert Assets","insertBlock":"Insert Block","insertCodeBlock":"Insert Code Block","insertVideoAudio":"Insert Video / Audio","insertDiagram":"Insert Diagram","insertMathExpression":"Insert Math Expression","tableHelper":"Table Helper","distractionFreeMode":"Distraction Free Mode","markdownFormattingHelp":"Markdown Formatting Help","noSelectionError":"Text must be selected first!","toggleSpellcheck":"Toggle Spellcheck"},"ckeditor":{"stats":"{{chars}} chars, {{words}} words"},"conflict":{"title":"Resolve Save Conflict","useLocal":"Use Local","useRemote":"Use Remote","useRemoteHint":"Discard local changes and use latest version","useLocalHint":"Use content in the left panel","viewLatestVersion":"View Latest Version","infoGeneric":"A more recent version of this page was saved by {{authorName}}, {{date}}","whatToDo":"What do you want to do?","whatToDoLocal":"Use your current local version and ignore the latest changes.","whatToDoRemote":"Use the remote version (latest) and discard your changes.","overwrite":{"title":"Overwrite with Remote Version?","description":"Are you sure you want to replace your current version with the latest remote content? {{refEditsLost}}","editsLost":"Your current edits will be lost."},"localVersion":"Local Version {{refEditable}}","editable":"(editable)","readonly":"(read-only)","remoteVersion":"Remote Version {{refReadOnly}}","leftPanelInfo":"Your current edit, based on page version from {{date}}","rightPanelInfo":"Last edited by {{authorName}}, {{date}}","pageTitle":"Title:","pageDescription":"Description:","warning":"Save conflict! Another user has already modified this page."},"unsavedWarning":"You have unsaved edits. Are you sure you want to leave the editor?"},"tags":{"currentSelection":"Current Selection","clearSelection":"Clear Selection","selectOneMoreTags":"Select one or more tags","searchWithinResultsPlaceholder":"Search within results...","locale":"Locale","orderBy":"Order By","selectOneMoreTagsHint":"Select one or more tags on the left.","retrievingResultsLoading":"Retrieving page results...","noResults":"Couldn't find any page with the selected tags.","noResultsWithFilter":"Couldn't find any page matching the current filtering options.","pageLastUpdated":"Last Updated {{date}}","orderByField":{"creationDate":"Creation Date","ID":"ID","lastModified":"Last Modified","path":"Path","title":"Title"},"localeAny":"Any"},"history":{"restore":{"confirmTitle":"Restore page version?","confirmText":"Are you sure you want to restore this page content as it was on {{date}}? This version will be copied on top of the current history. As such, newer versions will still be preserved.","confirmButton":"Restore","success":"Page version restored succesfully!"}},"profile":{"displayName":"Display Name","location":"Location","jobTitle":"Job Title","timezone":"Timezone","title":"Profile","subtitle":"My personal info","myInfo":"My Info","viewPublicProfile":"View Public Profile","auth":{"title":"Authentication","provider":"Provider","changePassword":"Change Password","currentPassword":"Current Password","newPassword":"New Password","verifyPassword":"Confirm New Password","changePassSuccess":"Password changed successfully."},"groups":{"title":"Groups"},"activity":{"title":"Activity","joinedOn":"Joined on","lastUpdatedOn":"Profile last updated on","lastLoginOn":"Last login on","pagesCreated":"Pages created","commentsPosted":"Comments posted"},"save":{"success":"Profile saved successfully."},"pages":{"title":"Pages","subtitle":"List of pages I created or last modified","emptyList":"No pages to display.","refreshSuccess":"Page list has been refreshed.","headerTitle":"Title","headerPath":"Path","headerCreatedAt":"Created","headerUpdatedAt":"Last Updated"},"comments":{"title":"Comments"},"preferences":"Preferences","dateFormat":"Date Format","localeDefault":"Locale Default","appearance":"Appearance","appearanceDefault":"Site Default","appearanceLight":"Light","appearanceDark":"Dark"}}	f	English	English	100	2021-04-07T19:45:26.033Z	2021-06-17T12:18:30.051Z
\.


--
-- Data for Name: loggers; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.loggers (key, "isEnabled", level, config) FROM stdin;
airbrake	f	warn	{}
bugsnag	f	warn	{"key":""}
disk	f	info	{}
eventlog	f	warn	{}
loggly	f	warn	{"token":"","subdomain":""}
logstash	f	warn	{}
newrelic	f	warn	{}
papertrail	f	warn	{"host":"","port":0}
raygun	f	warn	{}
rollbar	f	warn	{"key":""}
sentry	f	warn	{"key":""}
syslog	f	warn	{}
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.migrations (id, name, batch, migration_time) FROM stdin;
1	2.0.0.js	1	2021-04-07 19:44:33.966+00
2	2.1.85.js	1	2021-04-07 19:44:33.971+00
3	2.2.3.js	1	2021-04-07 19:44:33.995+00
4	2.2.17.js	1	2021-04-07 19:44:34.005+00
5	2.3.10.js	1	2021-04-07 19:44:34.011+00
6	2.3.23.js	1	2021-04-07 19:44:34.018+00
7	2.4.13.js	1	2021-04-07 19:44:34.031+00
8	2.4.14.js	1	2021-04-07 19:44:34.052+00
9	2.4.36.js	1	2021-04-07 19:44:34.063+00
10	2.4.61.js	1	2021-04-07 19:44:34.069+00
11	2.5.1.js	1	2021-04-07 19:44:34.09+00
12	2.5.12.js	1	2021-04-07 19:44:34.097+00
13	2.5.108.js	1	2021-04-07 19:44:34.104+00
14	2.5.118.js	1	2021-04-07 19:44:34.11+00
15	2.5.122.js	1	2021-04-07 19:44:34.132+00
16	2.5.128.js	1	2021-04-07 19:44:34.139+00
\.


--
-- Data for Name: migrations_lock; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.migrations_lock (index, is_locked) FROM stdin;
1	0
\.


--
-- Data for Name: navigation; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.navigation (key, config) FROM stdin;
site	[{"locale":"en","items":[{"id":"d6698b13-99f0-46b3-bdfb-a28dd6fffd82","kind":"link","label":"Home","icon":"mdi-home","targetType":"home","target":"/","visibilityMode":"all","visibilityGroups":null}]}]
\.


--
-- Data for Name: pageHistory; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."pageHistory" (id, path, hash, title, description, "isPrivate", "isPublished", "publishStartDate", "publishEndDate", action, "pageId", content, "contentType", "createdAt", "editorKey", "localeCode", "authorId", "versionDate", extra) FROM stdin;
1	home	b29b5d2ce62e55412776ab98f05631e0aa96597b	MQTT Best-Practice Guide		f	t			updated	1	# Header\nYour content here	markdown	2021-04-09T16:55:23.918Z	markdown	en	1	2021-04-07T19:48:23.941Z	{}
2	home	b29b5d2ce62e55412776ab98f05631e0aa96597b	MQTT Best-Practice Guide		f	t			updated	1	# Testing\nTop secret	markdown	2021-04-09T16:57:05.554Z	markdown	en	1	2021-04-09T16:55:32.777Z	{}
3	home	b29b5d2ce62e55412776ab98f05631e0aa96597b	MQTT Best-Practice Guide		f	t			updated	1	# Testing\nTop secret	markdown	2021-04-09T16:58:47.266Z	markdown	en	1	2021-04-09T16:57:13.486Z	{}
4	home	b29b5d2ce62e55412776ab98f05631e0aa96597b	MQTT Best-Practice Guide		f	t			updated	1	# Testing 2\nTop secret	markdown	2021-04-09T16:59:15.097Z	markdown	en	1	2021-04-09T16:58:55.148Z	{}
5	home	b29b5d2ce62e55412776ab98f05631e0aa96597b	MQTT Best-Practice Guide		f	t			deleted	1	# Testing 2\nTop secret	markdown	2021-04-09T17:02:40.210Z	markdown	en	1	2021-04-09T16:59:23.224Z	{}
6	new-page2	508e36472ac42a29412525113dcc15bbd91741e4	Unautheticated Access		f	t			updated	2	# Header\nYour content here	markdown	2021-04-12T18:33:36.100Z	markdown	en	1	2021-04-09T17:01:02.029Z	{}
7	new-page2	508e36472ac42a29412525113dcc15bbd91741e4	Missing Authetication		f	t			moved	2	# Missing Authetication\n\n## Problem Description\nThe MQTT broker does not require a valid username and password from a client before a connection is permitted. Therefore it is possible for any client to subscribe and publish to any topic of interest. \n\n\n## Solution\nConfigure Mosquitto to require authetication from every client. You need to configure two settings for this to work. those settings can be found in the security section of the mosquitto.conf file.\n\nThe required settings are `allow_anonymous` and `password_file`. To require username/password then `allow_anonymous` should be `false` and `password_file` should contain a valid passwords file.\n\n**Example configuration:**\n```\nallow_anonymous false\npassword_file c:\\mosquitto\\passwords.txt #Windows machine\n```\n\n### Sources\nhttp://www.steves-internet-guide.com/mqtt-security-mechanisms/\n\n	markdown	2021-04-12T18:34:52.242Z	markdown	en	1	2021-04-12T18:33:44.184Z	{}
8	missing-authentication	a129ef3377324dcc64e3cf85371431b3621dacfa	Missing Authetication		f	t			updated	2	# Missing Authetication\n\n## Problem Description\nThe MQTT broker does not require a valid username and password from a client before a connection is permitted. Therefore it is possible for any client to subscribe and publish to any topic of interest. \n\n\n## Solution\nConfigure Mosquitto to require authetication from every client. You need to configure two settings for this to work. those settings can be found in the security section of the mosquitto.conf file.\n\nThe required settings are `allow_anonymous` and `password_file`. To require username/password then `allow_anonymous` should be `false` and `password_file` should contain a valid passwords file.\n\n**Example configuration:**\n```\nallow_anonymous false\npassword_file c:\\mosquitto\\passwords.txt #Windows machine\n```\n\n### Sources\nhttp://www.steves-internet-guide.com/mqtt-security-mechanisms/\n\n	markdown	2021-04-12T19:29:54.549Z	markdown	en	1	2021-04-12T18:34:52.269Z	{}
9	mqtt_protocol_not_supported	85cc2c838cb3bbfb70e73f25a2c7bcacd61890db	MQTT Protocol Version not supported		f	t			updated	5	# MQTT Protocol Version not supported\n\n## Problem Description\nThe MQTT broker does not require a valid username and password from a client before a connection is permitted. Therefore it is possible for any client to subscribe and publish to any topic of interest. \n\n\n## Solution\nConfigure Mosquitto to require authetication from every client. You need to configure two settings for this to work. those settings can be found in the security section of the mosquitto.conf file.\n\nThe required settings are `allow_anonymous` and `password_file`. To require username/password then `allow_anonymous` should be `false` and `password_file` should contain a valid passwords file.\n\n**Example configuration:**\n```\nallow_anonymous false\npassword_file c:\\mosquitto\\passwords.txt #Windows machine\n```\n\nIf no password file is existing or if you want to create a new username/password combination, use the following command inside your Mosquitto installation path. The scirpt will ask yu twice for a new password during the setup process. \n\n```\nsudo mosquitto_passwd -c /etc/mosquitto/passwd <user_name>\n``` \n\nAfter configuring your files it is neccessary to restart Mosquitto. From now on authetication should be enabled.\n\n### Sources\nhttp://www.steves-internet-guide.com/mqtt-security-mechanisms/\n\n	markdown	2021-05-19T07:45:26.211Z	markdown	en	1	2021-05-19T07:44:29.118Z	{}
10	mqtt_broker_version_not_up2date	2bc1e4d3c59f655af038974e523dd930900718f3	MQTT Broker Version is not up to date		f	t			updated	6	# MQTT Broker Version is not up to date\n\n## Problem Description\n \n\n\n## Solution\n\n\n\n**Example configuration:**\n```\n```\n\n\n### Sources\n\n\n	markdown	2021-05-19T07:59:47.630Z	markdown	en	1	2021-05-19T07:47:25.012Z	{}
11	mqtt_broker_version_not_up2date	2bc1e4d3c59f655af038974e523dd930900718f3	MQTT Broker Version is not up to date		f	t			updated	6	# MQTT Broker Version is not up to date\n\n## Problem Description\nThe Mosquitto Broker Version is outdated \n\n\n## Solution\nUpdate the mosquitto broker version to the latest stable release\n\n\n**Example configuration:**\nwithout Docker Container\n```\nuser@broker~#\n```\nwith Docker Container\n```\nuser@broker~# mos\n```\n\nLatest Stable Release RSS Feed: \nhttps://mosquitto.org/blog/categories/releases.xml\n\n### Sources\nhttps://mosquitto.org/blog/categories/releases/\n\n\n\n\n\n	markdown	2021-05-19T08:13:06.931Z	markdown	en	1	2021-05-19T07:59:55.869Z	{}
12	mqtt_broker_version_not_up2date	2bc1e4d3c59f655af038974e523dd930900718f3	MQTT Broker Version is not up to date		f	t			updated	6	# MQTT Broker Version is not up to date\n\n## Problem Description\nThe Mosquitto Broker Version is outdated \n\n\n## Solution\nUpdate the mosquitto broker version to the latest stable release\n\n\n**Example configuration:**\n\n#without Docker Container\n*DEBIAN\nTo use the new repository you should first import the repository package signing key:\n```\nuser@broker#~: wget http://repo.mosquitto.org/debian/mosquitto-repo.gpg.key\nuser@broker#~: sudo apt-key add mosquitto-repo.gpg.key\n\n```\nThen make the repository available to apt:\n```\nuser@broker#~: cd /etc/apt/sources.list.d/\n\n```\nThen one of the following, depending on which version of debian you are using:\n```\nuser@broker#~: sudo wget http://repo.mosquitto.org/debian/mosquitto-jessie.list\nuser@broker#~: sudo wget http://repo.mosquitto.org/debian/mosquitto-stretch.list\nuser@broker#~: sudo wget http://repo.mosquitto.org/debian/mosquitto-buster.list\n\n```\nThen update apt information:\n```\nuser@broker#~: apt-get update\n\n```\nAnd discover what mosquitto packages are available:\n```\nuser@broker#~: apt-cache search mosquitto\n\n```\nOr just install:\n```\nuser@broker#~: apt-get install mosquitto\n\n```\n\n\n#with Docker Container\nObtain the latest available stable docker image from:\nhttps://hub.docker.com/_/eclipse-mosquitto\n\n\n\n### Sources\nhttps://mosquitto.org/blog/categories/releases/\n\nLatest Stable Release RSS Feed: \nhttps://mosquitto.org/blog/categories/releases.xml\n\nDocker Image: https://hub.docker.com/_/eclipse-mosquitto\n\n\n\n\n\n	markdown	2021-05-19T08:19:07.662Z	markdown	en	1	2021-05-19T08:13:16.291Z	{}
13	mqtt_broker_version_not_up2date	2bc1e4d3c59f655af038974e523dd930900718f3	MQTT Broker Version is not up to date		f	t			updated	6	# MQTT Broker Version is not up to date\n\n## Problem Description\nThe Mosquitto Broker Version is outdated \n\n\n## Solution\nUpdate the mosquitto broker version to the latest stable release\n\nGet your currently installed docker release\n```\nuser@broker#~: mosquitto\n mosquitto version <your version> (build date Wed, date of installation) starting\n\n```\n\n**UPDATE/UPGRADE - Example configuration:**\n#without Docker Container\n*DEBIAN\nTo use the new repository you should first import the repository package signing key:\n```\nuser@broker#~: wget http://repo.mosquitto.org/debian/mosquitto-repo.gpg.key\nuser@broker#~: sudo apt-key add mosquitto-repo.gpg.key\n\n```\nThen make the repository available to apt:\n```\nuser@broker#~: cd /etc/apt/sources.list.d/\n\n```\nThen one of the following, depending on which version of debian you are using:\n```\nuser@broker#~: sudo wget http://repo.mosquitto.org/debian/mosquitto-jessie.list\nuser@broker#~: sudo wget http://repo.mosquitto.org/debian/mosquitto-stretch.list\nuser@broker#~: sudo wget http://repo.mosquitto.org/debian/mosquitto-buster.list\n\n```\nThen update apt information:\n```\nuser@broker#~: apt-get update\n\n```\nAnd discover what mosquitto packages are available:\n```\nuser@broker#~: apt-cache search mosquitto\n\n```\nOr just install:\n```\nuser@broker#~: apt-get install mosquitto\n\n```\n\n\n#with Docker Container\nObtain the latest available stable docker image from:\nhttps://hub.docker.com/_/eclipse-mosquitto\n\n\n\n### Sources\nhttps://mosquitto.org/blog/categories/releases/\n\nLatest Stable Release RSS Feed: \nhttps://mosquitto.org/blog/categories/releases.xml\n\nDocker Image: https://hub.docker.com/_/eclipse-mosquitto\n\n\n\n\n\n	markdown	2021-05-19T08:19:35.905Z	markdown	en	1	2021-05-19T08:19:16.340Z	{}
14	mqtt_protocol_not_supported	85cc2c838cb3bbfb70e73f25a2c7bcacd61890db	MQTT Protocol Version not supported		f	t			updated	5	# MQTT Protocol Version not supported\n\n## Problem Description\n \n\n\n## Solution\n\n\n\n**Example configuration:**\n```\n```\n\n\n### Sources\n\n\n	markdown	2021-06-01T11:15:22.494Z	markdown	en	1	2021-05-19T07:45:40.534Z	{}
15	mqtt_protocol_not_supported	85cc2c838cb3bbfb70e73f25a2c7bcacd61890db	MQTT Protocol Version not supported		f	t			updated	5	# MQTT Protocol Version not supported\n\n## Problem Description\nYour MQTT Protocol Version (which you are currently using)  is not supported\n\n\n## Solution\nUpdate the MQTT Broker Version greater then Version 1.6\n\n**Example configuration:**\n```\n```\n\n\n### Sources\n\n\n	markdown	2021-06-01T11:18:41.775Z	markdown	en	1	2021-06-01T11:15:29.790Z	{}
16	mqtt_protocol_not_supported	85cc2c838cb3bbfb70e73f25a2c7bcacd61890db	MQTT Protocol Version not supported		f	t			updated	5	# MQTT Protocol Version not supported\n\n## Problem Description\nYour MQTT Protocol Version (which you are currently using)  is not supported\n\n\n## Solution\nUpdate the MQTT Broker Version greater then Version 1.6\n#Windows\nhttp://www.steves-internet-guide.com/install-mosquitto-broker/\n\n#Linux (Ubunto)\nhttp://www.steves-internet-guide.com/install-mosquitto-linux/\n\n#Docker\nhttps://hub.docker.com/_/eclipse-mosquittogoog\n\n\n**Example configuration:**\n```\n```\n\n\n### Sources\nhttp://www.steves-internet-guide.com/mosquitto-broker/\n\n\n	markdown	2021-06-01T11:23:51.448Z	markdown	en	1	2021-06-01T11:18:49.152Z	{}
17	mqtt_listener_not_available	019233f9afa9772da65c8b65653de2988def6564	MQTT Listener not available		f	t			updated	7	# MQTT Listener not available\n\n## Problem Description\n \n\n\n## Solution\n\n\n\n**Example configuration:**\n```\n```\n\n\n### Sources\n\n\n	markdown	2021-06-01T11:39:48.548Z	markdown	en	1	2021-05-19T07:49:01.305Z	{}
18	mqtt_listener_not_available	019233f9afa9772da65c8b65653de2988def6564	MQTT Listener not available		f	t			updated	7	# MQTT Listener not available\n\n## Problem Description\n The mosqitto default port (tcp 1883) is not reachable or in listening state\n\n\n## Solution\n- check : if the local firewall is active and the required ports are permitted\n- check: \tif a 3rd party firewall  is between the mosquitto broker and the mqtt client, permit all \t\t\t\t\t\tnecessary ports on the 3rd party firewall\n\n- check: if the common process is running , see **example configuration **\n\n\n**Example configuration:**\n#check if the process is currently running\n```\nuser@broker ~ $ ps -ef | grep mosq\nmosquit+   351     1  0 11:56 ?        00:00:16 /usr/sbin/mosquitto -c /etc/mosquitto/mosquitto.conf\nuser        4859  4852  0 16:45 pts/0    00:00:00 grep --color=auto mosq\n```\n\n#check the listener of the mosquitto process\n```\nuser@broker ~ $ sudo netstat -tlnp | grep mosq\ntcp        0      0 0.0.0.0:1883            0.0.0.0:*               LISTEN      351/mosquitto\ntcp6       0      0 :::1883                 :::*                    LISTEN      351/mosquitto\n```\n\n\n\n### Sources\nhttp://www.steves-internet-guide.com/mossquitto-conf-file/\nhttp://www.steves-internet-guide.com/mosquitto-broker/\n\n\n	markdown	2021-06-01T11:43:04.523Z	markdown	en	1	2021-06-01T11:39:57.891Z	{}
19	missing-authentication	a129ef3377324dcc64e3cf85371431b3621dacfa	Missing Authetication		f	t			updated	2	# Missing Authetication\n\n## Problem Description\nThe MQTT broker does not require a valid username and password from a client before a connection is permitted. Therefore it is possible for any client to subscribe and publish to any topic of interest. \n\n\n## Solution\nConfigure Mosquitto to require authetication from every client. You need to configure two settings for this to work. those settings can be found in the security section of the mosquitto.conf file.\n\nThe required settings are `allow_anonymous` and `password_file`. To require username/password then `allow_anonymous` should be `false` and `password_file` should contain a valid passwords file.\n\n**Example configuration:**\n```\nallow_anonymous false\npassword_file c:\\mosquitto\\passwords.txt #Windows machine\n```\n\nIf no password file is existing or if you want to create a new username/password combination, use the following command inside your Mosquitto installation path. The scirpt will ask yu twice for a new password during the setup process. \n\n```\nsudo mosquitto_passwd -c /etc/mosquitto/passwd <user_name>\n``` \n\nAfter configuring your files it is neccessary to restart Mosquitto. From now on authetication should be enabled.\n\n### Sources\nhttp://www.steves-internet-guide.com/mqtt-security-mechanisms/\n\n	markdown	2021-06-14T07:07:38.723Z	markdown	en	1	2021-04-12T19:30:02.131Z	{}
20	missing-authentication	a129ef3377324dcc64e3cf85371431b3621dacfa	Missing Authetication		f	t			updated	2	# Missing Authentication\n\n## Problem Description\nThe MQTT broker does not require a valid username and password from a client before a connection is permitted. Therefore it is possible for any client to subscribe and publish to any topic of interest. \n\n\n## Solution\nConfigure Mosquitto to require authetication from every client. You need to configure two settings for this to work. those settings can be found in the security section of the mosquitto.conf file.\n\nThe required settings are `allow_anonymous` and `password_file`. To require username/password then `allow_anonymous` should be `false` and `password_file` should contain a valid passwords file.\n\n**Example configuration:**\n```\nallow_anonymous false\npassword_file c:\\mosquitto\\passwords.txt #Windows machine\n```\n\nIf no password file is existing or if you want to create a new username/password combination, use the following command inside your Mosquitto installation path. The scirpt will ask yu twice for a new password during the setup process. \n\n```\nsudo mosquitto_passwd -c /etc/mosquitto/passwd <user_name>\n``` \n\nAfter configuring your files it is neccessary to restart Mosquitto. From now on authetication should be enabled.\n\n### Sources\nhttp://www.steves-internet-guide.com/mqtt-security-mechanisms/\n\n	markdown	2021-06-14T07:09:11.634Z	markdown	en	1	2021-06-14T07:08:09.997Z	{}
21	missing-authentication	a129ef3377324dcc64e3cf85371431b3621dacfa	Missing Authentication		f	t			updated	2	# Missing Authentication\n\n## Problem Description\nThe MQTT broker does not require a valid username and password from a client before a connection is permitted. Therefore it is possible for any client to subscribe and publish to any topic of interest. \n\n\n## Solution\nConfigure Mosquitto to require authetication from every client. You need to configure two settings for this to work. those settings can be found in the security section of the mosquitto.conf file.\n\nThe required settings are `allow_anonymous` and `password_file`. To require username/password then `allow_anonymous` should be `false` and `password_file` should contain a valid passwords file.\n\n**Example configuration:**\n```\nallow_anonymous false\npassword_file c:\\mosquitto\\passwords.txt #Windows machine\n```\n\nIf no password file is existing or if you want to create a new username/password combination, use the following command inside your Mosquitto installation path. The scirpt will ask yu twice for a new password during the setup process. \n\n```\nsudo mosquitto_passwd -c /etc/mosquitto/passwd <user_name>\n``` \n\nAfter configuring your files it is neccessary to restart Mosquitto. From now on authetication should be enabled.\n\n### Sources\nhttp://www.steves-internet-guide.com/mqtt-security-mechanisms/\n\n	markdown	2021-06-15T12:14:53.093Z	markdown	en	1	2021-06-14T07:09:30.459Z	{}
22	missing-authentication	a129ef3377324dcc64e3cf85371431b3621dacfa	Missing Authentication		f	t			updated	2	# Missing Authentication\n\n## Problem Description\nThe MQTT broker does not require a valid username and password from a client before a connection is permitted. Therefore it is possible for any client to subscribe and publish to any topic of interest. \n\n\n## Solution\nConfigure Mosquitto to require authetication from every client. You need to configure two settings for this to work. those settings can be found in the security section of the mosquitto.conf file.\n\nThe required settings are `allow_anonymous` and `password_file`. To require username/password then `allow_anonymous` should be `false` and `password_file` should contain a valid passwords file.\n\n**Example configuration:**\n```\nallow_anonymous false\npassword_file c:\\mosquitto\\passwords.txt #Windows machine\n```\n\nIf no password file is existing or if you want to create a new username/password combination, use the following command inside your Mosquitto installation path. The scirpt will ask yu twice for a new password during the setup process. \n\n```\nsudo mosquitto_passwd -c /etc/mosquitto/passwd <user_name>\n```\n\nTo add more users, us the following command:\n\n```\nmosquitto_passwd -b <path_to_password_file> <user_name> <password>\n```\n\nAfter configuring your files it is neccessary to restart Mosquitto. From now on authetication should be enabled.\n\n### Sources\nhttp://www.steves-internet-guide.com/mqtt-security-mechanisms/\n\n	markdown	2021-06-15T13:01:20.925Z	markdown	en	1	2021-06-15T12:15:12.125Z	{}
23	home	b29b5d2ce62e55412776ab98f05631e0aa96597b	Homepage - Landingpage		f	t			updated	3	# Header\n## Table of Contents:\n\n[Unautheticated](/new-page2)	markdown	2021-06-15T15:20:27.305Z	markdown	en	1	2021-04-09T17:05:45.897Z	{}
24	home	b29b5d2ce62e55412776ab98f05631e0aa96597b	Homepage - Landingpage		f	t			updated	3	# Header\n## Table of Contents:\n\n[MQTT Broker Version is not up to date](/mqtt_broker_version_not_up2date)	markdown	2021-06-15T16:32:34.654Z	markdown	en	1	2021-06-15T15:20:43.083Z	{}
25	home	b29b5d2ce62e55412776ab98f05631e0aa96597b	Homepage - Landingpage		f	t			updated	3	# Header\n## Table of Contents:\n\n[MQTT Broker Version is not up to date](/mqtt_broker_version_not_up2date)	markdown	2021-06-15T16:34:39.311Z	markdown	en	1	2021-06-15T16:32:53.501Z	{}
\.


--
-- Data for Name: pageHistoryTags; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."pageHistoryTags" (id, "pageId", "tagId") FROM stdin;
\.


--
-- Data for Name: pageLinks; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."pageLinks" (id, path, "localeCode", "pageId") FROM stdin;
2	mqtt_broker_version_not_up2date	en	3
3	mqtt_listener_not_available	en	3
4	mqtt_protocol_not_supported	en	3
5	missing-authentication	en	3
6	missing-authorization	en	3
7	missing-encryption	en	3
\.


--
-- Data for Name: pageTags; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."pageTags" (id, "pageId", "tagId") FROM stdin;
\.


--
-- Data for Name: pageTree; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."pageTree" (id, path, depth, title, "isPrivate", "isFolder", "privateNS", parent, "pageId", "localeCode", ancestors) FROM stdin;
3	missing-authorization	1	Missing Authorization	f	f	\N	\N	8	en	[]
4	missing-encryption	1	Missing Encryption	f	f	\N	\N	4	en	[]
5	mqtt_broker_version_not_up2date	1	MQTT Broker Version is not up to date	f	f	\N	\N	6	en	[]
6	mqtt_listener_not_available	1	MQTT Listener not available	f	f	\N	\N	7	en	[]
7	mqtt_protocol_not_supported	1	MQTT Protocol Version not supported	f	f	\N	\N	5	en	[]
2	missing-authentication	1	Missing Authentication	f	f	\N	\N	2	en	[]
1	home	1	Homepage - Landingpage	f	f	\N	\N	3	en	[]
\.


--
-- Data for Name: pages; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.pages (id, path, hash, title, description, "isPrivate", "isPublished", "privateNS", "publishStartDate", "publishEndDate", content, render, toc, "contentType", "createdAt", "updatedAt", "editorKey", "localeCode", "authorId", "creatorId", extra) FROM stdin;
3	home	b29b5d2ce62e55412776ab98f05631e0aa96597b	Homepage - Landingpage		f	t	\N			# MARTES\n## Table of Contents:\n\n[MQTT Broker Version is not up to date](/mqtt_broker_version_not_up2date)\n[MQTT Listener not available](/mqtt_listener_not_available)\n[MQTT Protocol Version not supported](/mqtt_protocol_not_supported)\n[Missing Authentication](/missing-authentication)\n[Missing Authorization](/missing-authorization)\n[Missing Encryption](/missing-encryption)	<h1 class="toc-header" id="martes"><a href="#martes" class="toc-anchor">¶</a> MARTES</h1><div>\n</div><h2 class="toc-header" id="table-of-contents"><a href="#table-of-contents" class="toc-anchor">¶</a> Table of Contents:</h2><div>\n</div><p><a class="is-internal-link is-valid-page" href="/mqtt_broker_version_not_up2date">MQTT Broker Version is not up to date</a><br>\n<a class="is-internal-link is-valid-page" href="/mqtt_listener_not_available">MQTT Listener not available</a><br>\n<a class="is-internal-link is-valid-page" href="/mqtt_protocol_not_supported">MQTT Protocol Version not supported</a><br>\n<a class="is-internal-link is-valid-page" href="/missing-authentication">Missing Authentication</a><br>\n<a class="is-internal-link is-valid-page" href="/missing-authorization">Missing Authorization</a><br>\n<a class="is-internal-link is-valid-page" href="/missing-encryption">Missing Encryption</a></p><div>\n</div>	[{"title":"MARTES","anchor":"#martes","children":[{"title":"Table of Contents:","anchor":"#table-of-contents","children":[]}]}]	markdown	2021-04-09T17:05:38.350Z	2021-06-15T16:35:00.891Z	markdown	en	1	1	{"js":"","css":""}
4	missing-encryption	d895bb601e61a2fcf4d3a0c2a66a8f278f714161	Missing Encryption		f	t	\N			# Missing Encryption\n\n## Problem Description\nThe MQTT broker does not enforce TLS encryption for all communication between clients and brokers. This enables atteckers to capture and read messages in clear text, including username and password. \n\n\n## Solution\nTo encrypt the whole MQTT communication, Mosquitto allows the use of TLS instead of plain TCP. Configure Mosquitto to only allow TLS connections. The following sections describe all necessary actions to enable TLS. Basic knowledge of PKI is recommendet.\n\n**Client Requirements**\n- A CA (certificate authority) certificate of the CA that has signed the server certificate on the Mosquitto broker.\n\n**Broker Requirements**\n- CA certificate of the CA that has signed the server certificate on the Mosquitto Broker.\n- \n- CA certified server certificate.\n- \n- Server Private key for decryption.\n\n**Overview of the required steps:**\n\nCreate a CA key pair\n\n1. Create a CA certificate and use the CA key from step 1 to sign it.\n\n1. Create a broker key pair and don’t password protect it.\n\n1. Create a broker certificate request using the key from step 3.\n\n1. Use the CA certificate to sign the broker certificate request from step 4.\n\n1. Now we should have a CA key file,a CA certificate file, a broker key file, and a broker certificate file.\n\n1. Place all files in a directory on the broker (e.g. certs).\n\n1. Copy the CA certificate file to the client.\n\n1. Edit the Mosquitto conf file to use the files\n\n1. Edit the client script to use TLS and the CA certificate.\n\nA detailed desciption of the required steps can be found [here](https://www.google.com).\n.\n\n### Sources\nhttps://www.hivemq.com/blog/mqtt-security-fundamentals-tls-ssl\n\nhttp://www.steves-internet-guide.com/mosquitto-tls/\n\n	<h1 class="toc-header" id="missing-encryption"><a href="#missing-encryption" class="toc-anchor">¶</a> Missing Encryption</h1><div>\n</div><h2 class="toc-header" id="problem-description"><a href="#problem-description" class="toc-anchor">¶</a> Problem Description</h2><div>\n</div><p>The MQTT broker does not enforce TLS encryption for all communication between clients and brokers. This enables atteckers to capture and read messages in clear text, including username and password.</p><div>\n</div><h2 class="toc-header" id="solution"><a href="#solution" class="toc-anchor">¶</a> Solution</h2><div>\n</div><p>To encrypt the whole MQTT communication, Mosquitto allows the use of TLS instead of plain TCP. Configure Mosquitto to only allow TLS connections. The following sections describe all necessary actions to enable TLS. Basic knowledge of PKI is recommendet.</p><div>\n</div><p><strong>Client Requirements</strong></p><div>\n</div><ul>\n<li>A CA (certificate authority) certificate of the CA that has signed the server certificate on the Mosquitto broker.</li>\n</ul><div>\n</div><p><strong>Broker Requirements</strong></p><div>\n</div><ul>\n<li>CA certificate of the CA that has signed the server certificate on the Mosquitto Broker.</li>\n<li></li>\n<li>CA certified server certificate.</li>\n<li></li>\n<li>Server Private key for decryption.</li>\n</ul><div>\n</div><p><strong>Overview of the required steps:</strong></p><div>\n</div><p>Create a CA key pair</p><div>\n</div><ol>\n<li>\n<p>Create a CA certificate and use the CA key from step 1 to sign it.</p>\n</li>\n<li>\n<p>Create a broker key pair and don’t password protect it.</p>\n</li>\n<li>\n<p>Create a broker certificate request using the key from step 3.</p>\n</li>\n<li>\n<p>Use the CA certificate to sign the broker certificate request from step 4.</p>\n</li>\n<li>\n<p>Now we should have a CA key file,a CA certificate file, a broker key file, and a broker certificate file.</p>\n</li>\n<li>\n<p>Place all files in a directory on the broker (e.g. certs).</p>\n</li>\n<li>\n<p>Copy the CA certificate file to the client.</p>\n</li>\n<li>\n<p>Edit the Mosquitto conf file to use the files</p>\n</li>\n<li>\n<p>Edit the client script to use TLS and the CA certificate.</p>\n</li>\n</ol><div>\n</div><p>A detailed desciption of the required steps can be found <a class="is-external-link" href="https://www.google.com">here</a>.<br>\n.</p><div>\n</div><h3 class="toc-header" id="sources"><a href="#sources" class="toc-anchor">¶</a> Sources</h3><div>\n</div><p><a class="is-external-link" href="https://www.hivemq.com/blog/mqtt-security-fundamentals-tls-ssl">https://www.hivemq.com/blog/mqtt-security-fundamentals-tls-ssl</a></p><div>\n</div><p><a class="is-external-link" href="http://www.steves-internet-guide.com/mosquitto-tls/">http://www.steves-internet-guide.com/mosquitto-tls/</a></p><div>\n</div>	[{"title":"Missing Encryption","anchor":"#missing-encryption","children":[{"title":"Problem Description","anchor":"#problem-description","children":[]},{"title":"Solution","anchor":"#solution","children":[{"title":"Sources","anchor":"#sources","children":[]}]}]}]	markdown	2021-04-12T19:23:33.723Z	2021-04-12T19:23:41.188Z	markdown	en	1	1	{"js":"","css":""}
7	mqtt_listener_not_available	019233f9afa9772da65c8b65653de2988def6564	MQTT Listener not available		f	t	\N			# MQTT Listener not available\n\n## Problem Description\n The mosqitto default port (tcp 1883) is not reachable or in listening state\n\n\n## Solution\n- check : if the local firewall is active --> permit all necessary ports on the local firewall\n- check: \tif 3rd party firewalls are between the mosquitto broker and the mqtt client, permit all \t\t\t\t\t\tnecessary ports on the 3rd party firewall\n\n- check: if the common process is running , see **example configuration **\n\n\n**Example configuration:**\n#check if the process is currently running\n```\nuser@broker ~ $ ps -ef | grep mosq\nmosquit+   351     1  0 11:56 ?        00:00:16 /usr/sbin/mosquitto -c /etc/mosquitto/mosquitto.conf\nuser        4859  4852  0 16:45 pts/0    00:00:00 grep --color=auto mosq\n```\n\n#check the listener of the mosquitto process\n```\nuser@broker ~ $ sudo netstat -tlnp | grep mosq\ntcp        0      0 0.0.0.0:1883            0.0.0.0:*               LISTEN      351/mosquitto\ntcp6       0      0 :::1883                 :::*                    LISTEN      351/mosquitto\n```\n\n\n\n### Sources\nhttp://www.steves-internet-guide.com/mossquitto-conf-file/\nhttp://www.steves-internet-guide.com/mosquitto-broker/\n\n\n	<h1 class="toc-header" id="mqtt-listener-not-available"><a href="#mqtt-listener-not-available" class="toc-anchor">¶</a> MQTT Listener not available</h1><div>\n</div><h2 class="toc-header" id="problem-description"><a href="#problem-description" class="toc-anchor">¶</a> Problem Description</h2><div>\n</div><p>The mosqitto default port (tcp 1883) is not reachable or in listening state</p><div>\n</div><h2 class="toc-header" id="solution"><a href="#solution" class="toc-anchor">¶</a> Solution</h2><div>\n</div><ul>\n<li>\n<p>check : if the local firewall is active --&gt; permit all necessary ports on the local firewall</p>\n</li>\n<li>\n<p>check: \tif 3rd party firewalls are between the mosquitto broker and the mqtt client, permit all \t\t\t\t\t\tnecessary ports on the 3rd party firewall</p>\n</li>\n<li>\n<p>check: if the common process is running , see **example configuration **</p>\n</li>\n</ul><div>\n</div><p><strong>Example configuration:</strong><br>\n#check if the process is currently running</p><div>\n</div><pre v-pre="true" class="prismjs line-numbers"><code class="language-">user@broker ~ $ ps -ef | grep mosq\nmosquit+   351     1  0 11:56 ?        00:00:16 /usr/sbin/mosquitto -c /etc/mosquitto/mosquitto.conf\nuser        4859  4852  0 16:45 pts/0    00:00:00 grep --color=auto mosq\n</code></pre><div>\n</div><p>#check the listener of the mosquitto process</p><div>\n</div><pre v-pre="true" class="prismjs line-numbers"><code class="language-">user@broker ~ $ sudo netstat -tlnp | grep mosq\ntcp        0      0 0.0.0.0:1883            0.0.0.0:*               LISTEN      351/mosquitto\ntcp6       0      0 :::1883                 :::*                    LISTEN      351/mosquitto\n</code></pre><div>\n</div><h3 class="toc-header" id="sources"><a href="#sources" class="toc-anchor">¶</a> Sources</h3><div>\n</div><p><a class="is-external-link" href="http://www.steves-internet-guide.com/mossquitto-conf-file/">http://www.steves-internet-guide.com/mossquitto-conf-file/</a><br>\n<a class="is-external-link" href="http://www.steves-internet-guide.com/mosquitto-broker/">http://www.steves-internet-guide.com/mosquitto-broker/</a></p><div>\n</div>	[{"title":"MQTT Listener not available","anchor":"#mqtt-listener-not-available","children":[{"title":"Problem Description","anchor":"#problem-description","children":[]},{"title":"Solution","anchor":"#solution","children":[{"title":"Sources","anchor":"#sources","children":[]}]}]}]	markdown	2021-05-19T07:48:53.885Z	2021-06-01T11:43:11.693Z	markdown	en	1	1	{"js":"","css":""}
6	mqtt_broker_version_not_up2date	2bc1e4d3c59f655af038974e523dd930900718f3	MQTT Broker Version is not up to date		f	t	\N			# MQTT Broker Version is not up to date\n\n## Problem Description\nYour Mosquitto Broker Version is outdated \n\n\n## Solution\nUpdate the mosquitto broker version to the latest stable release\n\nGet your currently installed docker release\n```\nuser@broker#~: mosquitto\n mosquitto version <your version> (build date Wed, date of installation) starting\n\n```\n\n**UPDATE/UPGRADE - Example configuration:**\n#without Docker Container\n*DEBIAN\nTo use the new repository you should first import the repository package signing key:\n```\nuser@broker#~: wget http://repo.mosquitto.org/debian/mosquitto-repo.gpg.key\nuser@broker#~: sudo apt-key add mosquitto-repo.gpg.key\n\n```\nThen make the repository available to apt:\n```\nuser@broker#~: cd /etc/apt/sources.list.d/\n\n```\nThen one of the following, depending on which version of debian you are using:\n```\nuser@broker#~: sudo wget http://repo.mosquitto.org/debian/mosquitto-jessie.list\nuser@broker#~: sudo wget http://repo.mosquitto.org/debian/mosquitto-stretch.list\nuser@broker#~: sudo wget http://repo.mosquitto.org/debian/mosquitto-buster.list\n\n```\nThen update apt information:\n```\nuser@broker#~: apt-get update\n\n```\nAnd discover what mosquitto packages are available:\n```\nuser@broker#~: apt-cache search mosquitto\n\n```\nOr just install:\n```\nuser@broker#~: apt-get install mosquitto\n\n```\n\n\n#with Docker Container\nObtain the latest available stable docker image from:\nhttps://hub.docker.com/_/eclipse-mosquitto\n\n\n\n### Sources\nhttps://mosquitto.org/blog/categories/releases/\n\nLatest Stable Release RSS Feed: \nhttps://mosquitto.org/blog/categories/releases.xml\n\nDocker Image: https://hub.docker.com/_/eclipse-mosquitto\n\n\n\n\n\n	<h1 class="toc-header" id="mqtt-broker-version-is-not-up-to-date"><a href="#mqtt-broker-version-is-not-up-to-date" class="toc-anchor">¶</a> MQTT Broker Version is not up to date</h1><div>\n</div><h2 class="toc-header" id="problem-description"><a href="#problem-description" class="toc-anchor">¶</a> Problem Description</h2><div>\n</div><p>Your Mosquitto Broker Version is outdated</p><div>\n</div><h2 class="toc-header" id="solution"><a href="#solution" class="toc-anchor">¶</a> Solution</h2><div>\n</div><p>Update the mosquitto broker version to the latest stable release</p><div>\n</div><p>Get your currently installed docker release</p><div>\n</div><pre v-pre="true" class="prismjs line-numbers"><code class="language-">user@broker#~: mosquitto\n mosquitto version &lt;your version&gt; (build date Wed, date of installation) starting\n\n</code></pre><div>\n</div><p><strong>UPDATE/UPGRADE - Example configuration:</strong><br>\n#without Docker Container<br>\n*DEBIAN<br>\nTo use the new repository you should first import the repository package signing key:</p><div>\n</div><pre v-pre="true" class="prismjs line-numbers"><code class="language-">user@broker#~: wget http://repo.mosquitto.org/debian/mosquitto-repo.gpg.key\nuser@broker#~: sudo apt-key add mosquitto-repo.gpg.key\n\n</code></pre><div>\n</div><p>Then make the repository available to apt:</p><div>\n</div><pre v-pre="true" class="prismjs line-numbers"><code class="language-">user@broker#~: cd /etc/apt/sources.list.d/\n\n</code></pre><div>\n</div><p>Then one of the following, depending on which version of debian you are using:</p><div>\n</div><pre v-pre="true" class="prismjs line-numbers"><code class="language-">user@broker#~: sudo wget http://repo.mosquitto.org/debian/mosquitto-jessie.list\nuser@broker#~: sudo wget http://repo.mosquitto.org/debian/mosquitto-stretch.list\nuser@broker#~: sudo wget http://repo.mosquitto.org/debian/mosquitto-buster.list\n\n</code></pre><div>\n</div><p>Then update apt information:</p><div>\n</div><pre v-pre="true" class="prismjs line-numbers"><code class="language-">user@broker#~: apt-get update\n\n</code></pre><div>\n</div><p>And discover what mosquitto packages are available:</p><div>\n</div><pre v-pre="true" class="prismjs line-numbers"><code class="language-">user@broker#~: apt-cache search mosquitto\n\n</code></pre><div>\n</div><p>Or just install:</p><div>\n</div><pre v-pre="true" class="prismjs line-numbers"><code class="language-">user@broker#~: apt-get install mosquitto\n\n</code></pre><div>\n</div><p>#with Docker Container<br>\nObtain the latest available stable docker image from:<br>\n<a class="is-external-link" href="https://hub.docker.com/_/eclipse-mosquitto">https://hub.docker.com/_/eclipse-mosquitto</a></p><div>\n</div><h3 class="toc-header" id="sources"><a href="#sources" class="toc-anchor">¶</a> Sources</h3><div>\n</div><p><a class="is-external-link" href="https://mosquitto.org/blog/categories/releases/">https://mosquitto.org/blog/categories/releases/</a></p><div>\n</div><p>Latest Stable Release RSS Feed:<br>\n<a class="is-external-link" href="https://mosquitto.org/blog/categories/releases.xml">https://mosquitto.org/blog/categories/releases.xml</a></p><div>\n</div><p>Docker Image: <a class="is-external-link" href="https://hub.docker.com/_/eclipse-mosquitto">https://hub.docker.com/_/eclipse-mosquitto</a></p><div>\n</div>	[{"title":"MQTT Broker Version is not up to date","anchor":"#mqtt-broker-version-is-not-up-to-date","children":[{"title":"Problem Description","anchor":"#problem-description","children":[]},{"title":"Solution","anchor":"#solution","children":[{"title":"Sources","anchor":"#sources","children":[]}]}]}]	markdown	2021-05-19T07:47:17.562Z	2021-05-19T08:19:44.185Z	markdown	en	1	1	{"js":"","css":""}
5	mqtt_protocol_not_supported	85cc2c838cb3bbfb70e73f25a2c7bcacd61890db	MQTT Protocol Version not supported		f	t	\N			# MQTT Protocol Version not supported\n\n## Problem Description\nYour MQTT Protocol Version (which you are currently using)  is not supported\n\n\n## Solution\nUpdate the MQTT Broker Version greater then Version 1.6\n#Windows\nhttp://www.steves-internet-guide.com/install-mosquitto-broker/\n\n#Linux (Ubunto)\nhttp://www.steves-internet-guide.com/install-mosquitto-linux/\n\n#Docker\nhttps://hub.docker.com/_/eclipse-mosquittogoog\n\n\n**Example configuration:**\n###Check currently installed version, for fully mqtt protocol support, you have to install greater then version 1.6\n```\nuser@broker#~: mosquitto\n mosquitto version <your version> (build date Wed, date of installation) starting\n```\n\n\n### Sources\nhttp://www.steves-internet-guide.com/mosquitto-broker/\n\n\n	<h1 class="toc-header" id="mqtt-protocol-version-not-supported"><a href="#mqtt-protocol-version-not-supported" class="toc-anchor">¶</a> MQTT Protocol Version not supported</h1><div>\n</div><h2 class="toc-header" id="problem-description"><a href="#problem-description" class="toc-anchor">¶</a> Problem Description</h2><div>\n</div><p>Your MQTT Protocol Version (which you are currently using)  is not supported</p><div>\n</div><h2 class="toc-header" id="solution"><a href="#solution" class="toc-anchor">¶</a> Solution</h2><div>\n</div><p>Update the MQTT Broker Version greater then Version 1.6<br>\n#Windows<br>\n<a class="is-external-link" href="http://www.steves-internet-guide.com/install-mosquitto-broker/">http://www.steves-internet-guide.com/install-mosquitto-broker/</a></p><div>\n</div><p>#Linux (Ubunto)<br>\n<a class="is-external-link" href="http://www.steves-internet-guide.com/install-mosquitto-linux/">http://www.steves-internet-guide.com/install-mosquitto-linux/</a></p><div>\n</div><p>#Docker<br>\n<a class="is-external-link" href="https://hub.docker.com/_/eclipse-mosquittogoog">https://hub.docker.com/_/eclipse-mosquittogoog</a></p><div>\n</div><p><strong>Example configuration:</strong><br>\n###Check currently installed version, for fully mqtt protocol support, you have to install greater then version 1.6</p><div>\n</div><pre v-pre="true" class="prismjs line-numbers"><code class="language-">user@broker#~: mosquitto\n mosquitto version &lt;your version&gt; (build date Wed, date of installation) starting\n</code></pre><div>\n</div><h3 class="toc-header" id="sources"><a href="#sources" class="toc-anchor">¶</a> Sources</h3><div>\n</div><p><a class="is-external-link" href="http://www.steves-internet-guide.com/mosquitto-broker/">http://www.steves-internet-guide.com/mosquitto-broker/</a></p><div>\n</div>	[{"title":"MQTT Protocol Version not supported","anchor":"#mqtt-protocol-version-not-supported","children":[{"title":"Problem Description","anchor":"#problem-description","children":[]},{"title":"Solution","anchor":"#solution","children":[{"title":"Sources","anchor":"#sources","children":[]}]}]}]	markdown	2021-05-19T07:44:16.303Z	2021-06-01T11:23:58.830Z	markdown	en	1	1	{"js":"","css":""}
2	missing-authentication	a129ef3377324dcc64e3cf85371431b3621dacfa	Missing Authentication		f	t	\N			# Missing Authentication\n\n## Problem Description\nThe MQTT broker does not require a valid username and password from a client before a connection is permitted. Therefore it is possible for any client to subscribe and publish to any topic of interest. \n\n\n## Solution\nConfigure Mosquitto to require authetication from every client. You need to configure two settings for this to work. those settings can be found in the security section of the mosquitto.conf file.\n\nThe required settings are `allow_anonymous` and `password_file`. To require username/password then `allow_anonymous` should be `false` and `password_file` should contain a valid passwords file.\n\n**Example configuration:**\n```\nallow_anonymous false\npassword_file c:\\mosquitto\\passwords.txt #Windows machine\n```\n\nIf no password file is existing or if you want to create a new username/password combination, use the following command inside your Mosquitto installation path. The scirpt will ask yu twice for a new password during the setup process. \n\n```\nsudo mosquitto_passwd -c /etc/mosquitto/passwd <user_name>\n```\n\nTo add more users, us the following command:\n\n```\nmosquitto_passwd -b <path_to_password_file> <user_name> <password>\n```\n\nAfter configuring your files it is neccessary to restart Mosquitto. From now on authetication should be enabled.\n\n### Sources\nhttp://www.steves-internet-guide.com/mqtt-security-mechanisms/\n\n	<h1 class="toc-header" id="missing-authentication"><a href="#missing-authentication" class="toc-anchor">¶</a> Missing Authentication</h1><div>\n</div><h2 class="toc-header" id="problem-description"><a href="#problem-description" class="toc-anchor">¶</a> Problem Description</h2><div>\n</div><p>The MQTT broker does not require a valid username and password from a client before a connection is permitted. Therefore it is possible for any client to subscribe and publish to any topic of interest.</p><div>\n</div><h2 class="toc-header" id="solution"><a href="#solution" class="toc-anchor">¶</a> Solution</h2><div>\n</div><p>Configure Mosquitto to require authetication from every client. You need to configure two settings for this to work. those settings can be found in the security section of the mosquitto.conf file.</p><div>\n</div><p>The required settings are <code>allow_anonymous</code> and <code>password_file</code>. To require username/password then <code>allow_anonymous</code> should be <code>false</code> and <code>password_file</code> should contain a valid passwords file.</p><div>\n</div><p><strong>Example configuration:</strong></p><div>\n</div><pre v-pre="true" class="prismjs line-numbers"><code class="language-">allow_anonymous false\npassword_file c:\\mosquitto\\passwords.txt #Windows machine\n</code></pre><div>\n</div><p>If no password file is existing or if you want to create a new username/password combination, use the following command inside your Mosquitto installation path. The scirpt will ask yu twice for a new password during the setup process.</p><div>\n</div><pre v-pre="true" class="prismjs line-numbers"><code class="language-">sudo mosquitto_passwd -c /etc/mosquitto/passwd &lt;user_name&gt;\n</code></pre><div>\n</div><p>To add more users, us the following command:</p><div>\n</div><pre v-pre="true" class="prismjs line-numbers"><code class="language-">mosquitto_passwd -b &lt;path_to_password_file&gt; &lt;user_name&gt; &lt;password&gt;\n</code></pre><div>\n</div><p>After configuring your files it is neccessary to restart Mosquitto. From now on authetication should be enabled.</p><div>\n</div><h3 class="toc-header" id="sources"><a href="#sources" class="toc-anchor">¶</a> Sources</h3><div>\n</div><p><a class="is-external-link" href="http://www.steves-internet-guide.com/mqtt-security-mechanisms/">http://www.steves-internet-guide.com/mqtt-security-mechanisms/</a></p><div>\n</div>	[{"title":"Missing Authentication","anchor":"#missing-authentication","children":[{"title":"Problem Description","anchor":"#problem-description","children":[]},{"title":"Solution","anchor":"#solution","children":[{"title":"Sources","anchor":"#sources","children":[]}]}]}]	markdown	2021-04-09T17:00:54.734Z	2021-06-15T13:01:38.666Z	markdown	en	1	1	{"js":"","css":""}
8	missing-authorization	2e2156ffc790f26786700e61241334d03b84f975	Missing Authorization		f	t	\N			# Missing Authorization\n\n## Problem Description\nThe authenticated user has no valid authorization to view the topic.\nTherefore the requested topic is not accessable.\n\n\n## Solution\nConfigure Mosquitto to require authorization for the requested user. You need to configure two settings for this to work, those settings can be found in the security section of the mosquitto.conf file.\n\nThe required settings are `allow_anonymous` and `acl_file`. To require authorization then `allow_anonymous` should be `false`, username and password defined and `acl` should contain the previously created user. \n\nBroker Config File - mosquitto.conf\n```\nallow_anonymous false\npassword_file /etc/mosquitto/passwords.txt\nacl_file /etc/mosquitto/acls\n```\n\nACL (Access Control List) - acl_file /etc/mosquitto/acls\n\n```\nuser <user-A>\ntopic write <topic-A>/+/event/+\ntopic read <topic-A>/+/command/+\n\nuser <user-B>\ntopic read <topic-A>/+/event/+\ntopic write <topic-A>/+/command/+\n\nuser <user-C>\ntopic write <application-A>/+/device/+/event/+\ntopic read <application-A>/+/device/+/command/+\n\nuser <user-D>\ntopic read <application-A>/123/device/+/event/+\ntopic write <application-A>/123/device/+/command/+\n``` \n\nAfter configuring your files it is neccessary to restart Mosquitto. From now on authorization for the user should be working without any issues.\n\n### Sources\nhttps://www.chirpstack.io/project/guides/mqtt-authentication/\nhttps://www.hackerspace-ffm.de/wiki/index.php?title=MQTT&mobileaction=toggle_view_desktop\n\n	<h1 class="toc-header" id="missing-authorization"><a href="#missing-authorization" class="toc-anchor">¶</a> Missing Authorization</h1><div>\n</div><h2 class="toc-header" id="problem-description"><a href="#problem-description" class="toc-anchor">¶</a> Problem Description</h2><div>\n</div><p>The authenticated user has no valid authorization to view the topic.<br>\nTherefore the requested topic is not accessable.</p><div>\n</div><h2 class="toc-header" id="solution"><a href="#solution" class="toc-anchor">¶</a> Solution</h2><div>\n</div><p>Configure Mosquitto to require authorization for the requested user. You need to configure two settings for this to work, those settings can be found in the security section of the mosquitto.conf file.</p><div>\n</div><p>The required settings are <code>allow_anonymous</code> and <code>acl_file</code>. To require authorization then <code>allow_anonymous</code> should be <code>false</code>, username and password defined and <code>acl</code> should contain the previously created user.</p><div>\n</div><p>Broker Config File - mosquitto.conf</p><div>\n</div><pre v-pre="true" class="prismjs line-numbers"><code class="language-">allow_anonymous false\npassword_file /etc/mosquitto/passwords.txt\nacl_file /etc/mosquitto/acls\n</code></pre><div>\n</div><p>ACL (Access Control List) - acl_file /etc/mosquitto/acls</p><div>\n</div><pre v-pre="true" class="prismjs line-numbers"><code class="language-">user &lt;user-A&gt;\ntopic write &lt;topic-A&gt;/+/event/+\ntopic read &lt;topic-A&gt;/+/command/+\n\nuser &lt;user-B&gt;\ntopic read &lt;topic-A&gt;/+/event/+\ntopic write &lt;topic-A&gt;/+/command/+\n\nuser &lt;user-C&gt;\ntopic write &lt;application-A&gt;/+/device/+/event/+\ntopic read &lt;application-A&gt;/+/device/+/command/+\n\nuser &lt;user-D&gt;\ntopic read &lt;application-A&gt;/123/device/+/event/+\ntopic write &lt;application-A&gt;/123/device/+/command/+\n</code></pre><div>\n</div><p>After configuring your files it is neccessary to restart Mosquitto. From now on authorization for the user should be working without any issues.</p><div>\n</div><h3 class="toc-header" id="sources"><a href="#sources" class="toc-anchor">¶</a> Sources</h3><div>\n</div><p><a class="is-external-link" href="https://www.chirpstack.io/project/guides/mqtt-authentication/">https://www.chirpstack.io/project/guides/mqtt-authentication/</a><br>\n<a class="is-external-link" href="https://www.hackerspace-ffm.de/wiki/index.php?title=MQTT&amp;mobileaction=toggle_view_desktop">https://www.hackerspace-ffm.de/wiki/index.php?title=MQTT&amp;mobileaction=toggle_view_desktop</a></p><div>\n</div>	[{"title":"Missing Authorization","anchor":"#missing-authorization","children":[{"title":"Problem Description","anchor":"#problem-description","children":[]},{"title":"Solution","anchor":"#solution","children":[{"title":"Sources","anchor":"#sources","children":[]}]}]}]	markdown	2021-06-14T07:38:06.283Z	2021-06-14T07:38:33.482Z	markdown	en	1	1	{"js":"","css":""}
\.


--
-- Data for Name: renderers; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.renderers (key, "isEnabled", config) FROM stdin;
htmlAsciinema	f	{}
htmlBlockquotes	t	{}
htmlCodehighlighter	t	{}
htmlCore	t	{"absoluteLinks":false,"openExternalLinkNewTab":false,"relAttributeExternalLink":"noreferrer"}
htmlDiagram	t	{}
htmlImagePrefetch	f	{}
htmlMediaplayers	t	{}
htmlMermaid	t	{}
htmlSecurity	t	{"safeHTML":true,"allowDrawIoUnsafe":true,"allowIFrames":false}
htmlTabset	t	{}
htmlTwemoji	t	{}
markdownAbbr	t	{}
markdownCore	t	{"allowHTML":true,"linkify":true,"linebreaks":true,"underline":false,"typographer":false,"quotes":"English"}
markdownEmoji	t	{}
markdownExpandtabs	t	{"tabWidth":4}
markdownFootnotes	t	{}
markdownImsize	t	{}
markdownKatex	t	{"useInline":true,"useBlocks":true}
markdownKroki	f	{"server":"https://kroki.io","openMarker":"```kroki","closeMarker":"```"}
markdownMathjax	f	{"useInline":true,"useBlocks":true}
markdownMultiTable	f	{"multilineEnabled":true,"headerlessEnabled":true,"rowspanEnabled":true}
markdownPlantuml	t	{"server":"https://plantuml.requarks.io","openMarker":"```plantuml","closeMarker":"```","imageFormat":"svg"}
markdownSupsub	t	{"subEnabled":true,"supEnabled":true}
markdownTasklists	t	{}
openapiCore	t	{}
\.


--
-- Data for Name: searchEngines; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."searchEngines" (key, "isEnabled", config) FROM stdin;
algolia	f	{"appId":"","apiKey":"","indexName":"wiki"}
aws	f	{"domain":"","endpoint":"","region":"us-east-1","accessKeyId":"","secretAccessKey":"","AnalysisSchemeLang":"en"}
azure	f	{"serviceName":"","adminKey":"","indexName":"wiki"}
db	t	{}
elasticsearch	f	{"apiVersion":"6.x","hosts":"","indexName":"wiki","analyzer":"simple","sniffOnStart":false,"sniffInterval":0}
manticore	f	{}
postgres	f	{"dictLanguage":"english"}
solr	f	{"host":"solr","port":8983,"core":"wiki","protocol":"http"}
sphinx	f	{}
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.sessions (sid, sess, expired) FROM stdin;
\.


--
-- Data for Name: settings; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.settings (key, value, "updatedAt") FROM stdin;
auth	{"audience":"urn:wiki.js","tokenExpiration":"30m","tokenRenewal":"14d"}	2021-04-07T19:45:25.655Z
certs	{"jwk":{"kty":"RSA","n":"yfkyUIhldwhIK2lLK3xmGsEgU9_uzPLAdGdB-9lCpqp80x2ToW-84tj3L4po4jbo3wH74D2a8_V4aDVTvQOvGAQ76KW8wI7Xfy0CfrTau110iY1Przmn1SIf0h-nZkN0J54plzhcZ6E2lwDsS-Zds9BFWOowKPaO54U2cGba66oaYDME7x2Kh_eWxYwPGG9GWtRcmxSYLUiGoX_4j9eYfdNzT4S6meA0P_Pn6gjVJZXPVb20U2VOP_2diSGc_C8lsWPudm9oU2P440ohEGZzRcHU7qD98_dWVJh5FnkBrt1rLI7tTpgqdflooMMHvgNzQuplZZILI2m3GC9y7EnjOw","e":"AQAB"},"public":"-----BEGIN RSA PUBLIC KEY-----\\nMIIBCgKCAQEAyfkyUIhldwhIK2lLK3xmGsEgU9/uzPLAdGdB+9lCpqp80x2ToW+8\\n4tj3L4po4jbo3wH74D2a8/V4aDVTvQOvGAQ76KW8wI7Xfy0CfrTau110iY1Przmn\\n1SIf0h+nZkN0J54plzhcZ6E2lwDsS+Zds9BFWOowKPaO54U2cGba66oaYDME7x2K\\nh/eWxYwPGG9GWtRcmxSYLUiGoX/4j9eYfdNzT4S6meA0P/Pn6gjVJZXPVb20U2VO\\nP/2diSGc/C8lsWPudm9oU2P440ohEGZzRcHU7qD98/dWVJh5FnkBrt1rLI7tTpgq\\ndflooMMHvgNzQuplZZILI2m3GC9y7EnjOwIDAQAB\\n-----END RSA PUBLIC KEY-----\\n","private":"-----BEGIN RSA PRIVATE KEY-----\\nProc-Type: 4,ENCRYPTED\\nDEK-Info: AES-256-CBC,D56A85E64ED92BF050B0486FB4958CDC\\n\\npfrxMzl8iKiXz3mMEpAdZS272cOoU3izFv+tgJBNOJFLK2TdpYCqjwF1DcFynEj9\\nr9ywJMaHIQ6iL7++SI8ceIXwtWMp5uYtvi2iN8S/eB22sXb7VOlzZWskUgGet0ov\\nqLC3dnyABiJY9q1k7raZYQsjkncFLIrzjbTCxs1KMiJvnrSusjJq2kQVvwQXEGcl\\nvX7OPZDd8zt9VQAJMUWfEij4JUTbSnemAhj4PBA1aV+SIu0he0wgyEL5YnEUiJgf\\nRwFJo5Fgb4QiylGK15WvdYzFwWJ/QTNchcXegHdz4rDPGt0N/nnbxNG1ubfWP1Lt\\nLSLEkP37HHDFYnjyDJASU1Y7vRHKWFtukHK8LYu6IiOndBeB+J3f0GBY5i3ak9Dx\\nmF5jjAfPB8E/4a68zJvas9YtGP89IBNQYusIj9WNl/hvzL1dCj9V+9pYoOEC1Qgt\\nTNyvU39tzK9pa32qwt4eDSvLeBlNPCscngNjczdmbSG045ra0AgGVB9AGvJ4MyB6\\nAg5QOzM+/v5LqmA1W9ous0KoboiYZg1lCGL9GcKyz0qLAo7gTnHbU0ctffpSFERj\\n77dUHRpAt8V11bVTcRzUAjT4aRe6SqrsyJ5o6KLXQkZdVfbVRvHrDGmK08RWQ/Af\\nU9XW7NQs/bAK+sS6pRwmgOmmfVf2DHeBqw4+ZxYZ2vTHncUPYJcHQF/XMLokgRfg\\nRWpx0BwsDVyqcrgn/rHaE51BhKFzvI6/N14EZLigHo0mM0Sgkb0aV+yl/dwrRSQf\\nRQryGsZDagJVzRVv8o8zLXwMOsnxj/6EROTzFWITtHEk6RIT6NZZIE8yLlnkIcOt\\nqOa4zKnW5Yx/GmjmS8JTbxVZ8kY9W2SeHn2iTW5LtoXOuOwvEkji5rDXfK95G/hZ\\npkBxh8Cmq7Lb1pvT2W16FNiXcZ2eZccAHSjyjy8YuRp4NzkOqEGnLSrsCbRK6/D+\\nzh0fo/GCsBmUYNKK4Gaq6XY5fkcr6noROJTtZC0BeDVmmKMlHqE4S9Pl73gvnSq0\\n+BUZFKCpVceSSypeLRaTIXHHmzVBh8sj7DtbPsMKWjtL19FOdBZbOt7slQ+IVlSQ\\nKzIeorSFIpojeSi+hafamWatd8TO0WbcerQVY7NtoSOZxMsPC2nmE/+StgP0uMT3\\nEacvrU41OaUsVbK9TIlRHH7Hq3UjU//3G/DhBK1DNPG95+tBDpX+7MxKHklfroej\\nUj3MEoMC6sn4Rw/RCOR4oTXLvqbJn5VnhzIxEwBLXt1by0y+VrFVLrP4EdngrcRn\\nzCTyP86PC7LErBEWepl0d+WQghly84KVPV5sWH43YRngTQyWMMyi1lsq48lZ3lJo\\n28OjHdo7B5dt/wQNhyNBczLGK9m+ny3NX9mJUnyFoSeRVaHko8uEvN01rogkQS2s\\n2cWxOLF+KimJMwv8lEMns4jQSYSFlotMx1m+jjH7b6t84xpY5FcOQjDEkiNh0kD2\\nUULZMZZZ2juSQ7/oJOC5fic6wIzpkVs5HOhMsX0UIl4yHbJMebpK5JBfS6yA0J+i\\nQG3wNAe/snUMdBrzS0i3j+ePIUr5sM4m+dYFweQijCc7mbMJeQIFDmz4GxfM4f8m\\n-----END RSA PRIVATE KEY-----\\n"}	2021-04-07T19:45:25.684Z
company	{"v":""}	2021-04-07T19:45:25.698Z
features	{"featurePageRatings":true,"featurePageComments":true,"featurePersonalWikis":true}	2021-04-07T19:45:25.712Z
graphEndpoint	{"v":"https://graph.requarks.io"}	2021-04-07T19:45:25.724Z
host	{"v":"https://wiki.yourdomain.com"}	2021-04-07T19:45:25.737Z
lang	{"code":"en","autoUpdate":true,"namespacing":false,"namespaces":[]}	2021-04-07T19:45:25.748Z
logo	{"hasLogo":false,"logoIsSquare":false}	2021-04-07T19:45:25.762Z
mail	{"senderName":"","senderEmail":"","host":"","port":465,"secure":true,"verifySSL":true,"user":"","pass":"","useDKIM":false,"dkimDomainName":"","dkimKeySelector":"","dkimPrivateKey":""}	2021-04-07T19:45:25.774Z
seo	{"description":"","robots":["index","follow"],"analyticsService":"","analyticsId":""}	2021-04-07T19:45:25.786Z
sessionSecret	{"v":"731a54ca4af02e5005dc8487d4047bfe54ed44a517c1657b9ea755234cda0953"}	2021-04-07T19:45:25.797Z
telemetry	{"isEnabled":false,"clientId":"3e4d15be-5d6b-4b3a-b54e-2f85ea151f38"}	2021-04-07T19:45:25.809Z
theming	{"theme":"default","darkMode":false,"iconset":"mdi","injectCSS":"","injectHead":"","injectBody":""}	2021-04-07T19:45:25.820Z
uploads	{"maxFileSize":5242880,"maxFiles":10}	2021-04-07T19:45:25.832Z
title	{"v":"Wiki.js"}	2021-04-07T19:45:25.845Z
nav	{"mode":"TREE"}	2021-06-17T08:09:02.657Z
\.


--
-- Data for Name: storage; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.storage (key, "isEnabled", mode, config, "syncInterval", state) FROM stdin;
s3	f	push	{"region":"","bucket":"","accessKeyId":"","secretAccessKey":""}	P0D	{"status":"pending","message":"","lastAttempt":null}
s3generic	f	push	{"endpoint":"https://service.region.example.com","bucket":"","accessKeyId":"","secretAccessKey":"","sslEnabled":true,"s3ForcePathStyle":false,"s3BucketEndpoint":false}	P0D	{"status":"pending","message":"","lastAttempt":null}
sftp	f	push	{"host":"","port":22,"authMode":"privateKey","username":"","privateKey":"","passphrase":"","password":"","basePath":"/root/wiki"}	P0D	{"status":"pending","message":"","lastAttempt":null}
azure	f	push	{"accountName":"","accountKey":"","containerName":"wiki","storageTier":"Cool"}	P0D	{"status":"pending","message":"","lastAttempt":null}
box	f	push	{"clientId":"","clientSecret":"","rootFolder":""}	P0D	{"status":"pending","message":"","lastAttempt":null}
digitalocean	f	push	{"endpoint":"nyc3.digitaloceanspaces.com","bucket":"","accessKeyId":"","secretAccessKey":""}	P0D	{"status":"pending","message":"","lastAttempt":null}
disk	f	push	{"path":"","createDailyBackups":false}	P0D	{"status":"pending","message":"","lastAttempt":null}
dropbox	f	push	{"appKey":"","appSecret":""}	P0D	{"status":"pending","message":"","lastAttempt":null}
gdrive	f	push	{"clientId":"","clientSecret":""}	P0D	{"status":"pending","message":"","lastAttempt":null}
git	f	sync	{"authType":"ssh","repoUrl":"","branch":"master","sshPrivateKeyMode":"path","sshPrivateKeyPath":"","sshPrivateKeyContent":"","verifySSL":true,"basicUsername":"","basicPassword":"","defaultEmail":"name@company.com","defaultName":"John Smith","localRepoPath":"./data/repo","gitBinaryPath":""}	PT5M	{"status":"pending","message":"","lastAttempt":null}
onedrive	f	push	{"clientId":"","clientSecret":""}	P0D	{"status":"pending","message":"","lastAttempt":null}
\.


--
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.tags (id, tag, title, "createdAt", "updatedAt") FROM stdin;
1	mqtt	mqtt	2021-04-07T19:48:15.915Z	2021-04-07T19:48:15.915Z
2	security	security	2021-04-07T19:48:15.915Z	2021-04-07T19:48:15.915Z
\.


--
-- Data for Name: userAvatars; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."userAvatars" (id, data) FROM stdin;
\.


--
-- Data for Name: userGroups; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."userGroups" (id, "userId", "groupId") FROM stdin;
1	1	1
2	2	2
\.


--
-- Data for Name: userKeys; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."userKeys" (id, kind, token, "createdAt", "validUntil", "userId") FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.users (id, email, name, "providerId", password, "tfaIsActive", "tfaSecret", "jobTitle", location, "pictureUrl", timezone, "isSystem", "isActive", "isVerified", "mustChangePwd", "createdAt", "updatedAt", "providerKey", "localeCode", "defaultEditor", "lastLoginAt", "dateFormat", appearance) FROM stdin;
2	guest@example.com	Guest	\N		f	\N			\N	America/New_York	t	t	t	f	2021-04-07T19:45:27.423Z	2021-04-07T19:45:27.423Z	local	en	markdown	\N		
1	admin@yourdomain.com	Administrator	\N	$2a$12$FLnL.27gqrg.kBGIhgpDPuMlhFMh0h.2xbc7J9LD5onKb8NUEmB7O	f	\N			\N	Europe/Vienna	f	t	t	f	2021-04-07T19:45:26.750Z	2021-04-13T09:59:27.763Z	local	en	markdown	2021-06-17T08:07:22.114Z		dark
\.


--
-- Name: apiKeys_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public."apiKeys_id_seq"', 1, false);


--
-- Name: assetFolders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public."assetFolders_id_seq"', 1, false);


--
-- Name: assets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public.assets_id_seq', 1, false);


--
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public.comments_id_seq', 1, false);


--
-- Name: groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public.groups_id_seq', 2, true);


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public.migrations_id_seq', 16, true);


--
-- Name: migrations_lock_index_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public.migrations_lock_index_seq', 1, true);


--
-- Name: pageHistoryTags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public."pageHistoryTags_id_seq"', 1, false);


--
-- Name: pageHistory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public."pageHistory_id_seq"', 25, true);


--
-- Name: pageLinks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public."pageLinks_id_seq"', 7, true);


--
-- Name: pageTags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public."pageTags_id_seq"', 2, true);


--
-- Name: pages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public.pages_id_seq', 8, true);


--
-- Name: tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public.tags_id_seq', 2, true);


--
-- Name: userGroups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public."userGroups_id_seq"', 2, true);


--
-- Name: userKeys_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public."userKeys_id_seq"', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public.users_id_seq', 2, true);


--
-- Name: analytics analytics_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.analytics
    ADD CONSTRAINT analytics_pkey PRIMARY KEY (key);


--
-- Name: apiKeys apiKeys_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."apiKeys"
    ADD CONSTRAINT "apiKeys_pkey" PRIMARY KEY (id);


--
-- Name: assetData assetData_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."assetData"
    ADD CONSTRAINT "assetData_pkey" PRIMARY KEY (id);


--
-- Name: assetFolders assetFolders_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."assetFolders"
    ADD CONSTRAINT "assetFolders_pkey" PRIMARY KEY (id);


--
-- Name: assets assets_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT assets_pkey PRIMARY KEY (id);


--
-- Name: authentication authentication_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.authentication
    ADD CONSTRAINT authentication_pkey PRIMARY KEY (key);


--
-- Name: commentProviders commentProviders_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."commentProviders"
    ADD CONSTRAINT "commentProviders_pkey" PRIMARY KEY (key);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: editors editors_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.editors
    ADD CONSTRAINT editors_pkey PRIMARY KEY (key);


--
-- Name: groups groups_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (id);


--
-- Name: locales locales_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.locales
    ADD CONSTRAINT locales_pkey PRIMARY KEY (code);


--
-- Name: loggers loggers_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.loggers
    ADD CONSTRAINT loggers_pkey PRIMARY KEY (key);


--
-- Name: migrations_lock migrations_lock_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.migrations_lock
    ADD CONSTRAINT migrations_lock_pkey PRIMARY KEY (index);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: navigation navigation_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.navigation
    ADD CONSTRAINT navigation_pkey PRIMARY KEY (key);


--
-- Name: pageHistoryTags pageHistoryTags_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageHistoryTags"
    ADD CONSTRAINT "pageHistoryTags_pkey" PRIMARY KEY (id);


--
-- Name: pageHistory pageHistory_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageHistory"
    ADD CONSTRAINT "pageHistory_pkey" PRIMARY KEY (id);


--
-- Name: pageLinks pageLinks_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageLinks"
    ADD CONSTRAINT "pageLinks_pkey" PRIMARY KEY (id);


--
-- Name: pageTags pageTags_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageTags"
    ADD CONSTRAINT "pageTags_pkey" PRIMARY KEY (id);


--
-- Name: pageTree pageTree_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageTree"
    ADD CONSTRAINT "pageTree_pkey" PRIMARY KEY (id);


--
-- Name: pages pages_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_pkey PRIMARY KEY (id);


--
-- Name: renderers renderers_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.renderers
    ADD CONSTRAINT renderers_pkey PRIMARY KEY (key);


--
-- Name: searchEngines searchEngines_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."searchEngines"
    ADD CONSTRAINT "searchEngines_pkey" PRIMARY KEY (key);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (sid);


--
-- Name: settings settings_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.settings
    ADD CONSTRAINT settings_pkey PRIMARY KEY (key);


--
-- Name: storage storage_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.storage
    ADD CONSTRAINT storage_pkey PRIMARY KEY (key);


--
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: tags tags_tag_unique; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_tag_unique UNIQUE (tag);


--
-- Name: userAvatars userAvatars_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."userAvatars"
    ADD CONSTRAINT "userAvatars_pkey" PRIMARY KEY (id);


--
-- Name: userGroups userGroups_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."userGroups"
    ADD CONSTRAINT "userGroups_pkey" PRIMARY KEY (id);


--
-- Name: userKeys userKeys_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."userKeys"
    ADD CONSTRAINT "userKeys_pkey" PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_providerkey_email_unique; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_providerkey_email_unique UNIQUE ("providerKey", email);


--
-- Name: pagelinks_path_localecode_index; Type: INDEX; Schema: public; Owner: wikijs
--

CREATE INDEX pagelinks_path_localecode_index ON public."pageLinks" USING btree (path, "localeCode");


--
-- Name: sessions_expired_index; Type: INDEX; Schema: public; Owner: wikijs
--

CREATE INDEX sessions_expired_index ON public.sessions USING btree (expired);


--
-- Name: assetFolders assetfolders_parentid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."assetFolders"
    ADD CONSTRAINT assetfolders_parentid_foreign FOREIGN KEY ("parentId") REFERENCES public."assetFolders"(id);


--
-- Name: assets assets_authorid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT assets_authorid_foreign FOREIGN KEY ("authorId") REFERENCES public.users(id);


--
-- Name: assets assets_folderid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT assets_folderid_foreign FOREIGN KEY ("folderId") REFERENCES public."assetFolders"(id);


--
-- Name: comments comments_authorid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_authorid_foreign FOREIGN KEY ("authorId") REFERENCES public.users(id);


--
-- Name: comments comments_pageid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pageid_foreign FOREIGN KEY ("pageId") REFERENCES public.pages(id);


--
-- Name: pageHistory pagehistory_authorid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageHistory"
    ADD CONSTRAINT pagehistory_authorid_foreign FOREIGN KEY ("authorId") REFERENCES public.users(id);


--
-- Name: pageHistory pagehistory_editorkey_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageHistory"
    ADD CONSTRAINT pagehistory_editorkey_foreign FOREIGN KEY ("editorKey") REFERENCES public.editors(key);


--
-- Name: pageHistory pagehistory_localecode_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageHistory"
    ADD CONSTRAINT pagehistory_localecode_foreign FOREIGN KEY ("localeCode") REFERENCES public.locales(code);


--
-- Name: pageHistoryTags pagehistorytags_pageid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageHistoryTags"
    ADD CONSTRAINT pagehistorytags_pageid_foreign FOREIGN KEY ("pageId") REFERENCES public."pageHistory"(id) ON DELETE CASCADE;


--
-- Name: pageHistoryTags pagehistorytags_tagid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageHistoryTags"
    ADD CONSTRAINT pagehistorytags_tagid_foreign FOREIGN KEY ("tagId") REFERENCES public.tags(id) ON DELETE CASCADE;


--
-- Name: pageLinks pagelinks_pageid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageLinks"
    ADD CONSTRAINT pagelinks_pageid_foreign FOREIGN KEY ("pageId") REFERENCES public.pages(id) ON DELETE CASCADE;


--
-- Name: pages pages_authorid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_authorid_foreign FOREIGN KEY ("authorId") REFERENCES public.users(id);


--
-- Name: pages pages_creatorid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_creatorid_foreign FOREIGN KEY ("creatorId") REFERENCES public.users(id);


--
-- Name: pages pages_editorkey_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_editorkey_foreign FOREIGN KEY ("editorKey") REFERENCES public.editors(key);


--
-- Name: pages pages_localecode_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_localecode_foreign FOREIGN KEY ("localeCode") REFERENCES public.locales(code);


--
-- Name: pageTags pagetags_pageid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageTags"
    ADD CONSTRAINT pagetags_pageid_foreign FOREIGN KEY ("pageId") REFERENCES public.pages(id) ON DELETE CASCADE;


--
-- Name: pageTags pagetags_tagid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageTags"
    ADD CONSTRAINT pagetags_tagid_foreign FOREIGN KEY ("tagId") REFERENCES public.tags(id) ON DELETE CASCADE;


--
-- Name: pageTree pagetree_localecode_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageTree"
    ADD CONSTRAINT pagetree_localecode_foreign FOREIGN KEY ("localeCode") REFERENCES public.locales(code);


--
-- Name: pageTree pagetree_pageid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageTree"
    ADD CONSTRAINT pagetree_pageid_foreign FOREIGN KEY ("pageId") REFERENCES public.pages(id) ON DELETE CASCADE;


--
-- Name: pageTree pagetree_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageTree"
    ADD CONSTRAINT pagetree_parent_foreign FOREIGN KEY (parent) REFERENCES public."pageTree"(id) ON DELETE CASCADE;


--
-- Name: userGroups usergroups_groupid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."userGroups"
    ADD CONSTRAINT usergroups_groupid_foreign FOREIGN KEY ("groupId") REFERENCES public.groups(id) ON DELETE CASCADE;


--
-- Name: userGroups usergroups_userid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."userGroups"
    ADD CONSTRAINT usergroups_userid_foreign FOREIGN KEY ("userId") REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: userKeys userkeys_userid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."userKeys"
    ADD CONSTRAINT userkeys_userid_foreign FOREIGN KEY ("userId") REFERENCES public.users(id);


--
-- Name: users users_defaulteditor_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_defaulteditor_foreign FOREIGN KEY ("defaultEditor") REFERENCES public.editors(key);


--
-- Name: users users_localecode_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_localecode_foreign FOREIGN KEY ("localeCode") REFERENCES public.locales(code);


--
-- Name: users users_providerkey_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_providerkey_foreign FOREIGN KEY ("providerKey") REFERENCES public.authentication(key);


--
-- PostgreSQL database dump complete
--

