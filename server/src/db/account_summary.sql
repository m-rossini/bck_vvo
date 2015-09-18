CREATE TABLE bck_account_summary 
(
   uid serial PRIMARY KEY,
   external_id varchar(255),
   account_number varchar(64),
   account_state varchar(2),
   customer_type varchar(2),
   cycle_code varchar(10) not null,
   cycle_end date,
   due_date date not null,
   payments_amnt float8,
   penalties_amnt float8,
   interests_amnt float8,
   penalties_return_amnt float8,
   interests_return_amnt float8,
   contract_break_amnt float8,
   ajustment_amnt float8,
   month_instmt_amnt float8,
   eqpmnt_instmt_amnt float8,
   retention_amnt float8,
   dispute_credits float8,
   curr_period_amnt float8,
   state_tax_amnt float8,
   total_amnt float8
);

CREATE INDEX bck_account_summary_idx_1 ON bck_account_summary
(
  external_id,
  account_state,
  account_number
);

