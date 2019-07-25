
Feita Integração do RH para empresa SAP- Software e Soluções Inteligentes na Nuvem

## Abrangência

Clientes que necessitam efetuar a importação do arquivo de integração na contabilidade da folha de pagamento SAP.

## Aplicação

Será disponibilizado pela fornecedora do sistema de RH (SAP) um arquivo texto separado por (;) ponto e vírgula, com as informações para serem contabilizadas. 
Portanto, foi desenvolvido o programa, para que possa realizar a importação, gravando os dados na contabilidade, conforme layout do arquivo.

Para iniciar a integração contábil dos registros, será feito os seguintes passos.
Acessando o Menu “Contabilidade > Integrações > RH”, na aba “Importação SAP”, será necessário importar o arquivo em formato txt, informar os parâmetros, se necessários, e clicar no botão
Iniciar Importação.

![image](https://user-images.githubusercontent.com/46023665/61897974-b7c37400-aeee-11e9-8c28-e02d2eaa7091.png)

## Tratamentos 

O sistema iniciará uma verificação dos dados do arquivo, para que só grave, se não houver nenhuma inconsistência. Caso ele encontre alguma inconsistência, será interrompida a importação, antes de ser integrado os lançamentos contábeis. Caso o somatório dos débitos ser diferentes dos créditos, o sistema, o sistema só irá continuar a importação, com a confirmação do usuário.

![image](https://user-images.githubusercontent.com/46023665/61898065-e4778b80-aeee-11e9-85c5-234803405509.png)


Se o sistema não encontrar os dados necessários para integração contábil dos lançamentos, irá gerar um relatório, para que seja verificado com precisão o arquivo, antes de prosseguir com a importação.
Após, a importação ter sido abortada, por algum erro, ou pelo usuário, será enviada para a aba ‘’Log de Execução’’ os erros que pararam a integração. 

![image](https://user-images.githubusercontent.com/46023665/61898518-dece7580-aeef-11e9-84d1-253145ff3825.png)


Caso a integração contábil, tenha sido realizada com sucesso, o sistema irá abrir uma janela informando a mensagem “ Lançamentos integrados na contabilidade com sucesso”.

![image](https://user-images.githubusercontent.com/46023665/61898582-0291bb80-aef0-11e9-800f-50388a5fd496.png)



