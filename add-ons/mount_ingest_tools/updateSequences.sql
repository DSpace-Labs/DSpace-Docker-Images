SELECT
  setval(
    'handle_seq',
    CAST (
      max(
      to_number(
          regexp_replace(handle, '.*/', ''),
          '999999999999'
        )
      )
      AS BIGINT
    )
  )
FROM handle
WHERE handle SIMILAR TO '%/[0123456789]*';
