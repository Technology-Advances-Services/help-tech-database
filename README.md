# Help Tech Database Schema

This document describes the database structure for the Help-Tech application. The database is designed to manage information related to technical services, including technicians, consumers, contracts, and communication.

## Database Structure

The database comprises the following tables:

### `departments` Table

- **id**: Unique identifier for the department (PRIMARY KEY).
- **name**: Name of the department (VARCHAR 50).

### `districts` Table

- **id**: Unique identifier for the district (PRIMARY KEY).
- **departments_id**: Identifier of the associated department (FOREIGN KEY).
- **name**: Name of the district (VARCHAR 50).

### `specialties` Table

- **id**: Unique identifier for the specialty (PRIMARY KEY).
- **name**: Name of the specialty (VARCHAR 50).

### `technicals` Table

- **id**: Unique identifier for the technician (PRIMARY KEY).
- **specialties_id**: Identifier of the associated specialty (FOREIGN KEY).
- **districts_id**: Identifier of the associated district (FOREIGN KEY).
- **profile_url**: URL to the technician's profile (VARCHAR(MAX)).
- **firstname**: First name of the technician (VARCHAR 50).
- **lastname**: Last name of the technician (VARCHAR 50).
- **age**: Age of the technician (INT).
- **genre**: Gender of the technician (VARCHAR 20).
- **phone**: Phone number of the technician (INT).
- **email**: Email address of the technician (VARCHAR 100).
- **availability**: Availability status ('TRABAJANDO', 'DISPONIBLE') (CHECK).
- **state**: State of the technician ('REPORTADO', 'INACTIVO', 'ACTIVO') (CHECK).

### `technicals_credentials` Table

- **technicals_id**: Unique identifier for the technician (PRIMARY KEY, FOREIGN KEY).
- **code**: Access code for the technician (VARCHAR 50).

### `consumers` Table

- **id**: Unique identifier for the consumer (PRIMARY KEY).
- **districts_id**: Identifier of the associated district (FOREIGN KEY).
- **profile_url**: URL to the consumer's profile (VARCHAR(MAX)).
- **firstname**: First name of the consumer (VARCHAR 50).
- **lastname**: Last name of the consumer (VARCHAR 50).
- **age**: Age of the consumer (INT).
- **genre**: Gender of the consumer (VARCHAR 20).
- **phone**: Phone number of the consumer (INT).
- **email**: Email address of the consumer (VARCHAR 100).
- **state**: State of the consumer ('REPORTADO', 'INACTIVO', 'ACTIVO') (CHECK).

### `consumers_credentials` Table

- **consumers_id**: Unique identifier for the consumer (PRIMARY KEY, FOREIGN KEY).
- **code**: Access code for the consumer (VARCHAR 50).

### `memberships` Table

- **id**: Unique identifier for the membership (PRIMARY KEY).
- **name**: Name of the membership (VARCHAR 20).
- **price**: Price of the membership (DECIMAL 10, 2).
- **policies**: Policies of the membership (VARCHAR 200).
- **state**: State of the membership ('ANULADO', 'VIGENTE') (CHECK).

### `contracts` Table

- **id**: Unique identifier for the contract (PRIMARY KEY).
- **memberships_id**: Identifier of the associated membership (FOREIGN KEY).
- **technicals_id**: Identifier of the associated technician (FOREIGN KEY, NULLABLE).
- **consumers_id**: Identifier of the associated consumer (FOREIGN KEY, NULLABLE).
- **start_date**: Start date of the contract (DATETIME).
- **final_date**: End date of the contract (DATETIME).
- **state**: State of the contract ('ANULADO', 'VENCIDO', 'VIGENTE') (CHECK).

### `criminals_records` Table

- **id**: Unique identifier for the criminal record (PRIMARY KEY).
- **technicals_id**: Identifier of the associated technician (FOREIGN KEY).
- **file_url**: URL of the criminal record file (VARCHAR(MAX)).

### `agendas` Table

- **id**: Unique identifier for the agenda (PRIMARY KEY).
- **technicals_id**: Identifier of the associated technician (FOREIGN KEY).
- **registration_date**: Date when the agenda was created (DATETIME).

### `jobs` Table

- **id**: Unique identifier for the job (PRIMARY KEY).
- **agendas_id**: Identifier of the associated agenda (FOREIGN KEY).
- **consumers_id**: Identifier of the associated consumer (FOREIGN KEY).
- **registration_date**: Date when the job was registered (DATETIME).
- **answer_date**: Date when the job was answered (DATETIME, NULLABLE).
- **work_date**: Date when the work was performed (DATETIME, NULLABLE).
- **address**: Address where the work was performed (VARCHAR 100).
- **description**: Description of the job (VARCHAR 200).
- **time**: Time spent on the job (DECIMAL 10, 2, NULLABLE).
- **labor_budget**: Labor budget for the job (FLOAT, NULLABLE).
- **material_budget**: Material budget for the job (FLOAT, NULLABLE).
- **amount_final**: Final amount for the job (FLOAT, NULLABLE).
- **state**: State of the job ('DENEGADO', 'EN PROCESO', 'PENDIENTE', 'COMPLETADO') (CHECK).

### `reviews` Table

- **id**: Unique identifier for the review (PRIMARY KEY).
- **technicals_id**: Identifier of the associated technician (FOREIGN KEY).
- **consumers_id**: Identifier of the associated consumer (FOREIGN KEY).
- **shipping_date**: Date when the review was posted (DATETIME).
- **score**: Score given in the review (INT).
- **opinion**: Opinion content of the review (VARCHAR 100).
- **state**: State of the review ('REPORTADO', 'PUBLICADO') (CHECK).

### `types_complaints` Table

- **id**: Unique identifier for the complaint type (PRIMARY KEY).
- **name**: Name of the complaint type (VARCHAR 50).

### `complaints` Table

- **id**: Unique identifier for the complaint (PRIMARY KEY).
- **types_complaints_id**: Identifier of the associated complaint type (FOREIGN KEY).
- **jobs_id**: Identifier of the associated job (FOREIGN KEY).
- **sender**: Sender of the complaint ('TECNICO', 'CONSUMIDOR') (CHECK).
- **registration_date**: Date when the complaint was registered (DATETIME).
- **description**: Description of the complaint (VARCHAR 200).
- **state**: State of the complaint ('ENTREGADO', 'LEIDO') (CHECK).

### `chats_rooms` Table

- **id**: Unique identifier for the chat room (PRIMARY KEY).
- **registration_date**: Date when the chat room was created (DATETIME).
- **state**: State of the chat room ('INACTIVO', 'ACTIVO') (CHECK).

### `chats_members` Table

- **chats_rooms_id**: Identifier of the associated chat room (FOREIGN KEY).
- **technicals_id**: Identifier of the associated technician (FOREIGN KEY, NULLABLE).
- **consumers_id**: Identifier of the associated consumer (FOREIGN KEY, NULLABLE).

### `chats` Table

- **id**: Unique identifier for the chat message (PRIMARY KEY).
- **chats_rooms_id**: Identifier of the associated chat room (FOREIGN KEY).
- **technicals_id**: Identifier of the associated technician (FOREIGN KEY, NULLABLE).
- **consumers_id**: Identifier of the associated consumer (FOREIGN KEY, NULLABLE).
- **shipping_date**: Date when the message was sent (DATETIME).
- **message**: Content message (VARCHAR 100).
