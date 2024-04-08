
# view: sql_runner_query5 {
#   derived_table: {
#     sql: SELECT
#     orders.status  AS `orders.status`,
#           MAX(CAST(( DATE(CONVERT_TZ(orders.created_at ,'UTC','America/Los_Angeles')) ) as date)) AS `orders.max_date`,
#           MAX(CASE WHEN orders.status   = "COMPLETED" THEN CAST(( DATE(CONVERT_TZ(orders.created_at ,'UTC','America/Los_Angeles')) ) as date) ELSE NULL END) AS `filtered_ordersmax_date`
#       FROM demo_db.orders  AS orders
#       LIMIT 500 ;;
#   }

#   measure: count {
#     type: count
#     drill_fields: [detail*]
#   }

#   dimension: orders_max_date {
#     type: string
#     sql: ${TABLE}.`orders.max_date` ;;
#   }


#   dimension: filtered_ordersmax_date {
#     type: string
#     sql: ${TABLE}.filtered_ordersmax_date ;;
#   }

#   set: detail {
#     fields: [
#         orders_max_date,
# filtered_ordersmax_date
#     ]
#   }
# }
