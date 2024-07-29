CREATE DATABASE HelpTech
GO

USE HelpTech
GO

CREATE TABLE departments
(
	id int identity (1,1) NOT NULL,
	name varchar(50) NOT NULL

	CONSTRAINT pk_department_id PRIMARY KEY (id)
)
GO
CREATE TABLE districts
(
	id int identity (1,1) NOT NULL,
	departments_id int NOT NULL,
	name varchar(50) NOT NULL

	CONSTRAINT pk_district_id PRIMARY KEY (id),

	CONSTRAINT fk_districts_departments_id FOREIGN KEY (departments_id)
	REFERENCES departments(id)
)
GO
CREATE TABLE specialties
(
	id int identity (1,1) NOT NULL,
	name varchar(50) NOT NULL

	CONSTRAINT pk_specialty_id PRIMARY KEY (id)
)
GO
CREATE TABLE technicals
(
	id int NOT NULL,
	specialties_id int NOT NULL,
	districts_id int NOT NULL,
	profile_url varchar(MAX) NOT NULL,
	firstname varchar(50) NOT NULL,
	lastname varchar(50) NOT NULL,
	age int NOT NULL,
	genre varchar(20) NOT NULL,
	phone int NOT NULL,
	email varchar(100) NOT NULL,
	availability varchar(20) NOT NULL,
	state varchar(20) NOT NULL

	CONSTRAINT pk_technical_id PRIMARY KEY (id),

	CONSTRAINT fk_technicals_specialties_id FOREIGN KEY (specialties_id)
	REFERENCES specialties(id),

	CONSTRAiNT fk_technicals_districts_id FOREIGN KEY (districts_id)
	REFERENCES districts(id),

	CONSTRAINT chk_technical_availability CHECK (availability IN ('TRABAJANDO', 'DISPONIBLE')),

	CONSTRAINT chk_technical_state CHECK (state IN ('REPORTADO', 'INACTIVO', 'ACTIVO'))
)
GO
CREATE TABLE technicals_credentials
(
	technicals_id int NOT NULL,
	code varchar(50) NOT NULL

	CONSTRAINT pk_technical_credential_technicals_id PRIMARY KEY (technicals_id),

	CONSTRAINT fk_technicals_credentials_technicals_id FOREIGN KEY (technicals_id)
	REFERENCES technicals(id)
)
GO
CREATE TABLE consumers
(
	id int NOT NULL,
	districts_id int NOT NULL,
	profile_url varchar(MAX) NOT NULL,
	firstname varchar(50) NOT NULL,
	lastname varchar(50) NOT NULL,
	age int NOT NULL,
	genre varchar(20) NOT NULL,
	phone int NOT NULL,
	email varchar(100) NOT NULL,
	state varchar(20) NOT NULL

	CONSTRAINT pk_consumer_id PRIMARY KEY (id),

	CONSTRAINT fk_consumers_districts_id FOREIGN KEY (districts_id)
	REFERENCES districts(id),

	CONSTRAINT chk_consumer_state CHECK (state IN ('REPORTADO', 'INACTIVO', 'ACTIVO'))
)
GO
CREATE TABLE consumers_credentials
(
	consumers_id int NOT NULL,
	code varchar(50) NOT NULL

	CONSTRAINT pk_consumer_credential_consumers_id PRIMARY KEY (consumers_id),

	CONSTRAINT fk_consumers_credentials_consumers_id FOREIGN KEY (consumers_id)
	REFERENCES consumers(id)
)
GO
CREATE TABLE memberships
(
	id int identity (1,1) NOT NULL,
	name varchar(20) NOT NULL,
	price decimal(10, 2) NOT NULL,
	policies varchar(200) NOT NULL,
	state varchar(20) NOT NULL

	CONSTRAINT pk_membership_id PRIMARY KEY (id),

	CONSTRAINT chk_membership_state CHECK (state IN ('ANULADO', 'VIGENTE'))
)
GO
CREATE TABLE contracts
(
	id int identity (1,1) NOT NULL,
	memberships_id int NOT NULL,
	technicals_id int NULL,
	consumers_id int NULL,
	start_date datetime NOT NULL,
	final_date datetime NOT NULL,
	state varchar(20) NOT NULL

	CONSTRAINT pk_contract_id PRIMARY KEY (id),

	CONSTRAINT fk_contracts_memberships_id FOREIGN KEY (memberships_id)
	REFERENCES memberships(id),

	CONSTRAINT fk_contracts_technicals_id FOREIGN KEY (technicals_id)
	REFERENCES technicals(id),

	CONSTRAINT fk_contracts_consumers_id FOREIGN KEY (consumers_id)
	REFERENCES consumers(id),

	CONSTRAINT chk_contract_state CHECK (state IN ('ANULADO', 'VENCIDO', 'VIGENTE'))
)
GO
CREATE TABLE criminals_records
(
	id int identity (1,1) NOT NULL,
	technicals_id int NOT NULL,
	file_url varchar(max) NOT NULL

	CONSTRAINT pk_criminal_record_id PRIMARY KEY (id),

	CONSTRAINT fk_criminals_records_technicals_id FOREIGN KEY (technicals_id)
	REFERENCES technicals(id)
)
GO
CREATE TABLE agendas
(
	id int identity (1,1) NOT NULL,
	technicals_id int NOT NULL,
	registration_date datetime NOT NULL

	CONSTRAINT pk_agendas_id PRIMARY KEY (id),

	CONSTRAINT fk_agendas_technicals_id FOREIGN KEY (technicals_id)
	REFERENCES technicals(id)
)
GO
CREATE TABLE jobs
(
	id int identity(1,1) NOT NULL,
	agendas_id int NOT NULL,
	consumers_id int NOT NULL,
	registration_date datetime NOT NULL,
	answer_date datetime NULL,
	work_date datetime NULL,
	address varchar(100) NOT NULL,
	description varchar(200) NOT NULL,
	time decimal(10,2) NULL,
	labor_budget float NULL,
	material_budget float NULL,
	amount_final float NULL,
	state varchar(20) NOT NULL

	CONSTRAINT pk_job_id PRIMARY KEY (id),

	CONSTRAINT fk_jobs_agendas_id FOREIGN KEY (agendas_id)
	REFERENCES agendas(id),

	CONSTRAINT fk_jobs_consumers_id FOREIGN KEY (consumers_id)
	REFERENCES consumers(id),

	CONSTRAINT chk_job_state CHECK (state IN ('DENEGADO', 'EN PROCESO', 'PENDIENTE', 'COMPLETADO'))
)
GO
CREATE TABLE reviews
(
	id int identity (1,1) NOT NULL,
	technicals_id int NOT NULL,
	consumers_id int NOT NULL,
	shipping_date datetime NOT NULL,
	score int NOT NULL,
	opinion varchar(100) NOT NULL,
	state varchar(20) NOT NULL

	CONSTRAINT pk_review_id PRIMARY KEY (id),

	CONSTRAINT fk_reviews_technicals_id FOREIGN KEY (technicals_id)
	REFERENCES technicals(id),

	CONSTRAINT fk_reviews_consumers_id FOREIGN KEY (consumers_id)
	REFERENCES consumers(id),

	CONSTRAINT chk_review_score CHECK (state IN (1, 2, 3, 4, 5)),

	CONSTRAINT chk_review_state CHECK (state IN ('REPORTADO', 'PUBLICADO'))
)
GO
CREATE TABLE types_complaints
(
	id int identity (1,1) NOT NULL,
	name varchar(50) NOT NULL

	CONSTRAINT pk_type_complaint_id PRIMARY KEY (id)
)
GO
CREATE TABLE complaints
(
	id int identity (1,1) NOT NULL,
	types_complaints_id int NOT NULL,
	jobs_id int NOT NULL,
	sender varchar(20) NOT NULL,
	registration_date datetime NOT NULL,
	description varchar(200) NOT NULL,
	state varchar(20) NOT NULL

	CONSTRAINT pk_complaint_id PRIMARY KEY (id),

	CONSTRAINT fk_complaints_types_complaints_id FOREIGN KEY (types_complaints_id)
	REFERENCES types_complaints(id),

	CONSTRAINT fk_complaints_jobs_id FOREIGN KEY (jobs_id)
	REFERENCES jobs(id),

	CONSTRAINT chk_complaint_sender CHECK (state IN ('TECNICO', 'CONSUMIDOR')),

	CONSTRAINT chk_complaint_state CHECK (state IN ('ENTREGADO', 'LEIDO'))
)
GO
CREATE TABLE chats_rooms
(
	id int identity (1,1) NOT NULL,
	registration_date datetime NOT NULL,
	state varchar(20) NOT NULL

	CONSTRAINT pk_chat_room_id PRIMARY KEY (id),

	CONSTRAINT chk_chat_room_state CHECK (state IN ('INACTIVO', 'ACTIVO'))
)
GO
CREATE TABLE chats_members
(
	chats_rooms_id int NOT NULL,
	technicals_id int NULL,
	consumers_id int NULL

	CONSTRAINT fk_chats_members_chats_rooms_id FOREIGN KEY (chats_rooms_id)
	REFERENCES chats_rooms(id),

	CONSTRAINT fk_chats_members_technicals_id FOREIGN KEY (technicals_id)
	REFERENCES technicals(id),

	CONSTRAINT fk_chats_members_consumers_id FOREIGN KEY (consumers_id)
	REFERENCES consumers(id)
)
GO
CREATE TABLE chats
(
	id int identity (1,1) NOT NULL,
	chats_rooms_id int NOT NULL,
	technicals_id int NULL,
	consumers_id int NULL,
	shipping_date datetime NOT NULL,
	message varchar(100) NOT NULL

	CONSTRAINT pk_chat_id PRIMARY KEY (id),

	CONSTRAINT fk_chats_chats_rooms_id FOREIGN KEY (chats_rooms_id)
	REFERENCES chats_rooms(id),

	CONSTRAINT fk_chats_technicals_id FOREIGN KEY (technicals_id)
	REFERENCES technicals(id),

	CONSTRAINT fk_chats_consumers_id FOREIGN KEY (consumers_id)
	REFERENCES consumers(id)
)
GO

CREATE PROCEDURE sp_general_technical_statistic
(
	@technical_id int
)
AS
BEGIN

	DECLARE @total_pendings_jobs int = (SELECT COUNT(state) FROM jobs
									   WHERE agendas_id = (SELECT id FROM agendas
														  WHERE technicals_id = @technical_id)
									   AND state = 'PENDIENTE')

	SELECT agendas_id, SUM(amount_final) AS total_income,
	COUNT(consumers_id) AS total_consumers_served,
	SUM(time) AS total_work_time, 
	@total_pendings_jobs AS total_pendings_jobs FROM jobs
	WHERE agendas_id = (SELECT id FROM agendas
					   WHERE technicals_id = @technical_id)
	AND FORMAT(work_date, 'MM') = FORMAT(GETDATE(), 'MM')
	AND state = 'COMPLETADO'
	GROUP BY agendas_id

END
GO
CREATE PROCEDURE sp_detailed_technical_statistic
(
	@technical_id int,
	@type_statistic varchar(20)
)
AS
BEGIN

	DECLARE @total_pendings_jobs int
	DECLARE @average_score int
	DECLARE @total_reviews int

	IF (@type_statistic = 'MENSUAL')
	BEGIN

		SET @total_pendings_jobs = (SELECT COUNT(state) FROM jobs
		                           WHERE agendas_id = (SELECT id FROM agendas
													  WHERE technicals_id = @technical_id)
								   AND FORMAT(work_date, 'MM') = FORMAT(GETDATE(), 'MM')
								   AND state = 'PENDIENTE')
		
		SET @average_score = (SELECT AVG(score) FROM reviews
							  WHERE technicals_id = @technical_id
							  AND FORMAT(shipping_date, 'MM') = FORMAT(GETDATE(), 'MM')
							  AND state = 'PUBLICADO')
		
		SET @total_reviews = (SELECT COUNT(opinion) FROM reviews
							  WHERE technicals_id = @technical_id
							  AND FORMAT(shipping_date, 'MM') = FORMAT(GETDATE(), 'MM')
							  AND state = 'PUBLICADO')
		
		SELECT agendas_id,
		AVG(amount_final) AS average_income,
		SUM(amount_final) AS total_income,
		COUNT(consumers_id) AS total_consumers_served,
		SUM(time) AS total_work_time,
		@total_pendings_jobs AS total_pending_jobs,
		@average_score AS average_score,
		@total_reviews AS total_reviews FROM jobs
		WHERE agendas_id = (SELECT id FROM agendas
		                   WHERE technicals_id = @technical_id)
		AND FORMAT(work_date, 'MM') = FORMAT(GETDATE(), 'MM')
		AND state = 'COMPLETADO'
		GROUP BY agendas_id

	END
	ELSE IF (@type_statistic = 'TOTAL')
	BEGIN

		SET @total_pendings_jobs = (SELECT COUNT(state) FROM jobs
		                           WHERE agendas_id = (SELECT id FROM agendas
													  WHERE technicals_id = @technical_id)
								   AND state = 'PENDIENTE')
		
		SET @average_score = (SELECT AVG(score) FROM reviews
							  WHERE technicals_id = @technical_id
							  AND state = 'PUBLICADO')
		
		SET @total_reviews = (SELECT COUNT(opinion) FROM reviews
							  WHERE technicals_id = @technical_id
							  AND state = 'PUBLICADO')
		
		SELECT agendas_id,
		AVG(amount_final) AS average_income,
		SUM(amount_final) AS total_income,
		COUNT(consumers_id) AS total_consumers_served,
		SUM(time) AS total_work_time,
		@total_pendings_jobs AS total_pending_jobs,
		@average_score AS average_score,
		@total_reviews AS total_reviews FROM jobs
		WHERE agendas_id = (SELECT id FROM agendas
		                   WHERE technicals_id = @technical_id)
		AND state = 'COMPLETADO'
		GROUP BY agendas_id

	END

END
GO
CREATE PROCEDURE sp_review_statistic
(
	@technical_id int
)
AS
BEGIN

	DECLARE @total_positive_reviews int = (SELECT COUNT(consumers_id) FROM reviews
										  WHERE technicals_id = @technical_id
										  AND score >= 3)

	DECLARE @total_negative_reviews int = (SELECT COUNT(consumers_id) FROM reviews
										  WHERE technicals_id = @technical_id
										  AND score < 3)

	SELECT technicals_id, AVG(score) AS average_score,
	@total_positive_reviews AS total_positive_reviews,
	@total_negative_reviews AS total_negative_reviews,
	COUNT(consumers_id) AS total_consumers_reviews FROM reviews
	WHERE technicals_id = @technical_id
	GROUP BY technicals_id

END
GO

CREATE TRIGGER tg_register_data_agendas
ON technicals FOR INSERT
AS

	SET NOCOUNT ON

	INSERT INTO agendas(technicals_id, registration_date) VALUES
	((SELECT inserted.id FROM inserted), GETDATE())

GO