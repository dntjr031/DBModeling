/* tablespace */
CREATE TABLESPACE "PROJECT" DATAFILE 
  'C:\ORACLEXE\MYDATA\PROJECT' SIZE 104857600
  AUTOEXTEND ON NEXT 10485760 MAXSIZE 209715200
  LOGGING ONLINE PERMANENT BLOCKSIZE 8192
  EXTENT MANAGEMENT LOCAL AUTOALLOCATE DEFAULT NOCOMPRESS  SEGMENT SPACE MANAGEMENT AUTO;

/* user */
-- USER SQL
CREATE USER "STORE" IDENTIFIED BY "123"  
DEFAULT TABLESPACE "PROJECT";

-- QUOTAS
ALTER USER "STORE" QUOTA UNLIMITED ON "PROJECT";

-- ROLES
GRANT "CONNECT" TO "STORE" ;
GRANT "RESOURCE" TO "STORE" ;

-- SYSTEM PRIVILEGES

/* �� */
CREATE TABLE customer (
	customer_id VARCHAR2(20) NOT NULL, /* �����̵� */
	customer_name VARCHAR2(20) NOT NULL, /* ���� */
	customer_ph VARCHAR2(20), /* �ڵ�����ȣ */
	customer_birthday DATE, /* ���� */
	customer_gender VARCHAR2(20), /* ���� */
	zipcode VARCHAR2(20), /* �����ȣ */
	address1 VARCHAR2(100), /* �ּ�1 */
	address2 VARCHAR2(100) /* �ּ�2 */
);

CREATE UNIQUE INDEX PK_customer
	ON customer (
		customer_id ASC
	);

ALTER TABLE customer
	ADD
		CONSTRAINT PK_customer
		PRIMARY KEY (
			customer_id
		);

/* �����ȣ  */
CREATE TABLE zipcode (
	zipcode VARCHAR2(20) NOT NULL, /* �����ȣ */
	sido VARCHAR2(20), /* �õ� */
	gugun VARCHAR2(20), /* ���� */
	dong VARCHAR2(20), /* �� */
	start_bunji VARCHAR2(20), /* ���۹��� */
	end_bunji VARCHAR2(20), /* ������ */
	seq NUMBER NOT NULL /* ������ȣ */
);

CREATE UNIQUE INDEX PK_zipcode
	ON zipcode (
		zipcode ASC
	);

ALTER TABLE zipcode
	ADD
		CONSTRAINT PK_zipcode
		PRIMARY KEY (
			zipcode
		);

/* ��ǰ */
CREATE TABLE product (
	product_code VARCHAR2(20) NOT NULL, /* ��ǰ�ڵ� */
	item_code VARCHAR2(20) NOT NULL, /* ǰ���ڵ� */
	product_name VARCHAR2(20) NOT NULL, /* ��ǰ�� */
	Unit_price NUMBER, /* �԰�ܰ� */
	price NUMBER, /* ���� */
	stock NUMBER /* ��� */
);

CREATE UNIQUE INDEX PK_product
	ON product (
		product_code ASC
	);

ALTER TABLE product
	ADD
		CONSTRAINT PK_product
		PRIMARY KEY (
			product_code
		);

/* ��ǰ�Ǹ� */
CREATE TABLE panmae (
	panmae_no NUMBER NOT NULL, /* ��ǰ�ǸŹ�ȣ */
	product_code VARCHAR2(20), /* ��ǰ�ڵ� */
	customer_id VARCHAR2(20), /* �����̵� */
	panmae_quantity NUMBER, /* �ǸŰ��� */
	price NUMBER, /* �ǸŰ��� */
	seller_id VARCHAR2(20), /* �Ǹ��� ���̵� */
	panmae_date DATE DEFAULT sysdate /* �Ǹų�¥ */
);

CREATE UNIQUE INDEX PK_panmae
	ON panmae (
		panmae_no ASC
	);

ALTER TABLE panmae
	ADD
		CONSTRAINT PK_panmae
		PRIMARY KEY (
			panmae_no
		);

/* �Ǹ��� */
CREATE TABLE seller (
	seller_id VARCHAR2(20) NOT NULL, /* �Ǹ��� ���̵� */
	seller_pwd VARCHAR2(20) NOT NULL, /* �Ǹ��� ��й�ȣ */
	seller_name VARCHAR2(20) NOT NULL, /* �Ǹ��ڸ� */
	seller_hp VARCHAR2(20), /* �ڵ�����ȣ */
	seller_jumin VARCHAR2(20), /* �ֹι�ȣ */
	seller_gender VARCHAR2(20), /* ���� */
	zipcode VARCHAR2(20), /* �����ȣ */
	address1 VARCHAR2(100), /* �ּ�1 */
	address2 VARCHAR2(100), /* �ּ�2 */
	hiredate DATE DEFAULT sysdate /* �Ի��� */
);

CREATE UNIQUE INDEX PK_seller
	ON seller (
		seller_id ASC
	);

ALTER TABLE seller
	ADD
		CONSTRAINT PK_seller
		PRIMARY KEY (
			seller_id
		);

/* �ŷ�ó���� */
CREATE TABLE account (
	account_code VARCHAR2(20) NOT NULL, /* �ŷ�ó�ڵ� */
	account_name VARCHAR2(20) NOT NULL, /* �ŷ�ó�� */
	rep_name VARCHAR2(20) NOT NULL, /* ��ǥ�̸� */
	account_hp VARCHAR2(20), /* ��ȭ��ȣ */
	zipcode VARCHAR2(20), /* �����ȣ */
	address1 VARCHAR2(100), /* �ּ�1 */
	address2 VARCHAR2(100), /* �ּ�2 */
	item_code VARCHAR2(20) NOT NULL /* ǰ���ڵ� */
);

CREATE UNIQUE INDEX PK_account
	ON account (
		account_code ASC
	);

ALTER TABLE account
	ADD
		CONSTRAINT PK_account
		PRIMARY KEY (
			account_code
		);

/* ǰ�� */
CREATE TABLE item (
	item_code VARCHAR2(20) NOT NULL, /* ǰ���ڵ� */
	item_name VARCHAR2(20) NOT NULL, /* ǰ��� */
	remark VARCHAR2(50) /* ��� */
);

CREATE UNIQUE INDEX PK_item
	ON item (
		item_code ASC
	);

ALTER TABLE item
	ADD
		CONSTRAINT PK_item
		PRIMARY KEY (
			item_code
		);

/* ��ǰ���� */
CREATE TABLE product_mgr (
	p_mgr_no NUMBER NOT NULL, /* ������ȣ */
	product_code VARCHAR2(20), /* ��ǰ�ڵ� */
	price NUMBER, /* �ܰ� */
	quantity NUMBER, /* ���� */
	total_price NUMBER, /* �ѱݾ� */
	account_code VARCHAR2(20), /* �ŷ�ó�ڵ� */
	trading_day DATE DEFAULT sysdate /* �ŷ��� */
);

CREATE UNIQUE INDEX PK_product_mgr
	ON product_mgr (
		p_mgr_no ASC
	);

ALTER TABLE product_mgr
	ADD
		CONSTRAINT PK_product_mgr
		PRIMARY KEY (
			p_mgr_no
		);

ALTER TABLE customer
	ADD
		CONSTRAINT FK_zipcode_TO_customer
		FOREIGN KEY (
			zipcode
		)
		REFERENCES zipcode (
			zipcode
		);

ALTER TABLE product
	ADD
		CONSTRAINT FK_item_TO_product
		FOREIGN KEY (
			item_code
		)
		REFERENCES item (
			item_code
		);

ALTER TABLE panmae
	ADD
		CONSTRAINT FK_product_TO_panmae
		FOREIGN KEY (
			product_code
		)
		REFERENCES product (
			product_code
		);

ALTER TABLE panmae
	ADD
		CONSTRAINT FK_customer_TO_panmae
		FOREIGN KEY (
			customer_id
		)
		REFERENCES customer (
			customer_id
		);

ALTER TABLE panmae
	ADD
		CONSTRAINT FK_seller_TO_panmae
		FOREIGN KEY (
			seller_id
		)
		REFERENCES seller (
			seller_id
		);

ALTER TABLE seller
	ADD
		CONSTRAINT FK_zipcode_TO_seller
		FOREIGN KEY (
			zipcode
		)
		REFERENCES zipcode (
			zipcode
		);

ALTER TABLE account
	ADD
		CONSTRAINT FK_zipcode_TO_account
		FOREIGN KEY (
			zipcode
		)
		REFERENCES zipcode (
			zipcode
		);

ALTER TABLE account
	ADD
		CONSTRAINT FK_item_TO_account
		FOREIGN KEY (
			item_code
		)
		REFERENCES item (
			item_code
		);

ALTER TABLE product_mgr
	ADD
		CONSTRAINT FK_account_TO_product_mgr
		FOREIGN KEY (
			account_code
		)
		REFERENCES account (
			account_code
		);

ALTER TABLE product_mgr
	ADD
		CONSTRAINT FK_product_TO_product_mgr
		FOREIGN KEY (
			product_code
		)
		REFERENCES product (
			product_code
		);