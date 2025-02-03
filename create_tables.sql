-- Create time_dim table with primary key
CREATE TABLE public.time_dim
(
    time_key CHAR(15) PRIMARY KEY,
    Date DATE,
    hour INT,
    day INT,
    week TEXT,
    month INT,
    quarter TEXT,
    year INT
);

-- Create customer_dim table with primary key
CREATE TABLE public.customer_dim
(
    customer_key CHAR(15) PRIMARY KEY,
    name VARCHAR(250),
    contact_no TEXT,
    nid VARCHAR(50)
);

-- Create store_dim table with primary key
CREATE TABLE public.store_dim
(
    store_key CHAR(15) PRIMARY KEY,
    state TEXT,
    city VARCHAR(255)
);

-- Create item_dim table with primary key 
CREATE TABLE public.item_dim
(
    item_key CHAR(15) PRIMARY KEY,
    item_name TEXT,
    description VARCHAR(255),
    unit_price NUMERIC,
    country TEXT,
    supplier TEXT,
    unit TEXT
);

-- Create Trans_dim table with primary key 
CREATE TABLE public.trans_dim 
(
    payment_key CHAR(15) PRIMARY KEY, 
    trans_type TEXT,
    bank_name VARCHAR(255)
);

-- Create fact_table table with foreign keys and composite keys
CREATE TABLE public.fact_table 
(
    payment_key CHAR(15) PRIMARY KEY,
    customer_key CHAR(15),
    time_key CHAR(15),
    item_key CHAR(15),
    store_key CHAR(15),
    quantity NUMERIC,
    unit TEXT,
    unit_price NUMERIC,
    total_price NUMERIC,
    -- Foreign key constraints
    CONSTRAINT fk_payment FOREIGN KEY (payment_key) REFERENCES public.trans_dim (payment_key),
    CONSTRAINT fk_customer FOREIGN KEY (customer_key) REFERENCES public.customer_dim (customer_key),
    CONSTRAINT fk_time FOREIGN KEY (time_key) REFERENCES public.time_dim (time_key),
    CONSTRAINT fk_item FOREIGN KEY (item_key) REFERENCES public.item_dim (item_key),
    CONSTRAINT fk_store FOREIGN KEY (store_key) REFERENCES public.store_dim (store_key)
);

-- Create indexes for foreign keys to optimize performance
CREATE INDEX idx_payment_fact ON public.fact_table (payment_key);
CREATE INDEX idx_customer_fact ON public.fact_table (customer_key);
CREATE INDEX idx_time_fact ON public.fact_table (time_key);
CREATE INDEX idx_item_fact ON public.fact_table (item_key);
CREATE INDEX idx_store_fact ON public.fact_table (store_key);

-- Set ownership of the tables to the postgres user
ALTER TABLE public.time_dim OWNER TO postgres;
ALTER TABLE public.customer_dim OWNER TO postgres;
ALTER TABLE public.store_dim OWNER TO postgres;
ALTER TABLE public.item_dim OWNER TO postgres;
ALTER TABLE public.trans_dim OWNER TO postgres;
ALTER TABLE public.fact_table OWNER TO postgres;
