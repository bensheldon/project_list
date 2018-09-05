class Screenshot < ApplicationRecord
  belongs_to :project

  has_one_attached :desktop_image
  has_one_attached :mobile_image

  scope :recent, ->(count = 1) do
    # This scope is complex. The table_reference (which is `projects`) is aliased to be
    # the model's table (`screenshots`) so that when this scope is used in an association
    # the eagerloaded foreign key query (`WHERE screenshots.project_id` IN ...) will work properly.
    #
    # SELECT <columns>
    # FROM <table reference>
    #      JOIN LATERAL <subquery>
    #      ON TRUE;
    #
    query = select('subquery.*').from('(SELECT *, id AS project_id FROM projects) AS screenshots')
    join_sql = <<~SQL
      JOIN LATERAL (
        SELECT * FROM screenshots AS sub_statuses
        WHERE sub_statuses.project_id = screenshots.project_id
        ORDER BY created_at DESC LIMIT :count
      ) AS subquery ON TRUE
    SQL

    query.joins(sanitize_sql_array([join_sql, { count: count }]))
  end
end
