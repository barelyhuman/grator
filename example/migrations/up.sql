CREATE FUNCTION public.set_current_timestamp_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  _new record;
BEGIN
  _new := NEW;
  _new."updated_at" = NOW();
  RETURN _new;
END;
$$;
CREATE TABLE public.access_token (
    id integer NOT NULL,
    access_token text,
    login_secret text NOT NULL,
    user_id integer NOT NULL,
    expiry timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);
CREATE SEQUENCE public.access_token_id_seq
    START WITH 8
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;
ALTER SEQUENCE public.access_token_id_seq OWNED BY public.access_token.id;
CREATE TABLE public.address (
    id integer NOT NULL,
    state text NOT NULL,
    city text NOT NULL,
    zipcode text NOT NULL,
    street text NOT NULL,
    country text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);
CREATE SEQUENCE public.address_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;
ALTER SEQUENCE public.address_id_seq OWNED BY public.address.id;
CREATE TABLE public.alert (
    id integer NOT NULL,
    user_id integer NOT NULL,
    created_by_id integer NOT NULL,
    message text NOT NULL,
    type_id integer NOT NULL,
    is_read boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    meta jsonb
);
CREATE SEQUENCE public.alert_id_seq
    START WITH 3
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;
ALTER SEQUENCE public.alert_id_seq OWNED BY public.alert.id;
CREATE TABLE public.customer_setting (
    receive_post_notification boolean DEFAULT true NOT NULL,
    receive_network_notification boolean DEFAULT true NOT NULL,
    user_id integer NOT NULL,
    id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone NOT NULL
);
CREATE SEQUENCE public.customer_notification_settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;
ALTER SEQUENCE public.customer_notification_settings_id_seq OWNED BY public.customer_setting.id;
CREATE TABLE public.customer_profile (
    id integer NOT NULL,
    user_id integer NOT NULL,
    age integer NOT NULL,
    gender_id integer NOT NULL,
    bank_id integer NOT NULL,
    account_number text NOT NULL,
    job_title_id integer NOT NULL,
    school_name text,
    graduation_year text,
    travel_for_work_id integer NOT NULL,
    bio text,
    profile_picture_id integer,
    address_id integer NOT NULL,
    preferred_working_cities text[] NOT NULL,
    working_hours_per_week_id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);
CREATE SEQUENCE public.customer_profile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;
ALTER SEQUENCE public.customer_profile_id_seq OWNED BY public.customer_profile.id;
CREATE TABLE public.cities (
    id integer NOT NULL,
    city text NOT NULL
);
CREATE SEQUENCE public.cities_id_seq
    START WITH 28338
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;
ALTER SEQUENCE public.cities_id_seq OWNED BY public.cities.id;
CREATE SEQUENCE public.cities_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.cities_id_seq1 OWNED BY public.cities.id;
CREATE TABLE public.files (
    id integer NOT NULL,
    name text,
    container_name text,
    path text,
    file_destination text,
    type text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    entity_type text NOT NULL,
    entity_id integer NOT NULL
);
CREATE SEQUENCE public.files_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.files_id_seq OWNED BY public.files.id;
CREATE TABLE public.jobs (
    id integer NOT NULL,
    title text NOT NULL,
    additional_skills text[] NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone NOT NULL
);
CREATE SEQUENCE public.jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;
ALTER SEQUENCE public.jobs_id_seq OWNED BY public.jobs.id;
CREATE TABLE public.jobs_skills (
    id integer NOT NULL,
    skill_id integer NOT NULL,
    job_id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone NOT NULL
);
CREATE SEQUENCE public.jobs_skills_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;
ALTER SEQUENCE public.jobs_skills_id_seq OWNED BY public.jobs_skills.id;
CREATE TABLE public.my_team (
    id integer NOT NULL,
    referred_by_id integer NOT NULL,
    referred_to_id integer NOT NULL,
    referral_type_id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    invited_by_sp_status_id integer DEFAULT 17 NOT NULL,
    invited_by_id integer
);
CREATE SEQUENCE public.my_team_id_seq
    START WITH 12
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;
ALTER SEQUENCE public.my_team_id_seq OWNED BY public.my_team.id;
CREATE TABLE public.options (
    value integer NOT NULL,
    label text NOT NULL,
    sequence integer NOT NULL,
    identifier text NOT NULL,
    id integer NOT NULL
);
CREATE SEQUENCE public.options_id_seq
    START WITH 43
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;
ALTER SEQUENCE public.options_id_seq OWNED BY public.options.id;
CREATE TABLE public.roles (
    id integer NOT NULL,
    role text NOT NULL
);
CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;
ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;
CREATE TABLE public.service_provider_employee (
    id integer NOT NULL,
    service_provider_id integer NOT NULL,
    employee_id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);
CREATE SEQUENCE public.service_provider_employee_id_seq
    START WITH 2
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;
ALTER SEQUENCE public.service_provider_employee_id_seq OWNED BY public.service_provider_employee.id;
CREATE TABLE public.service_provider_profile (
    id integer NOT NULL,
    company_name text NOT NULL,
    service_provider_id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);
CREATE SEQUENCE public.service_provider_profile_id_seq
    START WITH 2
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;
ALTER SEQUENCE public.service_provider_profile_id_seq OWNED BY public.service_provider_profile.id;
CREATE TABLE public.service_provider_staff (
    id integer NOT NULL,
    sp_admin_id integer NOT NULL,
    sp_staff_id integer NOT NULL,
    send_email_notification boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    deactivated boolean DEFAULT false NOT NULL,
    invite_status_id integer NOT NULL
);
CREATE SEQUENCE public.service_provider_staff_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;
ALTER SEQUENCE public.service_provider_staff_id_seq OWNED BY public.service_provider_staff.id;
CREATE TABLE public.skills (
    id integer NOT NULL,
    skill text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    deleted_at timestamp with time zone
);
CREATE SEQUENCE public.skills_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;
ALTER SEQUENCE public.skills_id_seq OWNED BY public.skills.id;
CREATE TABLE public."user" (
    id integer NOT NULL,
    mobile_no text NOT NULL,
    mobile_country_code text NOT NULL,
    mobile_verified boolean DEFAULT false NOT NULL,
    first_name text,
    last_name text,
    email text,
    password text,
    email_verified boolean DEFAULT false NOT NULL,
    terms_and_condition boolean DEFAULT false NOT NULL,
    invite_code text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    role_id integer,
    platform_role_id integer,
    invited_by_sp boolean DEFAULT false NOT NULL,
    heard_about_us_id integer,
    hashed_password text
);
CREATE TABLE public.user_connections (
    id integer NOT NULL,
    connection_request_recieved_by integer NOT NULL,
    connection_request_sent_by integer NOT NULL,
    connection_request_status integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);
CREATE SEQUENCE public.user_connections_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;
ALTER SEQUENCE public.user_connections_id_seq OWNED BY public.user_connections.id;
CREATE SEQUENCE public.user_id_seq
    START WITH 29
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;
ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;
CREATE TABLE public.user_skills (
    id integer NOT NULL,
    skill_id integer,
    user_id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    additional_skills text[]
);
CREATE SEQUENCE public.user_skills_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;
ALTER SEQUENCE public.user_skills_id_seq OWNED BY public.user_skills.id;
CREATE TABLE public.working_hours_per_week (
    label text NOT NULL,
    min_value integer NOT NULL,
    max_value integer NOT NULL,
    id integer NOT NULL
);
CREATE SEQUENCE public.working_hours_per_week_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;
ALTER SEQUENCE public.working_hours_per_week_id_seq OWNED BY public.working_hours_per_week.id;
ALTER TABLE ONLY public.access_token ALTER COLUMN id SET DEFAULT nextval('public.access_token_id_seq'::regclass);
ALTER TABLE ONLY public.address ALTER COLUMN id SET DEFAULT nextval('public.address_id_seq'::regclass);
ALTER TABLE ONLY public.alert ALTER COLUMN id SET DEFAULT nextval('public.alert_id_seq'::regclass);
ALTER TABLE ONLY public.customer_profile ALTER COLUMN id SET DEFAULT nextval('public.customer_profile_id_seq'::regclass);
ALTER TABLE ONLY public.customer_setting ALTER COLUMN id SET DEFAULT nextval('public.customer_notification_settings_id_seq'::regclass);
ALTER TABLE ONLY public.cities ALTER COLUMN id SET DEFAULT nextval('public.cities_id_seq'::regclass);
ALTER TABLE ONLY public.files ALTER COLUMN id SET DEFAULT nextval('public.files_id_seq'::regclass);
ALTER TABLE ONLY public.jobs ALTER COLUMN id SET DEFAULT nextval('public.jobs_id_seq'::regclass);
ALTER TABLE ONLY public.jobs_skills ALTER COLUMN id SET DEFAULT nextval('public.jobs_skills_id_seq'::regclass);
ALTER TABLE ONLY public.my_team ALTER COLUMN id SET DEFAULT nextval('public.my_team_id_seq'::regclass);
ALTER TABLE ONLY public.options ALTER COLUMN id SET DEFAULT nextval('public.options_id_seq'::regclass);
ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);
ALTER TABLE ONLY public.service_provider_employee ALTER COLUMN id SET DEFAULT nextval('public.service_provider_employee_id_seq'::regclass);
ALTER TABLE ONLY public.service_provider_profile ALTER COLUMN id SET DEFAULT nextval('public.service_provider_profile_id_seq'::regclass);
ALTER TABLE ONLY public.service_provider_staff ALTER COLUMN id SET DEFAULT nextval('public.service_provider_staff_id_seq'::regclass);
ALTER TABLE ONLY public.skills ALTER COLUMN id SET DEFAULT nextval('public.skills_id_seq'::regclass);
ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);
ALTER TABLE ONLY public.user_connections ALTER COLUMN id SET DEFAULT nextval('public.user_connections_id_seq'::regclass);
ALTER TABLE ONLY public.user_skills ALTER COLUMN id SET DEFAULT nextval('public.user_skills_id_seq'::regclass);
ALTER TABLE ONLY public.working_hours_per_week ALTER COLUMN id SET DEFAULT nextval('public.working_hours_per_week_id_seq'::regclass);
ALTER TABLE ONLY public.access_token
    ADD CONSTRAINT access_token_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.access_token
    ADD CONSTRAINT access_token_user_id_key UNIQUE (user_id);
ALTER TABLE ONLY public.address
    ADD CONSTRAINT address_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.alert
    ADD CONSTRAINT alert_id_key UNIQUE (id);
ALTER TABLE ONLY public.alert
    ADD CONSTRAINT alert_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.customer_setting
    ADD CONSTRAINT customer_notification_settings_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.customer_profile
    ADD CONSTRAINT customer_profile_id_key UNIQUE (id);
ALTER TABLE ONLY public.customer_profile
    ADD CONSTRAINT customer_profile_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.customer_profile
    ADD CONSTRAINT customer_profile_user_id_key UNIQUE (user_id);
ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.jobs_skills
    ADD CONSTRAINT jobs_skills_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.my_team
    ADD CONSTRAINT my_team_id_key UNIQUE (id);
ALTER TABLE ONLY public.my_team
    ADD CONSTRAINT my_team_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.my_team
    ADD CONSTRAINT my_team_referred_to_id_key UNIQUE (referred_to_id);
ALTER TABLE ONLY public.options
    ADD CONSTRAINT options_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.service_provider_employee
    ADD CONSTRAINT service_provider_employee_id_key UNIQUE (id);
ALTER TABLE ONLY public.service_provider_employee
    ADD CONSTRAINT service_provider_employee_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.service_provider_profile
    ADD CONSTRAINT service_provider_profile_id_service_provider_id_key UNIQUE (id, service_provider_id);
ALTER TABLE ONLY public.service_provider_profile
    ADD CONSTRAINT service_provider_profile_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.service_provider_staff
    ADD CONSTRAINT service_provider_staff_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.skills
    ADD CONSTRAINT skills_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.user_connections
    ADD CONSTRAINT user_connections_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key UNIQUE (email);
ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_invite_code_key UNIQUE (invite_code);
ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_mobile_no_key UNIQUE (mobile_no);
ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.user_skills
    ADD CONSTRAINT user_skills_id_key UNIQUE (id);
ALTER TABLE ONLY public.user_skills
    ADD CONSTRAINT user_skills_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.working_hours_per_week
    ADD CONSTRAINT working_hours_per_week_id_key UNIQUE (id);
ALTER TABLE ONLY public.working_hours_per_week
    ADD CONSTRAINT working_hours_per_week_pkey PRIMARY KEY (id);
CREATE TRIGGER set_public_files_updated_at BEFORE UPDATE ON public.files FOR EACH ROW EXECUTE PROCEDURE public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_files_updated_at ON public.files IS 'trigger to set value of column "updated_at" to current timestamp on row update';
ALTER TABLE ONLY public.access_token
    ADD CONSTRAINT access_token_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public.alert
    ADD CONSTRAINT alert_created_by_id_fkey FOREIGN KEY (created_by_id) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public.alert
    ADD CONSTRAINT alert_type_fkey FOREIGN KEY (type_id) REFERENCES public.options(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public.alert
    ADD CONSTRAINT alert_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public.customer_profile
    ADD CONSTRAINT customer_profile_address_id_fkey FOREIGN KEY (address_id) REFERENCES public.address(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public.customer_profile
    ADD CONSTRAINT customer_profile_gender_id_fkey FOREIGN KEY (gender_id) REFERENCES public.options(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public.customer_profile
    ADD CONSTRAINT customer_profile_job_title_id_fkey FOREIGN KEY (job_title_id) REFERENCES public.options(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public.customer_profile
    ADD CONSTRAINT customer_profile_profile_picture_id_fkey FOREIGN KEY (profile_picture_id) REFERENCES public.files(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public.customer_profile
    ADD CONSTRAINT customer_profile_travel_for_work_id_fkey FOREIGN KEY (travel_for_work_id) REFERENCES public.options(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public.customer_profile
    ADD CONSTRAINT customer_profile_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public.customer_profile
    ADD CONSTRAINT customer_profile_working_hours_per_week_id_fkey FOREIGN KEY (working_hours_per_week_id) REFERENCES public.working_hours_per_week(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public.customer_setting
    ADD CONSTRAINT customer_setting_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public.jobs_skills
    ADD CONSTRAINT jobs_skills_job_id_fkey FOREIGN KEY (job_id) REFERENCES public.jobs(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public.jobs_skills
    ADD CONSTRAINT jobs_skills_skill_id_fkey FOREIGN KEY (skill_id) REFERENCES public.skills(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public.my_team
    ADD CONSTRAINT my_team_invited_by_id_fkey FOREIGN KEY (invited_by_id) REFERENCES public."user"(id) ON UPDATE SET NULL ON DELETE CASCADE;
ALTER TABLE ONLY public.my_team
    ADD CONSTRAINT my_team_invited_by_sp_status_id_fkey FOREIGN KEY (invited_by_sp_status_id) REFERENCES public.options(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public.my_team
    ADD CONSTRAINT my_team_referral_type_id_fkey FOREIGN KEY (referral_type_id) REFERENCES public.options(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public.my_team
    ADD CONSTRAINT my_team_referred_by_fkey FOREIGN KEY (referred_by_id) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public.my_team
    ADD CONSTRAINT my_team_referred_to_fkey FOREIGN KEY (referred_to_id) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public.service_provider_employee
    ADD CONSTRAINT service_provider_employee_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public.service_provider_employee
    ADD CONSTRAINT service_provider_employee_service_provider_id_fkey FOREIGN KEY (service_provider_id) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public.service_provider_profile
    ADD CONSTRAINT service_provider_profile_service_provider_id_fkey FOREIGN KEY (service_provider_id) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public.service_provider_staff
    ADD CONSTRAINT service_provider_staff_invite_status_fkey FOREIGN KEY (invite_status_id) REFERENCES public.options(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public.service_provider_staff
    ADD CONSTRAINT service_provider_staff_sp_admin_id_fkey FOREIGN KEY (sp_admin_id) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public.service_provider_staff
    ADD CONSTRAINT service_provider_staff_sp_staff_id_fkey FOREIGN KEY (sp_staff_id) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public.user_connections
    ADD CONSTRAINT user_connections_connection_request_recieved_by_fkey FOREIGN KEY (connection_request_recieved_by) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public.user_connections
    ADD CONSTRAINT user_connections_connection_request_sent_by_fkey FOREIGN KEY (connection_request_sent_by) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public.user_connections
    ADD CONSTRAINT user_connections_connection_request_status_fkey FOREIGN KEY (connection_request_status) REFERENCES public.options(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_heard_about_us_id_fkey FOREIGN KEY (heard_about_us_id) REFERENCES public.options(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_platform_role_id_fkey FOREIGN KEY (platform_role_id) REFERENCES public.options(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public.user_skills
    ADD CONSTRAINT user_skills_skill_id_fkey FOREIGN KEY (skill_id) REFERENCES public.skills(id) ON UPDATE CASCADE ON DELETE SET NULL;
ALTER TABLE ONLY public.user_skills
    ADD CONSTRAINT user_skills_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;
