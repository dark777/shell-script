---
title: Debugando Shell script
---

### Use os cabeçalhos

#!/bin/bash -x
ou
#!/bin/bash -vx

-   Onde:

    -   v :: Mostra os comandos à medida que são lidos pelo bash.
    
    - x :: Expande os resultados dos comandos e variáveis
    (muito útil quando o shell script possui variáveis numéricas e laços de repetição, por exemplo).

# Você pode usar o comando acima dois no próprio script shell:

script:

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


# Você pode substituir a linha padrão de Shebang para depuração

de #!/bin/bash
para
#!/bin/bash -x
ou
#!/bin/bash -vx

# Use uma função DEBUG inteligente

Primeiro, adicione uma variável especial chamada  _DEBUG. Set _DEBUG  para 'on' quando você precisa depurar um script:

_DEBUG="on"

Coloque a seguinte função no início do script:

function DEBUG()
{
 [ "$_DEBUG" == "on" ] &&  $@
}

# Agora, onde quer que você precise de depuração, use simplesmente a função DEBUG da seguinte maneira:

DEBUG echo "File is $filename"

ou
DEBUG set -x
Cmd1
Cmd2
DEBUG set +x

Quando terminar com depuração (e antes de mover seu script para a produção), configure _DEBUG para 'off'. 
Não é necessário excluir linhas de depuração.

_DEBUG="off" # set to anything but not to 'on'

Script de exemplo:

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


# Salve e feche o arquivo.

Execute o script da seguinte maneira:

bash-4.4$ ./script.sh

# Output:

Reading files
Found in xyz.txt file
+ a=2
+ b=3
+ c=5
+ DEBUG set +x
+ '[' on == on ']'
+ set +x
2 + 3 = 5

# Agora, defina DEBUG como desligado.

você precisa editar o arquivo:

_DEBUG="off"

Execute o script:

bash-4.4$ ./script.sh

# Output:

Found in xyz.txt file
2 + 3 = 5


# Caso não queira usar um dos passos acima ou as Shebang em seu arquivo shell basta fazer:

bash-4.4 bash -x meuscript.sh


https://www.cyberciti.biz/tips/debugging-shell-script.html