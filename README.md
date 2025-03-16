Script com várias funções para otimizar o Windows e ter um maior desempenho e privacidade para jogos e produtividade.

## Essas são as opções atuais disponíveis nele:

#### -Desativar telemetria.
#### -Menu de contexto clássico.
#### -Desativar Hibernar.
#### -Habilitar alto desempenho.
#### -Desativar UAC
#### -Otimizar barra de tarefas e menu iniciar.
#### -Desativa histórico de área de transferência.

> [!Warning]
> Testamos muito bem para que o script nao cause danos ao sistema, porem use por sua própria conta e risco!

## Como executar o script:
Clique com o lado direito do mouse em cima do arquivo e clique na opção "Executar com PowerShell"


#### Caso apareça o erro do tipo "A execução de scripts foi desabilitada neste sistema." você pode estar usando a seguinte solução a baixo.

Você pode controlar estas permissões usando o cmdlet Set-ExecutionPolicy. E pode conferir qual a política de execução atual usando o cmdlet Get-ExecutionPolicy.
Existem vários tipos de permissão que você pode usar com este cmd comando

Restricted
Não carrega nem executa arquivos de configuração e/ou scripts do Powershell.

AllSigned
Só executa scripts e arquivos de configuração assinados por um fornecedor confiável, mesmo que o script tenha sido escrito por você mesmo (local).

RemoteSigned
É basicamente o mesmo que o acima, porém permite a execução de arquivos de configuração e/ou scripts locais.

Unrestricted
Carrega e executa todos os arquivos de configuração e scripts PowerShell. Pode ser pedida uma confirmação para executar scripts não assinados.

Bypass
Não há nenhuma restrição.

Undefined
Remove a política de execução atual. Exceto se ela estiver definida numa diretiva de grupo.

## Exemplo

Abra o CMD ou o PowerShell e insira o seguinte comando a baixo

```Set-ExecutionPolicy Bypass```

Ele removerá qualquer restrição de execução de scripts em sua máquina.
