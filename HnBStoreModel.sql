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

/* 고객 */
CREATE TABLE customer (
	customer_id VARCHAR2(20) NOT NULL, /* 고객아이디 */
	customer_name VARCHAR2(20) NOT NULL, /* 성명 */
	customer_ph VARCHAR2(20), /* 핸드폰번호 */
	customer_birthday DATE, /* 생일 */
	customer_gender VARCHAR2(20), /* 성별 */
	zipcode VARCHAR2(20), /* 우편번호 */
	address1 VARCHAR2(100), /* 주소1 */
	address2 VARCHAR2(100) /* 주소2 */
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

/* 우편번호  */
CREATE TABLE zipcode (
	zipcode VARCHAR2(20) NOT NULL, /* 우편번호 */
	sido VARCHAR2(20), /* 시도 */
	gugun VARCHAR2(20), /* 구군 */
	dong VARCHAR2(20), /* 동 */
	start_bunji VARCHAR2(20), /* 시작번지 */
	end_bunji VARCHAR2(20), /* 끝번지 */
	seq NUMBER NOT NULL /* 고유번호 */
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

/* 상품 */
CREATE TABLE product (
	product_code VARCHAR2(20) NOT NULL, /* 상품코드 */
	item_code VARCHAR2(20) NOT NULL, /* 품목코드 */
	product_name VARCHAR2(20) NOT NULL, /* 상품명 */
	Unit_price NUMBER, /* 입고단가 */
	price NUMBER, /* 가격 */
	stock NUMBER /* 재고 */
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

/* 상품판매 */
CREATE TABLE panmae (
	panmae_no NUMBER NOT NULL, /* 상품판매번호 */
	product_code VARCHAR2(20), /* 상품코드 */
	customer_id VARCHAR2(20), /* 고객아이디 */
	panmae_quantity NUMBER, /* 판매개수 */
	price NUMBER, /* 판매가격 */
	seller_id VARCHAR2(20), /* 판매자 아이디 */
	panmae_date DATE DEFAULT sysdate /* 판매날짜 */
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

/* 판매자 */
CREATE TABLE seller (
	seller_id VARCHAR2(20) NOT NULL, /* 판매자 아이디 */
	seller_pwd VARCHAR2(20) NOT NULL, /* 판매자 비밀번호 */
	seller_name VARCHAR2(20) NOT NULL, /* 판매자명 */
	seller_hp VARCHAR2(20), /* 핸드폰번호 */
	seller_jumin VARCHAR2(20), /* 주민번호 */
	seller_gender VARCHAR2(20), /* 성별 */
	zipcode VARCHAR2(20), /* 우편번호 */
	address1 VARCHAR2(100), /* 주소1 */
	address2 VARCHAR2(100), /* 주소2 */
	hiredate DATE DEFAULT sysdate /* 입사일 */
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

/* 거래처정보 */
CREATE TABLE account (
	account_code VARCHAR2(20) NOT NULL, /* 거래처코드 */
	account_name VARCHAR2(20) NOT NULL, /* 거래처명 */
	rep_name VARCHAR2(20) NOT NULL, /* 대표이름 */
	account_hp VARCHAR2(20), /* 전화번호 */
	zipcode VARCHAR2(20), /* 우편번호 */
	address1 VARCHAR2(100), /* 주소1 */
	address2 VARCHAR2(100), /* 주소2 */
	item_code VARCHAR2(20) NOT NULL /* 품목코드 */
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

/* 품목 */
CREATE TABLE item (
	item_code VARCHAR2(20) NOT NULL, /* 품목코드 */
	item_name VARCHAR2(20) NOT NULL, /* 품목명 */
	remark VARCHAR2(50) /* 비고 */
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

/* 상품관리 */
CREATE TABLE product_mgr (
	p_mgr_no NUMBER NOT NULL, /* 관리번호 */
	product_code VARCHAR2(20), /* 상품코드 */
	price NUMBER, /* 단가 */
	quantity NUMBER, /* 수량 */
	total_price NUMBER, /* 총금액 */
	account_code VARCHAR2(20), /* 거래처코드 */
	trading_day DATE DEFAULT sysdate /* 거래일 */
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