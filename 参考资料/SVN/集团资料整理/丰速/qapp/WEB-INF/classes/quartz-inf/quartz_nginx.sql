DROP TABLE IF EXISTS qrtz_job_triggers;

CREATE TABLE qrtz_job_triggers
  (
    sched_name VARCHAR(128) NOT NULL,
    context_instance_id VARCHAR(32),
    trigger_name VARCHAR(128),
    trigger_group VARCHAR(128),
    job_name VARCHAR(128),
    job_group VARCHAR(128),
    start_time BIGINT(13),
    PRIMARY KEY (sched_name,context_instance_id)
);