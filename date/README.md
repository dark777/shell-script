---
title: Desvendando o comando DATE
---

## Este tutorial mostra alguns exemplos de como utilizar o comando date para:

    Exibir a data/hora do Sistema;
    Alterar a data/hora do Sistema;
    Exibir a data/hora Formatada;
    Efetuar cálculos com Data e Hora. 

## Alterando a Data e Hora do Sistema: ##

Toda vez que o sistema operacional Linux é inicializado, este busca no relógio da BIOS
(também chamado de relógio de hardware) as configurações necessárias para configurar a
data/hora do sistema. Ou seja, no Linux podemos ter a data/hora do sistema diferente da data/hora
que temos no hardware, e essa informação é muito importante no momento de efetuar ajustes.

Pode-se ajustar sua data e hora conforme necessário, porém a mesma não será mantida até
o próximo boot, quando o sistema fará uma nova requisição ao relógio do hardware para ajustar-se.

Se for executado apenas o comando date no shell do Linux será obtido um
resultado com a seguinte formatação:

> Qui Jun 19 21:37:16 BRT 2008

Para ajustar a data do sistema para um dia qualquer
poderia ser utilizado o seguinte comando:

Sintaxe: date mês/dia/ano

    $ date -s 04/01/2018

Após ajustar a data do sistema é importante sincronizá-la com a data do hardware,
para isso use o seguinte comando na seqüência:

    $ hwclock -w

Dica: Para ajustar a data/hora do sistema e sincronizar com o hardware em um 
único comando é muito simples, basta seguir a seguinte sintaxe:

- mm (mês 00-12)
- dd (dia 00-31)
- HH (hora 00-23)
- MM (min 00-59)
- YYYY (0000-9999)

Exemplo 1: Ajustar a data para o dia 14 de setembro de 2008 e a hora para 18:30, 
por fim sincronizar com o relógio do hardware:

    $ date 091418302008 | hwclock -w

Exemplo 2: Ajustar a data para o dia 10 de agosto de 1987 e a hora para 07:50,
por fim sincronizar com o relógio do hardware:

    $ date 081007501987 | hwclock -w

## Parâmetros que podem ser utilizados para formatação de datas:

- %A : dia da semana (domingo,..., sábado).
- %B : nome do mês (janeiro,..., dezembro).
- %H : hora do dia (0 a 23).
- %M : minuto (0 a 59).
- %S : segundos (0 a 61).
- %T : hora no formato hh:mm:ss.
- %Y : ano.
- %a : dia da semana abreviado (dom,..., sab).
- %b : nome do mês abreviado (jan,..., dez).
- %c : dia da semana, data e hora.
- %d : dia do mês (00-31).
- %j : dia ano (1 a 366).
- %m : mês (1 a 12).
- %s : número de segundos desde das zero horas de 01/01/1970.
- %w : dia da semana, onde 0 = domingo, 1 = segunda,..., 6 = sábado.
- %x : representação da data local.
- %y : os dois últimos dígitos do ano.
- %r : formato de 12 horas completo (hh:mm:ss AM/PM) 

## Exemplos de formatações de data/hora com o comando date no shell:

    $ date
> Saída: Qui Jun 19 22:40:28 BRT 2008

    $ date +%d/%m/%y
> Saída: 19/06/08

    $ date +%d/%m/%Y
> Saída: 19/06/2008

    $ date +%H:%M:%S
> Saída: 22:45:24

    $ date "+%d %B %Y"
> Saída: 19 junho 2008

    $ date "+%d %B %Y , %A"
> Saída: 19 junho 2008 , quinta


## Exemplos de cálculos com Data/Hora no Linux.

## Qual a data de cinco dias atrás?

    $ date +%d%m%y -d "5 days ago"
> Saída: 140608

## Que dia e hora serão, se adicionarmos 45 horas na hora atual?

    $ date --date "45 hours"
> Saída: Sáb Jun 21 20:02:38 BRT 2008

## Que dia será daqui duas semanas?

    $ date -d "2 week"
> Saída: Qui Jul 3 23:22:25 BRT 2008

## Que dia será daqui a 5 meses e 2 dia?

    $ date -d "5 month 2 day"
> Saída: Sáb Nov 22 00:37:53 BRST 2008

## Outro exemplos:

    $ date
> Qui Jun 19 23:56:28 BRT 2008

    $ date --date=now
> Qui Jun 19 23:56:28 BRT 2008

    $ date --date=today #Mesma Coisa
> Qui Jun 19 23:56:28 BRT 2008

    $ date --date='3 seconds'
> Qui Jun 19 23:56:31 BRT 2008

    $ date --date='3 seconds ago'
> Qui Jun 19 23:56:25 BRT 2008

    $ date --date='4 hours'
> Sex Jun 20 03:56:28 BRT 2008

    $ date --date='tomorrow'
> Sex Jun 20 23:56:28 BRT 2008

    $ date --date='1 day'
> Sex Jun 20 23:56:28 BRT 2008

    $ date --date='1 days'
> Sex Jun 20 23:56:28 BRT 2008

    $ date --date='yesterday'
> Qua Jun 18 23:56:28 BRT 2008

    $ date --date='1 day ago'
> Qua Jun 18 23:56:28 BRT 2008

    $ date --date='1 days ago'
> Qua Jun 18 23:56:28 BRT 2008

    $ date --date='1 week'
> Qui Jun 26 23:56:28 BRT 2008

    $ date --date='1 fortnight'
> Qui Jul 3 23:56:28 BRT 2008

    $ date --date='1 month'
> Sáb Jul 19 23:56:28 BRT 2008

    $ date --date='1 year'
> Sex Jun 19 23:56:28 BRT 2009