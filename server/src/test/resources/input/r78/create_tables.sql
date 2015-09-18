CREATE TABLE R78_ACCTYPEANDHIRCH (
  PARENT_ACCT          				   VARCHAR2(64),
  ACCT_NBR                       VARCHAR2(64),
  ACCT_TYPE_CD                   VARCHAR2(64),
  ACCT_HIRCH_ID                  VARCHAR2(64),
  HIRCH_ACCT_ASGM_EFF_DT         VARCHAR2(8),
  HIRCH_ACCT_ASGM_EXPR_DT        VARCHAR2(8));  

CREATE TABLE R78_ACCTYPE (
  ACCT_NBR                       VARCHAR2(64),
  ACCT_TYPE_CD                   VARCHAR2(64));  
  