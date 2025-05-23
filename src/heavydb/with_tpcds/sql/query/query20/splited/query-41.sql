select  distinct(i_product_name)
 from item i1
 where i_manufact_id between 754 and 754+40 
   and (select count(*) as item_cnt
        from item
        where (i_manufact = i1.i_manufact and
        ((i_category = 'Women' and 
        (i_color = 'cornflower' or i_color = 'lace') and 
        (i_units = 'Lb' or i_units = 'Ton') and
        (i_size = 'medium' or i_size = 'extra large')
        ) or
        (i_category = 'Women' and
        (i_color = 'aquamarine' or i_color = 'almond') and
        (i_units = 'Pound' or i_units = 'Oz') and
        (i_size = 'petite' or i_size = 'N/A')
        ) or
        (i_category = 'Men' and
        (i_color = 'honeydew' or i_color = 'cyan') and
        (i_units = 'Ounce' or i_units = 'Case') and
        (i_size = 'small' or i_size = 'economy')
        ) or
        (i_category = 'Men' and
        (i_color = 'blush' or i_color = 'coral') and
        (i_units = 'Bundle' or i_units = 'N/A') and
        (i_size = 'medium' or i_size = 'extra large')
        ))) or
       (i_manufact = i1.i_manufact and
        ((i_category = 'Women' and 
        (i_color = 'chartreuse' or i_color = 'firebrick') and 
        (i_units = 'Unknown' or i_units = 'Dozen') and
        (i_size = 'medium' or i_size = 'extra large')
        ) or
        (i_category = 'Women' and
        (i_color = 'smoke' or i_color = 'orchid') and
        (i_units = 'Tbl' or i_units = 'Cup') and
        (i_size = 'petite' or i_size = 'N/A')
        ) or
        (i_category = 'Men' and
        (i_color = 'burnished' or i_color = 'sienna') and
        (i_units = 'Tsp' or i_units = 'Box') and
        (i_size = 'small' or i_size = 'economy')
        ) or
        (i_category = 'Men' and
        (i_color = 'navajo' or i_color = 'hot') and
        (i_units = 'Gross' or i_units = 'Gram') and
        (i_size = 'medium' or i_size = 'extra large')
        )))) > 0
 order by i_product_name
 limit 100;

