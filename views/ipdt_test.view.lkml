
view: ipdt_test {
  derived_table: {
    sql: SELECT
                    order_items.order_id AS order_id
                    ,order_items.id AS user_id
                    ,COUNT(*) AS order_item_count
                  FROM demo_db.order_items
                  WHERE order_items.returned_at >= '2018-01-01'
                  GROUP BY order_id, user_id
                  LIMIT 10 ; ; ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: order_item_count {
    type: number
    sql: ${TABLE}.order_item_count ;;
  }

  set: detail {
    fields: [
        order_id,
  user_id,
  order_item_count
    ]
  }
}
