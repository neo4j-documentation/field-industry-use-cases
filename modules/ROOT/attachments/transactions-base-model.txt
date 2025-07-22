# Transaction and Account Data Model

This document defines a standardised Neo4j data model for banking transactions and customer data. It serves as a technical specification for LLMs building data import scripts or validating existing graph schemas.

**Key Features for Automated Processing:**
- Comprehensive node labels with precise property definitions and data types
- Explicit relationship patterns with directional semantics
- Complete constraint definitions ensuring data integrity
- Executable demonstration code for validation and testing
- Standard naming conventions following Neo4j best practices

**Usage for LLMs:**
- Use the node and relationship definitions to generate import scripts matching your source data
- Apply the constraint definitions to ensure data quality and prevent duplicates
- Reference the demonstration code patterns for proper relationship modelling
- Validate existing schemas against this specification for compliance

## 1. Node Labels and Properties

### Account
- Labels:
  - `Account`: (Required) Base label for all bank accounts in the system
  - `Internal`: Label for accounts held within this bank (our customers' accounts). Essential for identifying fund flows leaving the organisation (Internal→External transactions) or incoming liquidity (External→Internal transactions)
  - `External`: Label for accounts held at other financial institutions. Critical for monitoring cross-institutional transfers and identifying potential money laundering patterns
  - `HighRiskJurisdiction`: Label for accounts in countries with elevated regulatory or compliance risks
- Properties:
  - `accountNumber` (String): Unique account identifier (e.g., sort code and account number, IBAN)
  - `accountType` (String): Optional: Type of account (e.g., "CURRENT", "SAVINGS", "BUSINESS", "LOAN")
  - `openDate` (DateTime): Optional: Date and time when the account was first opened
  - `closedDate` (DateTime): Optional: Date and time when the account was permanently closed (null if still active)
  - `suspendedDate` (DateTime): Optional: Date and time when the account was temporarily suspended (null if not suspended)

### Address
- Properties:
  - `addressLine1` (String): Primary address line containing house/building number and street name
  - `addressLine2` (String): Optional: Secondary address details such as flat number, building name, or estate
  - `postTown` (String): Post town as defined by Royal Mail (the town or city for postal delivery)
  - `postCode` (String): UK postcode or international postal code for the address
  - `region` (String): Optional: County, state, or administrative region
  - `latitude` (Float): Optional: Geographic latitude coordinate for precise location mapping
  - `longitude` (Float): Optional: Geographic longitude coordinate for precise location mapping
  - `createdAt` (DateTime): Timestamp when this address was first recorded in the system

### Counterparty
- Properties:
  - `counterpartyId` (String): Unique system identifier for the counterparty entity
  - `name` (String): Legal name of the counterparty (person's full name or registered company name)
  - `type` (String): Classification of counterparty (e.g., "INDIVIDUAL", "BUSINESS", "GOVERNMENT", "CHARITY")
  - `registrationNumber` (String): Optional: Official registration number (Companies House number, charity number, etc.)
  - `createdAt` (DateTime): Timestamp when this counterparty was first recorded in the system

### Country
- Properties:
  - `code` (String): Two-letter ISO 3166-1 alpha-2 country code (e.g., "GB" for United Kingdom, "US" for United States)
  - `name` (String): Official full country name in English

### Customer
- Properties:
  - `customerId` (String): Unique system identifier for the customer record
  - `firstName` (String): Optional: Customer's given name (first name)
  - `middleName` (String): Optional: Customer's middle name(s) or initial(s)
  - `lastName` (String): Optional: Customer's family name (surname)
  - `dateOfBirth` (Date): Optional: Customer's date of birth (used for identity verification and age calculations)
  - `placeOfBirth` (String): Optional: City or location where the customer was born (as stated on official documents)
  - `countryOfBirth` (String): Optional: ISO 3166-1 country code where the customer was born (may differ from nationality)

### Device
- Properties:
  - `deviceId` (String): Unique fingerprint or identifier for the device accessing the system
  - `deviceType` (String): Optional: Category of device (e.g., "mobile", "desktop", "tablet", "unknown")
  - `userAgent` (String): Optional: Browser or application user agent string containing device and software information
  - `createdAt` (DateTime): Timestamp when this device was first detected and recorded in the system

### DrivingLicense
- Properties:
  - `licenseNumber` (String): Unique driving licence number as printed on the physical document
  - `issueDate` (Date): Optional: Date when the driving licence was originally issued
  - `expiryDate` (Date): Optional: Date when the driving licence expires and requires renewal
  - `issuingCountry` (String): Optional: ISO 3166-1 country code of the authority that issued the licence
  - `createdAt` (DateTime): Timestamp when this driving licence record was first created in the system

### Email
- Properties:
  - `address` (String): Complete email address (e.g., "john.smith@example.com")
  - `domain` (String): Optional: Domain portion of the email address (e.g., "example.com")
  - `createdAt` (DateTime): Timestamp when this email address was first recorded in the system

### Face
- Properties:
  - `faceId` (String): Unique identifier for the face biometric record
  - `embedding` (List of Float): High-dimensional vector representation of facial features (typically 512-1536 dimensions)
  - `createdAt` (DateTime): Timestamp when this facial biometric record was created in the system

### IP
- Properties:
  - `ipAddress` (String): Internet Protocol address used to access the system (IPv4 or IPv6 format)
  - `createdAt` (DateTime): Timestamp when this IP address was first observed in the system

### ISP
- Properties:
  - `name` (String): Name of the Internet Service Provider or telecommunications company
  - `createdAt` (DateTime): Timestamp when this ISP was first recorded in the system

### Location
- Properties:
  - `city` (String): Name of the city or major population centre
  - `postCode` (String): Postal code or ZIP code for the general area (may be partial for privacy)
  - `country` (String): ISO 3166-1 country code where this location is situated
  - `latitude` (Float): Optional: Geographic latitude coordinate for the location centre
  - `longitude` (Float): Optional: Geographic longitude coordinate for the location centre
  - `createdAt` (DateTime): Timestamp when this location was first recorded in the system

### Movement
- Properties:
  - `movementId` (String): Unique system identifier for this individual movement
  - `amount` (Float): Monetary value of this specific movement (always positive)
  - `currency` (String): Three-letter ISO 4217 currency code (e.g., "GBP", "USD", "EUR")
  - `date` (DateTime): Date and time when this movement was executed or scheduled
  - `description` (String): Optional: Human-readable description explaining the movement's purpose (e.g., "Insurance claim payment 1 of 3")
  - `status` (String): Optional: Current processing status (e.g., "PENDING", "COMPLETED", "CANCELLED", "FAILED")
  - `sequenceNumber` (Integer): Chronological order of this movement within a series (starts from 1)
  - `authorisedBy` (String): Optional: User ID or name of the person who authorised this movement
  - `validatedBy` (String): Optional: User ID or name of the person who provided secondary approval (for dual control processes)
  - `createdAt` (DateTime): Timestamp when this movement record was initially created in the system

### Passport
- Properties:
  - `passportNumber` (String): Unique passport number as printed on the document
  - `issueDate` (Date): Optional: Date when the passport was originally issued
  - `expiryDate` (Date): Optional: Date when the passport expires and requires renewal
  - `issuingCountry` (String): Optional: ISO 3166-1 country code of the government that issued this passport
  - `nationality` (String): Optional: Nationality or citizenship recorded in the passport (may differ from issuing country)
  - `createdAt` (DateTime): Timestamp when this passport record was first created in the system

### Phone
- Properties:
  - `number` (String): Complete phone number including country code (e.g., "447971020304")
  - `countryCode` (String): Optional: International dialling code with plus prefix (e.g., "+44", "+1")
  - `createdAt` (DateTime): Timestamp when this phone number was first recorded in the system

### Session
- Properties:
  - `sessionId` (String): Unique identifier for the user session or login attempt
  - `status` (String): Optional: Outcome of the session (e.g., "success", "failed", "suspicious", "timeout")
  - `createdAt` (DateTime): Timestamp when the session was initiated

### Transaction
- Properties:
  - `transactionId` (String): Unique system identifier for the transaction
  - `amount` (Float): Monetary value of the transaction (always positive, direction indicated by relationships)
  - `currency` (String): Three-letter ISO 4217 currency code (e.g., "GBP", "USD", "EUR")
  - `date` (DateTime): Date and time when the transaction was processed or initiated
  - `message` (String): Optional: Payment reference or description text (e.g., "Swift payment for services", "Invoice #12345")
  - `type` (String): Optional: Payment method or transaction type (e.g., "SWIFT", "ACH", "FASTER_PAYMENT", "CARD")

## 2. Relationship Types and Properties

### :BENEFITS_TO
- Direction: Transaction->Account
- Properties: None
- Description: Links a transaction to the account that receives the funds (the destination or beneficiary account)

### :HAS_ACCOUNT
- Direction: Customer->Account
- Properties:
  - `role` (String): Customer's role on the account (e.g., "owner", "joint", "authorised_signatory")
  - `since` (DateTime): Date and time when this account relationship was established

### :HAS_ACCOUNT
- Direction: Counterparty->Account
- Properties:
  - `since` (DateTime): Date and time when this counterparty-account relationship was first recorded

### :HAS_ADDRESS
- Direction: Customer->Address
- Properties:
  - `addedAt` (DateTime): When this address was first linked to the customer
  - `lastChangedAt` (DateTime): When the address details were last updated
  - `isCurrent` (Boolean): Whether this is the customer's current residential address

### :HAS_ADDRESS
- Direction: Counterparty->Address
- Properties:
  - `since` (DateTime): When this address was first linked to the counterparty
  - `isCurrent` (Boolean): Whether this is the counterparty's current registered address

### :HAS_DRIVING_LICENSE
- Direction: Customer->DrivingLicense
- Properties:
  - `verificationDate` (DateTime): When the driving licence was verified by the bank
  - `verificationMethod` (String): How verification was performed (e.g., "BRANCH_VERIFIED", "DIGITAL_SCAN", "VIDEO_KYC")
  - `verificationStatus` (String): Current verification status (e.g., "VERIFIED", "PENDING", "REJECTED", "EXPIRED")

### :HAS_EMAIL
- Direction: Customer->Email
- Properties:
  - `since` (DateTime): When this email address was first linked to the customer record

### :HAS_FACE
- Direction: Customer->Face
- Properties:
  - `verificationDate` (DateTime): When the facial biometric was verified against the customer
  - `verificationMethod` (String): How facial verification was performed (e.g., "SELFIE", "VIDEO_KYC", "BRANCH_PHOTO")
  - `verificationStatus` (String): Current verification status (e.g., "VERIFIED", "PENDING", "REJECTED")


### :HAS_NATIONALITY
- Direction: Customer->Country
- Properties: None
- Description: Links a customer to their country of citizenship or nationality (customers may have multiple nationalities)

### :HAS_PASSPORT
- Direction: Customer->Passport
- Properties:
  - `verificationDate` (DateTime): When the passport was verified by the bank
  - `verificationMethod` (String): How verification was performed (e.g., "BRANCH_VERIFIED", "DIGITAL_SCAN", "VIDEO_KYC")
  - `verificationStatus` (String): Current verification status (e.g., "VERIFIED", "PENDING", "REJECTED", "EXPIRED")

### :HAS_PHONE
- Direction: Customer->Phone
- Properties:
  - `since` (DateTime): When this phone number was first linked to the customer record

### :IMPLIED
- Direction: Transaction->Movement
- Properties:
  - `totalMovements` (Integer): Total number of movements that will result from this transaction
- Description: Links a transaction to its component movements when a single transaction results in multiple separate payments (e.g., insurance claim paid in instalments, loan disbursement in tranches)

### :IS_ALLOCATED_TO
- Direction: IP->ISP
- Properties:
  - `createdAt` (DateTime): Timestamp when this IP address allocation was first recorded
- Description: Links an IP address to the Internet Service Provider that owns or manages that IP address range

### :IS_HOSTED
- Direction: Account->Country
- Properties: None
- Description: Links an account to the country where it is held or domiciled (using ISO 3166-1 country codes)

### :LOCATED_IN
- Direction: Address->Country
- Properties: None
- Description: Links a physical address to the country where it is located (using ISO 3166-1 country codes)

### :LOCATED_IN
- Direction: IP->Location
- Properties:
  - `createdAt` (DateTime): Timestamp when this IP geolocation was first determined
- Description: Links an IP address to its approximate geographic location based on geolocation services

### :LOCATED_IN
- Direction: Location->Country
- Properties: None
- Description: Links a geographic location to the country where it is situated (using ISO 3166-1 country codes)

### :PERFORMS
- Direction: Account->Transaction
- Properties: None
- Description: Links the account that initiated or sent the transaction (the source or debtor account)

### :SESSION_USES_DEVICE
- Direction: Session->Device
- Properties: None
- Description: Records which device was used to establish or conduct the session

### :USED_BY
- Direction: Device->Customer
- Properties:
  - `lastUsed` (DateTime): When this device was last used by the customer

### :USES_IP
- Direction: Session->IP
- Properties: None
- Description: Records which IP address was used to establish or conduct the session

## 3. Constraints and Indexes

```cypher
// Constraints
CREATE CONSTRAINT customer_id IF NOT EXISTS
FOR (c:Customer) REQUIRE c.customerId IS NODE KEY;

CREATE CONSTRAINT email_address IF NOT EXISTS
FOR (e:Email) REQUIRE e.address IS NODE KEY;

CREATE CONSTRAINT phone_number IF NOT EXISTS
FOR (p:Phone) REQUIRE p.number IS NODE KEY;

CREATE CONSTRAINT passport_number IF NOT EXISTS
FOR (p:Passport) REQUIRE (p.passportNumber, p.issuingCountry) IS NODE KEY;

CREATE CONSTRAINT driving_licence_number IF NOT EXISTS
FOR (d:DrivingLicense) REQUIRE (d.licenseNumber, d.issuingCountry) IS NODE KEY;

CREATE CONSTRAINT device_id IF NOT EXISTS
FOR (d:Device) REQUIRE d.deviceId IS NODE KEY;

CREATE CONSTRAINT ip_address IF NOT EXISTS
FOR (i:IP) REQUIRE i.ipAddress IS NODE KEY;

CREATE CONSTRAINT session_id IF NOT EXISTS
FOR (s:Session) REQUIRE s.sessionId IS NODE KEY;

CREATE CONSTRAINT account_number IF NOT EXISTS
FOR (a:Account) REQUIRE a.accountNumber IS NODE KEY;

CREATE CONSTRAINT transaction_id IF NOT EXISTS
FOR (t:Transaction) REQUIRE t.transactionId IS NODE KEY;

CREATE CONSTRAINT face_id IF NOT EXISTS
FOR (f:Face) REQUIRE f.faceId IS NODE KEY;

CREATE CONSTRAINT counterparty_id IF NOT EXISTS
FOR (cp:Counterparty) REQUIRE cp.counterpartyId IS NODE KEY;

CREATE CONSTRAINT movement_id IF NOT EXISTS
FOR (m:Movement) REQUIRE m.movementId IS NODE KEY;

CREATE CONSTRAINT isp_name IF NOT EXISTS
FOR (i:ISP) REQUIRE i.name IS NODE KEY;

CREATE CONSTRAINT country_code IF NOT EXISTS
FOR (c:Country) REQUIRE c.code IS NODE KEY;

CREATE CONSTRAINT address_composite IF NOT EXISTS
FOR (a:Address) REQUIRE (a.addressLine1, a.postTown, a.postCode) IS NODE KEY;

// Additional Indexes

CREATE INDEX transaction_date_idx IF NOT EXISTS FOR (t:Transaction) ON (t.date);
CREATE INDEX transaction_amount_idx IF NOT EXISTS FOR (t:Transaction) ON (t.amount);

// Vector index for face embeddings (used for biometric matching)
CALL db.index.vector.createNodeIndex(
  'face_embedding_idx',
  'Face',
  'embedding',
  1536,  // dimensionality of the face embeddings (typical range: 512-1536)
  'cosine'  // similarity metric for comparing facial features
);

// Full Text Search

// Full-text index for customer name search
CREATE FULLTEXT INDEX customer_name_idx IF NOT EXISTS FOR (c:Customer) ON EACH [c.firstName, c.lastName, c.middleName];
```

## 4. Minimal Demo Code

The following Cypher code creates a complete example dataset demonstrating all the main entities and relationships in the model. This code is suitable for testing and demonstration purposes.

```cypher
//--------------------
// Create base countries
//--------------------
CREATE (uk:Country {code: "GB", name: "United Kingdom"})
CREATE (us:Country {code: "US", name: "United States"})

//--------------------
// Create customer and their identity information
//--------------------
// Create main customer node
CREATE (c:Customer {
    customerId: "CUS001", 
    firstName: "John",
    middleName: "Michael",
    lastName: "Smith", 
    dateOfBirth: date("1990-01-01"),
    placeOfBirth: "Manchester",
    countryOfBirth: "GB"
})

// Create customer's address
CREATE (addr:Address {
    addressLine1: "123 High Street",
    addressLine2: "Flat 4B",
    postTown: "London",
    postCode: "SW1A 1AA",
    region: "Greater London",
    latitude: 51.5074,
    longitude: -0.1278,
    createdAt: datetime("2024-01-01T00:00:00")
})

// Create customer's contact information
CREATE (e:Email {
    address: "john@example.com",
    domain: "example.com",
    createdAt: datetime("2024-01-01T00:00:00")
})
CREATE (ph:Phone {
    number: "447971020304", 
    countryCode: "+44",
    createdAt: datetime("2024-01-01T00:00:00")
})

// Create customer's identity documents
CREATE (p:Passport {
    passportNumber: "123456789",
    issueDate: date("2020-01-01"),
    expiryDate: date("2030-01-01"),
    issuingCountry: "GB",
    nationality: "British",
    createdAt: datetime("2024-01-01T00:00:00")
})
CREATE (dl:DrivingLicense {
    licenseNumber: "SMITH901011J99AB",
    issueDate: date("2018-01-01"),
    expiryDate: date("2028-01-01"),
    issuingCountry: "GB",
    createdAt: datetime("2024-01-01T00:00:00")
})

// Create customer's face biometric
CREATE (f:Face {
    faceId: "FACE001",
    embedding: [0.153, 0.254, 0.255, 0.0, 0.0, 0.253, 0.200, 0.252, 0.254, 0.100, 0.253],  // Truncated example of 1536-dimension vector
    createdAt: datetime("2024-01-01T00:00:00")
})

//--------------------
// Create all identity relationships
//--------------------
// Link customer to their identity information
CREATE (c)-[:HAS_ADDRESS {
    addedAt: datetime("2024-01-01T00:00:00"),
    lastChangedAt: datetime("2024-01-01T00:00:00"),
    isCurrent: true
}]->(addr)
CREATE (addr)-[:LOCATED_IN]->(uk)
CREATE (c)-[:HAS_EMAIL {since: datetime("2024-01-01T00:00:00")}]->(e)
CREATE (c)-[:HAS_PHONE {since: datetime("2024-01-01T00:00:00")}]->(ph)
CREATE (c)-[:HAS_NATIONALITY]->(uk)

// Link customer to their identity documents
CREATE (c)-[:HAS_PASSPORT {
    verificationDate: datetime("2024-01-01T00:00:00"),
    verificationMethod: "VIDEO_KYC",
    verificationStatus: "VERIFIED"
}]->(p)
CREATE (c)-[:HAS_DRIVING_LICENSE {
    verificationDate: datetime("2024-01-01T00:00:00"),
    verificationMethod: "BRANCH_VERIFIED",
    verificationStatus: "VERIFIED"
}]->(dl)
CREATE (c)-[:HAS_FACE {
    verificationDate: datetime("2024-01-01T00:00:00"),
    verificationMethod: "SELFIE",
    verificationStatus: "VERIFIED"
}]->(f)

//--------------------
// Create digital access nodes
//--------------------
// Create device, IP, ISP, and session information
CREATE (d:Device {
    deviceId: "DEV001", 
    deviceType: "desktop", 
    userAgent: "Mozilla/5.0 Chrome/91.0",
    createdAt: datetime("2024-01-01T00:00:00")
})
CREATE (ip:IP {ipAddress: "192.168.1.1", createdAt: datetime("2024-01-01T00:00:00")})
CREATE (isp:ISP {name: "BT", createdAt: datetime("2024-01-01T00:00:00")})
CREATE (loc:Location {
    city: "London",
    postCode: "SW1A",
    country: "GB",
    latitude: 51.5074,
    longitude: -0.1278,
    createdAt: datetime("2024-01-01T00:00:00")
})
CREATE (s:Session {
    sessionId: "SESS001", 
    status: "success",
    createdAt: datetime("2024-03-01T10:00:00")
})

// Create digital access relationships
CREATE (d)-[:USED_BY {lastUsed: datetime("2024-03-01T10:00:00")}]->(c)
CREATE (s)-[:USES_IP]->(ip)
CREATE (ip)-[:IS_ALLOCATED_TO {createdAt: datetime("2024-01-01T00:00:00")}]->(isp)
CREATE (ip)-[:LOCATED_IN {createdAt: datetime("2024-01-01T00:00:00")}]->(loc)
CREATE (loc)-[:LOCATED_IN]->(uk)
CREATE (s)-[:SESSION_USES_DEVICE]->(d)

//--------------------
// Create banking nodes
//--------------------
// Create internal and external accounts
CREATE (a:Account:Internal {
    accountNumber: "ACC001", 
    accountType: "CURRENT", 
    openDate: datetime("2024-01-01T00:00:00"),
    closedDate: null,
    suspendedDate: null
})
CREATE (a2:Account:External:HighRiskJurisdiction {
    accountNumber: "ACC002", 
    accountType: null, 
    openDate: null,
    closedDate: null,
    suspendedDate: null
})

// Create transaction
CREATE (t1:Transaction {
    transactionId: "TXN001",
    amount: 1000.00,
    currency: "GBP",
    date: datetime("2024-03-01T11:00:00"),
    message: "Payment for services",
    type: "SWIFT"
})

//--------------------
// Create banking relationships
//--------------------
// Link accounts to customer and countries
CREATE (c)-[:HAS_ACCOUNT {role: "OWNER", since: datetime("2024-01-01T00:00:00")}]->(a)
CREATE (a)-[:IS_HOSTED]->(uk)
CREATE (a2)-[:IS_HOSTED]->(us)

// Create transaction flow
CREATE (a)-[:PERFORMS]->(t1)-[:BENEFITS_TO]->(a2)

//--------------------
// Create movements for transaction (example: insurance claim paid in instalments)
//--------------------
// Create movements
CREATE (m1:Movement {
    movementId: "MOV001",
    amount: 400.00,
    currency: "GBP",
    date: datetime("2024-03-05T10:00:00"),
    description: "Insurance claim payment 1 of 3",
    status: "COMPLETED",
    sequenceNumber: 1,
    authorisedBy: "USER001",
    validatedBy: "MANAGER001",
    createdAt: datetime("2024-03-01T11:00:00")
})
CREATE (m2:Movement {
    movementId: "MOV002",
    amount: 400.00,
    currency: "GBP",
    date: datetime("2024-03-12T10:00:00"),
    description: "Insurance claim payment 2 of 3",
    status: "COMPLETED",
    sequenceNumber: 2,
    authorisedBy: "USER001",
    validatedBy: "MANAGER002",
    createdAt: datetime("2024-03-01T11:00:00")
})
CREATE (m3:Movement {
    movementId: "MOV003",
    amount: 200.00,
    currency: "GBP",
    date: datetime("2024-03-19T10:00:00"),
    description: "Insurance claim payment 3 of 3",
    sequenceNumber: 3,
    authorisedBy: "USER001",
    validatedBy: null,
    createdAt: datetime("2024-03-01T11:00:00")
})

// Link transaction to movements
CREATE (t1)-[:IMPLIED {totalMovements: 3}]->(m1)
CREATE (t1)-[:IMPLIED {totalMovements: 3}]->(m2)
CREATE (t1)-[:IMPLIED {totalMovements: 3}]->(m3)

//--------------------
// Create counterparty
//--------------------
// Create counterparty and their address
CREATE (cp:Counterparty {
    counterpartyId: "CP001",
    name: "ACME Corporation Ltd",
    type: "BUSINESS",
    registrationNumber: "12345678",
    createdAt: datetime("2024-02-01T00:00:00")
})
CREATE (cpAddr:Address {
    addressLine1: "456 Business Park",
    addressLine2: "Suite 100",
    postTown: "Birmingham",
    postCode: "B1 1AA",
    region: "West Midlands",
    latitude: 52.4862,
    longitude: -1.8904,
    createdAt: datetime("2024-02-01T00:00:00")
})

// Link counterparty to address and account
CREATE (cp)-[:HAS_ADDRESS {
    since: datetime("2024-02-01T00:00:00"),
    isCurrent: true
}]->(cpAddr)
CREATE (cpAddr)-[:LOCATED_IN]->(uk)
CREATE (cp)-[:HAS_ACCOUNT {
    since: datetime("2024-02-01T00:00:00")
}]->(a2)
```
