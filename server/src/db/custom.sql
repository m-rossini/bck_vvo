insert into om_unit_convertion values ( 'EVENTS',     'UNIT',  1);
insert into om_unit_convertion values ( 'BILLINGS',   'UNIT',  1);
insert into om_unit_convertion values ( 'PERCENT',    'UNIT',  1);
insert into om_unit_convertion values ( 'EVT',        'UNIT',  1);

insert into om_unit_convertion values ( 'DURATION(S', 'TIME',  60);
insert into om_unit_convertion values ( 'SEC',        'TIME',  60);

insert into om_unit_convertion values ( 'DATA-.01MB', 'DATA',  10000);
insert into om_unit_convertion values ( '.01MB',      'DATA',  10000);
insert into om_unit_convertion values ( 'DATA-.01KB', 'DATA',     10);
insert into om_unit_convertion values ( '.01KB',      'DATA',     10);






CREATE TABLE MIG_LOG (
        ERROR_TYPE  VARCHAR(48) NOT NULL,
	LOG_MESSAGE VARCHAR(256) NOT NULL
);

CREATE OR REPLACE FUNCTION validateImport() RETURNS void AS $$
DECLARE
	old_pricing RECORD;
	new_pricing RECORD;
BEGIN
	DELETE FROM MIG_LOG;
	FOR old_pricing IN SELECT * FROM SVC_PRICE LOOP
		RAISE NOTICE 'validating svc_id (%)', old_pricing.svc_id;
		SELECT INTO new_pricing * FROM PRC_SERVICE_PRICE WHERE SCENARIO_ID = old_pricing.svc_id;
		IF NOT FOUND THEN
			INSERT INTO MIG_LOG VALUES ( 'NOT FOUND IN NEW TABLE', 'SVC_ID=' || old_pricing.svc_id || ';svc_name=' || old_pricing.svc_name );
		END IF;
		IF ((old_pricing.svc_init_price <> new_pricing.initial_unit_value) OR
                    (old_pricing.svc_add_price <> new_pricing.step_unit_value)) THEN
			UPDATE PRC_SERVICE_PRICE SET
				INITIAL_UNIT_VALUE = old_pricing.svc_init_price,
				STEP_UNIT_VALUE = old_pricing.svc_add_price
			WHERE   UID = new_pricing.uid;
			INSERT INTO MIG_LOG VALUES ( 'DIFF. CHARGE VALUES', 'SVC_ID=' || old_pricing.svc_id || ';svc_name=' || old_pricing.svc_name || ';was=' || old_pricing.svc_init_price || '/' || old_pricing.svc_add_price || ' & is now=' || new_pricing.initial_unit_value || '/' || new_pricing.step_unit_value);
		END IF;
	END LOOP;
	RETURN;
END; 
$$ LANGUAGE plpgsql;
