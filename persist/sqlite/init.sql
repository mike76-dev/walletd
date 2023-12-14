CREATE TABLE siacoin_elements (
	id INTEGER PRIMARY KEY,
	maturity_height INTEGER NOT NULL, /* stored as int64 for easier querying */
	leaf_index INTEGER NOT NULL,
	merkle_proof BLOB NOT NULL,
	output_id BLOB UNIQUE NOT NULL,
	siacoin_value BLOB NOT NULL,
	sia_address TEXT NOT NULL
);
CREATE INDEX siacoin_elements_sia_address ON siacoin_elements (sia_address);

CREATE TABLE siafund_elements (
	id INTEGER PRIMARY KEY,
	leaf_index INTEGER NOT NULL,
	merkle_proof BLOB NOT NULL,
	output_id BLOB UNIQUE NOT NULL,
	siafund_value BLOB NOT NULL,
	claim_start BLOB NOT NULL,
	sia_address TEXT NOT NULL
);
CREATE INDEX siafund_elements_sia_address ON siafund_elements (sia_address);

CREATE TABLE wallets (
	id INTEGER PRIMARY KEY,
	friendly_id TEXT UNIQUE NOT NULL,
	extra_data BLOB NOT NULL
);
CREATE index wallets_friendly_id_idx ON wallets (friendly_id);

CREATE TABLE wallet_addresses (
	id INTEGER PRIMARY KEY,
	wallet_id INTEGER NOT NULL REFERENCES wallets (id),,
	sia_address TEXT NOT NULL,
	UNIQUE (wallet_id, sia_address)
);
CREATE INDEX wallet_addresses_wallet_id_idx ON wallet_addresses (wallet_id);

CREATE TABLE events (
	id INTEGER PRIMARY KEY,
	date_created INTEGER NOT NULL,
	block_height INTEGER NOT NULL,
	block_id BLOB NOT NULL,
	event_type TEXT NOT NULL,
	event_data TEXT NOT NULL
);

CREATE TABLE event_addresses (
	id INTEGER PRIMARY KEY,
	event_id INTEGER NOT NULL REFERENCES events (id),
	sia_address TEXT NOT NULL,
	UNIQUE (event_id, sia_address)
);
CREATE INDEX event_addresses_event_id_idx ON event_addresses (event_id);