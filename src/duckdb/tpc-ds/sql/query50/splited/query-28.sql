select  *
from (select avg(ss_list_price) B1_LP
            ,count(ss_list_price) B1_CNT
            ,count(distinct ss_list_price) B1_CNTD
      from store_sales
      where ss_quantity between 0 and 5
        and (ss_list_price between 68 and 68+10 
             or ss_coupon_amt between 5630 and 5630+1000
             or ss_wholesale_cost between 12 and 12+20)) B1,
     (select avg(ss_list_price) B2_LP
            ,count(ss_list_price) B2_CNT
            ,count(distinct ss_list_price) B2_CNTD
      from store_sales
      where ss_quantity between 6 and 10
        and (ss_list_price between 30 and 30+10
          or ss_coupon_amt between 9141 and 9141+1000
          or ss_wholesale_cost between 19 and 19+20)) B2,
     (select avg(ss_list_price) B3_LP
            ,count(ss_list_price) B3_CNT
            ,count(distinct ss_list_price) B3_CNTD
      from store_sales
      where ss_quantity between 11 and 15
        and (ss_list_price between 49 and 49+10
          or ss_coupon_amt between 9042 and 9042+1000
          or ss_wholesale_cost between 2 and 2+20)) B3,
     (select avg(ss_list_price) B4_LP
            ,count(ss_list_price) B4_CNT
            ,count(distinct ss_list_price) B4_CNTD
      from store_sales
      where ss_quantity between 16 and 20
        and (ss_list_price between 143 and 143+10
          or ss_coupon_amt between 17187 and 17187+1000
          or ss_wholesale_cost between 7 and 7+20)) B4,
     (select avg(ss_list_price) B5_LP
            ,count(ss_list_price) B5_CNT
            ,count(distinct ss_list_price) B5_CNTD
      from store_sales
      where ss_quantity between 21 and 25
        and (ss_list_price between 169 and 169+10
          or ss_coupon_amt between 16554 and 16554+1000
          or ss_wholesale_cost between 57 and 57+20)) B5,
     (select avg(ss_list_price) B6_LP
            ,count(ss_list_price) B6_CNT
            ,count(distinct ss_list_price) B6_CNTD
      from store_sales
      where ss_quantity between 26 and 30
        and (ss_list_price between 71 and 71+10
          or ss_coupon_amt between 5840 and 5840+1000
          or ss_wholesale_cost between 22 and 22+20)) B6
limit 100;

