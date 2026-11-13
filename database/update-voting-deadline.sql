-- Move the voting cutoff to midnight after 19 November in Moscow.
-- Preserve current nominees, start time, ballots and permissions.
begin;

do $migration$
declare
  fn regprocedure;
  definition text;
  previous_deadline constant text := '2026-11-28 00:00:00+03';
  new_deadline constant text := '2026-11-20 00:00:00+03';
begin
  foreach fn in array array[
    'public.cast_vote(integer,text,uuid)'::regprocedure,
    'public.vote_stats()'::regprocedure
  ] loop
    definition := pg_get_functiondef(fn);
    if strpos(definition, quote_literal(previous_deadline)) > 0 then
      execute replace(definition, quote_literal(previous_deadline), quote_literal(new_deadline));
    elsif strpos(definition, quote_literal(new_deadline)) = 0 then
      raise exception 'Unexpected voting deadline in %; no changes applied', fn;
    end if;
  end loop;
end;
$migration$;

commit;

select public.vote_stats() as voting_status;
