--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: temp; Type: SCHEMA; Schema: -; Owner: craft3
--

CREATE SCHEMA temp;


ALTER SCHEMA temp OWNER TO craft3;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: assettransforms_interlace; Type: TYPE; Schema: temp; Owner: craft3
--

CREATE TYPE temp.assettransforms_interlace AS ENUM (
    'none',
    'line',
    'plane',
    'partition'
);


ALTER TYPE temp.assettransforms_interlace OWNER TO craft3;

--
-- Name: assettransforms_mode; Type: TYPE; Schema: temp; Owner: craft3
--

CREATE TYPE temp.assettransforms_mode AS ENUM (
    'stretch',
    'fit',
    'crop'
);


ALTER TYPE temp.assettransforms_mode OWNER TO craft3;

--
-- Name: assettransforms_position; Type: TYPE; Schema: temp; Owner: craft3
--

CREATE TYPE temp.assettransforms_position AS ENUM (
    'top-left',
    'top-center',
    'top-right',
    'center-left',
    'center-center',
    'center-right',
    'bottom-left',
    'bottom-center',
    'bottom-right'
);


ALTER TYPE temp.assettransforms_position OWNER TO craft3;

--
-- Name: migrations_type; Type: TYPE; Schema: temp; Owner: craft3
--

CREATE TYPE temp.migrations_type AS ENUM (
    'app',
    'plugin',
    'content'
);


ALTER TYPE temp.migrations_type OWNER TO craft3;

--
-- Name: plugins_licensekeystatus; Type: TYPE; Schema: temp; Owner: craft3
--

CREATE TYPE temp.plugins_licensekeystatus AS ENUM (
    'valid',
    'invalid',
    'mismatched',
    'astray',
    'unknown'
);


ALTER TYPE temp.plugins_licensekeystatus OWNER TO craft3;

--
-- Name: sections_type; Type: TYPE; Schema: temp; Owner: craft3
--

CREATE TYPE temp.sections_type AS ENUM (
    'single',
    'channel',
    'structure'
);


ALTER TYPE temp.sections_type OWNER TO craft3;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: assetindexdata; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.assetindexdata (
    id bigint NOT NULL,
    sessionid character varying(36) DEFAULT ''::character varying NOT NULL,
    volumeid bigint NOT NULL,
    uri text,
    size numeric,
    "timestamp" timestamp with time zone,
    recordid bigint,
    inprogress boolean DEFAULT false,
    completed boolean DEFAULT false,
    datecreated timestamp with time zone NOT NULL,
    dateupdated timestamp with time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE temp.assetindexdata OWNER TO craft3;

--
-- Name: assetindexdata_id_seq; Type: SEQUENCE; Schema: temp; Owner: craft3
--

CREATE SEQUENCE temp.assetindexdata_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE temp.assetindexdata_id_seq OWNER TO craft3;

--
-- Name: assetindexdata_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: craft3
--

ALTER SEQUENCE temp.assetindexdata_id_seq OWNED BY temp.assetindexdata.id;


--
-- Name: assets; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.assets (
    id bigint NOT NULL,
    volumeid bigint,
    folderid bigint NOT NULL,
    filename character varying(255) NOT NULL,
    kind character varying(50) DEFAULT 'unknown'::character varying NOT NULL,
    width bigint,
    height bigint,
    size numeric,
    focalpoint character varying(13),
    datemodified timestamp with time zone,
    datecreated timestamp with time zone NOT NULL,
    dateupdated timestamp with time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE temp.assets OWNER TO craft3;

--
-- Name: assettransformindex; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.assettransformindex (
    id bigint NOT NULL,
    assetid bigint NOT NULL,
    filename character varying(255),
    format character varying(255),
    location character varying(255) NOT NULL,
    volumeid bigint,
    fileexists boolean DEFAULT false NOT NULL,
    inprogress boolean DEFAULT false NOT NULL,
    dateindexed timestamp with time zone,
    datecreated timestamp with time zone NOT NULL,
    dateupdated timestamp with time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE temp.assettransformindex OWNER TO craft3;

--
-- Name: assettransformindex_id_seq; Type: SEQUENCE; Schema: temp; Owner: craft3
--

CREATE SEQUENCE temp.assettransformindex_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE temp.assettransformindex_id_seq OWNER TO craft3;

--
-- Name: assettransformindex_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: craft3
--

ALTER SEQUENCE temp.assettransformindex_id_seq OWNED BY temp.assettransformindex.id;


--
-- Name: assettransforms; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.assettransforms (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    handle character varying(255) NOT NULL,
    mode temp.assettransforms_mode DEFAULT 'crop'::temp.assettransforms_mode NOT NULL,
    "position" temp.assettransforms_position DEFAULT 'center-center'::temp.assettransforms_position NOT NULL,
    width bigint,
    height bigint,
    format character varying(255),
    quality bigint,
    interlace temp.assettransforms_interlace DEFAULT 'none'::temp.assettransforms_interlace NOT NULL,
    dimensionchangetime timestamp with time zone,
    datecreated timestamp with time zone NOT NULL,
    dateupdated timestamp with time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE temp.assettransforms OWNER TO craft3;

--
-- Name: assettransforms_id_seq; Type: SEQUENCE; Schema: temp; Owner: craft3
--

CREATE SEQUENCE temp.assettransforms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE temp.assettransforms_id_seq OWNER TO craft3;

--
-- Name: assettransforms_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: craft3
--

ALTER SEQUENCE temp.assettransforms_id_seq OWNED BY temp.assettransforms.id;


--
-- Name: categories; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.categories (
    id bigint NOT NULL,
    groupid bigint NOT NULL,
    datecreated timestamp with time zone NOT NULL,
    dateupdated timestamp with time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE temp.categories OWNER TO craft3;

--
-- Name: categorygroups; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.categorygroups (
    id bigint NOT NULL,
    structureid bigint NOT NULL,
    fieldlayoutid bigint,
    name character varying(255) NOT NULL,
    handle character varying(255) NOT NULL,
    datecreated timestamp with time zone NOT NULL,
    dateupdated timestamp with time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE temp.categorygroups OWNER TO craft3;

--
-- Name: categorygroups_id_seq; Type: SEQUENCE; Schema: temp; Owner: craft3
--

CREATE SEQUENCE temp.categorygroups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE temp.categorygroups_id_seq OWNER TO craft3;

--
-- Name: categorygroups_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: craft3
--

ALTER SEQUENCE temp.categorygroups_id_seq OWNED BY temp.categorygroups.id;


--
-- Name: categorygroups_sites; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.categorygroups_sites (
    id bigint NOT NULL,
    groupid bigint NOT NULL,
    siteid bigint NOT NULL,
    hasurls boolean DEFAULT true NOT NULL,
    uriformat text,
    template character varying(500),
    datecreated timestamp with time zone NOT NULL,
    dateupdated timestamp with time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE temp.categorygroups_sites OWNER TO craft3;

--
-- Name: categorygroups_sites_id_seq; Type: SEQUENCE; Schema: temp; Owner: craft3
--

CREATE SEQUENCE temp.categorygroups_sites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE temp.categorygroups_sites_id_seq OWNER TO craft3;

--
-- Name: categorygroups_sites_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: craft3
--

ALTER SEQUENCE temp.categorygroups_sites_id_seq OWNED BY temp.categorygroups_sites.id;


--
-- Name: content; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.content (
    id bigint NOT NULL,
    elementid bigint NOT NULL,
    siteid bigint NOT NULL,
    title character varying(255),
    datecreated timestamp with time zone NOT NULL,
    dateupdated timestamp with time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL,
    field_text text,
    field_address text,
    field_opentime text
);


ALTER TABLE temp.content OWNER TO craft3;

--
-- Name: content_id_seq; Type: SEQUENCE; Schema: temp; Owner: craft3
--

CREATE SEQUENCE temp.content_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE temp.content_id_seq OWNER TO craft3;

--
-- Name: content_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: craft3
--

ALTER SEQUENCE temp.content_id_seq OWNED BY temp.content.id;


--
-- Name: craftidtokens; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.craftidtokens (
    id bigint NOT NULL,
    userid bigint NOT NULL,
    accesstoken text NOT NULL,
    expirydate timestamp with time zone,
    datecreated timestamp with time zone NOT NULL,
    dateupdated timestamp with time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE temp.craftidtokens OWNER TO craft3;

--
-- Name: craftidtokens_id_seq; Type: SEQUENCE; Schema: temp; Owner: craft3
--

CREATE SEQUENCE temp.craftidtokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE temp.craftidtokens_id_seq OWNER TO craft3;

--
-- Name: craftidtokens_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: craft3
--

ALTER SEQUENCE temp.craftidtokens_id_seq OWNED BY temp.craftidtokens.id;


--
-- Name: deprecationerrors; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.deprecationerrors (
    id bigint NOT NULL,
    key character varying(255) NOT NULL,
    fingerprint character varying(255) NOT NULL,
    lastoccurrence timestamp with time zone NOT NULL,
    file character varying(255) NOT NULL,
    line integer,
    message character varying(255),
    traces text,
    datecreated timestamp with time zone NOT NULL,
    dateupdated timestamp with time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE temp.deprecationerrors OWNER TO craft3;

--
-- Name: deprecationerrors_id_seq; Type: SEQUENCE; Schema: temp; Owner: craft3
--

CREATE SEQUENCE temp.deprecationerrors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE temp.deprecationerrors_id_seq OWNER TO craft3;

--
-- Name: deprecationerrors_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: craft3
--

ALTER SEQUENCE temp.deprecationerrors_id_seq OWNED BY temp.deprecationerrors.id;


--
-- Name: elementindexsettings; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.elementindexsettings (
    id bigint NOT NULL,
    type character varying(255) NOT NULL,
    settings text,
    datecreated timestamp with time zone NOT NULL,
    dateupdated timestamp with time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE temp.elementindexsettings OWNER TO craft3;

--
-- Name: elementindexsettings_id_seq; Type: SEQUENCE; Schema: temp; Owner: craft3
--

CREATE SEQUENCE temp.elementindexsettings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE temp.elementindexsettings_id_seq OWNER TO craft3;

--
-- Name: elementindexsettings_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: craft3
--

ALTER SEQUENCE temp.elementindexsettings_id_seq OWNED BY temp.elementindexsettings.id;


--
-- Name: elements; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.elements (
    id bigint NOT NULL,
    fieldlayoutid bigint,
    type character varying(255) NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    archived boolean DEFAULT false NOT NULL,
    datecreated timestamp with time zone NOT NULL,
    dateupdated timestamp with time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE temp.elements OWNER TO craft3;

--
-- Name: elements_id_seq; Type: SEQUENCE; Schema: temp; Owner: craft3
--

CREATE SEQUENCE temp.elements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE temp.elements_id_seq OWNER TO craft3;

--
-- Name: elements_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: craft3
--

ALTER SEQUENCE temp.elements_id_seq OWNED BY temp.elements.id;


--
-- Name: elements_sites; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.elements_sites (
    id bigint NOT NULL,
    elementid bigint NOT NULL,
    siteid bigint NOT NULL,
    slug character varying(255),
    uri character varying(255),
    enabled boolean DEFAULT true NOT NULL,
    datecreated timestamp with time zone NOT NULL,
    dateupdated timestamp with time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE temp.elements_sites OWNER TO craft3;

--
-- Name: elements_sites_id_seq; Type: SEQUENCE; Schema: temp; Owner: craft3
--

CREATE SEQUENCE temp.elements_sites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE temp.elements_sites_id_seq OWNER TO craft3;

--
-- Name: elements_sites_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: craft3
--

ALTER SEQUENCE temp.elements_sites_id_seq OWNED BY temp.elements_sites.id;


--
-- Name: entries; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.entries (
    id bigint NOT NULL,
    sectionid bigint NOT NULL,
    typeid bigint NOT NULL,
    authorid bigint,
    postdate timestamp with time zone,
    expirydate timestamp with time zone,
    datecreated timestamp with time zone NOT NULL,
    dateupdated timestamp with time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE temp.entries OWNER TO craft3;

--
-- Name: entrydrafts; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.entrydrafts (
    id bigint NOT NULL,
    entryid bigint NOT NULL,
    sectionid bigint NOT NULL,
    creatorid bigint NOT NULL,
    siteid bigint NOT NULL,
    name character varying(255) NOT NULL,
    notes text,
    data text NOT NULL,
    datecreated timestamp with time zone NOT NULL,
    dateupdated timestamp with time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE temp.entrydrafts OWNER TO craft3;

--
-- Name: entrydrafts_id_seq; Type: SEQUENCE; Schema: temp; Owner: craft3
--

CREATE SEQUENCE temp.entrydrafts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE temp.entrydrafts_id_seq OWNER TO craft3;

--
-- Name: entrydrafts_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: craft3
--

ALTER SEQUENCE temp.entrydrafts_id_seq OWNED BY temp.entrydrafts.id;


--
-- Name: entrytypes; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.entrytypes (
    id bigint NOT NULL,
    sectionid bigint NOT NULL,
    fieldlayoutid bigint,
    name character varying(255) NOT NULL,
    handle character varying(255) NOT NULL,
    hastitlefield boolean DEFAULT true NOT NULL,
    titlelabel character varying(255) DEFAULT 'Title'::character varying,
    titleformat character varying(255),
    sortorder integer,
    datecreated timestamp with time zone NOT NULL,
    dateupdated timestamp with time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE temp.entrytypes OWNER TO craft3;

--
-- Name: entrytypes_id_seq; Type: SEQUENCE; Schema: temp; Owner: craft3
--

CREATE SEQUENCE temp.entrytypes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE temp.entrytypes_id_seq OWNER TO craft3;

--
-- Name: entrytypes_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: craft3
--

ALTER SEQUENCE temp.entrytypes_id_seq OWNED BY temp.entrytypes.id;


--
-- Name: entryversions; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.entryversions (
    id bigint NOT NULL,
    entryid bigint NOT NULL,
    sectionid bigint NOT NULL,
    creatorid bigint,
    siteid bigint NOT NULL,
    num integer NOT NULL,
    notes text,
    data text NOT NULL,
    datecreated timestamp with time zone NOT NULL,
    dateupdated timestamp with time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE temp.entryversions OWNER TO craft3;

--
-- Name: entryversions_id_seq; Type: SEQUENCE; Schema: temp; Owner: craft3
--

CREATE SEQUENCE temp.entryversions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE temp.entryversions_id_seq OWNER TO craft3;

--
-- Name: entryversions_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: craft3
--

ALTER SEQUENCE temp.entryversions_id_seq OWNED BY temp.entryversions.id;


--
-- Name: fieldgroups; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.fieldgroups (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    datecreated timestamp with time zone NOT NULL,
    dateupdated timestamp with time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE temp.fieldgroups OWNER TO craft3;

--
-- Name: fieldgroups_id_seq; Type: SEQUENCE; Schema: temp; Owner: craft3
--

CREATE SEQUENCE temp.fieldgroups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE temp.fieldgroups_id_seq OWNER TO craft3;

--
-- Name: fieldgroups_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: craft3
--

ALTER SEQUENCE temp.fieldgroups_id_seq OWNED BY temp.fieldgroups.id;


--
-- Name: fieldlayoutfields; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.fieldlayoutfields (
    id bigint NOT NULL,
    layoutid bigint NOT NULL,
    tabid bigint NOT NULL,
    fieldid bigint NOT NULL,
    required boolean DEFAULT false NOT NULL,
    sortorder integer,
    datecreated timestamp with time zone NOT NULL,
    dateupdated timestamp with time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE temp.fieldlayoutfields OWNER TO craft3;

--
-- Name: fieldlayoutfields_id_seq; Type: SEQUENCE; Schema: temp; Owner: craft3
--

CREATE SEQUENCE temp.fieldlayoutfields_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE temp.fieldlayoutfields_id_seq OWNER TO craft3;

--
-- Name: fieldlayoutfields_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: craft3
--

ALTER SEQUENCE temp.fieldlayoutfields_id_seq OWNED BY temp.fieldlayoutfields.id;


--
-- Name: fieldlayouts; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.fieldlayouts (
    id bigint NOT NULL,
    type character varying(255) NOT NULL,
    datecreated timestamp with time zone NOT NULL,
    dateupdated timestamp with time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE temp.fieldlayouts OWNER TO craft3;

--
-- Name: fieldlayouts_id_seq; Type: SEQUENCE; Schema: temp; Owner: craft3
--

CREATE SEQUENCE temp.fieldlayouts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE temp.fieldlayouts_id_seq OWNER TO craft3;

--
-- Name: fieldlayouts_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: craft3
--

ALTER SEQUENCE temp.fieldlayouts_id_seq OWNED BY temp.fieldlayouts.id;


--
-- Name: fieldlayouttabs; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.fieldlayouttabs (
    id bigint NOT NULL,
    layoutid bigint NOT NULL,
    name character varying(255) NOT NULL,
    sortorder integer,
    datecreated timestamp with time zone NOT NULL,
    dateupdated timestamp with time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE temp.fieldlayouttabs OWNER TO craft3;

--
-- Name: fieldlayouttabs_id_seq; Type: SEQUENCE; Schema: temp; Owner: craft3
--

CREATE SEQUENCE temp.fieldlayouttabs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE temp.fieldlayouttabs_id_seq OWNER TO craft3;

--
-- Name: fieldlayouttabs_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: craft3
--

ALTER SEQUENCE temp.fieldlayouttabs_id_seq OWNED BY temp.fieldlayouttabs.id;


--
-- Name: fields; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.fields (
    id bigint NOT NULL,
    groupid bigint,
    name character varying(255) NOT NULL,
    handle character varying(64) NOT NULL,
    context character varying(255) DEFAULT 'global'::character varying NOT NULL,
    instructions text,
    translationmethod character varying(255) DEFAULT 'none'::character varying NOT NULL,
    translationkeyformat text,
    type character varying(255) NOT NULL,
    settings text,
    datecreated timestamp with time zone NOT NULL,
    dateupdated timestamp with time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE temp.fields OWNER TO craft3;

--
-- Name: fields_id_seq; Type: SEQUENCE; Schema: temp; Owner: craft3
--

CREATE SEQUENCE temp.fields_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE temp.fields_id_seq OWNER TO craft3;

--
-- Name: fields_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: craft3
--

ALTER SEQUENCE temp.fields_id_seq OWNED BY temp.fields.id;


--
-- Name: globalsets; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.globalsets (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    handle character varying(255) NOT NULL,
    fieldlayoutid bigint,
    datecreated timestamp with time zone NOT NULL,
    dateupdated timestamp with time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE temp.globalsets OWNER TO craft3;

--
-- Name: globalsets_id_seq; Type: SEQUENCE; Schema: temp; Owner: craft3
--

CREATE SEQUENCE temp.globalsets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE temp.globalsets_id_seq OWNER TO craft3;

--
-- Name: globalsets_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: craft3
--

ALTER SEQUENCE temp.globalsets_id_seq OWNED BY temp.globalsets.id;


--
-- Name: info; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.info (
    id bigint NOT NULL,
    version character varying(50) NOT NULL,
    schemaversion character varying(15) NOT NULL,
    edition smallint NOT NULL,
    timezone character varying(30),
    name character varying(255) NOT NULL,
    "on" boolean DEFAULT false NOT NULL,
    maintenance boolean DEFAULT false NOT NULL,
    fieldversion character(12) DEFAULT '000000000000'::bpchar NOT NULL,
    datecreated timestamp with time zone NOT NULL,
    dateupdated timestamp with time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE temp.info OWNER TO craft3;

--
-- Name: info_id_seq; Type: SEQUENCE; Schema: temp; Owner: craft3
--

CREATE SEQUENCE temp.info_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE temp.info_id_seq OWNER TO craft3;

--
-- Name: info_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: craft3
--

ALTER SEQUENCE temp.info_id_seq OWNED BY temp.info.id;


--
-- Name: matrixblocks; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.matrixblocks (
    id bigint NOT NULL,
    ownerid bigint NOT NULL,
    ownersiteid bigint,
    fieldid bigint NOT NULL,
    typeid bigint NOT NULL,
    sortorder integer,
    datecreated timestamp with time zone NOT NULL,
    dateupdated timestamp with time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE temp.matrixblocks OWNER TO craft3;

--
-- Name: matrixblocktypes; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.matrixblocktypes (
    id bigint NOT NULL,
    fieldid bigint NOT NULL,
    fieldlayoutid bigint,
    name character varying(255) NOT NULL,
    handle character varying(255) NOT NULL,
    sortorder integer,
    datecreated timestamp with time zone NOT NULL,
    dateupdated timestamp with time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE temp.matrixblocktypes OWNER TO craft3;

--
-- Name: matrixblocktypes_id_seq; Type: SEQUENCE; Schema: temp; Owner: craft3
--

CREATE SEQUENCE temp.matrixblocktypes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE temp.matrixblocktypes_id_seq OWNER TO craft3;

--
-- Name: matrixblocktypes_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: craft3
--

ALTER SEQUENCE temp.matrixblocktypes_id_seq OWNED BY temp.matrixblocktypes.id;


--
-- Name: migrations; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.migrations (
    id bigint NOT NULL,
    pluginid bigint,
    type temp.migrations_type DEFAULT 'app'::temp.migrations_type NOT NULL,
    name character varying(255) NOT NULL,
    applytime timestamp with time zone NOT NULL,
    datecreated timestamp with time zone NOT NULL,
    dateupdated timestamp with time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE temp.migrations OWNER TO craft3;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: temp; Owner: craft3
--

CREATE SEQUENCE temp.migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE temp.migrations_id_seq OWNER TO craft3;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: craft3
--

ALTER SEQUENCE temp.migrations_id_seq OWNED BY temp.migrations.id;


--
-- Name: plugins; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.plugins (
    id bigint NOT NULL,
    handle character varying(255) NOT NULL,
    version character varying(255) NOT NULL,
    schemaversion character varying(255) NOT NULL,
    licensekey character(24),
    licensekeystatus temp.plugins_licensekeystatus DEFAULT 'unknown'::temp.plugins_licensekeystatus NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    settings text,
    installdate timestamp with time zone NOT NULL,
    datecreated timestamp with time zone NOT NULL,
    dateupdated timestamp with time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE temp.plugins OWNER TO craft3;

--
-- Name: plugins_id_seq; Type: SEQUENCE; Schema: temp; Owner: craft3
--

CREATE SEQUENCE temp.plugins_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE temp.plugins_id_seq OWNER TO craft3;

--
-- Name: plugins_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: craft3
--

ALTER SEQUENCE temp.plugins_id_seq OWNED BY temp.plugins.id;


--
-- Name: queue; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.queue (
    id bigint NOT NULL,
    job bytea NOT NULL,
    description text,
    timepushed bigint NOT NULL,
    ttr bigint NOT NULL,
    delay bigint DEFAULT 0::bigint NOT NULL,
    priority bigint DEFAULT 1024::bigint NOT NULL,
    datereserved timestamp with time zone,
    timeupdated bigint,
    progress smallint DEFAULT 0::smallint NOT NULL,
    attempt bigint,
    fail boolean DEFAULT false,
    datefailed timestamp with time zone,
    error text
);


ALTER TABLE temp.queue OWNER TO craft3;

--
-- Name: queue_id_seq; Type: SEQUENCE; Schema: temp; Owner: craft3
--

CREATE SEQUENCE temp.queue_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE temp.queue_id_seq OWNER TO craft3;

--
-- Name: queue_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: craft3
--

ALTER SEQUENCE temp.queue_id_seq OWNED BY temp.queue.id;


--
-- Name: relations; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.relations (
    id bigint NOT NULL,
    fieldid bigint NOT NULL,
    sourceid bigint NOT NULL,
    sourcesiteid bigint,
    targetid bigint NOT NULL,
    sortorder integer,
    datecreated timestamp with time zone NOT NULL,
    dateupdated timestamp with time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE temp.relations OWNER TO craft3;

--
-- Name: relations_id_seq; Type: SEQUENCE; Schema: temp; Owner: craft3
--

CREATE SEQUENCE temp.relations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE temp.relations_id_seq OWNER TO craft3;

--
-- Name: relations_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: craft3
--

ALTER SEQUENCE temp.relations_id_seq OWNED BY temp.relations.id;


--
-- Name: resourcepaths; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.resourcepaths (
    hash character varying(255) NOT NULL,
    path character varying(255) NOT NULL
);


ALTER TABLE temp.resourcepaths OWNER TO craft3;

--
-- Name: routes; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.routes (
    id bigint NOT NULL,
    siteid bigint,
    uriparts character varying(255) NOT NULL,
    uripattern character varying(255) NOT NULL,
    template character varying(500) NOT NULL,
    sortorder integer,
    datecreated timestamp with time zone NOT NULL,
    dateupdated timestamp with time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE temp.routes OWNER TO craft3;

--
-- Name: routes_id_seq; Type: SEQUENCE; Schema: temp; Owner: craft3
--

CREATE SEQUENCE temp.routes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE temp.routes_id_seq OWNER TO craft3;

--
-- Name: routes_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: craft3
--

ALTER SEQUENCE temp.routes_id_seq OWNED BY temp.routes.id;


--
-- Name: searchindex; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.searchindex (
    elementid bigint NOT NULL,
    attribute character varying(25) NOT NULL,
    fieldid bigint NOT NULL,
    siteid bigint NOT NULL,
    keywords text NOT NULL
);


ALTER TABLE temp.searchindex OWNER TO craft3;

--
-- Name: sections; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.sections (
    id bigint NOT NULL,
    structureid bigint,
    name character varying(255) NOT NULL,
    handle character varying(255) NOT NULL,
    type temp.sections_type DEFAULT 'channel'::temp.sections_type NOT NULL,
    enableversioning boolean DEFAULT false NOT NULL,
    propagateentries boolean DEFAULT true NOT NULL,
    datecreated timestamp with time zone NOT NULL,
    dateupdated timestamp with time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE temp.sections OWNER TO craft3;

--
-- Name: sections_id_seq; Type: SEQUENCE; Schema: temp; Owner: craft3
--

CREATE SEQUENCE temp.sections_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE temp.sections_id_seq OWNER TO craft3;

--
-- Name: sections_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: craft3
--

ALTER SEQUENCE temp.sections_id_seq OWNED BY temp.sections.id;


--
-- Name: sections_sites; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.sections_sites (
    id bigint NOT NULL,
    sectionid bigint NOT NULL,
    siteid bigint NOT NULL,
    hasurls boolean DEFAULT true NOT NULL,
    uriformat text,
    template character varying(500),
    enabledbydefault boolean DEFAULT true NOT NULL,
    datecreated timestamp with time zone NOT NULL,
    dateupdated timestamp with time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE temp.sections_sites OWNER TO craft3;

--
-- Name: sections_sites_id_seq; Type: SEQUENCE; Schema: temp; Owner: craft3
--

CREATE SEQUENCE temp.sections_sites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE temp.sections_sites_id_seq OWNER TO craft3;

--
-- Name: sections_sites_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: craft3
--

ALTER SEQUENCE temp.sections_sites_id_seq OWNED BY temp.sections_sites.id;


--
-- Name: sequences; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.sequences (
    name character varying(255) NOT NULL,
    next bigint DEFAULT 1::bigint NOT NULL
);


ALTER TABLE temp.sequences OWNER TO craft3;

--
-- Name: sessions; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.sessions (
    id bigint NOT NULL,
    userid bigint NOT NULL,
    token character(100) NOT NULL,
    datecreated timestamp with time zone NOT NULL,
    dateupdated timestamp with time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE temp.sessions OWNER TO craft3;

--
-- Name: sessions_id_seq; Type: SEQUENCE; Schema: temp; Owner: craft3
--

CREATE SEQUENCE temp.sessions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE temp.sessions_id_seq OWNER TO craft3;

--
-- Name: sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: craft3
--

ALTER SEQUENCE temp.sessions_id_seq OWNED BY temp.sessions.id;


--
-- Name: shunnedmessages; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.shunnedmessages (
    id bigint NOT NULL,
    userid bigint NOT NULL,
    message character varying(255) NOT NULL,
    expirydate timestamp with time zone,
    datecreated timestamp with time zone NOT NULL,
    dateupdated timestamp with time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE temp.shunnedmessages OWNER TO craft3;

--
-- Name: shunnedmessages_id_seq; Type: SEQUENCE; Schema: temp; Owner: craft3
--

CREATE SEQUENCE temp.shunnedmessages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE temp.shunnedmessages_id_seq OWNER TO craft3;

--
-- Name: shunnedmessages_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: craft3
--

ALTER SEQUENCE temp.shunnedmessages_id_seq OWNED BY temp.shunnedmessages.id;


--
-- Name: sitegroups; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.sitegroups (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    datecreated timestamp with time zone NOT NULL,
    dateupdated timestamp with time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE temp.sitegroups OWNER TO craft3;

--
-- Name: sitegroups_id_seq; Type: SEQUENCE; Schema: temp; Owner: craft3
--

CREATE SEQUENCE temp.sitegroups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE temp.sitegroups_id_seq OWNER TO craft3;

--
-- Name: sitegroups_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: craft3
--

ALTER SEQUENCE temp.sitegroups_id_seq OWNED BY temp.sitegroups.id;


--
-- Name: sites; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.sites (
    id bigint NOT NULL,
    groupid bigint NOT NULL,
    "primary" boolean NOT NULL,
    name character varying(255) NOT NULL,
    handle character varying(255) NOT NULL,
    language character varying(12) NOT NULL,
    hasurls boolean DEFAULT false NOT NULL,
    baseurl character varying(255),
    sortorder integer,
    datecreated timestamp with time zone NOT NULL,
    dateupdated timestamp with time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE temp.sites OWNER TO craft3;

--
-- Name: sites_id_seq; Type: SEQUENCE; Schema: temp; Owner: craft3
--

CREATE SEQUENCE temp.sites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE temp.sites_id_seq OWNER TO craft3;

--
-- Name: sites_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: craft3
--

ALTER SEQUENCE temp.sites_id_seq OWNED BY temp.sites.id;


--
-- Name: structureelements; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.structureelements (
    id bigint NOT NULL,
    structureid bigint NOT NULL,
    elementid bigint,
    root bigint,
    lft bigint NOT NULL,
    rgt bigint NOT NULL,
    level integer NOT NULL,
    datecreated timestamp with time zone NOT NULL,
    dateupdated timestamp with time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE temp.structureelements OWNER TO craft3;

--
-- Name: structureelements_id_seq; Type: SEQUENCE; Schema: temp; Owner: craft3
--

CREATE SEQUENCE temp.structureelements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE temp.structureelements_id_seq OWNER TO craft3;

--
-- Name: structureelements_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: craft3
--

ALTER SEQUENCE temp.structureelements_id_seq OWNED BY temp.structureelements.id;


--
-- Name: structures; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.structures (
    id bigint NOT NULL,
    maxlevels integer,
    datecreated timestamp with time zone NOT NULL,
    dateupdated timestamp with time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE temp.structures OWNER TO craft3;

--
-- Name: structures_id_seq; Type: SEQUENCE; Schema: temp; Owner: craft3
--

CREATE SEQUENCE temp.structures_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE temp.structures_id_seq OWNER TO craft3;

--
-- Name: structures_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: craft3
--

ALTER SEQUENCE temp.structures_id_seq OWNED BY temp.structures.id;


--
-- Name: systemmessages; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.systemmessages (
    id bigint NOT NULL,
    language character varying(255) NOT NULL,
    key character varying(255) NOT NULL,
    subject text NOT NULL,
    body text NOT NULL,
    datecreated timestamp with time zone NOT NULL,
    dateupdated timestamp with time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE temp.systemmessages OWNER TO craft3;

--
-- Name: systemmessages_id_seq; Type: SEQUENCE; Schema: temp; Owner: craft3
--

CREATE SEQUENCE temp.systemmessages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE temp.systemmessages_id_seq OWNER TO craft3;

--
-- Name: systemmessages_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: craft3
--

ALTER SEQUENCE temp.systemmessages_id_seq OWNED BY temp.systemmessages.id;


--
-- Name: systemsettings; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.systemsettings (
    id bigint NOT NULL,
    category character varying(15) NOT NULL,
    settings text,
    datecreated timestamp with time zone NOT NULL,
    dateupdated timestamp with time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE temp.systemsettings OWNER TO craft3;

--
-- Name: systemsettings_id_seq; Type: SEQUENCE; Schema: temp; Owner: craft3
--

CREATE SEQUENCE temp.systemsettings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE temp.systemsettings_id_seq OWNER TO craft3;

--
-- Name: systemsettings_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: craft3
--

ALTER SEQUENCE temp.systemsettings_id_seq OWNED BY temp.systemsettings.id;


--
-- Name: taggroups; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.taggroups (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    handle character varying(255) NOT NULL,
    fieldlayoutid bigint,
    datecreated timestamp with time zone NOT NULL,
    dateupdated timestamp with time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE temp.taggroups OWNER TO craft3;

--
-- Name: taggroups_id_seq; Type: SEQUENCE; Schema: temp; Owner: craft3
--

CREATE SEQUENCE temp.taggroups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE temp.taggroups_id_seq OWNER TO craft3;

--
-- Name: taggroups_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: craft3
--

ALTER SEQUENCE temp.taggroups_id_seq OWNED BY temp.taggroups.id;


--
-- Name: tags; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.tags (
    id bigint NOT NULL,
    groupid bigint NOT NULL,
    datecreated timestamp with time zone NOT NULL,
    dateupdated timestamp with time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE temp.tags OWNER TO craft3;

--
-- Name: templatecacheelements; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.templatecacheelements (
    cacheid bigint NOT NULL,
    elementid bigint NOT NULL
);


ALTER TABLE temp.templatecacheelements OWNER TO craft3;

--
-- Name: templatecachequeries; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.templatecachequeries (
    id bigint NOT NULL,
    cacheid bigint NOT NULL,
    type character varying(255) NOT NULL,
    query text NOT NULL
);


ALTER TABLE temp.templatecachequeries OWNER TO craft3;

--
-- Name: templatecachequeries_id_seq; Type: SEQUENCE; Schema: temp; Owner: craft3
--

CREATE SEQUENCE temp.templatecachequeries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE temp.templatecachequeries_id_seq OWNER TO craft3;

--
-- Name: templatecachequeries_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: craft3
--

ALTER SEQUENCE temp.templatecachequeries_id_seq OWNED BY temp.templatecachequeries.id;


--
-- Name: templatecaches; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.templatecaches (
    id bigint NOT NULL,
    siteid bigint NOT NULL,
    cachekey character varying(255) NOT NULL,
    path character varying(255),
    expirydate timestamp with time zone NOT NULL,
    body text NOT NULL
);


ALTER TABLE temp.templatecaches OWNER TO craft3;

--
-- Name: templatecaches_id_seq; Type: SEQUENCE; Schema: temp; Owner: craft3
--

CREATE SEQUENCE temp.templatecaches_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE temp.templatecaches_id_seq OWNER TO craft3;

--
-- Name: templatecaches_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: craft3
--

ALTER SEQUENCE temp.templatecaches_id_seq OWNED BY temp.templatecaches.id;


--
-- Name: tokens; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.tokens (
    id bigint NOT NULL,
    token character(32) NOT NULL,
    route text,
    usagelimit smallint,
    usagecount smallint,
    expirydate timestamp with time zone NOT NULL,
    datecreated timestamp with time zone NOT NULL,
    dateupdated timestamp with time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE temp.tokens OWNER TO craft3;

--
-- Name: tokens_id_seq; Type: SEQUENCE; Schema: temp; Owner: craft3
--

CREATE SEQUENCE temp.tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE temp.tokens_id_seq OWNER TO craft3;

--
-- Name: tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: craft3
--

ALTER SEQUENCE temp.tokens_id_seq OWNED BY temp.tokens.id;


--
-- Name: usergroups; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.usergroups (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    handle character varying(255) NOT NULL,
    datecreated timestamp with time zone NOT NULL,
    dateupdated timestamp with time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE temp.usergroups OWNER TO craft3;

--
-- Name: usergroups_id_seq; Type: SEQUENCE; Schema: temp; Owner: craft3
--

CREATE SEQUENCE temp.usergroups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE temp.usergroups_id_seq OWNER TO craft3;

--
-- Name: usergroups_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: craft3
--

ALTER SEQUENCE temp.usergroups_id_seq OWNED BY temp.usergroups.id;


--
-- Name: usergroups_users; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.usergroups_users (
    id bigint NOT NULL,
    groupid bigint NOT NULL,
    userid bigint NOT NULL,
    datecreated timestamp with time zone NOT NULL,
    dateupdated timestamp with time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE temp.usergroups_users OWNER TO craft3;

--
-- Name: usergroups_users_id_seq; Type: SEQUENCE; Schema: temp; Owner: craft3
--

CREATE SEQUENCE temp.usergroups_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE temp.usergroups_users_id_seq OWNER TO craft3;

--
-- Name: usergroups_users_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: craft3
--

ALTER SEQUENCE temp.usergroups_users_id_seq OWNED BY temp.usergroups_users.id;


--
-- Name: userpermissions; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.userpermissions (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    datecreated timestamp with time zone NOT NULL,
    dateupdated timestamp with time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE temp.userpermissions OWNER TO craft3;

--
-- Name: userpermissions_id_seq; Type: SEQUENCE; Schema: temp; Owner: craft3
--

CREATE SEQUENCE temp.userpermissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE temp.userpermissions_id_seq OWNER TO craft3;

--
-- Name: userpermissions_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: craft3
--

ALTER SEQUENCE temp.userpermissions_id_seq OWNED BY temp.userpermissions.id;


--
-- Name: userpermissions_usergroups; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.userpermissions_usergroups (
    id bigint NOT NULL,
    permissionid bigint NOT NULL,
    groupid bigint NOT NULL,
    datecreated timestamp with time zone NOT NULL,
    dateupdated timestamp with time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE temp.userpermissions_usergroups OWNER TO craft3;

--
-- Name: userpermissions_usergroups_id_seq; Type: SEQUENCE; Schema: temp; Owner: craft3
--

CREATE SEQUENCE temp.userpermissions_usergroups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE temp.userpermissions_usergroups_id_seq OWNER TO craft3;

--
-- Name: userpermissions_usergroups_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: craft3
--

ALTER SEQUENCE temp.userpermissions_usergroups_id_seq OWNED BY temp.userpermissions_usergroups.id;


--
-- Name: userpermissions_users; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.userpermissions_users (
    id bigint NOT NULL,
    permissionid bigint NOT NULL,
    userid bigint NOT NULL,
    datecreated timestamp with time zone NOT NULL,
    dateupdated timestamp with time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE temp.userpermissions_users OWNER TO craft3;

--
-- Name: userpermissions_users_id_seq; Type: SEQUENCE; Schema: temp; Owner: craft3
--

CREATE SEQUENCE temp.userpermissions_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE temp.userpermissions_users_id_seq OWNER TO craft3;

--
-- Name: userpermissions_users_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: craft3
--

ALTER SEQUENCE temp.userpermissions_users_id_seq OWNED BY temp.userpermissions_users.id;


--
-- Name: userpreferences; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.userpreferences (
    userid bigint NOT NULL,
    preferences text
);


ALTER TABLE temp.userpreferences OWNER TO craft3;

--
-- Name: userpreferences_userid_seq; Type: SEQUENCE; Schema: temp; Owner: craft3
--

CREATE SEQUENCE temp.userpreferences_userid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE temp.userpreferences_userid_seq OWNER TO craft3;

--
-- Name: userpreferences_userid_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: craft3
--

ALTER SEQUENCE temp.userpreferences_userid_seq OWNED BY temp.userpreferences.userid;


--
-- Name: users; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.users (
    id bigint NOT NULL,
    username character varying(100) NOT NULL,
    photoid bigint,
    firstname character varying(100),
    lastname character varying(100),
    email character varying(255) NOT NULL,
    password character varying(255),
    admin boolean DEFAULT false NOT NULL,
    locked boolean DEFAULT false NOT NULL,
    suspended boolean DEFAULT false NOT NULL,
    pending boolean DEFAULT false NOT NULL,
    lastlogindate timestamp with time zone,
    lastloginattemptip character varying(45),
    invalidloginwindowstart timestamp with time zone,
    invalidlogincount smallint,
    lastinvalidlogindate timestamp with time zone,
    lockoutdate timestamp with time zone,
    hasdashboard boolean DEFAULT false NOT NULL,
    verificationcode character varying(255),
    verificationcodeissueddate timestamp with time zone,
    unverifiedemail character varying(255),
    passwordresetrequired boolean DEFAULT false NOT NULL,
    lastpasswordchangedate timestamp with time zone,
    datecreated timestamp with time zone NOT NULL,
    dateupdated timestamp with time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE temp.users OWNER TO craft3;

--
-- Name: volumefolders; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.volumefolders (
    id bigint NOT NULL,
    parentid bigint,
    volumeid bigint,
    name character varying(255) NOT NULL,
    path character varying(255),
    datecreated timestamp with time zone NOT NULL,
    dateupdated timestamp with time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE temp.volumefolders OWNER TO craft3;

--
-- Name: volumefolders_id_seq; Type: SEQUENCE; Schema: temp; Owner: craft3
--

CREATE SEQUENCE temp.volumefolders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE temp.volumefolders_id_seq OWNER TO craft3;

--
-- Name: volumefolders_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: craft3
--

ALTER SEQUENCE temp.volumefolders_id_seq OWNED BY temp.volumefolders.id;


--
-- Name: volumes; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.volumes (
    id bigint NOT NULL,
    fieldlayoutid bigint,
    name character varying(255) NOT NULL,
    handle character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    hasurls boolean DEFAULT true NOT NULL,
    url character varying(255),
    settings text,
    sortorder integer,
    datecreated timestamp with time zone NOT NULL,
    dateupdated timestamp with time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE temp.volumes OWNER TO craft3;

--
-- Name: volumes_id_seq; Type: SEQUENCE; Schema: temp; Owner: craft3
--

CREATE SEQUENCE temp.volumes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE temp.volumes_id_seq OWNER TO craft3;

--
-- Name: volumes_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: craft3
--

ALTER SEQUENCE temp.volumes_id_seq OWNED BY temp.volumes.id;


--
-- Name: widgets; Type: TABLE; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE TABLE temp.widgets (
    id bigint NOT NULL,
    userid bigint NOT NULL,
    type character varying(255) NOT NULL,
    sortorder integer,
    colspan boolean DEFAULT false NOT NULL,
    settings text,
    enabled boolean DEFAULT true NOT NULL,
    datecreated timestamp with time zone NOT NULL,
    dateupdated timestamp with time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE temp.widgets OWNER TO craft3;

--
-- Name: widgets_id_seq; Type: SEQUENCE; Schema: temp; Owner: craft3
--

CREATE SEQUENCE temp.widgets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE temp.widgets_id_seq OWNER TO craft3;

--
-- Name: widgets_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: craft3
--

ALTER SEQUENCE temp.widgets_id_seq OWNED BY temp.widgets.id;


--
-- Name: id; Type: DEFAULT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.assetindexdata ALTER COLUMN id SET DEFAULT nextval('temp.assetindexdata_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.assettransformindex ALTER COLUMN id SET DEFAULT nextval('temp.assettransformindex_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.assettransforms ALTER COLUMN id SET DEFAULT nextval('temp.assettransforms_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.categorygroups ALTER COLUMN id SET DEFAULT nextval('temp.categorygroups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.categorygroups_sites ALTER COLUMN id SET DEFAULT nextval('temp.categorygroups_sites_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.content ALTER COLUMN id SET DEFAULT nextval('temp.content_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.craftidtokens ALTER COLUMN id SET DEFAULT nextval('temp.craftidtokens_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.deprecationerrors ALTER COLUMN id SET DEFAULT nextval('temp.deprecationerrors_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.elementindexsettings ALTER COLUMN id SET DEFAULT nextval('temp.elementindexsettings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.elements ALTER COLUMN id SET DEFAULT nextval('temp.elements_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.elements_sites ALTER COLUMN id SET DEFAULT nextval('temp.elements_sites_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.entrydrafts ALTER COLUMN id SET DEFAULT nextval('temp.entrydrafts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.entrytypes ALTER COLUMN id SET DEFAULT nextval('temp.entrytypes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.entryversions ALTER COLUMN id SET DEFAULT nextval('temp.entryversions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.fieldgroups ALTER COLUMN id SET DEFAULT nextval('temp.fieldgroups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.fieldlayoutfields ALTER COLUMN id SET DEFAULT nextval('temp.fieldlayoutfields_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.fieldlayouts ALTER COLUMN id SET DEFAULT nextval('temp.fieldlayouts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.fieldlayouttabs ALTER COLUMN id SET DEFAULT nextval('temp.fieldlayouttabs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.fields ALTER COLUMN id SET DEFAULT nextval('temp.fields_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.globalsets ALTER COLUMN id SET DEFAULT nextval('temp.globalsets_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.info ALTER COLUMN id SET DEFAULT nextval('temp.info_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.matrixblocktypes ALTER COLUMN id SET DEFAULT nextval('temp.matrixblocktypes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.migrations ALTER COLUMN id SET DEFAULT nextval('temp.migrations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.plugins ALTER COLUMN id SET DEFAULT nextval('temp.plugins_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.queue ALTER COLUMN id SET DEFAULT nextval('temp.queue_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.relations ALTER COLUMN id SET DEFAULT nextval('temp.relations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.routes ALTER COLUMN id SET DEFAULT nextval('temp.routes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.sections ALTER COLUMN id SET DEFAULT nextval('temp.sections_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.sections_sites ALTER COLUMN id SET DEFAULT nextval('temp.sections_sites_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.sessions ALTER COLUMN id SET DEFAULT nextval('temp.sessions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.shunnedmessages ALTER COLUMN id SET DEFAULT nextval('temp.shunnedmessages_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.sitegroups ALTER COLUMN id SET DEFAULT nextval('temp.sitegroups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.sites ALTER COLUMN id SET DEFAULT nextval('temp.sites_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.structureelements ALTER COLUMN id SET DEFAULT nextval('temp.structureelements_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.structures ALTER COLUMN id SET DEFAULT nextval('temp.structures_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.systemmessages ALTER COLUMN id SET DEFAULT nextval('temp.systemmessages_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.systemsettings ALTER COLUMN id SET DEFAULT nextval('temp.systemsettings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.taggroups ALTER COLUMN id SET DEFAULT nextval('temp.taggroups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.templatecachequeries ALTER COLUMN id SET DEFAULT nextval('temp.templatecachequeries_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.templatecaches ALTER COLUMN id SET DEFAULT nextval('temp.templatecaches_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.tokens ALTER COLUMN id SET DEFAULT nextval('temp.tokens_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.usergroups ALTER COLUMN id SET DEFAULT nextval('temp.usergroups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.usergroups_users ALTER COLUMN id SET DEFAULT nextval('temp.usergroups_users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.userpermissions ALTER COLUMN id SET DEFAULT nextval('temp.userpermissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.userpermissions_usergroups ALTER COLUMN id SET DEFAULT nextval('temp.userpermissions_usergroups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.userpermissions_users ALTER COLUMN id SET DEFAULT nextval('temp.userpermissions_users_id_seq'::regclass);


--
-- Name: userid; Type: DEFAULT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.userpreferences ALTER COLUMN userid SET DEFAULT nextval('temp.userpreferences_userid_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.volumefolders ALTER COLUMN id SET DEFAULT nextval('temp.volumefolders_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.volumes ALTER COLUMN id SET DEFAULT nextval('temp.volumes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.widgets ALTER COLUMN id SET DEFAULT nextval('temp.widgets_id_seq'::regclass);


--
-- Data for Name: assetindexdata; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.assetindexdata (id, sessionid, volumeid, uri, size, "timestamp", recordid, inprogress, completed, datecreated, dateupdated, uid) FROM stdin;
\.


--
-- Name: assetindexdata_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: craft3
--

SELECT pg_catalog.setval('temp.assetindexdata_id_seq', 1, true);


--
-- Data for Name: assets; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.assets (id, volumeid, folderid, filename, kind, width, height, size, focalpoint, datemodified, datecreated, dateupdated, uid) FROM stdin;
3	1	1	MM-Mark.svg	image	127	140	38120	\N	2019-01-09 04:13:21-06	2019-01-09 04:07:21-06	2019-01-09 04:07:21-06	8fafeca2-c256-477a-af20-4f5ced5d0598
7	1	1	about.png	image	838	472	463552	\N	2019-01-10 05:09:31-06	2019-01-10 05:09:31-06	2019-01-10 05:09:31-06	fa8d78e8-d276-4439-9860-b93d4eb4fc79
8	1	1	about-icon.svg	image	66	83	380	\N	2019-01-10 05:10:51-06	2019-01-10 05:10:51-06	2019-01-10 05:10:51-06	3f468f12-2fca-4a97-b1eb-6ea825e36c23
9	1	1	home1.jpg	image	2400	1350	640561	\N	2019-01-10 05:13:18-06	2019-01-10 05:13:18-06	2019-01-10 05:13:18-06	2b11efb0-4e5a-401a-b812-cd487fe1f40a
\.


--
-- Data for Name: assettransformindex; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.assettransformindex (id, assetid, filename, format, location, volumeid, fileexists, inprogress, dateindexed, datecreated, dateupdated, uid) FROM stdin;
\.


--
-- Name: assettransformindex_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: craft3
--

SELECT pg_catalog.setval('temp.assettransformindex_id_seq', 1, true);


--
-- Data for Name: assettransforms; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.assettransforms (id, name, handle, mode, "position", width, height, format, quality, interlace, dimensionchangetime, datecreated, dateupdated, uid) FROM stdin;
\.


--
-- Name: assettransforms_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: craft3
--

SELECT pg_catalog.setval('temp.assettransforms_id_seq', 1, true);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.categories (id, groupid, datecreated, dateupdated, uid) FROM stdin;
\.


--
-- Data for Name: categorygroups; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.categorygroups (id, structureid, fieldlayoutid, name, handle, datecreated, dateupdated, uid) FROM stdin;
\.


--
-- Name: categorygroups_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: craft3
--

SELECT pg_catalog.setval('temp.categorygroups_id_seq', 1, true);


--
-- Data for Name: categorygroups_sites; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.categorygroups_sites (id, groupid, siteid, hasurls, uriformat, template, datecreated, dateupdated, uid) FROM stdin;
\.


--
-- Name: categorygroups_sites_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: craft3
--

SELECT pg_catalog.setval('temp.categorygroups_sites_id_seq', 1, true);


--
-- Data for Name: content; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.content (id, elementid, siteid, title, datecreated, dateupdated, uid, field_text, field_address, field_opentime) FROM stdin;
1	1	1	\N	2019-01-08 06:43:22-06	2019-01-08 06:43:22-06	a47515a4-f254-46bd-be55-680483480d2b	\N	\N	\N
2	2	1	Landing	2019-01-09 04:04:18-06	2019-01-09 04:10:17-06	77c6d503-67b1-47ad-a3b0-79799328c06d	<p>Mattie</p><p>Michelle</p><p>Color</p>	\N	\N
3	3	1	Mm Mark	2019-01-09 04:07:21-06	2019-01-09 04:07:21-06	282096a9-75d2-41a4-9364-69d05854f614	\N	\N	\N
4	4	1	Home	2019-01-10 04:58:52-06	2019-01-10 05:13:28-06	5d23bd86-2df7-47ac-b4a7-4297e8b19deb	\N	\N	\N
5	5	1	About	2019-01-10 04:59:57-06	2019-01-10 05:11:07-06	7a2fcce2-71c5-48fd-b4af-243c238ac456	<p>OUR GOAL IS SIMPLE. WE LIVE IN COLOR, WE CREATE IN COLOR, AND WE DREAM IN COLOR. WE APPLY COLOR TO CHALLENGE THE STATUS QUO’ TO CREATE A COMMUNITY ROOTED IN UNIQUENESS. WE HOLD OURSELVES TO A HIGHER STANDARD TO ENSURE THAT WE GIVE OUR CLIENT’S THE CONFIDENCE TO BE THEMSELVES AND FEEL GREAT DOING IT. MATTIE MICHELLE IS A LIFESTYLE WITHOUT LIMITS, WE ARE NOT SOLELY CHANGING HAIR, WE ARE BUILDING COMMUNITIES.  </p>	\N	\N
6	6	1	Follow	2019-01-10 05:00:50-06	2019-01-10 05:15:40-06	ace43e3c-2d35-4f06-af96-3be120b93496	\N	1906 North Henderson Ave.\nDallas, TX 75206	[{"col1":"Mon","col2":"Closed"},{"col1":"Tue","col2":"Closed"},{"col1":"Wed","col2":"9:00 AM - 5:00 PM"},{"col1":"Thu","col2":"9:00 AM - 5:00 PM"},{"col1":"Fri","col2":"9:00 AM - 5:00 PM"},{"col1":"Sat","col2":"9:00 AM - 3:00 PM"},{"col1":"Sun","col2":"Closed"}]
7	7	1	About	2019-01-10 05:09:31-06	2019-01-10 05:09:31-06	36436e32-336d-4a88-b917-9e7b9941e7b1	\N	\N	\N
8	8	1	About Icon	2019-01-10 05:10:51-06	2019-01-10 05:10:51-06	0054e820-7390-4189-90c3-7e71ae53b740	\N	\N	\N
9	9	1	Home1	2019-01-10 05:13:18-06	2019-01-10 05:13:18-06	d67eae76-7e96-4909-974d-4acb2674166c	\N	\N	\N
\.


--
-- Name: content_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: craft3
--

SELECT pg_catalog.setval('temp.content_id_seq', 9, true);


--
-- Data for Name: craftidtokens; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.craftidtokens (id, userid, accesstoken, expirydate, datecreated, dateupdated, uid) FROM stdin;
\.


--
-- Name: craftidtokens_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: craft3
--

SELECT pg_catalog.setval('temp.craftidtokens_id_seq', 1, true);


--
-- Data for Name: deprecationerrors; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.deprecationerrors (id, key, fingerprint, lastoccurrence, file, line, message, traces, datecreated, dateupdated, uid) FROM stdin;
1	ElementQuery::first()	/vagrant/craft/templates/index.html:13	2019-01-10 03:53:10-06	/vagrant/craft/templates/index.html	13	The first() function used to query for elements is now deprecated. Use one() instead.	[{"objectClass":"craft\\\\services\\\\Deprecator","file":"/vagrant/craft/vendor/craftcms/cms/src/elements/db/ElementQuery.php","line":1401,"class":"craft\\\\services\\\\Deprecator","method":"log","args":"\\"ElementQuery::first()\\", \\"The first() function used to query for elements is now deprecate...\\""},{"objectClass":"craft\\\\elements\\\\db\\\\EntryQuery","file":"/vagrant/craft/vendor/twig/twig/lib/Twig/Extension/Core.php","line":1608,"class":"craft\\\\elements\\\\db\\\\ElementQuery","method":"first","args":null},{"objectClass":null,"file":"/vagrant/craft/vendor/craftcms/cms/src/helpers/Template.php","line":73,"class":null,"method":"twig_get_attribute","args":"craft\\\\web\\\\twig\\\\Environment, Twig_Source, craft\\\\elements\\\\db\\\\EntryQuery, \\"first\\", ..."},{"objectClass":null,"file":"/vagrant/craft/storage/runtime/compiled_templates/cd/cd697418ca3327a5fda4e0a2ee38f2639c885dfed08de8620eac58161dde69f4.php","line":43,"class":"craft\\\\helpers\\\\Template","method":"attribute","args":"craft\\\\web\\\\twig\\\\Environment, Twig_Source, craft\\\\elements\\\\db\\\\EntryQuery, \\"first\\", ..."},{"objectClass":"__TwigTemplate_0ccb46ace4633151e1d182d87445066100ec128f36072ecd89aed57278c950c1","file":"/vagrant/craft/vendor/twig/twig/lib/Twig/Template.php","line":390,"class":"__TwigTemplate_0ccb46ace4633151e1d182d87445066100ec128f36072ecd89aed57278c950c1","method":"doDisplay","args":"[\\"view\\" => craft\\\\web\\\\View, \\"SORT_ASC\\" => 4, \\"SORT_DESC\\" => 3, \\"SORT_REGULAR\\" => 0, ...], []"},{"objectClass":"__TwigTemplate_0ccb46ace4633151e1d182d87445066100ec128f36072ecd89aed57278c950c1","file":"/vagrant/craft/vendor/craftcms/cms/src/web/twig/Template.php","line":49,"class":"Twig_Template","method":"displayWithErrorHandling","args":"[\\"view\\" => craft\\\\web\\\\View, \\"SORT_ASC\\" => 4, \\"SORT_DESC\\" => 3, \\"SORT_REGULAR\\" => 0, ...], []"},{"objectClass":"__TwigTemplate_0ccb46ace4633151e1d182d87445066100ec128f36072ecd89aed57278c950c1","file":"/vagrant/craft/vendor/twig/twig/lib/Twig/Template.php","line":367,"class":"craft\\\\web\\\\twig\\\\Template","method":"displayWithErrorHandling","args":"[\\"view\\" => craft\\\\web\\\\View, \\"SORT_ASC\\" => 4, \\"SORT_DESC\\" => 3, \\"SORT_REGULAR\\" => 0, ...], []"},{"objectClass":"__TwigTemplate_0ccb46ace4633151e1d182d87445066100ec128f36072ecd89aed57278c950c1","file":"/vagrant/craft/vendor/craftcms/cms/src/web/twig/Template.php","line":31,"class":"Twig_Template","method":"display","args":"[], []"},{"objectClass":"__TwigTemplate_0ccb46ace4633151e1d182d87445066100ec128f36072ecd89aed57278c950c1","file":"/vagrant/craft/vendor/twig/twig/lib/Twig/Template.php","line":375,"class":"craft\\\\web\\\\twig\\\\Template","method":"display","args":"[]"},{"objectClass":"__TwigTemplate_0ccb46ace4633151e1d182d87445066100ec128f36072ecd89aed57278c950c1","file":"/vagrant/craft/vendor/twig/twig/lib/Twig/Environment.php","line":289,"class":"Twig_Template","method":"render","args":"[]"},{"objectClass":"craft\\\\web\\\\twig\\\\Environment","file":"/vagrant/craft/vendor/craftcms/cms/src/web/View.php","line":331,"class":"Twig_Environment","method":"render","args":"\\"\\", []"},{"objectClass":"craft\\\\web\\\\View","file":"/vagrant/craft/vendor/craftcms/cms/src/web/View.php","line":378,"class":"craft\\\\web\\\\View","method":"renderTemplate","args":"\\"\\", []"},{"objectClass":"craft\\\\web\\\\View","file":"/vagrant/craft/vendor/craftcms/cms/src/web/Controller.php","line":156,"class":"craft\\\\web\\\\View","method":"renderPageTemplate","args":"\\"\\", []"},{"objectClass":"craft\\\\controllers\\\\TemplatesController","file":"/vagrant/craft/vendor/craftcms/cms/src/controllers/TemplatesController.php","line":78,"class":"craft\\\\web\\\\Controller","method":"renderTemplate","args":"\\"\\", []"},{"objectClass":"craft\\\\controllers\\\\TemplatesController","file":null,"line":null,"class":"craft\\\\controllers\\\\TemplatesController","method":"actionRender","args":"\\"\\", []"},{"objectClass":null,"file":"/vagrant/craft/vendor/yiisoft/yii2/base/InlineAction.php","line":57,"class":null,"method":"call_user_func_array","args":"[craft\\\\controllers\\\\TemplatesController, \\"actionRender\\"], [\\"\\", []]"},{"objectClass":"yii\\\\base\\\\InlineAction","file":"/vagrant/craft/vendor/yiisoft/yii2/base/Controller.php","line":157,"class":"yii\\\\base\\\\InlineAction","method":"runWithParams","args":"[\\"template\\" => \\"\\"]"},{"objectClass":"craft\\\\controllers\\\\TemplatesController","file":"/vagrant/craft/vendor/craftcms/cms/src/web/Controller.php","line":104,"class":"yii\\\\base\\\\Controller","method":"runAction","args":"\\"render\\", [\\"template\\" => \\"\\"]"},{"objectClass":"craft\\\\controllers\\\\TemplatesController","file":"/vagrant/craft/vendor/yiisoft/yii2/base/Module.php","line":528,"class":"craft\\\\web\\\\Controller","method":"runAction","args":"\\"render\\", [\\"template\\" => \\"\\"]"},{"objectClass":"craft\\\\web\\\\Application","file":"/vagrant/craft/vendor/craftcms/cms/src/web/Application.php","line":282,"class":"yii\\\\base\\\\Module","method":"runAction","args":"\\"templates/render\\", [\\"template\\" => \\"\\"]"},{"objectClass":"craft\\\\web\\\\Application","file":"/vagrant/craft/vendor/yiisoft/yii2/web/Application.php","line":103,"class":"craft\\\\web\\\\Application","method":"runAction","args":"\\"templates/render\\", [\\"template\\" => \\"\\"]"},{"objectClass":"craft\\\\web\\\\Application","file":"/vagrant/craft/vendor/craftcms/cms/src/web/Application.php","line":271,"class":"yii\\\\web\\\\Application","method":"handleRequest","args":"craft\\\\web\\\\Request"},{"objectClass":"craft\\\\web\\\\Application","file":"/vagrant/craft/vendor/yiisoft/yii2/base/Application.php","line":386,"class":"craft\\\\web\\\\Application","method":"handleRequest","args":"craft\\\\web\\\\Request"},{"objectClass":"craft\\\\web\\\\Application","file":"/vagrant/craft/web/index.php","line":21,"class":"yii\\\\base\\\\Application","method":"run","args":null}]	2019-01-10 03:53:10-06	2019-01-10 03:53:10-06	c045eded-cdef-4bd2-9a75-e717a8d2d42d
18	ElementQuery::first()	/vagrant/craft/templates/index.html:14	2019-01-09 06:30:02-06	/vagrant/craft/templates/index.html	14	The first() function used to query for elements is now deprecated. Use one() instead.	[{"objectClass":"craft\\\\services\\\\Deprecator","file":"/vagrant/craft/vendor/craftcms/cms/src/elements/db/ElementQuery.php","line":1401,"class":"craft\\\\services\\\\Deprecator","method":"log","args":"\\"ElementQuery::first()\\", \\"The first() function used to query for elements is now deprecate...\\""},{"objectClass":"craft\\\\elements\\\\db\\\\AssetQuery","file":"/vagrant/craft/vendor/twig/twig/lib/Twig/Extension/Core.php","line":1608,"class":"craft\\\\elements\\\\db\\\\ElementQuery","method":"first","args":null},{"objectClass":null,"file":"/vagrant/craft/vendor/craftcms/cms/src/helpers/Template.php","line":73,"class":null,"method":"twig_get_attribute","args":"craft\\\\web\\\\twig\\\\Environment, Twig_Source, craft\\\\elements\\\\db\\\\AssetQuery, \\"first\\", ..."},{"objectClass":null,"file":"/vagrant/craft/storage/runtime/compiled_templates/cd/cd697418ca3327a5fda4e0a2ee38f2639c885dfed08de8620eac58161dde69f4.php","line":46,"class":"craft\\\\helpers\\\\Template","method":"attribute","args":"craft\\\\web\\\\twig\\\\Environment, Twig_Source, craft\\\\elements\\\\db\\\\AssetQuery, \\"first\\", ..."},{"objectClass":"__TwigTemplate_0ccb46ace4633151e1d182d87445066100ec128f36072ecd89aed57278c950c1","file":"/vagrant/craft/vendor/twig/twig/lib/Twig/Template.php","line":390,"class":"__TwigTemplate_0ccb46ace4633151e1d182d87445066100ec128f36072ecd89aed57278c950c1","method":"doDisplay","args":"[\\"view\\" => craft\\\\web\\\\View, \\"SORT_ASC\\" => 4, \\"SORT_DESC\\" => 3, \\"SORT_REGULAR\\" => 0, ...], []"},{"objectClass":"__TwigTemplate_0ccb46ace4633151e1d182d87445066100ec128f36072ecd89aed57278c950c1","file":"/vagrant/craft/vendor/craftcms/cms/src/web/twig/Template.php","line":49,"class":"Twig_Template","method":"displayWithErrorHandling","args":"[\\"view\\" => craft\\\\web\\\\View, \\"SORT_ASC\\" => 4, \\"SORT_DESC\\" => 3, \\"SORT_REGULAR\\" => 0, ...], []"},{"objectClass":"__TwigTemplate_0ccb46ace4633151e1d182d87445066100ec128f36072ecd89aed57278c950c1","file":"/vagrant/craft/vendor/twig/twig/lib/Twig/Template.php","line":367,"class":"craft\\\\web\\\\twig\\\\Template","method":"displayWithErrorHandling","args":"[\\"view\\" => craft\\\\web\\\\View, \\"SORT_ASC\\" => 4, \\"SORT_DESC\\" => 3, \\"SORT_REGULAR\\" => 0, ...], []"},{"objectClass":"__TwigTemplate_0ccb46ace4633151e1d182d87445066100ec128f36072ecd89aed57278c950c1","file":"/vagrant/craft/vendor/craftcms/cms/src/web/twig/Template.php","line":31,"class":"Twig_Template","method":"display","args":"[], []"},{"objectClass":"__TwigTemplate_0ccb46ace4633151e1d182d87445066100ec128f36072ecd89aed57278c950c1","file":"/vagrant/craft/vendor/twig/twig/lib/Twig/Template.php","line":375,"class":"craft\\\\web\\\\twig\\\\Template","method":"display","args":"[]"},{"objectClass":"__TwigTemplate_0ccb46ace4633151e1d182d87445066100ec128f36072ecd89aed57278c950c1","file":"/vagrant/craft/vendor/twig/twig/lib/Twig/Environment.php","line":289,"class":"Twig_Template","method":"render","args":"[]"},{"objectClass":"craft\\\\web\\\\twig\\\\Environment","file":"/vagrant/craft/vendor/craftcms/cms/src/web/View.php","line":331,"class":"Twig_Environment","method":"render","args":"\\"\\", []"},{"objectClass":"craft\\\\web\\\\View","file":"/vagrant/craft/vendor/craftcms/cms/src/web/View.php","line":378,"class":"craft\\\\web\\\\View","method":"renderTemplate","args":"\\"\\", []"},{"objectClass":"craft\\\\web\\\\View","file":"/vagrant/craft/vendor/craftcms/cms/src/web/Controller.php","line":156,"class":"craft\\\\web\\\\View","method":"renderPageTemplate","args":"\\"\\", []"},{"objectClass":"craft\\\\controllers\\\\TemplatesController","file":"/vagrant/craft/vendor/craftcms/cms/src/controllers/TemplatesController.php","line":78,"class":"craft\\\\web\\\\Controller","method":"renderTemplate","args":"\\"\\", []"},{"objectClass":"craft\\\\controllers\\\\TemplatesController","file":null,"line":null,"class":"craft\\\\controllers\\\\TemplatesController","method":"actionRender","args":"\\"\\", []"},{"objectClass":null,"file":"/vagrant/craft/vendor/yiisoft/yii2/base/InlineAction.php","line":57,"class":null,"method":"call_user_func_array","args":"[craft\\\\controllers\\\\TemplatesController, \\"actionRender\\"], [\\"\\", []]"},{"objectClass":"yii\\\\base\\\\InlineAction","file":"/vagrant/craft/vendor/yiisoft/yii2/base/Controller.php","line":157,"class":"yii\\\\base\\\\InlineAction","method":"runWithParams","args":"[\\"template\\" => \\"\\"]"},{"objectClass":"craft\\\\controllers\\\\TemplatesController","file":"/vagrant/craft/vendor/craftcms/cms/src/web/Controller.php","line":104,"class":"yii\\\\base\\\\Controller","method":"runAction","args":"\\"render\\", [\\"template\\" => \\"\\"]"},{"objectClass":"craft\\\\controllers\\\\TemplatesController","file":"/vagrant/craft/vendor/yiisoft/yii2/base/Module.php","line":528,"class":"craft\\\\web\\\\Controller","method":"runAction","args":"\\"render\\", [\\"template\\" => \\"\\"]"},{"objectClass":"craft\\\\web\\\\Application","file":"/vagrant/craft/vendor/craftcms/cms/src/web/Application.php","line":282,"class":"yii\\\\base\\\\Module","method":"runAction","args":"\\"templates/render\\", [\\"template\\" => \\"\\"]"},{"objectClass":"craft\\\\web\\\\Application","file":"/vagrant/craft/vendor/yiisoft/yii2/web/Application.php","line":103,"class":"craft\\\\web\\\\Application","method":"runAction","args":"\\"templates/render\\", [\\"template\\" => \\"\\"]"},{"objectClass":"craft\\\\web\\\\Application","file":"/vagrant/craft/vendor/craftcms/cms/src/web/Application.php","line":271,"class":"yii\\\\web\\\\Application","method":"handleRequest","args":"craft\\\\web\\\\Request"},{"objectClass":"craft\\\\web\\\\Application","file":"/vagrant/craft/vendor/yiisoft/yii2/base/Application.php","line":386,"class":"craft\\\\web\\\\Application","method":"handleRequest","args":"craft\\\\web\\\\Request"},{"objectClass":"craft\\\\web\\\\Application","file":"/vagrant/craft/web/index.php","line":21,"class":"yii\\\\base\\\\Application","method":"run","args":null}]	2019-01-09 06:30:02-06	2019-01-09 06:30:02-06	18465d3d-721c-4abb-aacd-27bb0986436d
24	ElementQuery::first()	/vagrant/craft/templates/index.html:15	2019-01-09 06:37:07-06	/vagrant/craft/templates/index.html	15	The first() function used to query for elements is now deprecated. Use one() instead.	[{"objectClass":"craft\\\\services\\\\Deprecator","file":"/vagrant/craft/vendor/craftcms/cms/src/elements/db/ElementQuery.php","line":1401,"class":"craft\\\\services\\\\Deprecator","method":"log","args":"\\"ElementQuery::first()\\", \\"The first() function used to query for elements is now deprecate...\\""},{"objectClass":"craft\\\\elements\\\\db\\\\AssetQuery","file":"/vagrant/craft/vendor/twig/twig/lib/Twig/Extension/Core.php","line":1608,"class":"craft\\\\elements\\\\db\\\\ElementQuery","method":"first","args":null},{"objectClass":null,"file":"/vagrant/craft/vendor/craftcms/cms/src/helpers/Template.php","line":73,"class":null,"method":"twig_get_attribute","args":"craft\\\\web\\\\twig\\\\Environment, Twig_Source, craft\\\\elements\\\\db\\\\AssetQuery, \\"first\\", ..."},{"objectClass":null,"file":"/vagrant/craft/storage/runtime/compiled_templates/cd/cd697418ca3327a5fda4e0a2ee38f2639c885dfed08de8620eac58161dde69f4.php","line":48,"class":"craft\\\\helpers\\\\Template","method":"attribute","args":"craft\\\\web\\\\twig\\\\Environment, Twig_Source, craft\\\\elements\\\\db\\\\AssetQuery, \\"first\\", ..."},{"objectClass":"__TwigTemplate_0ccb46ace4633151e1d182d87445066100ec128f36072ecd89aed57278c950c1","file":"/vagrant/craft/vendor/twig/twig/lib/Twig/Template.php","line":390,"class":"__TwigTemplate_0ccb46ace4633151e1d182d87445066100ec128f36072ecd89aed57278c950c1","method":"doDisplay","args":"[\\"view\\" => craft\\\\web\\\\View, \\"SORT_ASC\\" => 4, \\"SORT_DESC\\" => 3, \\"SORT_REGULAR\\" => 0, ...], []"},{"objectClass":"__TwigTemplate_0ccb46ace4633151e1d182d87445066100ec128f36072ecd89aed57278c950c1","file":"/vagrant/craft/vendor/craftcms/cms/src/web/twig/Template.php","line":49,"class":"Twig_Template","method":"displayWithErrorHandling","args":"[\\"view\\" => craft\\\\web\\\\View, \\"SORT_ASC\\" => 4, \\"SORT_DESC\\" => 3, \\"SORT_REGULAR\\" => 0, ...], []"},{"objectClass":"__TwigTemplate_0ccb46ace4633151e1d182d87445066100ec128f36072ecd89aed57278c950c1","file":"/vagrant/craft/vendor/twig/twig/lib/Twig/Template.php","line":367,"class":"craft\\\\web\\\\twig\\\\Template","method":"displayWithErrorHandling","args":"[\\"view\\" => craft\\\\web\\\\View, \\"SORT_ASC\\" => 4, \\"SORT_DESC\\" => 3, \\"SORT_REGULAR\\" => 0, ...], []"},{"objectClass":"__TwigTemplate_0ccb46ace4633151e1d182d87445066100ec128f36072ecd89aed57278c950c1","file":"/vagrant/craft/vendor/craftcms/cms/src/web/twig/Template.php","line":31,"class":"Twig_Template","method":"display","args":"[], []"},{"objectClass":"__TwigTemplate_0ccb46ace4633151e1d182d87445066100ec128f36072ecd89aed57278c950c1","file":"/vagrant/craft/vendor/twig/twig/lib/Twig/Template.php","line":375,"class":"craft\\\\web\\\\twig\\\\Template","method":"display","args":"[]"},{"objectClass":"__TwigTemplate_0ccb46ace4633151e1d182d87445066100ec128f36072ecd89aed57278c950c1","file":"/vagrant/craft/vendor/twig/twig/lib/Twig/Environment.php","line":289,"class":"Twig_Template","method":"render","args":"[]"},{"objectClass":"craft\\\\web\\\\twig\\\\Environment","file":"/vagrant/craft/vendor/craftcms/cms/src/web/View.php","line":331,"class":"Twig_Environment","method":"render","args":"\\"\\", []"},{"objectClass":"craft\\\\web\\\\View","file":"/vagrant/craft/vendor/craftcms/cms/src/web/View.php","line":378,"class":"craft\\\\web\\\\View","method":"renderTemplate","args":"\\"\\", []"},{"objectClass":"craft\\\\web\\\\View","file":"/vagrant/craft/vendor/craftcms/cms/src/web/Controller.php","line":156,"class":"craft\\\\web\\\\View","method":"renderPageTemplate","args":"\\"\\", []"},{"objectClass":"craft\\\\controllers\\\\TemplatesController","file":"/vagrant/craft/vendor/craftcms/cms/src/controllers/TemplatesController.php","line":78,"class":"craft\\\\web\\\\Controller","method":"renderTemplate","args":"\\"\\", []"},{"objectClass":"craft\\\\controllers\\\\TemplatesController","file":null,"line":null,"class":"craft\\\\controllers\\\\TemplatesController","method":"actionRender","args":"\\"\\", []"},{"objectClass":null,"file":"/vagrant/craft/vendor/yiisoft/yii2/base/InlineAction.php","line":57,"class":null,"method":"call_user_func_array","args":"[craft\\\\controllers\\\\TemplatesController, \\"actionRender\\"], [\\"\\", []]"},{"objectClass":"yii\\\\base\\\\InlineAction","file":"/vagrant/craft/vendor/yiisoft/yii2/base/Controller.php","line":157,"class":"yii\\\\base\\\\InlineAction","method":"runWithParams","args":"[\\"template\\" => \\"\\"]"},{"objectClass":"craft\\\\controllers\\\\TemplatesController","file":"/vagrant/craft/vendor/craftcms/cms/src/web/Controller.php","line":104,"class":"yii\\\\base\\\\Controller","method":"runAction","args":"\\"render\\", [\\"template\\" => \\"\\"]"},{"objectClass":"craft\\\\controllers\\\\TemplatesController","file":"/vagrant/craft/vendor/yiisoft/yii2/base/Module.php","line":528,"class":"craft\\\\web\\\\Controller","method":"runAction","args":"\\"render\\", [\\"template\\" => \\"\\"]"},{"objectClass":"craft\\\\web\\\\Application","file":"/vagrant/craft/vendor/craftcms/cms/src/web/Application.php","line":282,"class":"yii\\\\base\\\\Module","method":"runAction","args":"\\"templates/render\\", [\\"template\\" => \\"\\"]"},{"objectClass":"craft\\\\web\\\\Application","file":"/vagrant/craft/vendor/yiisoft/yii2/web/Application.php","line":103,"class":"craft\\\\web\\\\Application","method":"runAction","args":"\\"templates/render\\", [\\"template\\" => \\"\\"]"},{"objectClass":"craft\\\\web\\\\Application","file":"/vagrant/craft/vendor/craftcms/cms/src/web/Application.php","line":271,"class":"yii\\\\web\\\\Application","method":"handleRequest","args":"craft\\\\web\\\\Request"},{"objectClass":"craft\\\\web\\\\Application","file":"/vagrant/craft/vendor/yiisoft/yii2/base/Application.php","line":386,"class":"craft\\\\web\\\\Application","method":"handleRequest","args":"craft\\\\web\\\\Request"},{"objectClass":"craft\\\\web\\\\Application","file":"/vagrant/craft/web/index.php","line":21,"class":"yii\\\\base\\\\Application","method":"run","args":null}]	2019-01-09 06:37:07-06	2019-01-09 06:37:07-06	f3ab3e75-7385-445d-8088-eff082f6e1f5
\.


--
-- Name: deprecationerrors_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: craft3
--

SELECT pg_catalog.setval('temp.deprecationerrors_id_seq', 24, true);


--
-- Data for Name: elementindexsettings; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.elementindexsettings (id, type, settings, datecreated, dateupdated, uid) FROM stdin;
\.


--
-- Name: elementindexsettings_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: craft3
--

SELECT pg_catalog.setval('temp.elementindexsettings_id_seq', 1, true);


--
-- Data for Name: elements; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.elements (id, fieldlayoutid, type, enabled, archived, datecreated, dateupdated, uid) FROM stdin;
1	\N	craft\\elements\\User	t	f	2019-01-08 06:43:22-06	2019-01-08 06:43:22-06	336531f5-413c-4efd-ad76-4f3e4054e569
2	2	craft\\elements\\Entry	t	f	2019-01-09 04:04:18-06	2019-01-09 04:10:17-06	2a6cf54a-2b51-44e5-91ea-36cf13a6f92f
3	1	craft\\elements\\Asset	t	f	2019-01-09 04:07:21-06	2019-01-09 04:07:21-06	bcdca28f-73cb-4f6a-b631-02fc99f59fb2
4	3	craft\\elements\\Entry	t	f	2019-01-10 04:58:52-06	2019-01-10 05:13:28-06	44ca6da0-54ad-459c-ba5b-f19468c1684e
5	4	craft\\elements\\Entry	t	f	2019-01-10 04:59:57-06	2019-01-10 05:11:07-06	ff65edb0-fc6e-4b37-a196-0383ff17a614
6	5	craft\\elements\\Entry	t	f	2019-01-10 05:00:50-06	2019-01-10 05:15:40-06	8b78212c-3cf0-4987-b756-01ef85fb8680
7	1	craft\\elements\\Asset	t	f	2019-01-10 05:09:31-06	2019-01-10 05:09:31-06	94037b19-fddc-4ba0-9236-9fe03e06a322
8	1	craft\\elements\\Asset	t	f	2019-01-10 05:10:51-06	2019-01-10 05:10:51-06	4d6fa422-81fe-4f6a-ada4-0a97b0eafdf1
9	1	craft\\elements\\Asset	t	f	2019-01-10 05:13:18-06	2019-01-10 05:13:18-06	cda5036d-eb06-4584-b949-bee2d8685f85
\.


--
-- Name: elements_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: craft3
--

SELECT pg_catalog.setval('temp.elements_id_seq', 9, true);


--
-- Data for Name: elements_sites; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.elements_sites (id, elementid, siteid, slug, uri, enabled, datecreated, dateupdated, uid) FROM stdin;
1	1	1	\N	\N	t	2019-01-08 06:43:22-06	2019-01-08 06:43:22-06	71f0af44-bf92-46d2-af57-8b99ecbd3b65
2	2	1	landing	landing	t	2019-01-09 04:04:18-06	2019-01-09 04:10:17-06	7d326ff9-e5ea-4a0a-ae29-f17afbaf1b57
3	3	1	\N	\N	t	2019-01-09 04:07:21-06	2019-01-09 04:07:21-06	4984704a-a9e2-494e-be8c-058a2651dfb6
4	4	1	home	home	t	2019-01-10 04:58:52-06	2019-01-10 05:13:28-06	532a299e-184a-41b1-8233-d63c064133b4
5	5	1	about	about	t	2019-01-10 04:59:57-06	2019-01-10 05:11:07-06	da39ea4f-1146-48e8-b585-aba1c869e680
6	6	1	follow	follow	t	2019-01-10 05:00:50-06	2019-01-10 05:15:40-06	d2e98276-153f-41db-a03c-707ec9da028f
7	7	1	\N	\N	t	2019-01-10 05:09:31-06	2019-01-10 05:09:31-06	9fc0e378-fdc8-42bd-9c4a-59e00fc0b295
8	8	1	\N	\N	t	2019-01-10 05:10:51-06	2019-01-10 05:10:51-06	f290d9cc-8a80-419f-86ac-b63b846e6e7d
9	9	1	\N	\N	t	2019-01-10 05:13:18-06	2019-01-10 05:13:18-06	5cc7d1a9-7f4a-4d31-80ea-e53125fa1fa4
\.


--
-- Name: elements_sites_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: craft3
--

SELECT pg_catalog.setval('temp.elements_sites_id_seq', 9, true);


--
-- Data for Name: entries; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.entries (id, sectionid, typeid, authorid, postdate, expirydate, datecreated, dateupdated, uid) FROM stdin;
2	1	1	\N	2019-01-09 04:04:00-06	\N	2019-01-09 04:04:18-06	2019-01-09 04:10:17-06	3ed6368a-9c41-4df1-bfc5-f72c1901bc6e
4	2	2	\N	2019-01-10 04:58:00-06	\N	2019-01-10 04:58:52-06	2019-01-10 05:13:28-06	6071dfa2-e252-4d87-8285-5b437d6262ba
5	3	3	\N	2019-01-10 04:59:00-06	\N	2019-01-10 04:59:57-06	2019-01-10 05:11:07-06	ab33683e-5185-4453-b044-4b272f6425ec
6	4	4	\N	2019-01-10 05:00:00-06	\N	2019-01-10 05:00:50-06	2019-01-10 05:15:40-06	305310ad-b664-4843-9073-991651297dd1
\.


--
-- Data for Name: entrydrafts; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.entrydrafts (id, entryid, sectionid, creatorid, siteid, name, notes, data, datecreated, dateupdated, uid) FROM stdin;
\.


--
-- Name: entrydrafts_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: craft3
--

SELECT pg_catalog.setval('temp.entrydrafts_id_seq', 1, true);


--
-- Data for Name: entrytypes; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.entrytypes (id, sectionid, fieldlayoutid, name, handle, hastitlefield, titlelabel, titleformat, sortorder, datecreated, dateupdated, uid) FROM stdin;
1	1	2	Landing	landing	f	\N	{section.name|raw}	1	2019-01-09 04:04:18-06	2019-01-09 04:04:39-06	04c891e5-2b73-45cf-a10c-c91aa1da5485
2	2	3	Home	home	f	\N	{section.name|raw}	1	2019-01-10 04:58:52-06	2019-01-10 04:59:26-06	58458886-8008-4c4b-818c-3364ec3a6b81
3	3	4	About	about	f	\N	{section.name|raw}	1	2019-01-10 04:59:57-06	2019-01-10 05:00:28-06	ac71ba05-1457-4521-80af-c9393d96acfb
4	4	5	Follow	follow	f	\N	{section.name|raw}	1	2019-01-10 05:00:50-06	2019-01-10 05:01:09-06	a11bebcc-98e8-4d6b-b2b1-e31be413e0da
\.


--
-- Name: entrytypes_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: craft3
--

SELECT pg_catalog.setval('temp.entrytypes_id_seq', 4, true);


--
-- Data for Name: entryversions; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.entryversions (id, entryid, sectionid, creatorid, siteid, num, notes, data, datecreated, dateupdated, uid) FROM stdin;
1	2	1	1	1	1	Revision from Jan 8, 2019, 8:04:40 PM	{"typeId":"1","authorId":null,"title":"Landing","slug":"landing","postDate":1547006640,"expiryDate":null,"enabled":"1","newParentId":null,"fields":{"1":[]}}	2019-01-09 04:10:16-06	2019-01-09 04:10:16-06	c0f8b9bb-3126-4b0f-a890-87c697d8ebb6
2	2	1	1	1	2		{"typeId":"1","authorId":null,"title":"Landing","slug":"landing","postDate":1547006640,"expiryDate":null,"enabled":true,"newParentId":null,"fields":{"1":["3"],"2":"<p>Mattie</p><p>Michelle</p><p>Color</p>"}}	2019-01-09 04:10:17-06	2019-01-09 04:10:17-06	222e6c91-b67f-4685-b1e9-8725dae311ec
3	5	3	1	1	1	Revision from Jan 9, 2019, 9:00:29 PM	{"typeId":"3","authorId":null,"title":"About","slug":"about","postDate":1547096340,"expiryDate":null,"enabled":"1","newParentId":null,"fields":{"1":[],"3":[]}}	2019-01-10 05:11:06-06	2019-01-10 05:11:06-06	842675bf-0eb3-499d-9419-8e0afcf34660
4	5	3	1	1	2		{"typeId":"3","authorId":null,"title":"About","slug":"about","postDate":1547096340,"expiryDate":null,"enabled":true,"newParentId":null,"fields":{"1":["8","7"],"3":["7"],"2":"<p>OUR GOAL IS SIMPLE. WE LIVE IN COLOR, WE CREATE IN COLOR, AND WE DREAM IN COLOR. WE APPLY COLOR TO CHALLENGE THE STATUS QUO’ TO CREATE A COMMUNITY ROOTED IN UNIQUENESS. WE HOLD OURSELVES TO A HIGHER STANDARD TO ENSURE THAT WE GIVE OUR CLIENT’S THE CONFIDENCE TO BE THEMSELVES AND FEEL GREAT DOING IT. MATTIE MICHELLE IS A LIFESTYLE WITHOUT LIMITS, WE ARE NOT SOLELY CHANGING HAIR, WE ARE BUILDING COMMUNITIES.  </p>"}}	2019-01-10 05:11:07-06	2019-01-10 05:11:07-06	a18f5d24-0045-4a50-a439-d45497b746b6
5	4	2	1	1	1	Revision from Jan 9, 2019, 8:59:27 PM	{"typeId":"2","authorId":null,"title":"Home","slug":"home","postDate":1547096280,"expiryDate":null,"enabled":"1","newParentId":null,"fields":{"3":[]}}	2019-01-10 05:13:28-06	2019-01-10 05:13:28-06	9803fd9c-eb55-4e2e-a35a-3beaad0a965c
6	4	2	1	1	2		{"typeId":"2","authorId":null,"title":"Home","slug":"home","postDate":1547096280,"expiryDate":null,"enabled":true,"newParentId":null,"fields":{"3":["9"]}}	2019-01-10 05:13:28-06	2019-01-10 05:13:28-06	adfc6833-2610-4b72-a4cd-598aae986be6
7	6	4	1	1	1	Revision from Jan 9, 2019, 9:01:10 PM	{"typeId":"4","authorId":null,"title":"Follow","slug":"follow","postDate":1547096400,"expiryDate":null,"enabled":"1","newParentId":null,"fields":[]}	2019-01-10 05:15:40-06	2019-01-10 05:15:40-06	dab1738c-8ed6-490e-92c1-c6081211afd4
8	6	4	1	1	2		{"typeId":"4","authorId":null,"title":"Follow","slug":"follow","postDate":1547096400,"expiryDate":null,"enabled":true,"newParentId":null,"fields":{"4":"1906 North Henderson Ave.\\nDallas, TX 75206","5":[{"col1":"Mon","col2":"Closed"},{"col1":"Tue","col2":"Closed"},{"col1":"Wed","col2":"9:00 AM - 5:00 PM"},{"col1":"Thu","col2":"9:00 AM - 5:00 PM"},{"col1":"Fri","col2":"9:00 AM - 5:00 PM"},{"col1":"Sat","col2":"9:00 AM - 3:00 PM"},{"col1":"Sun","col2":"Closed"}]}}	2019-01-10 05:15:40-06	2019-01-10 05:15:40-06	e0afe385-b6eb-40a1-abab-56c5a1a97318
\.


--
-- Name: entryversions_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: craft3
--

SELECT pg_catalog.setval('temp.entryversions_id_seq', 8, true);


--
-- Data for Name: fieldgroups; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.fieldgroups (id, name, datecreated, dateupdated, uid) FROM stdin;
1	Common	2019-01-08 06:43:22-06	2019-01-08 06:43:22-06	e11054c5-fbf9-41a5-aa92-8dfccdf261b7
3	Follow	2019-01-10 04:56:59-06	2019-01-10 04:56:59-06	2d16a954-ca26-44bd-bde1-f8fd79336379
\.


--
-- Name: fieldgroups_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: craft3
--

SELECT pg_catalog.setval('temp.fieldgroups_id_seq', 3, true);


--
-- Data for Name: fieldlayoutfields; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.fieldlayoutfields (id, layoutid, tabid, fieldid, required, sortorder, datecreated, dateupdated, uid) FROM stdin;
1	2	1	1	f	1	2019-01-09 04:04:39-06	2019-01-09 04:04:39-06	e92ae6c8-d279-4fce-8b2b-4c2652bb8bd7
2	2	1	2	f	2	2019-01-09 04:04:39-06	2019-01-09 04:04:39-06	2e8a5b81-7957-498b-aecb-bebde05da557
3	3	2	3	f	1	2019-01-10 04:59:26-06	2019-01-10 04:59:26-06	655a6a7d-e6fc-4301-8226-52ce6650dcc4
4	4	3	1	f	1	2019-01-10 05:00:28-06	2019-01-10 05:00:28-06	8787ce06-c5bf-4bb1-aabf-bd07a0edf07c
5	4	3	3	f	2	2019-01-10 05:00:28-06	2019-01-10 05:00:28-06	d5fee7bd-bd41-4e9a-9298-acf9c5e317f7
6	4	3	2	f	3	2019-01-10 05:00:28-06	2019-01-10 05:00:28-06	43fb5d34-73dc-40bb-8f36-5d95a31469ee
7	5	4	4	f	1	2019-01-10 05:01:09-06	2019-01-10 05:01:09-06	68e03388-f3c4-4df2-bf55-ebe1f9f2847f
8	5	4	5	f	2	2019-01-10 05:01:09-06	2019-01-10 05:01:09-06	888f202c-ebd8-4654-b011-ea7588b3c1a8
\.


--
-- Name: fieldlayoutfields_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: craft3
--

SELECT pg_catalog.setval('temp.fieldlayoutfields_id_seq', 8, true);


--
-- Data for Name: fieldlayouts; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.fieldlayouts (id, type, datecreated, dateupdated, uid) FROM stdin;
1	craft\\elements\\Asset	2019-01-09 03:36:17-06	2019-01-09 05:45:05-06	c2968b31-099b-4bbd-a585-f1ca52c0232b
2	craft\\elements\\Entry	2019-01-09 04:04:18-06	2019-01-09 04:04:39-06	df55d3cc-aae3-4df9-a387-32ef28c89663
3	craft\\elements\\Entry	2019-01-10 04:58:52-06	2019-01-10 04:59:26-06	a053effd-09d7-44d1-8af1-5afed6c3a42a
4	craft\\elements\\Entry	2019-01-10 04:59:57-06	2019-01-10 05:00:28-06	1771b449-a1c9-4d9a-8378-214b238c67c1
5	craft\\elements\\Entry	2019-01-10 05:00:50-06	2019-01-10 05:01:09-06	39cf27a1-1517-46e0-9abf-aa9c4035d7cc
\.


--
-- Name: fieldlayouts_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: craft3
--

SELECT pg_catalog.setval('temp.fieldlayouts_id_seq', 5, true);


--
-- Data for Name: fieldlayouttabs; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.fieldlayouttabs (id, layoutid, name, sortorder, datecreated, dateupdated, uid) FROM stdin;
1	2	Landing	1	2019-01-09 04:04:39-06	2019-01-09 04:04:39-06	b29ea719-85e2-4b4d-8a49-ebd29b9cd8d0
2	3	Tab 1	1	2019-01-10 04:59:26-06	2019-01-10 04:59:26-06	d569016c-8b2f-4975-9f01-7143b6e52a94
3	4	About	1	2019-01-10 05:00:28-06	2019-01-10 05:00:28-06	8fb73e73-4b8a-4ef0-a2a7-a80b779d084a
4	5	Follow	1	2019-01-10 05:01:09-06	2019-01-10 05:01:09-06	c811900f-3b62-49d7-896e-7146e2900365
\.


--
-- Name: fieldlayouttabs_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: craft3
--

SELECT pg_catalog.setval('temp.fieldlayouttabs_id_seq', 4, true);


--
-- Data for Name: fields; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.fields (id, groupid, name, handle, context, instructions, translationmethod, translationkeyformat, type, settings, datecreated, dateupdated, uid) FROM stdin;
1	1	Icon	icon	global		site	\N	craft\\fields\\Assets	{"useSingleFolder":"","defaultUploadLocationSource":"folder:1","defaultUploadLocationSubpath":"","singleUploadLocationSource":"folder:1","singleUploadLocationSubpath":"","restrictFiles":"","allowedKinds":null,"sources":["folder:1"],"source":null,"targetSiteId":null,"viewMode":"list","limit":"","selectionLabel":"","localizeRelations":false}	2019-01-09 03:34:23-06	2019-01-09 03:42:06-06	24a82afc-73b9-49d5-b3b1-cff20311ea28
2	1	Text	text	global		none	\N	craft\\ckeditor\\Field	{"purifierConfig":"","purifyHtml":"1","columnType":"text"}	2019-01-09 04:02:31-06	2019-01-09 04:02:31-06	27428094-97cd-4cf9-bd4e-34bac362f156
3	1	Image	image	global		site	\N	craft\\fields\\Assets	{"useSingleFolder":"","defaultUploadLocationSource":"folder:1","defaultUploadLocationSubpath":"","singleUploadLocationSource":"folder:1","singleUploadLocationSubpath":"","restrictFiles":"","allowedKinds":null,"sources":["folder:1"],"source":null,"targetSiteId":null,"viewMode":"list","limit":"","selectionLabel":"","localizeRelations":false}	2019-01-10 04:54:14-06	2019-01-10 04:54:14-06	5e216fb1-a0e4-40d3-a35a-8c1716cab427
4	3	Address	address	global		none	\N	craft\\fields\\PlainText	{"placeholder":"","code":"","multiline":"1","initialRows":"4","charLimit":"","columnType":"text"}	2019-01-10 04:57:22-06	2019-01-10 04:57:36-06	c513e010-de36-4f1a-9ddc-33383d288e6e
5	3	Open Time	openTime	global		none	\N	craft\\fields\\Table	{"addRowLabel":"Add a row","maxRows":"","minRows":"","columns":{"col1":{"heading":"Date","handle":"date","width":"","type":"singleline"},"col2":{"heading":"Time","handle":"time","width":"","type":"singleline"}},"defaults":{"row1":{"col1":"","col2":""}},"columnType":"text"}	2019-01-10 04:58:24-06	2019-01-10 04:58:24-06	c9e582d0-2771-43b7-b7ae-b03f08524332
\.


--
-- Name: fields_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: craft3
--

SELECT pg_catalog.setval('temp.fields_id_seq', 5, true);


--
-- Data for Name: globalsets; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.globalsets (id, name, handle, fieldlayoutid, datecreated, dateupdated, uid) FROM stdin;
\.


--
-- Name: globalsets_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: craft3
--

SELECT pg_catalog.setval('temp.globalsets_id_seq', 1, true);


--
-- Data for Name: info; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.info (id, version, schemaversion, edition, timezone, name, "on", maintenance, fieldversion, datecreated, dateupdated, uid) FROM stdin;
1	3.0.36	3.0.94	0	America/Los_Angeles	mattie-michelle	t	f	Bt9BFgdgJP77	2019-01-08 06:43:22-06	2019-01-10 04:58:24-06	26a078a6-9c54-4353-ada8-9cb6105246dc
\.


--
-- Name: info_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: craft3
--

SELECT pg_catalog.setval('temp.info_id_seq', 1, true);


--
-- Data for Name: matrixblocks; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.matrixblocks (id, ownerid, ownersiteid, fieldid, typeid, sortorder, datecreated, dateupdated, uid) FROM stdin;
\.


--
-- Data for Name: matrixblocktypes; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.matrixblocktypes (id, fieldid, fieldlayoutid, name, handle, sortorder, datecreated, dateupdated, uid) FROM stdin;
\.


--
-- Name: matrixblocktypes_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: craft3
--

SELECT pg_catalog.setval('temp.matrixblocktypes_id_seq', 1, true);


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.migrations (id, pluginid, type, name, applytime, datecreated, dateupdated, uid) FROM stdin;
1	\N	app	Install	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	0385669d-a373-4104-8ec9-8dd697686fb5
2	\N	app	m150403_183908_migrations_table_changes	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	04556598-3473-4310-a467-df5d5dc78c66
3	\N	app	m150403_184247_plugins_table_changes	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	abfe75e0-c9b6-4749-b7cc-f9b8781b76a2
4	\N	app	m150403_184533_field_version	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	240e0652-42c6-49cd-a265-0a2fa76856a9
5	\N	app	m150403_184729_type_columns	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	67acaadc-fdde-4a7e-aceb-1bd488644103
6	\N	app	m150403_185142_volumes	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	a276a665-da0b-41e2-b042-03e4ff4be97d
7	\N	app	m150428_231346_userpreferences	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	42cdf30c-bd6e-459f-94a3-6bb84f0bf329
8	\N	app	m150519_150900_fieldversion_conversion	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	d78029a2-abdb-4b64-b061-d017119a1866
9	\N	app	m150617_213829_update_email_settings	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	cb679023-9a12-4712-9d35-c67eeb47039e
10	\N	app	m150721_124739_templatecachequeries	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	4d14ecf4-4ddd-4359-933d-5bff9c5fa019
11	\N	app	m150724_140822_adjust_quality_settings	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	3ab2d673-fc1d-4c3e-a0da-836abd0d3b59
12	\N	app	m150815_133521_last_login_attempt_ip	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	ab4352a9-5e30-49f3-bd52-87b5a8cea368
13	\N	app	m151002_095935_volume_cache_settings	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	7d8c7140-3b9a-47e7-afb6-6602048364cf
14	\N	app	m151005_142750_volume_s3_storage_settings	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	9a1ad247-7f05-4455-89eb-17a483a2fae1
15	\N	app	m151016_133600_delete_asset_thumbnails	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	6c009df8-dbbd-4eae-9cf8-099c74935ebc
16	\N	app	m151209_000000_move_logo	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	224c415c-04ff-42ef-a691-c0a72ca98999
17	\N	app	m151211_000000_rename_fileId_to_assetId	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	1c44c3fb-a2b4-4e24-870c-d729a2b22fc6
18	\N	app	m151215_000000_rename_asset_permissions	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	1d37161b-6949-44b4-a68b-27506278f454
19	\N	app	m160707_000001_rename_richtext_assetsource_setting	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	e86ee485-3e6e-45a3-8a23-0a9109213b65
20	\N	app	m160708_185142_volume_hasUrls_setting	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	9cf4c6ec-6235-4e3b-8db8-f4ef6370594d
21	\N	app	m160714_000000_increase_max_asset_filesize	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	9ea826a6-eb8c-4c3e-8311-f18e0df079b7
22	\N	app	m160727_194637_column_cleanup	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	b4675d0a-9c3f-47c7-b3cb-849f67344992
23	\N	app	m160804_110002_userphotos_to_assets	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	56179871-9d13-4d20-bc94-4123a4ca275e
24	\N	app	m160807_144858_sites	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	ddb9e203-5410-41c0-aac1-e4794dd83dd1
25	\N	app	m160829_000000_pending_user_content_cleanup	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	8e9445b2-1e33-4c2b-b54e-960564fc4cc6
26	\N	app	m160830_000000_asset_index_uri_increase	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	1f785e07-7eb5-4567-bf1a-e19461e6b18d
27	\N	app	m160912_230520_require_entry_type_id	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	76bb10ee-45b9-4581-ac69-4c70638655e3
28	\N	app	m160913_134730_require_matrix_block_type_id	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	d5939328-22ef-464a-96bb-1b97f61069c8
29	\N	app	m160920_174553_matrixblocks_owner_site_id_nullable	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	fd9b53ac-7e34-4ef8-8c7c-71627174045f
30	\N	app	m160920_231045_usergroup_handle_title_unique	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	9307eb4c-6033-427f-ad88-f9f516b24ed1
31	\N	app	m160925_113941_route_uri_parts	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	b99da33c-7a1a-4d05-9871-7db508e47ea9
32	\N	app	m161006_205918_schemaVersion_not_null	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	e0127c64-f9dd-4b71-9fbb-162c1f3db59c
33	\N	app	m161007_130653_update_email_settings	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	9b3d50d8-3f26-439e-b1ce-28aff412bc82
34	\N	app	m161013_175052_newParentId	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	203c19b2-bd67-4cde-8c17-e80b97d3822a
35	\N	app	m161021_102916_fix_recent_entries_widgets	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	47a62a9a-5fd6-4858-b2a2-8d91de65f8b9
36	\N	app	m161021_182140_rename_get_help_widget	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	ccc2ba9c-8218-4d46-b222-c07ef47409f2
37	\N	app	m161025_000000_fix_char_columns	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	1a1b46a6-16d4-4e2e-b4b7-4173ff9a8ca8
38	\N	app	m161029_124145_email_message_languages	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	b262ad8f-2c05-459a-9fa2-8f868c5c822c
39	\N	app	m161108_000000_new_version_format	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	0ebaf491-027c-410e-bb90-0c1488394e2b
40	\N	app	m161109_000000_index_shuffle	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	f67578e8-a5e8-4d04-9e7f-1cca5c1f5b73
41	\N	app	m161122_185500_no_craft_app	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	f340b11c-fb1c-4472-be3b-476941f2ac23
42	\N	app	m161125_150752_clear_urlmanager_cache	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	d406d110-ee8b-4893-9a2c-9c7c2506503b
43	\N	app	m161220_000000_volumes_hasurl_notnull	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	8877e97f-a10b-4951-bde6-7c73dc9a5b9b
44	\N	app	m170114_161144_udates_permission	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2bc8ae7b-bdf0-4658-a053-a0f392e9bcec
45	\N	app	m170120_000000_schema_cleanup	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	b849d3fc-bd08-4b8c-9f95-1f4d24fee6bf
46	\N	app	m170126_000000_assets_focal_point	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	dd8190c7-3e63-4116-89a0-e6a97b022ed7
47	\N	app	m170206_142126_system_name	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	60fbdcc6-8050-4b60-a42e-877665dee22b
48	\N	app	m170217_044740_category_branch_limits	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	89bdf078-deee-4251-a0ff-fb9c1fb01b31
49	\N	app	m170217_120224_asset_indexing_columns	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	c826df96-0f91-4031-9b77-1a39c662847a
50	\N	app	m170223_224012_plain_text_settings	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	873e40b9-acd4-4a99-89b8-09ec2cf7d484
51	\N	app	m170227_120814_focal_point_percentage	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	0eed98df-119e-41ad-90bd-bffaf1a8889a
52	\N	app	m170228_171113_system_messages	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	ae86edfb-e3f2-440b-9831-e36a3b9f9336
53	\N	app	m170303_140500_asset_field_source_settings	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	fe87fee2-3f87-44ed-ba0e-708d763554c1
54	\N	app	m170306_150500_asset_temporary_uploads	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	790f2fb9-2ed2-4af0-97f2-076c1e41335f
55	\N	app	m170414_162429_rich_text_config_setting	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2449919d-7f21-4976-adea-61551c7486b7
56	\N	app	m170523_190652_element_field_layout_ids	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	8cedaa6f-a2fb-497d-8169-de9c4287942f
57	\N	app	m170612_000000_route_index_shuffle	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	453edf18-7601-434f-a8eb-63ca365d4cf0
58	\N	app	m170621_195237_format_plugin_handles	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	ef16239f-a36a-4a42-ab28-9092b16607bd
59	\N	app	m170630_161028_deprecation_changes	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	7717043c-faab-4c1e-bc8e-d9e5d51e2d3b
60	\N	app	m170703_181539_plugins_table_tweaks	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	7e5c4ed6-b2a5-4701-bf6e-e8dba2ffc949
61	\N	app	m170704_134916_sites_tables	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	80285337-2fd8-4aa6-b546-86faf03d6ac1
62	\N	app	m170706_183216_rename_sequences	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	33d78d07-96d7-4932-b0f3-588f8f3640e9
63	\N	app	m170707_094758_delete_compiled_traits	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	0e2d5f6c-bb32-4d58-8849-d6dedc14286c
64	\N	app	m170731_190138_drop_asset_packagist	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	24589872-08b6-43a2-b0fb-7f1e061f6723
65	\N	app	m170810_201318_create_queue_table	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	a3b1b2b3-20eb-4d1d-b30e-3a26e75d56bf
66	\N	app	m170816_133741_delete_compiled_behaviors	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	78b1b939-40dc-4820-b6d1-18c905a10ffc
67	\N	app	m170821_180624_deprecation_line_nullable	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	e9673714-df0c-41ab-91c5-b7215ad2a9fd
68	\N	app	m170903_192801_longblob_for_queue_jobs	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	265a22f8-b58d-48e3-a4ed-8bf8f38647a0
69	\N	app	m170914_204621_asset_cache_shuffle	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	9611699e-3391-4e4d-a9c6-0a0ab1a7ac1a
70	\N	app	m171011_214115_site_groups	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	d634d29b-770a-4115-a89a-d3b6bbd9a90b
71	\N	app	m171012_151440_primary_site	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	37c18faf-640a-4d10-9499-76b167f6a839
72	\N	app	m171013_142500_transform_interlace	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	5490273b-2a30-48da-81cb-604c69647639
73	\N	app	m171016_092553_drop_position_select	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	44db3408-6a90-47a7-9314-a5be88401d17
74	\N	app	m171016_221244_less_strict_translation_method	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2c757f64-93a5-446c-bc0c-7eedd4c3c065
75	\N	app	m171107_000000_assign_group_permissions	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2ad04590-f005-4b84-bbba-bb635f195eb7
76	\N	app	m171117_000001_templatecache_index_tune	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	c9fdf22f-a15b-4c43-b563-54e595f40037
77	\N	app	m171126_105927_disabled_plugins	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	f0471788-574c-474a-84ee-bd4738f28d38
78	\N	app	m171130_214407_craftidtokens_table	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	9b5a5c2b-3bd0-4647-bafc-c23e48a29bcb
79	\N	app	m171202_004225_update_email_settings	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	595e554b-b674-41c5-aa34-9d6fd7f78fbd
80	\N	app	m171204_000001_templatecache_index_tune_deux	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	46aa3234-174a-4ae9-916d-b985ea7dd580
81	\N	app	m171205_130908_remove_craftidtokens_refreshtoken_column	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	30279c17-7f9e-4560-9f88-e421d6238159
82	\N	app	m171218_143135_longtext_query_column	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	ffbbc487-3c8e-4113-9d35-358a760b0466
83	\N	app	m171231_055546_environment_variables_to_aliases	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	6d3801ca-1ebc-443f-91e9-3fa702aa8bc8
84	\N	app	m180113_153740_drop_users_archived_column	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	09a08de2-db02-4f86-a5f2-483943cb3754
85	\N	app	m180122_213433_propagate_entries_setting	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	d5af3026-f50f-427a-959c-b6894cca0b42
86	\N	app	m180124_230459_fix_propagate_entries_values	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	79eeb1b7-814c-4dd6-a31a-ffe3f98b9f43
87	\N	app	m180128_235202_set_tag_slugs	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	e245a200-1279-4847-ad55-329820754884
88	\N	app	m180202_185551_fix_focal_points	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	d14f2a83-35e8-4823-afa8-c602c38a1ce9
89	\N	app	m180217_172123_tiny_ints	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	e278ddd9-9a87-4594-8d49-8965cf114fd8
90	\N	app	m180321_233505_small_ints	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	7283ee81-7daf-4bd1-833d-861f1c11836f
91	\N	app	m180328_115523_new_license_key_statuses	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	72321a30-3748-4ec5-9ba9-b6b96a9f4d27
92	\N	app	m180404_182320_edition_changes	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	ce181fd1-c9fe-470c-89c6-65ae58bc344c
93	\N	app	m180411_102218_fix_db_routes	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	15ab1de8-f6c3-4d40-b45a-8b175934d581
94	\N	app	m180416_205628_resourcepaths_table	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	90cc9cae-4841-4ec7-81f6-877a5f13d413
95	\N	app	m180418_205713_widget_cleanup	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2c4e7bd9-c303-44db-b572-94cf7cb0ebc1
96	\N	app	m180824_193422_case_sensitivity_fixes	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	b4994d29-d9fe-43fa-bb9d-fffb13271da7
97	\N	app	m180901_151639_fix_matrixcontent_tables	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	9ad45665-9e79-400a-9cd2-83eef1fd524d
98	\N	app	m181112_203955_sequences_table	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	68a3f8ab-cea5-4acf-9757-91140ed9111a
\.


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: craft3
--

SELECT pg_catalog.setval('temp.migrations_id_seq', 98, true);


--
-- Data for Name: plugins; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.plugins (id, handle, version, schemaversion, licensekey, licensekeystatus, enabled, settings, installdate, datecreated, dateupdated, uid) FROM stdin;
1	ckeditor	1.0.0-beta.2	1.0.0	\N	unknown	t	\N	2019-01-09 03:47:08-06	2019-01-09 03:47:08-06	2019-01-10 05:06:27-06	b010a00b-893c-4c4f-ab10-6cfe84124b70
2	contact-form	2.2.3	1.0.0	\N	unknown	t	{"toEmail":"daituzhang@gmail.com","prependSender":"On behalf of","prependSubject":"New message from mattie-michelle","allowAttachments":"","successFlashMessage":"Your message has been sent."}	2019-01-10 05:06:18-06	2019-01-10 05:06:18-06	2019-01-10 05:07:12-06	faa5276b-6ac4-438b-bf73-a83fa01bc37c
\.


--
-- Name: plugins_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: craft3
--

SELECT pg_catalog.setval('temp.plugins_id_seq', 2, true);


--
-- Data for Name: queue; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.queue (id, job, description, timepushed, ttr, delay, priority, datereserved, timeupdated, progress, attempt, fail, datefailed, error) FROM stdin;
\.


--
-- Name: queue_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: craft3
--

SELECT pg_catalog.setval('temp.queue_id_seq', 1, true);


--
-- Data for Name: relations; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.relations (id, fieldid, sourceid, sourcesiteid, targetid, sortorder, datecreated, dateupdated, uid) FROM stdin;
1	1	2	\N	3	1	2019-01-09 04:10:17-06	2019-01-09 04:10:17-06	778fba34-657e-45ef-8f53-172fff91f8e0
2	1	5	\N	8	1	2019-01-10 05:11:07-06	2019-01-10 05:11:07-06	81aae82c-8b5d-42db-b701-790c3ae8cfba
3	1	5	\N	7	2	2019-01-10 05:11:07-06	2019-01-10 05:11:07-06	5e7b60b0-0b48-42dc-9457-89a4b9b7be50
4	3	5	\N	7	1	2019-01-10 05:11:07-06	2019-01-10 05:11:07-06	d3e92aa3-e22f-4277-ac03-9235bcbd8e7d
5	3	4	\N	9	1	2019-01-10 05:13:28-06	2019-01-10 05:13:28-06	ccb72519-e1ac-449f-b5f3-7bad6c9575bb
\.


--
-- Name: relations_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: craft3
--

SELECT pg_catalog.setval('temp.relations_id_seq', 5, true);


--
-- Data for Name: resourcepaths; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.resourcepaths (hash, path) FROM stdin;
1507da42	@lib/fabric
16fdf219	@craft/web/assets/tablesettings/dist
195a3f3d	@lib/garnishjs
1ed75a6f	@craft/web/assets/utilities/dist
25b13855	@lib/fileupload
2ae728bb	@lib/d3
387b0fe0	@lib/prismjs
3a3ffc0a	@app/web/assets/fields/dist
3afd0569	@lib/jquery-touch-events
3d58d244	@app/web/assets/dashboard/dist
3d5939ab	@lib/picturefill
3eef406c	@craft/web/assets/fields/dist
442562a5	@craft/web/assets/cp/dist
45af3991	@lib/timepicker
4d5e52d8	@craft/web/assets/pluginstore/dist
5e5bbb34	@craft/web/assets/updateswidget/dist
60e1f95a	@craft/web/assets/recententries/dist
634b50a5	@lib/xregexp
6922bf05	@craft/web/assets/updater/dist
6927142f	@lib/selectize
874ed7b6	@app/web/assets/feed/dist
90c2f595	@lib
9504b0c6	@app/web/assets/tablesettings/dist
9e63aed9	@lib/element-resize-detector
9f0794b2	@craft/web/assets/editentry/dist
a06bb5de	@craft/web/assets/matrixsettings/dist
a07cf251	@lib/velocity
b103bbe	@craft/ckeditor/assets/field/dist
b1f3052c	@bower/jquery/dist
b68483d9	@app/web/assets/matrixsettings/dist
b702b341	@vendor/craftcms/ckeditor/lib/ckeditor/dist
bc5b5db9	@lib/jquery.payment
bfa156b2	@craft/web/assets/dashboard/dist
c6e27079	@craft/web/assets/feed/dist
cdf7abd4	@app/web/assets/updater/dist
d330552a	@app/web/assets/craftsupport/dist
dda2f9eb	@app/web/assets/updateswidget/dist
e318bb85	@app/web/assets/recententries/dist
e56dd123	@app/web/assets/pluginstore/dist
eed569f4	@lib/jquery-ui
f1f1faf0	@craft/web/assets/login/dist
f3606a31	@craft/web/assets/dbbackup/dist
f9f74d3d	@craft/web/assets/craftsupport/dist
fa6b8976	@app/web/assets/login/dist
fe559c08	@app/web/assets/cp/dist
\.


--
-- Data for Name: routes; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.routes (id, siteid, uriparts, uripattern, template, sortorder, datecreated, dateupdated, uid) FROM stdin;
\.


--
-- Name: routes_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: craft3
--

SELECT pg_catalog.setval('temp.routes_id_seq', 1, true);


--
-- Data for Name: searchindex; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.searchindex (elementid, attribute, fieldid, siteid, keywords) FROM stdin;
1	username	0	1	 admin 
1	firstname	0	1	
1	lastname	0	1	
1	fullname	0	1	
1	email	0	1	 daituzhang gmail com 
1	slug	0	1	
2	slug	0	1	 landing 
2	title	0	1	 landing 
2	field	1	1	 mm mark 
2	field	2	1	 mattiemichellecolor 
3	filename	0	1	 mm mark svg 
3	extension	0	1	 svg 
3	kind	0	1	 image 
3	slug	0	1	
3	title	0	1	 mm mark 
4	slug	0	1	 home 
4	title	0	1	 home 
4	field	3	1	 home1 
5	slug	0	1	 about 
5	title	0	1	 about 
5	field	1	1	 about icon about 
5	field	3	1	 about 
5	field	2	1	 our goal is simple we live in color we create in color and we dream in color we apply color to challenge the status quo to create a community rooted in uniqueness we hold ourselves to a higher standard to ensure that we give our client s the confidence to be themselves and feel great doing it mattie michelle is a lifestyle without limits we are not solely changing hair we are building communities 
6	slug	0	1	 follow 
6	title	0	1	 follow 
6	field	4	1	 1906 north henderson ave dallas tx 75206 
6	field	5	1	 mon closed mon closed tue closed tue closed wed 9 00 am 5 00 pm wed 9 00 am 5 00 pm thu 9 00 am 5 00 pm thu 9 00 am 5 00 pm fri 9 00 am 5 00 pm fri 9 00 am 5 00 pm sat 9 00 am 3 00 pm sat 9 00 am 3 00 pm sun closed sun closed 
7	filename	0	1	 about png 
7	extension	0	1	 png 
7	kind	0	1	 image 
7	slug	0	1	
7	title	0	1	 about 
8	filename	0	1	 about icon svg 
8	extension	0	1	 svg 
8	kind	0	1	 image 
8	slug	0	1	
8	title	0	1	 about icon 
9	filename	0	1	 home1 jpg 
9	extension	0	1	 jpg 
9	kind	0	1	 image 
9	slug	0	1	
9	title	0	1	 home1 
\.


--
-- Data for Name: sections; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.sections (id, structureid, name, handle, type, enableversioning, propagateentries, datecreated, dateupdated, uid) FROM stdin;
1	\N	Landing	landing	single	t	t	2019-01-09 04:04:18-06	2019-01-09 04:04:18-06	f2950b55-e7c2-44ed-88cd-af3e0ebcad06
2	\N	Home	home	single	t	t	2019-01-10 04:58:52-06	2019-01-10 04:58:52-06	aee20c09-6685-41d4-acd1-14ec05694295
3	\N	About	about	single	t	t	2019-01-10 04:59:57-06	2019-01-10 04:59:57-06	396be30d-227d-4324-a4b9-1353754cb72d
4	\N	Follow	follow	single	t	t	2019-01-10 05:00:50-06	2019-01-10 05:00:50-06	b00c168d-7ac1-4ad8-acd2-f6d2dc76e854
\.


--
-- Name: sections_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: craft3
--

SELECT pg_catalog.setval('temp.sections_id_seq', 4, true);


--
-- Data for Name: sections_sites; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.sections_sites (id, sectionid, siteid, hasurls, uriformat, template, enabledbydefault, datecreated, dateupdated, uid) FROM stdin;
1	1	1	t	landing	landing/_entry	t	2019-01-09 04:04:18-06	2019-01-09 04:04:18-06	a2e6dfec-6535-4d47-b40c-7ec34ffa9ffa
2	2	1	t	home	home/_entry	t	2019-01-10 04:58:52-06	2019-01-10 04:58:52-06	97ac769c-09b2-4fc0-ac50-b346330afb1f
3	3	1	t	about	about/_entry	t	2019-01-10 04:59:57-06	2019-01-10 04:59:57-06	bfb1b943-bee8-4cef-a8e8-3f4f1913ac4b
4	4	1	t	follow	follow/_entry	t	2019-01-10 05:00:50-06	2019-01-10 05:00:50-06	8bb375e8-7ced-4cc1-a21b-fab21a357262
\.


--
-- Name: sections_sites_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: craft3
--

SELECT pg_catalog.setval('temp.sections_sites_id_seq', 4, true);


--
-- Data for Name: sequences; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.sequences (name, next) FROM stdin;
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.sessions (id, userid, token, datecreated, dateupdated, uid) FROM stdin;
\.


--
-- Name: sessions_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: craft3
--

SELECT pg_catalog.setval('temp.sessions_id_seq', 1, true);


--
-- Data for Name: shunnedmessages; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.shunnedmessages (id, userid, message, expirydate, datecreated, dateupdated, uid) FROM stdin;
\.


--
-- Name: shunnedmessages_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: craft3
--

SELECT pg_catalog.setval('temp.shunnedmessages_id_seq', 1, true);


--
-- Data for Name: sitegroups; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.sitegroups (id, name, datecreated, dateupdated, uid) FROM stdin;
1	mattie-michelle	2019-01-08 06:43:22-06	2019-01-08 06:43:22-06	4bbc78c6-d207-4b7b-96a0-5328d3665dae
\.


--
-- Name: sitegroups_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: craft3
--

SELECT pg_catalog.setval('temp.sitegroups_id_seq', 1, true);


--
-- Data for Name: sites; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.sites (id, groupid, "primary", name, handle, language, hasurls, baseurl, sortorder, datecreated, dateupdated, uid) FROM stdin;
1	1	t	mattie-michelle	default	en-US	t	/	1	2019-01-08 06:43:22-06	2019-01-08 06:43:22-06	60cd9a47-84f9-44a0-b46d-9272c882f7cd
\.


--
-- Name: sites_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: craft3
--

SELECT pg_catalog.setval('temp.sites_id_seq', 1, true);


--
-- Data for Name: structureelements; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.structureelements (id, structureid, elementid, root, lft, rgt, level, datecreated, dateupdated, uid) FROM stdin;
\.


--
-- Name: structureelements_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: craft3
--

SELECT pg_catalog.setval('temp.structureelements_id_seq', 1, true);


--
-- Data for Name: structures; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.structures (id, maxlevels, datecreated, dateupdated, uid) FROM stdin;
\.


--
-- Name: structures_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: craft3
--

SELECT pg_catalog.setval('temp.structures_id_seq', 1, true);


--
-- Data for Name: systemmessages; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.systemmessages (id, language, key, subject, body, datecreated, dateupdated, uid) FROM stdin;
\.


--
-- Name: systemmessages_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: craft3
--

SELECT pg_catalog.setval('temp.systemmessages_id_seq', 1, true);


--
-- Data for Name: systemsettings; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.systemsettings (id, category, settings, datecreated, dateupdated, uid) FROM stdin;
1	email	{"fromEmail":"daituzhang@gmail.com","fromName":"mattie-michelle","transportType":"craft\\\\mail\\\\transportadapters\\\\Sendmail"}	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	5ed00746-d7d8-487d-88dd-f3d046ef322c
\.


--
-- Name: systemsettings_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: craft3
--

SELECT pg_catalog.setval('temp.systemsettings_id_seq', 1, true);


--
-- Data for Name: taggroups; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.taggroups (id, name, handle, fieldlayoutid, datecreated, dateupdated, uid) FROM stdin;
\.


--
-- Name: taggroups_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: craft3
--

SELECT pg_catalog.setval('temp.taggroups_id_seq', 1, true);


--
-- Data for Name: tags; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.tags (id, groupid, datecreated, dateupdated, uid) FROM stdin;
\.


--
-- Data for Name: templatecacheelements; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.templatecacheelements (cacheid, elementid) FROM stdin;
\.


--
-- Data for Name: templatecachequeries; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.templatecachequeries (id, cacheid, type, query) FROM stdin;
\.


--
-- Name: templatecachequeries_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: craft3
--

SELECT pg_catalog.setval('temp.templatecachequeries_id_seq', 1, true);


--
-- Data for Name: templatecaches; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.templatecaches (id, siteid, cachekey, path, expirydate, body) FROM stdin;
\.


--
-- Name: templatecaches_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: craft3
--

SELECT pg_catalog.setval('temp.templatecaches_id_seq', 1, true);


--
-- Data for Name: tokens; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.tokens (id, token, route, usagelimit, usagecount, expirydate, datecreated, dateupdated, uid) FROM stdin;
\.


--
-- Name: tokens_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: craft3
--

SELECT pg_catalog.setval('temp.tokens_id_seq', 1, true);


--
-- Data for Name: usergroups; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.usergroups (id, name, handle, datecreated, dateupdated, uid) FROM stdin;
\.


--
-- Name: usergroups_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: craft3
--

SELECT pg_catalog.setval('temp.usergroups_id_seq', 1, true);


--
-- Data for Name: usergroups_users; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.usergroups_users (id, groupid, userid, datecreated, dateupdated, uid) FROM stdin;
\.


--
-- Name: usergroups_users_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: craft3
--

SELECT pg_catalog.setval('temp.usergroups_users_id_seq', 1, true);


--
-- Data for Name: userpermissions; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.userpermissions (id, name, datecreated, dateupdated, uid) FROM stdin;
\.


--
-- Name: userpermissions_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: craft3
--

SELECT pg_catalog.setval('temp.userpermissions_id_seq', 1, true);


--
-- Data for Name: userpermissions_usergroups; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.userpermissions_usergroups (id, permissionid, groupid, datecreated, dateupdated, uid) FROM stdin;
\.


--
-- Name: userpermissions_usergroups_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: craft3
--

SELECT pg_catalog.setval('temp.userpermissions_usergroups_id_seq', 1, true);


--
-- Data for Name: userpermissions_users; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.userpermissions_users (id, permissionid, userid, datecreated, dateupdated, uid) FROM stdin;
\.


--
-- Name: userpermissions_users_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: craft3
--

SELECT pg_catalog.setval('temp.userpermissions_users_id_seq', 1, true);


--
-- Data for Name: userpreferences; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.userpreferences (userid, preferences) FROM stdin;
1	{"language":"en-US"}
\.


--
-- Name: userpreferences_userid_seq; Type: SEQUENCE SET; Schema: temp; Owner: craft3
--

SELECT pg_catalog.setval('temp.userpreferences_userid_seq', 1, true);


--
-- Data for Name: users; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.users (id, username, photoid, firstname, lastname, email, password, admin, locked, suspended, pending, lastlogindate, lastloginattemptip, invalidloginwindowstart, invalidlogincount, lastinvalidlogindate, lockoutdate, hasdashboard, verificationcode, verificationcodeissueddate, unverifiedemail, passwordresetrequired, lastpasswordchangedate, datecreated, dateupdated, uid) FROM stdin;
1	admin	\N	\N	\N	daituzhang@gmail.com	$2y$13$MBeBfiyepRf.U57Ee.I5p.WRkd9DGpEuIzU7ut9Txp3N78vb51Eq.	t	f	f	f	2019-01-10 04:46:11-06	10.0.2.2	\N	\N	\N	\N	t	\N	\N	\N	f	2019-01-08 06:43:23-06	2019-01-08 06:43:23-06	2019-01-10 04:46:11-06	050ae4ad-9f76-4274-86ab-e2a70766e4fe
\.


--
-- Data for Name: volumefolders; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.volumefolders (id, parentid, volumeid, name, path, datecreated, dateupdated, uid) FROM stdin;
1	\N	1	Images		2019-01-09 03:36:17-06	2019-01-09 03:36:17-06	332b2e33-ab55-45ce-be29-3ace31cc59d3
2	\N	\N	Temporary source	\N	2019-01-09 04:04:57-06	2019-01-09 04:04:57-06	e035c937-5ead-4c16-ab03-9ea16b553b56
3	2	\N	user_1	user_1/	2019-01-09 04:04:57-06	2019-01-09 04:04:57-06	6a3e2848-0a60-4a87-9abd-c6b82f6ae948
\.


--
-- Name: volumefolders_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: craft3
--

SELECT pg_catalog.setval('temp.volumefolders_id_seq', 3, true);


--
-- Data for Name: volumes; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.volumes (id, fieldlayoutid, name, handle, type, hasurls, url, settings, sortorder, datecreated, dateupdated, uid) FROM stdin;
1	1	Images	images	craft\\volumes\\Local	t	/uploads/images/	{"path":"uploads/images/"}	1	2019-01-09 03:36:17-06	2019-01-09 05:45:05-06	af362e51-f0e6-4cfc-8c54-ccf6821ca677
\.


--
-- Name: volumes_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: craft3
--

SELECT pg_catalog.setval('temp.volumes_id_seq', 1, true);


--
-- Data for Name: widgets; Type: TABLE DATA; Schema: temp; Owner: craft3
--

COPY temp.widgets (id, userid, type, sortorder, colspan, settings, enabled, datecreated, dateupdated, uid) FROM stdin;
1	1	craft\\widgets\\RecentEntries	1	f	{"section":"*","siteId":"1","limit":10}	t	2019-01-08 06:43:25-06	2019-01-08 06:43:25-06	196f8821-3da0-4629-8b75-3f48c3bbcb92
2	1	craft\\widgets\\CraftSupport	2	f	[]	t	2019-01-08 06:43:25-06	2019-01-08 06:43:25-06	44fbb14c-13a2-40cc-9ea1-4c6af7518e4b
3	1	craft\\widgets\\Updates	3	f	[]	t	2019-01-08 06:43:25-06	2019-01-08 06:43:25-06	3b52f284-7fa5-4e55-ac67-28f33dbc7860
4	1	craft\\widgets\\Feed	4	f	{"url":"https://craftcms.com/news.rss","title":"Craft News","limit":5}	t	2019-01-08 06:43:25-06	2019-01-08 06:43:25-06	b7b6c493-406a-48be-86d3-9d9f9b064844
\.


--
-- Name: widgets_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: craft3
--

SELECT pg_catalog.setval('temp.widgets_id_seq', 4, true);


--
-- Name: idx_17717_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.assetindexdata
    ADD CONSTRAINT idx_17717_primary PRIMARY KEY (id);


--
-- Name: idx_17728_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.assets
    ADD CONSTRAINT idx_17728_primary PRIMARY KEY (id);


--
-- Name: idx_17738_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.assettransformindex
    ADD CONSTRAINT idx_17738_primary PRIMARY KEY (id);


--
-- Name: idx_17750_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.assettransforms
    ADD CONSTRAINT idx_17750_primary PRIMARY KEY (id);


--
-- Name: idx_17761_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.categories
    ADD CONSTRAINT idx_17761_primary PRIMARY KEY (id);


--
-- Name: idx_17767_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.categorygroups
    ADD CONSTRAINT idx_17767_primary PRIMARY KEY (id);


--
-- Name: idx_17777_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.categorygroups_sites
    ADD CONSTRAINT idx_17777_primary PRIMARY KEY (id);


--
-- Name: idx_17788_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.content
    ADD CONSTRAINT idx_17788_primary PRIMARY KEY (id);


--
-- Name: idx_17798_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.craftidtokens
    ADD CONSTRAINT idx_17798_primary PRIMARY KEY (id);


--
-- Name: idx_17808_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.deprecationerrors
    ADD CONSTRAINT idx_17808_primary PRIMARY KEY (id);


--
-- Name: idx_17818_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.elementindexsettings
    ADD CONSTRAINT idx_17818_primary PRIMARY KEY (id);


--
-- Name: idx_17828_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.elements
    ADD CONSTRAINT idx_17828_primary PRIMARY KEY (id);


--
-- Name: idx_17837_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.elements_sites
    ADD CONSTRAINT idx_17837_primary PRIMARY KEY (id);


--
-- Name: idx_17846_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.entries
    ADD CONSTRAINT idx_17846_primary PRIMARY KEY (id);


--
-- Name: idx_17852_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.entrydrafts
    ADD CONSTRAINT idx_17852_primary PRIMARY KEY (id);


--
-- Name: idx_17862_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.entrytypes
    ADD CONSTRAINT idx_17862_primary PRIMARY KEY (id);


--
-- Name: idx_17874_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.entryversions
    ADD CONSTRAINT idx_17874_primary PRIMARY KEY (id);


--
-- Name: idx_17884_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.fieldgroups
    ADD CONSTRAINT idx_17884_primary PRIMARY KEY (id);


--
-- Name: idx_17891_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.fieldlayoutfields
    ADD CONSTRAINT idx_17891_primary PRIMARY KEY (id);


--
-- Name: idx_17899_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.fieldlayouts
    ADD CONSTRAINT idx_17899_primary PRIMARY KEY (id);


--
-- Name: idx_17906_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.fieldlayouttabs
    ADD CONSTRAINT idx_17906_primary PRIMARY KEY (id);


--
-- Name: idx_17913_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.fields
    ADD CONSTRAINT idx_17913_primary PRIMARY KEY (id);


--
-- Name: idx_17925_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.globalsets
    ADD CONSTRAINT idx_17925_primary PRIMARY KEY (id);


--
-- Name: idx_17935_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.info
    ADD CONSTRAINT idx_17935_primary PRIMARY KEY (id);


--
-- Name: idx_17943_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.matrixblocks
    ADD CONSTRAINT idx_17943_primary PRIMARY KEY (id);


--
-- Name: idx_17949_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.matrixblocktypes
    ADD CONSTRAINT idx_17949_primary PRIMARY KEY (id);


--
-- Name: idx_17959_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.migrations
    ADD CONSTRAINT idx_17959_primary PRIMARY KEY (id);


--
-- Name: idx_17967_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.plugins
    ADD CONSTRAINT idx_17967_primary PRIMARY KEY (id);


--
-- Name: idx_17979_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.queue
    ADD CONSTRAINT idx_17979_primary PRIMARY KEY (id);


--
-- Name: idx_17992_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.relations
    ADD CONSTRAINT idx_17992_primary PRIMARY KEY (id);


--
-- Name: idx_17997_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.resourcepaths
    ADD CONSTRAINT idx_17997_primary PRIMARY KEY (hash);


--
-- Name: idx_18005_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.routes
    ADD CONSTRAINT idx_18005_primary PRIMARY KEY (id);


--
-- Name: idx_18013_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.searchindex
    ADD CONSTRAINT idx_18013_primary PRIMARY KEY (elementid, attribute, fieldid, siteid);


--
-- Name: idx_18021_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.sections
    ADD CONSTRAINT idx_18021_primary PRIMARY KEY (id);


--
-- Name: idx_18034_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.sections_sites
    ADD CONSTRAINT idx_18034_primary PRIMARY KEY (id);


--
-- Name: idx_18044_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.sequences
    ADD CONSTRAINT idx_18044_primary PRIMARY KEY (name);


--
-- Name: idx_18050_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.sessions
    ADD CONSTRAINT idx_18050_primary PRIMARY KEY (id);


--
-- Name: idx_18057_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.shunnedmessages
    ADD CONSTRAINT idx_18057_primary PRIMARY KEY (id);


--
-- Name: idx_18064_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.sitegroups
    ADD CONSTRAINT idx_18064_primary PRIMARY KEY (id);


--
-- Name: idx_18071_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.sites
    ADD CONSTRAINT idx_18071_primary PRIMARY KEY (id);


--
-- Name: idx_18082_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.structureelements
    ADD CONSTRAINT idx_18082_primary PRIMARY KEY (id);


--
-- Name: idx_18089_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.structures
    ADD CONSTRAINT idx_18089_primary PRIMARY KEY (id);


--
-- Name: idx_18096_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.systemmessages
    ADD CONSTRAINT idx_18096_primary PRIMARY KEY (id);


--
-- Name: idx_18106_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.systemsettings
    ADD CONSTRAINT idx_18106_primary PRIMARY KEY (id);


--
-- Name: idx_18116_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.taggroups
    ADD CONSTRAINT idx_18116_primary PRIMARY KEY (id);


--
-- Name: idx_18124_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.tags
    ADD CONSTRAINT idx_18124_primary PRIMARY KEY (id);


--
-- Name: idx_18133_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.templatecachequeries
    ADD CONSTRAINT idx_18133_primary PRIMARY KEY (id);


--
-- Name: idx_18142_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.templatecaches
    ADD CONSTRAINT idx_18142_primary PRIMARY KEY (id);


--
-- Name: idx_18151_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.tokens
    ADD CONSTRAINT idx_18151_primary PRIMARY KEY (id);


--
-- Name: idx_18161_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.usergroups
    ADD CONSTRAINT idx_18161_primary PRIMARY KEY (id);


--
-- Name: idx_18171_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.usergroups_users
    ADD CONSTRAINT idx_18171_primary PRIMARY KEY (id);


--
-- Name: idx_18178_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.userpermissions
    ADD CONSTRAINT idx_18178_primary PRIMARY KEY (id);


--
-- Name: idx_18185_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.userpermissions_usergroups
    ADD CONSTRAINT idx_18185_primary PRIMARY KEY (id);


--
-- Name: idx_18192_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.userpermissions_users
    ADD CONSTRAINT idx_18192_primary PRIMARY KEY (id);


--
-- Name: idx_18199_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.userpreferences
    ADD CONSTRAINT idx_18199_primary PRIMARY KEY (userid);


--
-- Name: idx_18206_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.users
    ADD CONSTRAINT idx_18206_primary PRIMARY KEY (id);


--
-- Name: idx_18221_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.volumefolders
    ADD CONSTRAINT idx_18221_primary PRIMARY KEY (id);


--
-- Name: idx_18231_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.volumes
    ADD CONSTRAINT idx_18231_primary PRIMARY KEY (id);


--
-- Name: idx_18242_primary; Type: CONSTRAINT; Schema: temp; Owner: craft3; Tablespace: 
--

ALTER TABLE ONLY temp.widgets
    ADD CONSTRAINT idx_18242_primary PRIMARY KEY (id);


--
-- Name: idx_17717_assetindexdata_sessionid_volumeid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17717_assetindexdata_sessionid_volumeid_idx ON temp.assetindexdata USING btree (sessionid, volumeid);


--
-- Name: idx_17717_assetindexdata_volumeid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17717_assetindexdata_volumeid_idx ON temp.assetindexdata USING btree (volumeid);


--
-- Name: idx_17728_assets_filename_folderid_unq_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE UNIQUE INDEX idx_17728_assets_filename_folderid_unq_idx ON temp.assets USING btree (filename, folderid);


--
-- Name: idx_17728_assets_folderid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17728_assets_folderid_idx ON temp.assets USING btree (folderid);


--
-- Name: idx_17728_assets_volumeid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17728_assets_volumeid_idx ON temp.assets USING btree (volumeid);


--
-- Name: idx_17738_assettransformindex_volumeid_assetid_location_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17738_assettransformindex_volumeid_assetid_location_idx ON temp.assettransformindex USING btree (volumeid, assetid, location);


--
-- Name: idx_17750_assettransforms_handle_unq_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE UNIQUE INDEX idx_17750_assettransforms_handle_unq_idx ON temp.assettransforms USING btree (handle);


--
-- Name: idx_17750_assettransforms_name_unq_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE UNIQUE INDEX idx_17750_assettransforms_name_unq_idx ON temp.assettransforms USING btree (name);


--
-- Name: idx_17761_categories_groupid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17761_categories_groupid_idx ON temp.categories USING btree (groupid);


--
-- Name: idx_17767_categorygroups_fieldlayoutid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17767_categorygroups_fieldlayoutid_idx ON temp.categorygroups USING btree (fieldlayoutid);


--
-- Name: idx_17767_categorygroups_handle_unq_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE UNIQUE INDEX idx_17767_categorygroups_handle_unq_idx ON temp.categorygroups USING btree (handle);


--
-- Name: idx_17767_categorygroups_name_unq_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE UNIQUE INDEX idx_17767_categorygroups_name_unq_idx ON temp.categorygroups USING btree (name);


--
-- Name: idx_17767_categorygroups_structureid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17767_categorygroups_structureid_idx ON temp.categorygroups USING btree (structureid);


--
-- Name: idx_17777_categorygroups_sites_groupid_siteid_unq_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE UNIQUE INDEX idx_17777_categorygroups_sites_groupid_siteid_unq_idx ON temp.categorygroups_sites USING btree (groupid, siteid);


--
-- Name: idx_17777_categorygroups_sites_siteid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17777_categorygroups_sites_siteid_idx ON temp.categorygroups_sites USING btree (siteid);


--
-- Name: idx_17788_content_elementid_siteid_unq_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE UNIQUE INDEX idx_17788_content_elementid_siteid_unq_idx ON temp.content USING btree (elementid, siteid);


--
-- Name: idx_17788_content_siteid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17788_content_siteid_idx ON temp.content USING btree (siteid);


--
-- Name: idx_17788_content_title_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17788_content_title_idx ON temp.content USING btree (title);


--
-- Name: idx_17798_craftidtokens_userid_fk; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17798_craftidtokens_userid_fk ON temp.craftidtokens USING btree (userid);


--
-- Name: idx_17808_deprecationerrors_key_fingerprint_unq_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE UNIQUE INDEX idx_17808_deprecationerrors_key_fingerprint_unq_idx ON temp.deprecationerrors USING btree (key, fingerprint);


--
-- Name: idx_17818_elementindexsettings_type_unq_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE UNIQUE INDEX idx_17818_elementindexsettings_type_unq_idx ON temp.elementindexsettings USING btree (type);


--
-- Name: idx_17828_elements_archived_datecreated_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17828_elements_archived_datecreated_idx ON temp.elements USING btree (archived, datecreated);


--
-- Name: idx_17828_elements_enabled_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17828_elements_enabled_idx ON temp.elements USING btree (enabled);


--
-- Name: idx_17828_elements_fieldlayoutid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17828_elements_fieldlayoutid_idx ON temp.elements USING btree (fieldlayoutid);


--
-- Name: idx_17828_elements_type_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17828_elements_type_idx ON temp.elements USING btree (type);


--
-- Name: idx_17837_elements_sites_elementid_siteid_unq_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE UNIQUE INDEX idx_17837_elements_sites_elementid_siteid_unq_idx ON temp.elements_sites USING btree (elementid, siteid);


--
-- Name: idx_17837_elements_sites_enabled_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17837_elements_sites_enabled_idx ON temp.elements_sites USING btree (enabled);


--
-- Name: idx_17837_elements_sites_siteid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17837_elements_sites_siteid_idx ON temp.elements_sites USING btree (siteid);


--
-- Name: idx_17837_elements_sites_slug_siteid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17837_elements_sites_slug_siteid_idx ON temp.elements_sites USING btree (slug, siteid);


--
-- Name: idx_17837_elements_sites_uri_siteid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17837_elements_sites_uri_siteid_idx ON temp.elements_sites USING btree (uri, siteid);


--
-- Name: idx_17846_entries_authorid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17846_entries_authorid_idx ON temp.entries USING btree (authorid);


--
-- Name: idx_17846_entries_expirydate_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17846_entries_expirydate_idx ON temp.entries USING btree (expirydate);


--
-- Name: idx_17846_entries_postdate_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17846_entries_postdate_idx ON temp.entries USING btree (postdate);


--
-- Name: idx_17846_entries_sectionid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17846_entries_sectionid_idx ON temp.entries USING btree (sectionid);


--
-- Name: idx_17846_entries_typeid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17846_entries_typeid_idx ON temp.entries USING btree (typeid);


--
-- Name: idx_17852_entrydrafts_creatorid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17852_entrydrafts_creatorid_idx ON temp.entrydrafts USING btree (creatorid);


--
-- Name: idx_17852_entrydrafts_entryid_siteid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17852_entrydrafts_entryid_siteid_idx ON temp.entrydrafts USING btree (entryid, siteid);


--
-- Name: idx_17852_entrydrafts_sectionid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17852_entrydrafts_sectionid_idx ON temp.entrydrafts USING btree (sectionid);


--
-- Name: idx_17852_entrydrafts_siteid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17852_entrydrafts_siteid_idx ON temp.entrydrafts USING btree (siteid);


--
-- Name: idx_17862_entrytypes_fieldlayoutid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17862_entrytypes_fieldlayoutid_idx ON temp.entrytypes USING btree (fieldlayoutid);


--
-- Name: idx_17862_entrytypes_handle_sectionid_unq_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE UNIQUE INDEX idx_17862_entrytypes_handle_sectionid_unq_idx ON temp.entrytypes USING btree (handle, sectionid);


--
-- Name: idx_17862_entrytypes_name_sectionid_unq_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE UNIQUE INDEX idx_17862_entrytypes_name_sectionid_unq_idx ON temp.entrytypes USING btree (name, sectionid);


--
-- Name: idx_17862_entrytypes_sectionid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17862_entrytypes_sectionid_idx ON temp.entrytypes USING btree (sectionid);


--
-- Name: idx_17874_entryversions_creatorid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17874_entryversions_creatorid_idx ON temp.entryversions USING btree (creatorid);


--
-- Name: idx_17874_entryversions_entryid_siteid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17874_entryversions_entryid_siteid_idx ON temp.entryversions USING btree (entryid, siteid);


--
-- Name: idx_17874_entryversions_sectionid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17874_entryversions_sectionid_idx ON temp.entryversions USING btree (sectionid);


--
-- Name: idx_17874_entryversions_siteid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17874_entryversions_siteid_idx ON temp.entryversions USING btree (siteid);


--
-- Name: idx_17884_fieldgroups_name_unq_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE UNIQUE INDEX idx_17884_fieldgroups_name_unq_idx ON temp.fieldgroups USING btree (name);


--
-- Name: idx_17891_fieldlayoutfields_fieldid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17891_fieldlayoutfields_fieldid_idx ON temp.fieldlayoutfields USING btree (fieldid);


--
-- Name: idx_17891_fieldlayoutfields_layoutid_fieldid_unq_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE UNIQUE INDEX idx_17891_fieldlayoutfields_layoutid_fieldid_unq_idx ON temp.fieldlayoutfields USING btree (layoutid, fieldid);


--
-- Name: idx_17891_fieldlayoutfields_sortorder_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17891_fieldlayoutfields_sortorder_idx ON temp.fieldlayoutfields USING btree (sortorder);


--
-- Name: idx_17891_fieldlayoutfields_tabid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17891_fieldlayoutfields_tabid_idx ON temp.fieldlayoutfields USING btree (tabid);


--
-- Name: idx_17899_fieldlayouts_type_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17899_fieldlayouts_type_idx ON temp.fieldlayouts USING btree (type);


--
-- Name: idx_17906_fieldlayouttabs_layoutid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17906_fieldlayouttabs_layoutid_idx ON temp.fieldlayouttabs USING btree (layoutid);


--
-- Name: idx_17906_fieldlayouttabs_sortorder_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17906_fieldlayouttabs_sortorder_idx ON temp.fieldlayouttabs USING btree (sortorder);


--
-- Name: idx_17913_fields_context_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17913_fields_context_idx ON temp.fields USING btree (context);


--
-- Name: idx_17913_fields_groupid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17913_fields_groupid_idx ON temp.fields USING btree (groupid);


--
-- Name: idx_17913_fields_handle_context_unq_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE UNIQUE INDEX idx_17913_fields_handle_context_unq_idx ON temp.fields USING btree (handle, context);


--
-- Name: idx_17925_globalsets_fieldlayoutid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17925_globalsets_fieldlayoutid_idx ON temp.globalsets USING btree (fieldlayoutid);


--
-- Name: idx_17925_globalsets_handle_unq_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE UNIQUE INDEX idx_17925_globalsets_handle_unq_idx ON temp.globalsets USING btree (handle);


--
-- Name: idx_17925_globalsets_name_unq_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE UNIQUE INDEX idx_17925_globalsets_name_unq_idx ON temp.globalsets USING btree (name);


--
-- Name: idx_17943_matrixblocks_fieldid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17943_matrixblocks_fieldid_idx ON temp.matrixblocks USING btree (fieldid);


--
-- Name: idx_17943_matrixblocks_ownerid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17943_matrixblocks_ownerid_idx ON temp.matrixblocks USING btree (ownerid);


--
-- Name: idx_17943_matrixblocks_ownersiteid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17943_matrixblocks_ownersiteid_idx ON temp.matrixblocks USING btree (ownersiteid);


--
-- Name: idx_17943_matrixblocks_sortorder_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17943_matrixblocks_sortorder_idx ON temp.matrixblocks USING btree (sortorder);


--
-- Name: idx_17943_matrixblocks_typeid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17943_matrixblocks_typeid_idx ON temp.matrixblocks USING btree (typeid);


--
-- Name: idx_17949_matrixblocktypes_fieldid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17949_matrixblocktypes_fieldid_idx ON temp.matrixblocktypes USING btree (fieldid);


--
-- Name: idx_17949_matrixblocktypes_fieldlayoutid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17949_matrixblocktypes_fieldlayoutid_idx ON temp.matrixblocktypes USING btree (fieldlayoutid);


--
-- Name: idx_17949_matrixblocktypes_handle_fieldid_unq_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE UNIQUE INDEX idx_17949_matrixblocktypes_handle_fieldid_unq_idx ON temp.matrixblocktypes USING btree (handle, fieldid);


--
-- Name: idx_17949_matrixblocktypes_name_fieldid_unq_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE UNIQUE INDEX idx_17949_matrixblocktypes_name_fieldid_unq_idx ON temp.matrixblocktypes USING btree (name, fieldid);


--
-- Name: idx_17959_migrations_pluginid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17959_migrations_pluginid_idx ON temp.migrations USING btree (pluginid);


--
-- Name: idx_17959_migrations_type_pluginid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17959_migrations_type_pluginid_idx ON temp.migrations USING btree (type, pluginid);


--
-- Name: idx_17967_plugins_enabled_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17967_plugins_enabled_idx ON temp.plugins USING btree (enabled);


--
-- Name: idx_17967_plugins_handle_unq_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE UNIQUE INDEX idx_17967_plugins_handle_unq_idx ON temp.plugins USING btree (handle);


--
-- Name: idx_17979_queue_fail_timeupdated_delay_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17979_queue_fail_timeupdated_delay_idx ON temp.queue USING btree (fail, timeupdated, delay);


--
-- Name: idx_17979_queue_fail_timeupdated_timepushed_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17979_queue_fail_timeupdated_timepushed_idx ON temp.queue USING btree (fail, timeupdated, timepushed);


--
-- Name: idx_17992_relations_fieldid_sourceid_sourcesiteid_targetid_unq_; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE UNIQUE INDEX idx_17992_relations_fieldid_sourceid_sourcesiteid_targetid_unq_ ON temp.relations USING btree (fieldid, sourceid, sourcesiteid, targetid);


--
-- Name: idx_17992_relations_sourceid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17992_relations_sourceid_idx ON temp.relations USING btree (sourceid);


--
-- Name: idx_17992_relations_sourcesiteid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17992_relations_sourcesiteid_idx ON temp.relations USING btree (sourcesiteid);


--
-- Name: idx_17992_relations_targetid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_17992_relations_targetid_idx ON temp.relations USING btree (targetid);


--
-- Name: idx_18005_routes_siteid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_18005_routes_siteid_idx ON temp.routes USING btree (siteid);


--
-- Name: idx_18005_routes_uripattern_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_18005_routes_uripattern_idx ON temp.routes USING btree (uripattern);


--
-- Name: idx_18013_searchindex_keywords_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_18013_searchindex_keywords_idx ON temp.searchindex USING gin (to_tsvector('simple'::regconfig, keywords));


--
-- Name: idx_18021_sections_handle_unq_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE UNIQUE INDEX idx_18021_sections_handle_unq_idx ON temp.sections USING btree (handle);


--
-- Name: idx_18021_sections_name_unq_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE UNIQUE INDEX idx_18021_sections_name_unq_idx ON temp.sections USING btree (name);


--
-- Name: idx_18021_sections_structureid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_18021_sections_structureid_idx ON temp.sections USING btree (structureid);


--
-- Name: idx_18034_sections_sites_sectionid_siteid_unq_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE UNIQUE INDEX idx_18034_sections_sites_sectionid_siteid_unq_idx ON temp.sections_sites USING btree (sectionid, siteid);


--
-- Name: idx_18034_sections_sites_siteid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_18034_sections_sites_siteid_idx ON temp.sections_sites USING btree (siteid);


--
-- Name: idx_18050_sessions_dateupdated_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_18050_sessions_dateupdated_idx ON temp.sessions USING btree (dateupdated);


--
-- Name: idx_18050_sessions_token_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_18050_sessions_token_idx ON temp.sessions USING btree (token);


--
-- Name: idx_18050_sessions_uid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_18050_sessions_uid_idx ON temp.sessions USING btree (uid);


--
-- Name: idx_18050_sessions_userid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_18050_sessions_userid_idx ON temp.sessions USING btree (userid);


--
-- Name: idx_18057_shunnedmessages_userid_message_unq_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE UNIQUE INDEX idx_18057_shunnedmessages_userid_message_unq_idx ON temp.shunnedmessages USING btree (userid, message);


--
-- Name: idx_18064_sitegroups_name_unq_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE UNIQUE INDEX idx_18064_sitegroups_name_unq_idx ON temp.sitegroups USING btree (name);


--
-- Name: idx_18071_sites_groupid_fk; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_18071_sites_groupid_fk ON temp.sites USING btree (groupid);


--
-- Name: idx_18071_sites_handle_unq_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE UNIQUE INDEX idx_18071_sites_handle_unq_idx ON temp.sites USING btree (handle);


--
-- Name: idx_18071_sites_sortorder_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_18071_sites_sortorder_idx ON temp.sites USING btree (sortorder);


--
-- Name: idx_18082_structureelements_elementid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_18082_structureelements_elementid_idx ON temp.structureelements USING btree (elementid);


--
-- Name: idx_18082_structureelements_level_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_18082_structureelements_level_idx ON temp.structureelements USING btree (level);


--
-- Name: idx_18082_structureelements_lft_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_18082_structureelements_lft_idx ON temp.structureelements USING btree (lft);


--
-- Name: idx_18082_structureelements_rgt_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_18082_structureelements_rgt_idx ON temp.structureelements USING btree (rgt);


--
-- Name: idx_18082_structureelements_root_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_18082_structureelements_root_idx ON temp.structureelements USING btree (root);


--
-- Name: idx_18082_structureelements_structureid_elementid_unq_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE UNIQUE INDEX idx_18082_structureelements_structureid_elementid_unq_idx ON temp.structureelements USING btree (structureid, elementid);


--
-- Name: idx_18096_systemmessages_key_language_unq_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE UNIQUE INDEX idx_18096_systemmessages_key_language_unq_idx ON temp.systemmessages USING btree (key, language);


--
-- Name: idx_18096_systemmessages_language_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_18096_systemmessages_language_idx ON temp.systemmessages USING btree (language);


--
-- Name: idx_18106_systemsettings_category_unq_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE UNIQUE INDEX idx_18106_systemsettings_category_unq_idx ON temp.systemsettings USING btree (category);


--
-- Name: idx_18116_taggroups_fieldlayoutid_fk; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_18116_taggroups_fieldlayoutid_fk ON temp.taggroups USING btree (fieldlayoutid);


--
-- Name: idx_18116_taggroups_handle_unq_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE UNIQUE INDEX idx_18116_taggroups_handle_unq_idx ON temp.taggroups USING btree (handle);


--
-- Name: idx_18116_taggroups_name_unq_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE UNIQUE INDEX idx_18116_taggroups_name_unq_idx ON temp.taggroups USING btree (name);


--
-- Name: idx_18124_tags_groupid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_18124_tags_groupid_idx ON temp.tags USING btree (groupid);


--
-- Name: idx_18128_templatecacheelements_cacheid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_18128_templatecacheelements_cacheid_idx ON temp.templatecacheelements USING btree (cacheid);


--
-- Name: idx_18128_templatecacheelements_elementid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_18128_templatecacheelements_elementid_idx ON temp.templatecacheelements USING btree (elementid);


--
-- Name: idx_18133_templatecachequeries_cacheid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_18133_templatecachequeries_cacheid_idx ON temp.templatecachequeries USING btree (cacheid);


--
-- Name: idx_18133_templatecachequeries_type_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_18133_templatecachequeries_type_idx ON temp.templatecachequeries USING btree (type);


--
-- Name: idx_18142_templatecaches_cachekey_siteid_expirydate_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_18142_templatecaches_cachekey_siteid_expirydate_idx ON temp.templatecaches USING btree (cachekey, siteid, expirydate);


--
-- Name: idx_18142_templatecaches_cachekey_siteid_expirydate_path_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_18142_templatecaches_cachekey_siteid_expirydate_path_idx ON temp.templatecaches USING btree (cachekey, siteid, expirydate, path);


--
-- Name: idx_18142_templatecaches_siteid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_18142_templatecaches_siteid_idx ON temp.templatecaches USING btree (siteid);


--
-- Name: idx_18151_tokens_expirydate_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_18151_tokens_expirydate_idx ON temp.tokens USING btree (expirydate);


--
-- Name: idx_18151_tokens_token_unq_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE UNIQUE INDEX idx_18151_tokens_token_unq_idx ON temp.tokens USING btree (token);


--
-- Name: idx_18161_usergroups_handle_unq_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE UNIQUE INDEX idx_18161_usergroups_handle_unq_idx ON temp.usergroups USING btree (handle);


--
-- Name: idx_18161_usergroups_name_unq_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE UNIQUE INDEX idx_18161_usergroups_name_unq_idx ON temp.usergroups USING btree (name);


--
-- Name: idx_18171_usergroups_users_groupid_userid_unq_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE UNIQUE INDEX idx_18171_usergroups_users_groupid_userid_unq_idx ON temp.usergroups_users USING btree (groupid, userid);


--
-- Name: idx_18171_usergroups_users_userid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_18171_usergroups_users_userid_idx ON temp.usergroups_users USING btree (userid);


--
-- Name: idx_18178_userpermissions_name_unq_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE UNIQUE INDEX idx_18178_userpermissions_name_unq_idx ON temp.userpermissions USING btree (name);


--
-- Name: idx_18185_userpermissions_usergroups_groupid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_18185_userpermissions_usergroups_groupid_idx ON temp.userpermissions_usergroups USING btree (groupid);


--
-- Name: idx_18185_userpermissions_usergroups_permissionid_groupid_unq_i; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE UNIQUE INDEX idx_18185_userpermissions_usergroups_permissionid_groupid_unq_i ON temp.userpermissions_usergroups USING btree (permissionid, groupid);


--
-- Name: idx_18192_userpermissions_users_permissionid_userid_unq_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE UNIQUE INDEX idx_18192_userpermissions_users_permissionid_userid_unq_idx ON temp.userpermissions_users USING btree (permissionid, userid);


--
-- Name: idx_18192_userpermissions_users_userid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_18192_userpermissions_users_userid_idx ON temp.userpermissions_users USING btree (userid);


--
-- Name: idx_18206_users_email_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_18206_users_email_idx ON temp.users USING btree (email);


--
-- Name: idx_18206_users_photoid_fk; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_18206_users_photoid_fk ON temp.users USING btree (photoid);


--
-- Name: idx_18206_users_uid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_18206_users_uid_idx ON temp.users USING btree (uid);


--
-- Name: idx_18206_users_username_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_18206_users_username_idx ON temp.users USING btree (username);


--
-- Name: idx_18206_users_verificationcode_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_18206_users_verificationcode_idx ON temp.users USING btree (verificationcode);


--
-- Name: idx_18221_volumefolders_name_parentid_volumeid_unq_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE UNIQUE INDEX idx_18221_volumefolders_name_parentid_volumeid_unq_idx ON temp.volumefolders USING btree (name, parentid, volumeid);


--
-- Name: idx_18221_volumefolders_parentid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_18221_volumefolders_parentid_idx ON temp.volumefolders USING btree (parentid);


--
-- Name: idx_18221_volumefolders_volumeid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_18221_volumefolders_volumeid_idx ON temp.volumefolders USING btree (volumeid);


--
-- Name: idx_18231_volumes_fieldlayoutid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_18231_volumes_fieldlayoutid_idx ON temp.volumes USING btree (fieldlayoutid);


--
-- Name: idx_18231_volumes_handle_unq_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE UNIQUE INDEX idx_18231_volumes_handle_unq_idx ON temp.volumes USING btree (handle);


--
-- Name: idx_18231_volumes_name_unq_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE UNIQUE INDEX idx_18231_volumes_name_unq_idx ON temp.volumes USING btree (name);


--
-- Name: idx_18242_widgets_userid_idx; Type: INDEX; Schema: temp; Owner: craft3; Tablespace: 
--

CREATE INDEX idx_18242_widgets_userid_idx ON temp.widgets USING btree (userid);


--
-- Name: assetindexdata_volumeid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.assetindexdata
    ADD CONSTRAINT assetindexdata_volumeid_fk FOREIGN KEY (volumeid) REFERENCES temp.volumes(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: assets_folderid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.assets
    ADD CONSTRAINT assets_folderid_fk FOREIGN KEY (folderid) REFERENCES temp.volumefolders(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: assets_id_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.assets
    ADD CONSTRAINT assets_id_fk FOREIGN KEY (id) REFERENCES temp.elements(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: assets_volumeid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.assets
    ADD CONSTRAINT assets_volumeid_fk FOREIGN KEY (volumeid) REFERENCES temp.volumes(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: categories_groupid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.categories
    ADD CONSTRAINT categories_groupid_fk FOREIGN KEY (groupid) REFERENCES temp.categorygroups(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: categories_id_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.categories
    ADD CONSTRAINT categories_id_fk FOREIGN KEY (id) REFERENCES temp.elements(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: categorygroups_fieldlayoutid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.categorygroups
    ADD CONSTRAINT categorygroups_fieldlayoutid_fk FOREIGN KEY (fieldlayoutid) REFERENCES temp.fieldlayouts(id) ON UPDATE RESTRICT ON DELETE SET NULL;


--
-- Name: categorygroups_sites_groupid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.categorygroups_sites
    ADD CONSTRAINT categorygroups_sites_groupid_fk FOREIGN KEY (groupid) REFERENCES temp.categorygroups(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: categorygroups_sites_siteid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.categorygroups_sites
    ADD CONSTRAINT categorygroups_sites_siteid_fk FOREIGN KEY (siteid) REFERENCES temp.sites(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: categorygroups_structureid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.categorygroups
    ADD CONSTRAINT categorygroups_structureid_fk FOREIGN KEY (structureid) REFERENCES temp.structures(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: content_elementid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.content
    ADD CONSTRAINT content_elementid_fk FOREIGN KEY (elementid) REFERENCES temp.elements(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: content_siteid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.content
    ADD CONSTRAINT content_siteid_fk FOREIGN KEY (siteid) REFERENCES temp.sites(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: craftidtokens_userid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.craftidtokens
    ADD CONSTRAINT craftidtokens_userid_fk FOREIGN KEY (userid) REFERENCES temp.users(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: elements_fieldlayoutid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.elements
    ADD CONSTRAINT elements_fieldlayoutid_fk FOREIGN KEY (fieldlayoutid) REFERENCES temp.fieldlayouts(id) ON UPDATE RESTRICT ON DELETE SET NULL;


--
-- Name: elements_sites_elementid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.elements_sites
    ADD CONSTRAINT elements_sites_elementid_fk FOREIGN KEY (elementid) REFERENCES temp.elements(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: elements_sites_siteid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.elements_sites
    ADD CONSTRAINT elements_sites_siteid_fk FOREIGN KEY (siteid) REFERENCES temp.sites(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: entries_authorid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.entries
    ADD CONSTRAINT entries_authorid_fk FOREIGN KEY (authorid) REFERENCES temp.users(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: entries_id_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.entries
    ADD CONSTRAINT entries_id_fk FOREIGN KEY (id) REFERENCES temp.elements(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: entries_sectionid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.entries
    ADD CONSTRAINT entries_sectionid_fk FOREIGN KEY (sectionid) REFERENCES temp.sections(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: entries_typeid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.entries
    ADD CONSTRAINT entries_typeid_fk FOREIGN KEY (typeid) REFERENCES temp.entrytypes(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: entrydrafts_creatorid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.entrydrafts
    ADD CONSTRAINT entrydrafts_creatorid_fk FOREIGN KEY (creatorid) REFERENCES temp.users(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: entrydrafts_entryid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.entrydrafts
    ADD CONSTRAINT entrydrafts_entryid_fk FOREIGN KEY (entryid) REFERENCES temp.entries(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: entrydrafts_sectionid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.entrydrafts
    ADD CONSTRAINT entrydrafts_sectionid_fk FOREIGN KEY (sectionid) REFERENCES temp.sections(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: entrydrafts_siteid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.entrydrafts
    ADD CONSTRAINT entrydrafts_siteid_fk FOREIGN KEY (siteid) REFERENCES temp.sites(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: entrytypes_fieldlayoutid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.entrytypes
    ADD CONSTRAINT entrytypes_fieldlayoutid_fk FOREIGN KEY (fieldlayoutid) REFERENCES temp.fieldlayouts(id) ON UPDATE RESTRICT ON DELETE SET NULL;


--
-- Name: entrytypes_sectionid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.entrytypes
    ADD CONSTRAINT entrytypes_sectionid_fk FOREIGN KEY (sectionid) REFERENCES temp.sections(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: entryversions_creatorid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.entryversions
    ADD CONSTRAINT entryversions_creatorid_fk FOREIGN KEY (creatorid) REFERENCES temp.users(id) ON UPDATE RESTRICT ON DELETE SET NULL;


--
-- Name: entryversions_entryid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.entryversions
    ADD CONSTRAINT entryversions_entryid_fk FOREIGN KEY (entryid) REFERENCES temp.entries(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: entryversions_sectionid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.entryversions
    ADD CONSTRAINT entryversions_sectionid_fk FOREIGN KEY (sectionid) REFERENCES temp.sections(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: entryversions_siteid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.entryversions
    ADD CONSTRAINT entryversions_siteid_fk FOREIGN KEY (siteid) REFERENCES temp.sites(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fieldlayoutfields_fieldid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.fieldlayoutfields
    ADD CONSTRAINT fieldlayoutfields_fieldid_fk FOREIGN KEY (fieldid) REFERENCES temp.fields(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: fieldlayoutfields_layoutid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.fieldlayoutfields
    ADD CONSTRAINT fieldlayoutfields_layoutid_fk FOREIGN KEY (layoutid) REFERENCES temp.fieldlayouts(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: fieldlayoutfields_tabid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.fieldlayoutfields
    ADD CONSTRAINT fieldlayoutfields_tabid_fk FOREIGN KEY (tabid) REFERENCES temp.fieldlayouttabs(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: fieldlayouttabs_layoutid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.fieldlayouttabs
    ADD CONSTRAINT fieldlayouttabs_layoutid_fk FOREIGN KEY (layoutid) REFERENCES temp.fieldlayouts(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: fields_groupid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.fields
    ADD CONSTRAINT fields_groupid_fk FOREIGN KEY (groupid) REFERENCES temp.fieldgroups(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: globalsets_fieldlayoutid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.globalsets
    ADD CONSTRAINT globalsets_fieldlayoutid_fk FOREIGN KEY (fieldlayoutid) REFERENCES temp.fieldlayouts(id) ON UPDATE RESTRICT ON DELETE SET NULL;


--
-- Name: globalsets_id_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.globalsets
    ADD CONSTRAINT globalsets_id_fk FOREIGN KEY (id) REFERENCES temp.elements(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: matrixblocks_fieldid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.matrixblocks
    ADD CONSTRAINT matrixblocks_fieldid_fk FOREIGN KEY (fieldid) REFERENCES temp.fields(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: matrixblocks_id_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.matrixblocks
    ADD CONSTRAINT matrixblocks_id_fk FOREIGN KEY (id) REFERENCES temp.elements(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: matrixblocks_ownerid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.matrixblocks
    ADD CONSTRAINT matrixblocks_ownerid_fk FOREIGN KEY (ownerid) REFERENCES temp.elements(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: matrixblocks_ownersiteid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.matrixblocks
    ADD CONSTRAINT matrixblocks_ownersiteid_fk FOREIGN KEY (ownersiteid) REFERENCES temp.sites(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: matrixblocks_typeid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.matrixblocks
    ADD CONSTRAINT matrixblocks_typeid_fk FOREIGN KEY (typeid) REFERENCES temp.matrixblocktypes(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: matrixblocktypes_fieldid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.matrixblocktypes
    ADD CONSTRAINT matrixblocktypes_fieldid_fk FOREIGN KEY (fieldid) REFERENCES temp.fields(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: matrixblocktypes_fieldlayoutid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.matrixblocktypes
    ADD CONSTRAINT matrixblocktypes_fieldlayoutid_fk FOREIGN KEY (fieldlayoutid) REFERENCES temp.fieldlayouts(id) ON UPDATE RESTRICT ON DELETE SET NULL;


--
-- Name: migrations_pluginid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.migrations
    ADD CONSTRAINT migrations_pluginid_fk FOREIGN KEY (pluginid) REFERENCES temp.plugins(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: relations_fieldid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.relations
    ADD CONSTRAINT relations_fieldid_fk FOREIGN KEY (fieldid) REFERENCES temp.fields(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: relations_sourceid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.relations
    ADD CONSTRAINT relations_sourceid_fk FOREIGN KEY (sourceid) REFERENCES temp.elements(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: relations_sourcesiteid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.relations
    ADD CONSTRAINT relations_sourcesiteid_fk FOREIGN KEY (sourcesiteid) REFERENCES temp.sites(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: relations_targetid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.relations
    ADD CONSTRAINT relations_targetid_fk FOREIGN KEY (targetid) REFERENCES temp.elements(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: routes_siteid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.routes
    ADD CONSTRAINT routes_siteid_fk FOREIGN KEY (siteid) REFERENCES temp.sites(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sections_sites_sectionid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.sections_sites
    ADD CONSTRAINT sections_sites_sectionid_fk FOREIGN KEY (sectionid) REFERENCES temp.sections(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: sections_sites_siteid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.sections_sites
    ADD CONSTRAINT sections_sites_siteid_fk FOREIGN KEY (siteid) REFERENCES temp.sites(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sections_structureid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.sections
    ADD CONSTRAINT sections_structureid_fk FOREIGN KEY (structureid) REFERENCES temp.structures(id) ON UPDATE RESTRICT ON DELETE SET NULL;


--
-- Name: sessions_userid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.sessions
    ADD CONSTRAINT sessions_userid_fk FOREIGN KEY (userid) REFERENCES temp.users(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: shunnedmessages_userid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.shunnedmessages
    ADD CONSTRAINT shunnedmessages_userid_fk FOREIGN KEY (userid) REFERENCES temp.users(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: sites_groupid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.sites
    ADD CONSTRAINT sites_groupid_fk FOREIGN KEY (groupid) REFERENCES temp.sitegroups(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: structureelements_elementid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.structureelements
    ADD CONSTRAINT structureelements_elementid_fk FOREIGN KEY (elementid) REFERENCES temp.elements(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: structureelements_structureid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.structureelements
    ADD CONSTRAINT structureelements_structureid_fk FOREIGN KEY (structureid) REFERENCES temp.structures(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: taggroups_fieldlayoutid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.taggroups
    ADD CONSTRAINT taggroups_fieldlayoutid_fk FOREIGN KEY (fieldlayoutid) REFERENCES temp.fieldlayouts(id) ON UPDATE RESTRICT ON DELETE SET NULL;


--
-- Name: tags_groupid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.tags
    ADD CONSTRAINT tags_groupid_fk FOREIGN KEY (groupid) REFERENCES temp.taggroups(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: tags_id_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.tags
    ADD CONSTRAINT tags_id_fk FOREIGN KEY (id) REFERENCES temp.elements(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: templatecacheelements_cacheid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.templatecacheelements
    ADD CONSTRAINT templatecacheelements_cacheid_fk FOREIGN KEY (cacheid) REFERENCES temp.templatecaches(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: templatecacheelements_elementid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.templatecacheelements
    ADD CONSTRAINT templatecacheelements_elementid_fk FOREIGN KEY (elementid) REFERENCES temp.elements(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: templatecachequeries_cacheid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.templatecachequeries
    ADD CONSTRAINT templatecachequeries_cacheid_fk FOREIGN KEY (cacheid) REFERENCES temp.templatecaches(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: templatecaches_siteid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.templatecaches
    ADD CONSTRAINT templatecaches_siteid_fk FOREIGN KEY (siteid) REFERENCES temp.sites(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: usergroups_users_groupid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.usergroups_users
    ADD CONSTRAINT usergroups_users_groupid_fk FOREIGN KEY (groupid) REFERENCES temp.usergroups(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: usergroups_users_userid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.usergroups_users
    ADD CONSTRAINT usergroups_users_userid_fk FOREIGN KEY (userid) REFERENCES temp.users(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: userpermissions_usergroups_groupid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.userpermissions_usergroups
    ADD CONSTRAINT userpermissions_usergroups_groupid_fk FOREIGN KEY (groupid) REFERENCES temp.usergroups(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: userpermissions_usergroups_permissionid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.userpermissions_usergroups
    ADD CONSTRAINT userpermissions_usergroups_permissionid_fk FOREIGN KEY (permissionid) REFERENCES temp.userpermissions(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: userpermissions_users_permissionid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.userpermissions_users
    ADD CONSTRAINT userpermissions_users_permissionid_fk FOREIGN KEY (permissionid) REFERENCES temp.userpermissions(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: userpermissions_users_userid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.userpermissions_users
    ADD CONSTRAINT userpermissions_users_userid_fk FOREIGN KEY (userid) REFERENCES temp.users(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: userpreferences_userid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.userpreferences
    ADD CONSTRAINT userpreferences_userid_fk FOREIGN KEY (userid) REFERENCES temp.users(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: users_id_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.users
    ADD CONSTRAINT users_id_fk FOREIGN KEY (id) REFERENCES temp.elements(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: users_photoid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.users
    ADD CONSTRAINT users_photoid_fk FOREIGN KEY (photoid) REFERENCES temp.assets(id) ON UPDATE RESTRICT ON DELETE SET NULL;


--
-- Name: volumefolders_parentid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.volumefolders
    ADD CONSTRAINT volumefolders_parentid_fk FOREIGN KEY (parentid) REFERENCES temp.volumefolders(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: volumefolders_volumeid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.volumefolders
    ADD CONSTRAINT volumefolders_volumeid_fk FOREIGN KEY (volumeid) REFERENCES temp.volumes(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: volumes_fieldlayoutid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.volumes
    ADD CONSTRAINT volumes_fieldlayoutid_fk FOREIGN KEY (fieldlayoutid) REFERENCES temp.fieldlayouts(id) ON UPDATE RESTRICT ON DELETE SET NULL;


--
-- Name: widgets_userid_fk; Type: FK CONSTRAINT; Schema: temp; Owner: craft3
--

ALTER TABLE ONLY temp.widgets
    ADD CONSTRAINT widgets_userid_fk FOREIGN KEY (userid) REFERENCES temp.users(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM craft3;
GRANT ALL ON SCHEMA public TO craft3;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

