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


CREATE SCHEMA IF NOT EXISTS raw;

CREATE TABLE IF NOT EXISTS raw.log_events (
    id BIGSERIAL PRIMARY KEY,
    event_time TIMESTAMPTZ,
    service_name TEXT,
    message TEXT
);


-- Vector invia id=NULL: questo trigger assegna il valore della sequenza.
CREATE OR REPLACE FUNCTION raw.assign_log_event_id()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF NEW.id IS NULL THEN
        NEW.id := nextval(
            pg_get_serial_sequence('raw.log_events', 'id')
        );
    END IF;

    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_assign_log_event_id
    ON raw.log_events;

CREATE TRIGGER trg_assign_log_event_id
BEFORE INSERT ON raw.log_events
FOR EACH ROW
EXECUTE FUNCTION raw.assign_log_event_id();