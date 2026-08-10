CREATE TABLE IF NOT EXISTS network_measurements (
    id BIGSERIAL PRIMARY KEY,
    measured_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    source VARCHAR(255) NOT NULL,
    destination VARCHAR(255) NOT NULL,
    latency_ms DOUBLE PRECISION,
    packet_loss_percent DOUBLE PRECISION,
    notes TEXT
);

CREATE INDEX IF NOT EXISTS idx_network_measurements_measured_at
    ON network_measurements (measured_at DESC);