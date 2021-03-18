CREATE OR REPLACE FUNCTION public.etl_get_start_time(cntry_key character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
DECLARE
  err_context varchar;
  etl_start_time varchar;
  status_exec VARCHAR = 'Executing';
BEGIN

  SET search_path = public;

  etl_start_time = NOW();

  RETURN etl_start_time;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE EXCEPTION 'None start date returned';
    WHEN TOO_MANY_ROWS THEN
      RAISE EXCEPTION 'More than one start date';
    WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS err_context = PG_EXCEPTION_CONTEXT;
      RAISE INFO 'Error Name:%',SQLERRM;
      RAISE INFO 'Error State:%', SQLSTATE;
      RAISE INFO 'Error Context:%', err_context;

END;
$function$;
