-- Current nominees including Nastya in Queen and Zhenya in Style.
-- Retains voting dates, votes and permissions; does not open voting.
begin;
do $update$
declare
 definition text;
 updated text;
begin
 definition := pg_get_functiondef('public.cast_vote(integer,text,uuid)'::regprocedure);
 if definition !~ $pattern$config jsonb := '[^
]*'::jsonb;$pattern$ then
  raise exception 'Voting configuration not recognized; no changes applied';
 end if;
 updated := regexp_replace(definition, $pattern$config jsonb := '[^
]*'::jsonb;$pattern$, $replacement$config jsonb := '{"0":{"title":"PRESTIGE King","candidates":["Арсений_Gadza","Рома_semki","Синан_rightchappa","Арсений_broffq","Егор_Frize16","Максим_samlame","Никита_Студенов","Егор_Панк","Рома_faneriks"]},"1":{"title":"PRESTIGE Queen","candidates":["Чукотка","Полина","Кира","Натусик","Женя","Вика","Кристина","Настя"]},"2":{"title":"Стиль года","candidates":["Арсений_Толстый","Синан_rightchappa","Рома_semki","Егор_Frize16","Лёша_Сандул","Арсений_Gadza","Арсений_Футбольный","Егор_Панк","Максим_samlame","Лёха_Dizary","Женя"]},"3":{"title":"Конфликт года","candidates":["Синан_rightchappa × Рома × Кристина × Вика","Драка на поле","Арсений × Арсений_Gadza","Арсений_Gadza × Некит"]},"4":{"title":"Завоз года","candidates":["Авария Карша","Трусы Никиты","Марвел на ДР Егора","Тёма наблевал","Все мы любим Настин ***","Арсений украл трусы у Саши","Снесли знак"]},"5":{"title":"Ксер года","candidates":["Арсений_Gadza","Рома_semki","Синан_rightchappa","Арсений_broffq","Егор_Frize16","Максим_samlame","Арсений_Футбольный","Лёха_Dizary","Глеб_mickey"]},"6":{"title":"Дотер года","candidates":["Рома_faneriks","Егор_Frize16","Никита_Студенов","Синан_rightchappa","Рома_semki","Лёня_Зотов"]},"7":{"title":"Прорыв года","candidates":["Лёша_Сандул","Саня_wynedra","Лёха_Dizary","Натусик","Валера","Глеб_mickey","Саня_ЕКБ"]},"8":{"title":"Футболист года","candidates":["Макс_Афонин","Дэн_Афонин","Егор_Frize16","Лёшка","Максим_Скопцов","Рома_semki","Арсений_Лавринович","Синан_rightchappa","Арсений_Футбольный","Арман","Жендос","Валя","Шамрай","Слава"]},"9":{"title":"Алкаш года","candidates":["Рома_semki","Егор_Frize16","Лёша_Сандул","Макс_Афонин","Синан_rightchappa","Арсений_Пауков","Тёма","Егор_Панк","Арсений_Футбольный","Марк","Максим_Скопцов","Арсений_Gadza"]},"10":{"title":"Пара года","candidates":["Егор × Кира","Арсений_Толстый × Чукотка","Арсений_Gadza × Ульяна","Макс_Афонин × Полина","Максим_Колесников × Настя","Максим_Скопцов × Ксюша","Слава × Настя"]},"11":{"title":"Тусовка года","candidates":["ДР Егора","ДР Ромы","ДР Синана","Проводы Максима","Шашлыки ЛЧ","Каток","Монополия у Ромы"]},"12":{"title":"Хата года","candidates":["У Ромы в Мытищах","У Синана","У Ромчика в Долгопрудном","У Ромчика на стройке","У Егора_Frize16","У Ромы в Москве","У Ромчика на Алтушке","У Егора_Панка"]},"13":{"title":"Duo года","candidates":["Синан_rightchappa × Арсений_Толстый","Арсений_Gadza × Рома_semki","Егор × Лёша_Сандул","Максим_Скопцов × Данёк","Марк × Тёмыч","Макс_Афонин × Дэн_Афонин","Арсений_Gadza × Лёха_Dizary"]},"14":{"title":"Харизма года","candidates":["Саня","Егор_Frize16","Лёша_Сандул","Шамрай","Синан_rightchappa"]}}'::jsonb;$replacement$);
 execute updated;
end
$update$;
notify pgrst, 'reload schema';
commit;
