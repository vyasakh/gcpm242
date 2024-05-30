view: orders {
  sql_table_name: demo_db.orders ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_at ;;
  }
  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  # measure: max_date {
  #   type: max

  #   sql: CONVERT((${created_date}), DATE) ;;
  # }
  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }
  measure: count {
    type: count
    drill_fields: [detail*]
  }
  parameter: date_type

  {     type: unquoted     allowed_value:

    { value: "Day" }
    allowed_value: { value: "Week" }
    allowed_value: { value: "Month" }
    allowed_value: { value: "Quarter" }
    allowed_value: { value: "Year" }
  }
  dimension: report_date{
    sql:
    {% if date_type._parameter_value == 'Day' %}
    ${created_date}
    {% elsif date_type._parameter_value == 'Week' %}
    ${created_week}
    {% elsif date_type._parameter_value == 'Month' %}
    ${created_month}
    {% elsif date_type._parameter_value == 'Quarter' %}
    ${created_quarter}
    {% elsif date_type._parameter_value == 'Year' %}
    ${created_year}
    {% else %}
    ${created_date}
      {% endif %};;   }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
  id,
  users.id,
  users.first_name,
  users.last_name,
  billion_orders.count,
  fakeorders.count,
  hundred_million_orders.count,
  hundred_million_orders_wide.count,
  order_items.count,
  order_items_vijaya.count,
  ten_million_orders.count
  ]
  }

}
