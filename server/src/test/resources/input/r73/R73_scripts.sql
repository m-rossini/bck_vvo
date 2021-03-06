create table R73_SVC_PRICE (
    MEMBER_SVC_NAME   VARCHAR2(20),
    SVC_PRICE_EFF_DT  VARCHAR2(20),
    SVC_PRICE_EXPR_DT VARCHAR2(20),
    CHARGE_TYPE_CD    VARCHAR2(20),
    CAPTN_CD          VARCHAR2(20)
)
/
create table R73_INVC_CAPTN (
    CHARGE_TYPE_CD    VARCHAR2(20),
    CAPTN_CD          VARCHAR2(20),
    CAPTN_TEXT        VARCHAR2(20)  
)
/
create table R73_SVC_AGRMNT_LINE_ITEM (
    SBSCRP_ID            VARCHAR2(20),
    SVC_NAME             VARCHAR2(20),
    SVC_AGRMNT_EFF_DT    VARCHAR2(20),
    SVC_AGRMNT_TRMNTN_DT VARCHAR2(20)
)
/
create table R73_SBSCRP_ASGM (
    SBSCRP_ID            VARCHAR2(20),
    ACCT_NBR             VARCHAR2(20),
    SBSCRP_ASGM_EXPR_DT  VARCHAR2(20),
    SBSCRP_ASGM_EFF_DT   VARCHAR2(20),
    svc_price_seq_nbr VARCHAR2(20)
)
/
create table R73_ACCT_CYCLE (
    CYCLE_CD  VARCHAR2(20),
    ACCT_NBR  VARCHAR2(20)
)
