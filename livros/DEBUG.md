---
title: Debugando Shell script
---

### Use os cabeçalhos
```
#!/bin/bash -x
ou
#!/bin/bash -vx
```
-   Onde:

    - v :: Mostra os comandos à medida que são lidos pelo bash.
    
    - x :: Expande os resultados dos comandos e variáveis
    (muito útil quando o shell script possui variáveis numéricas e laços de repetição, por exemplo).

### Você pode usar o comando acima dois no próprio script shell:

script:
```
#!/bin/bash
clear
#turn on debug mode
set -x
for f in *
 do
 file $f
done
#turn OFF debug mode
set +x
ls
#more commands
```

### Você pode substituir a linha padrão de Shebang para depuração
```
de:
#!/bin/bash
para
#!/bin/bash -x
ou
#!/bin/bash -vx
```

### Use uma função DEBUG inteligente

Primeiro, adicione uma variável especial chamada  _DEBUG. Set _DEBUG  para 'on' quando você precisa depurar um script:
```
 _DEBUG="on"
```
Coloque a seguinte função no início do script:
```
function DEBUG()
 {
  [ "$_DEBUG" == "on" ] &&  $@
 }
```
### Agora, onde quer que você precise de depuração, use simplesmente a função DEBUG da seguinte maneira:
```
DEBUG echo "File is $filename"
ou
DEBUG set -x
Cmd1
Cmd2
DEBUG set +x
```
Quando terminar com depuração (e antes de mover seu script para a produção), configure _DEBUG para 'off'. 
Não é necessário excluir linhas de depuração.
```
_DEBUG="off" # set to anything but not to 'on'
```
Script de exemplo:
```
#!/bin/bash
 _DEBUG="on"
function DEBUG()
 {
  [ "$_DEBUG" == "on" ] &&  $@
 }

 DEBUG echo 'Reading files'
 for i in *
 do
  grep 'something' $i > /dev/null
  [ $? -eq 0 ] && echo "Found in $i file"
 done
 DEBUG set -x
 a=2
 b=3
 c=$(( $a + $b ))
 DEBUG set +x
echo "$a + $b = $c"
```

### Salve e feche o arquivo.

Execute o script da seguinte maneira:

    $ ./script.sh

### Output:

Reading files
Found in xyz.txt file
```
a=2
b=3
c=5
DEBUG set +x
'[' on == on ']'
set +x
2 + 3 = 5
```
### Agora, defina DEBUG como desligado.

você precisa editar o arquivo:
```
 _DEBUG="off"
```
Execute o script:

    $ ./script.sh

Output:
```
Found in xyz.txt file
2 + 3 = 5
```

### Caso não queira usar um dos passos acima ou as Shebang em seu arquivo shell basta fazer:

    $ bash -x meuscript.sh


- **Debugging Shell Script**: https://www.cyberciti.biz/tips/debugging-shell-script.html

```
Para fazer debug de Bash-Script existem algumas ferramentas muito úteis:
Parametro -n no bash

O uso do comando bash -n faz a análise sintáxica do seu script,
para verificar se existem erros de digitação ou que impessam seu script de ser executado.
```
Arquivo: exemploBashN.sh
```
#!/bin/bash

echo "Isso é um exemplo"
echo "Agora falta uma aspas
echo "E o bash -n deve notificar esse problema"
```
Execução:

    $ bash -n exemploBashN.sh
 + exemploBashN.sh: line 5: unexpected EOF while looking for matching `"'
 + exemploBashN.sh: line 7: syntax error: unexpected end of file

```
Comando set

O comando set permite habilitar e desabilitar algumas funcionalidades do bash. Quando usado com -, ele habilita a funcionalidade. Quando usando com + ele desliga a mesma.
set -x

Ativa a impressão da EXPRESSÃO executada.
```

Arquivo: exemploBashSetX.sh
```
#!/bin/bash

set -x
echo "Quantos anos você tem?"
read idade
echo "Você tem $idade anos"
set +x
echo "Agora sem imprimir a expressão executada"
```
Execução:

    $ ./exemploSetX.sh
    
 + echo 'Quantos anos você tem?'
 + Quantos anos você tem?
 + read idade
 + 26
 + echo 'Você tem 26 anos'
 + Você tem 26 anos
 + set +x
 + Agora sem imprimir a expressão executada

set -v

Ativa a impressão da LINHA executada

Arquivo: exemploSetV.sh
```
#!/bin/bash

set -v
echo "Quantos anos você tem?"
read idade
echo "Você tem $idade anos"
set +x
echo "Agora sem imprimir a LINHA executada"
```
Execução:

    $ ./exemploSetV.sh
 + echo "Quantos anos você tem?"
 + Quantos anos você tem?
 + read idade
 + 26
 + echo "Você tem $idade anos"
 + Você tem 26 anos
 + set +v
 + Agora sem imprimir a LINHA executada

set -e

Aborta a execução do script quando qualquer comando falhar.

Arquivo: exemploSetE.sh
```
#!/bin/bash

set -e

echo "Carregando www.goooooooogle.com.br (site não existe)"

curl -v -f "www.goooooooogle.com.br" > site.html

echo "Essas linha não serão executadas"
echo "pois o comando 'curl' não conseguiu executar com sucesso"   

set +e

echo "Nem essas, pois o script já foi abortado."
```
Execução:

    $ ./exemploSetE.sh
Carregando www.goooooooogle.com.br (site não existe)
* Rebuilt URL to: www.goooooooogle.com.br/
* Could not resolve host: www.goooooooogle.com.br
* Closing connection 0
curl: (6) Could not resolve host: www.goooooooogle.com.br

### Comando trap

O comando trap pode ser utilizado junto com o read para simular o uso de breakpoints.
```
#!/bin/bash

echo "após o comando \"trap 'read' DEBUG\", aperte ENTER para executar o proximo comando"

trap 'read' DEBUG 

echo "olá"
echo "mundo"
echo "bash"
echo "é só love"

trap - DEBUG 

echo "agora"
echo "sem"
echo "debug"
```
Execução:

    $ ./exemploTrap.sh 
``` 
após o comando "trap 'read' DEBUG", aperte ENTER para executar o proximo comando
<ENTER>
olá
<ENTER>
mundo
<ENTER>
bash
<ENTER>
é só love
<ENTER>
agora
sem
debug
```
### Se você só quiser debugar uma parte do código, pode encerrar ela com set:
```
set -x
<código>
set +x
```
+ Fonte:
- http://shellscript.com.br/
- tldp.org/LDP/abs/html/debugging.html