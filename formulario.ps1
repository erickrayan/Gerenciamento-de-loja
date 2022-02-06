#Assemblies
Add-Type -AssemblyName System.Windows.forms
Add-Type -Assemblyname System.Drawing
Add-Type -AssemblyName PresentationFramework #para janelas de erro ou sucesso

#menu ####################################################################################################################
#Janela principal menu
$menu = New-Object System.Windows.Forms.Form
$menu.text = "Gerenciador Loja"
#$menu.size = New-Object System.Drawing.Size(350,200)
$menu.size = New-Object System.Drawing.Size(460,500)
$menu.StartPosition = "CenterScreen"

#listbox do menu
$listBoxLojas = New-Object System.Windows.Forms.ListBox
$listBoxLojas.Location = New-Object System.Drawing.Size(10,200)
$listBoxLojas.Size = New-Object System.Drawing.Size(260,20)
$listBoxLojas.Height = 80
$listBoxLojas.add_SelectedIndexChanged({ #Essa parte � executada quando o usu�rio clica em uma loja
    exibeDepartamentos
})
$menu.Controls.Add($listBoxLojas)

#listbox de sa�da do menu
$listBoxSaida = New-Object System.Windows.Forms.Listbox
$listBoxSaida.Location = New-Object System.Drawing.Size(10,350)
$listBoxSaida.Size = New-Object System.Drawing.Size(260,20)
$listBoxSaida.Height = 80
$menu.Controls.Add($listBoxSaida)

#Label menu
$mLabel = New-Object System.Windows.Forms.Label
$mLabel.Text = "Menu principal"
$mLabel.Location =  New-Object System.Drawing.Size(20,15)
$mLabel.AutoSize = $true
$menu.Controls.Add($mLabel)

#bot�o inserir loja do menu
$inserirLoja = New-Object System.Windows.Forms.Button 
$inserirLoja.Location = New-Object System.Drawing.Size(20,90)
$inserirLoja.Size = New-Object System.Drawing.Size(130,20)
$inserirLoja.Text = "Criar loja"
$inserirLoja.Add_click({
    $textboxLoja.Text=""
    $result=$formLoja.ShowDialog()
    if($result -eq "Cancel"){
        popularLojas
        popularLojasVendas
    }
    $msgBottomLoja.Text= ""
    
    
})
$menu.Controls.Add($inserirLoja)

#bot�o inserir departamento do menu
$inserirDepartamento = New-Object System.Windows.Forms.Button 
$inserirDepartamento.Location = New-Object System.Drawing.Size(180,90)
$inserirDepartamento.Size = New-Object System.Drawing.Size(130,20)
$inserirDepartamento.Text = "Criar departamento"
$inserirDepartamento.Add_click({
    $textboxDepartamento.Text=""
    $formDepartamento.ShowDialog() 
    popularLojas
    $listBoxSaida.items.Clear() 
    $msgBottomDepartamento.Text= ""
    
})
$menu.Controls.Add($inserirDepartamento)

#bot�o inserir produto do menu
$inserirProduto = New-Object System.Windows.Forms.Button 
$inserirProduto.Location = New-Object System.Drawing.Size(20,130)
$inserirProduto.Size = New-Object System.Drawing.Size(130,20)
$inserirProduto.Text = "Criar produto"
$inserirProduto.Add_click({
    popularDptProduto
    $textboxNomeProduto.Text=""
    $textboxCustoProduto.Text=""
    $textboxPrecoProduto.Text=""
    $formProduto.ShowDialog()
    
})
$menu.Controls.Add($inserirProduto)

#bot�o cadastrar venda do menu
$cadastrarVenda = New-Object System.Windows.Forms.Button 
$cadastrarVenda.Location = New-Object System.Drawing.Size(180,130)
$cadastrarVenda.Size = New-Object System.Drawing.Size(130,20)
$cadastrarVenda.Text = "Cadastrar venda"
$cadastrarVenda.Add_click({
    popularProdutosVendas
    $labelDepartamentoVendas.Text = ""
    $listBoxItens.Items.Clear()
    $labelTotalVendas.Text = "Total: R$ $total"
    $textboxQuantidadeVendas.Text = "1"
    $horaVenda= (Get-Date -Format "ddMMyyHHmmss") #� usada ao adicionar no arquivo texto
    $idVenda= Get-Content .\ixTbVenda.txt
    $labelNVendasVendas.Text = "Venda n�: $idVenda"
    $formVendas.ShowDialog()
})
$menu.Controls.Add($cadastrarVenda)

#Label lojas do menu
$LabelLojas = New-Object System.Windows.Forms.label
$LabelLojas.Text = "Lojas"
$LabelLojas.Location =  New-Object System.Drawing.Size(9,180)
$LabelLojas.AutoSize = $true
$menu.Controls.Add($LabelLojas)

#Label departamentos do menu
$LabelDepartamentos = New-Object System.Windows.Forms.label
$LabelDepartamentos.Text = "Departamentos"
$LabelDepartamentos.Location =  New-Object System.Drawing.Size(9,330)
$LabelDepartamentos.AutoSize = $true
$menu.Controls.Add($LabelDepartamentos)

#bot�o Teste
$botaoTeste = New-Object System.Windows.Forms.Button 
$botaoTeste.Location = New-Object System.Drawing.Size(290,200)
$botaoTeste.Size = New-Object System.Drawing.Size(130,20)
$botaoTeste.Text = "Bot�o teste"
$botaoTeste.Add_click({

})
#$menu.Controls.Add($botaoTeste)

#bot�o Criar relacionamento
$botaoRelacionar = New-Object System.Windows.Forms.Button 
$botaoRelacionar.Location = New-Object System.Drawing.Size(290,350)
$botaoRelacionar.Size = New-Object System.Drawing.Size(130,20)
$botaoRelacionar.Text = "Criar relacionamento"
$botaoRelacionar.Add_click({

    #[System.Windows.MessageBox]::Show('Op��o em desenvolvimento')

    if ($null -eq $listBoxLojas.SelectedItem -or $null -eq $listBoxSaida.SelectedItem){
        [System.Windows.MessageBox]::Show('Selecione uma loja e um departamento.', 'Erro')
    }
    else{
        $lojaAdicionada=($listBoxLojas.SelectedItem -split " \| ")[0]
        $departamentoAdicionado=($listBoxSaida.SelectedItem -split " \| ")[0]
        Add-Content -Value "$lojaAdicionada | $departamentoAdicionado" -Path .\rlLojaDepto.txt
        exibeDepartamentos
        [System.Windows.MessageBox]::Show('Relacionamento criado')

    }

})
$menu.Controls.Add($botaoRelacionar)

#Loja ######################################################################################################################
#Janela Inser��o de loja
$formLoja = New-Object System.Windows.Forms.Form
$formLoja.text = "Inser��o de loja"
$formLoja.size = New-Object System.Drawing.Size(350,200)
$formLoja.StartPosition = "CenterScreen"

#Caixa de texto loja
$textboxLoja = New-Object System.Windows.Forms.TextBox
$textboxLoja.Location = New-Object System.Drawing.Size(100,50)
$textboxLoja.Size = New-Object System.Drawing.Size(208,20)
$formLoja.Controls.Add($textboxLoja) 

#Label loja
$labelLoja = New-Object System.Windows.Forms.Label
$labelLoja.Text = "Digite o nome da loja a ser criada:"
$labelLoja.Location =  New-Object System.Drawing.Size(20,15)
$labelLoja.AutoSize = $true
$formLoja.Controls.Add($labelLoja)

#Mensagem parte inferior loja
$msgBottomLoja = New-Object System.Windows.Forms.Label
$msgBottomLoja.Location =  New-Object System.Drawing.Size(20,130)
$msgBottomLoja.AutoSize = $true
$formLoja.Controls.Add($msgBottomLoja)

#label idLoja
$labelIdLoja = New-Object System.Windows.Forms.Label
$labelIdLoja.Location =  New-Object System.Drawing.Size(23,52)
$labelIdLoja.AutoSize = $true
$formLoja.Controls.Add($labelIdLoja)

#bot�o cancelar loja
$botaoCancelarLoja = New-Object System.Windows.Forms.Button 
$botaoCancelarLoja.Location = New-Object System.Drawing.Size(130,90)
$botaoCancelarLoja.Size = New-Object System.Drawing.Size(100,20)
$botaoCancelarLoja.Text = "Fechar"
$botaoCancelarLoja.Add_Click({$formLoja.Tag = $formLoja.close()}) 
$formLoja.Controls.Add($botaoCancelarLoja)

#bot�o ok loja
$botaoOkLoja = New-Object System.Windows.Forms.Button 
$botaoOkLoja.Location = New-Object System.Drawing.Size(20,90)
$botaoOkLoja.Size = New-Object System.Drawing.Size(100,20)
$botaoOkLoja.Text = "Ok"
$botaoOkLoja.Add_click({ #essa parte � executada ao clicar no bot�o ok
    if($textboxLoja.text -eq ""){
        $msgBottomLoja.Text = "Loja n�o adicionada, caixa de texto vazia"
    }
    else{
        $cont=0
        foreach ($linha in Get-Content .\tbLoja.txt){ #verifica se j� existe algum com o mesmo nome
            if(($linha -split " \| ")[1] -eq $textboxLoja.text){
                $cont++
                break
            }

        }
        if($cont -ne 0){
            $msgBottomLoja.Text = "Loja j� existente."
        }
        else{
            $ultimo=Get-Content .\ixTbLoja.txt #vari�vel recebe conte�do do texto
            $texto=$textboxLoja.text
            Add-Content -Value "$ultimo | $texto" -Path .\tbLoja.txt #nova linha adicionada no arquivo

            [int]$ultimo=$ultimo #vari�vel � convertida para int
            $ultimo++ #e � incrementada
            [string]$ultimo=([string]$ultimo).PadLeft(4,'0') #vari�vel volta a ser string padronizada com zeros � esquerda
            Clear-Content -Path .\ixTbLoja.txt 
            Add-Content -Value $ultimo -Path .\ixTbLoja.txt 
            $labelIdLoja.Text = "codLoja: " + $ultimo + ":"
            $msgBottomLoja.Text = "Loja $texto inserida."
            $textboxLoja.text= ""
        }
        
    }

})
$formLoja.Controls.Add($botaoOkLoja)



# Departamento ############################################################################################################
#Janela Inser��o de departamento
$formDepartamento = New-Object System.Windows.Forms.Form
$formDepartamento.text = "Inser��o de departamento"
$formDepartamento.size = New-Object System.Drawing.Size(350,200)
$formDepartamento.StartPosition = "CenterScreen"

#Caixa de texto departamento
$textboxDepartamento = New-Object System.Windows.Forms.TextBox
$textboxDepartamento.Location = New-Object System.Drawing.Size(100,50)
$textboxDepartamento.Size = New-Object System.Drawing.Size(208,20)
$formDepartamento.Controls.Add($textboxDepartamento) 

#Label departamento
$labelDepartamento = New-Object System.Windows.Forms.Label
$labelDepartamento.Text = "Digite o nome do departamento a ser criado:"
$labelDepartamento.Location =  New-Object System.Drawing.Size(20,15)
$labelDepartamento.AutoSize = $true
$formDepartamento.Controls.Add($labelDepartamento)

#Mensagem parte inferior departamento
$msgBottomDepartamento = New-Object System.Windows.Forms.Label
$msgBottomDepartamento.Location =  New-Object System.Drawing.Size(20,130)
$msgBottomDepartamento.AutoSize = $true
$formDepartamento.Controls.Add($msgBottomDepartamento)

#IdDepartamento label
$labelIdDepartamento = New-Object System.Windows.Forms.Label
$labelIdDepartamento.Location =  New-Object System.Drawing.Size(23,52)
$labelIdDepartamento.AutoSize = $true
$formDepartamento.Controls.Add($labelIdDepartamento)

#bot�o cancelar departamento
$botaoCancelarDepartamento = New-Object System.Windows.Forms.Button 
$botaoCancelarDepartamento.Location = New-Object System.Drawing.Size(130,90)
$botaoCancelarDepartamento.Size = New-Object System.Drawing.Size(100,20)
$botaoCancelarDepartamento.Text = "Fechar"
$botaoCancelarDepartamento.Add_Click({$formDepartamento.Tag = $formDepartamento.close()}) 
$formDepartamento.Controls.Add($botaoCancelarDepartamento)

#bot�o botao ok departamento
$botaoOkDepartamento = New-Object System.Windows.Forms.Button #bot�o ok
$botaoOkDepartamento.Location = New-Object System.Drawing.Size(20,90)
$botaoOkDepartamento.Size = New-Object System.Drawing.Size(100,20)
$botaoOkDepartamento.Text = "Ok"
$botaoOkDepartamento.Add_click({
    if($textboxDepartamento.text -eq ""){
        $msgBottomDepartamento.Text = "Departamento n�o adicionado, caixa de texto vazia"
    }
    else{
        $cont=0
        foreach ($linha in Get-Content .\tbDepartamento.txt){ #verifica se j� existe algum com o mesmo nome
            if(($linha -split " \| ")[1] -eq $textboxDepartamento.text){
                $cont++
                break
            }
        }
        if($cont -ne 0){
            $msgBottomDepartamento.Text = "Departamento j� existente."
        }
        else{
            $dultimo=Get-Content .\ixTbDepartamento.txt #vari�vel recebe conte�do do texto
            $dtexto=$textboxDepartamento.text
            Add-Content -Value "$dultimo | $dtexto" -Path .\tbDepartamento.txt #nova linha adicionada no arquivo

            [int]$dultimo=$dultimo #vari�vel � convertida para int
            $dultimo++ #e � incrementada
            [string]$dultimo=([string]$dultimo).PadLeft(4,'0') #vari�vel volta a ser string padronizada com zeros � esquerda
            Clear-Content -Path .\ixTbDepartamento.txt 
            Add-Content -Value $dultimo -Path .\ixTbDepartamento.txt 
            $labelIdDepartamento.Text = "codDpt: " + $dultimo + ":"
            $msgBottomDepartamento.Text = "Departamento $dtexto inserido."
            $textboxDepartamento.text= ""
        }
    }
})
$formDepartamento.Controls.Add($botaoOkDepartamento)

# Produto #############################################################################################################################################
#Janela Inser��o de produto
$formProduto = New-Object System.Windows.Forms.Form
$formProduto.text = "Inser��o de produto"
$formProduto.size = New-Object System.Drawing.Size(350,480)
$formProduto.StartPosition = "CenterScreen"

#Label nome produto
$labelNomeProduto = New-Object System.Windows.Forms.Label
$labelNomeProduto.Text = "Digite o nome do produto a ser criado:"
$labelNomeProduto.Location =  New-Object System.Drawing.Size(20,15)
$labelNomeProduto.AutoSize = $true
$formProduto.Controls.Add($labelNomeProduto)

#IdProduto label
$labelIdProduto = New-Object System.Windows.Forms.Label
$labelIdProduto.Location =  New-Object System.Drawing.Size(23,52)
$labelIdProduto.AutoSize = $true
$formProduto.Controls.Add($labelIdProduto)

#Label Custo produto
$labelCustoProduto = New-Object System.Windows.Forms.Label
$labelCustoProduto.Text = "Digite o custo do produto a ser criado:"
$labelCustoProduto.Location =  New-Object System.Drawing.Size(20,95)
$labelCustoProduto.AutoSize = $true
$formProduto.Controls.Add($labelCustoProduto)

#Label pre�o produto
$labelPrecoProduto = New-Object System.Windows.Forms.Label
$labelPrecoProduto.Text = "Digite o pre�o final do produto a ser criado:"
$labelPrecoProduto.Location =  New-Object System.Drawing.Size(20,175)
$labelPrecoProduto.AutoSize = $true
$formProduto.Controls.Add($labelPrecoProduto)

#Label departamentos para o produto
$labelDptProduto = New-Object System.Windows.Forms.Label
$labelDptProduto.Text = "Selecione o departamento onde o produto ser� criado:"
$labelDptProduto.Location =  New-Object System.Drawing.Size(20,255)
$labelDptProduto.AutoSize = $true
$formProduto.Controls.Add($labelDptProduto)

#bot�o cancelar produto
$botaoCancelarProduto = New-Object System.Windows.Forms.Button 
$botaoCancelarProduto.Location = New-Object System.Drawing.Size(130,390)
$botaoCancelarProduto.Size = New-Object System.Drawing.Size(100,20)
$botaoCancelarProduto.Text = "Fechar"
$botaoCancelarProduto.Add_Click({$formProduto.Tag = $formProduto.close()}) 
$formProduto.Controls.Add($botaoCancelarProduto)

#bot�o ok produto
$botaoOkProduto = New-Object System.Windows.Forms.Button #bot�o ok
$botaoOkProduto.Location = New-Object System.Drawing.Size(20,390)
$botaoOkProduto.Size = New-Object System.Drawing.Size(100,20)
$botaoOkProduto.Text = "Ok"
$botaoOkProduto.Add_click({

    #verifica se est� tudo selecionado
    if ("" -eq $textboxNomeProduto.Text -or "" -eq $textboxCustoProduto.Text -or "" -eq $textboxPrecoProduto.Text -or $null -eq $listboxProduto.SelectedItem){
        [System.Windows.MessageBox]::Show('Preencha todos os campos.', 'Erro')
    }
    else{
        $cont=0
        foreach ($linha in Get-Content .\tbProduto.txt){ #verifica se j� existe algum com o mesmo nome
            if(($linha -split " \| ")[4] -eq $textboxNomeProduto.text){
                $cont++
                break
            }
        }
        if($cont -ne 0){
            [System.Windows.MessageBox]::Show('Produto j� existente.')
        }
        else{ #se estiver tudo correto

            #limpeza dos campos
            #$textboxNomeProduto.Text=""
            #$textboxCustoProduto.Text=""
            #$textboxPrecoProduto.Text=""
            #$listboxProduto.SelectedIndex=-1

            $nomeAdicionado=$textboxNomeProduto.Text
            $custoAdicionado=$textboxCustoProduto.Text
            $precoAdicionado=$textboxPrecoProduto.Text
            $idProdutoAdicionado=(Get-Content .\ixTbProduto.txt)
            $idDepartamentoAdicionado=($listboxproduto.SelectedItem -split " \| ")[0]

            Add-Content -Value "$idProdutoAdicionado | $idDepartamentoAdicionado | $precoAdicionado | $custoAdicionado | $nomeAdicionado" -Path .\tbProduto.txt

            $ultimo=Get-Content .\ixTbProduto.txt #vari�vel recebe conte�do do texto
            [int]$ultimo=$ultimo #vari�vel � convertida para int
            $ultimo++ #e � incrementada
            [string]$ultimo=([string]$ultimo).PadLeft(4,'0') #vari�vel volta a ser string padronizada com zeros � esquerda
            Clear-Content -Path .\ixTbProduto.txt 
            Add-Content -Value $ultimo -Path .\ixTbProduto.txt
            $labelIdProduto.Text = "codProd: " + $ultimo + ":"

            
            [System.Windows.MessageBox]::Show('Produto adicionado.')
        }
    }
  
})
$formProduto.Controls.Add($botaoOkProduto)

#Caixa de texto nome produto
$textboxNomeProduto = New-Object System.Windows.Forms.TextBox
$textboxNomeProduto.Location = New-Object System.Drawing.Size(103,50)
$textboxNomeProduto.Size = New-Object System.Drawing.Size(205,20)
$formProduto.Controls.Add($textboxNomeProduto)

#Caixa de texto custo produto
$textboxCustoProduto = New-Object System.Windows.Forms.TextBox
$textboxCustoProduto.Location = New-Object System.Drawing.Size(22,130)
$textboxCustoProduto.Size = New-Object System.Drawing.Size(286,20)
$formProduto.Controls.Add($textboxCustoProduto)

#Caixa de texto pre�o produto
$textboxPrecoProduto = New-Object System.Windows.Forms.TextBox
$textboxPrecoProduto.Location = New-Object System.Drawing.Size(22,210)
$textboxPrecoProduto.Size = New-Object System.Drawing.Size(286,20)
$formProduto.Controls.Add($textboxPrecoProduto)

#listbox com departamentos da janela de produtos
$listboxProduto = New-Object System.Windows.Forms.Listbox
$listboxProduto.Location = New-Object System.Drawing.Size(22,290)
$listboxProduto.Size = New-Object System.Drawing.Size(286,20)
$listboxProduto.Height = 80
$formProduto.Controls.Add($listboxProduto)




# Venda #########################################################################################################################################################

#Janela cadastro de venda
$formVendas = New-Object System.Windows.Forms.Form
$formVendas.text = "Cadastro de venda"
$formVendas.size = New-Object System.Drawing.Size(350,480)
$formVendas.StartPosition = "CenterScreen"

#combobox lojas de vendas
$listBoxLojasVendas = New-Object System.Windows.Forms.ComboBox
$listBoxLojasVendas.Location = New-Object System.Drawing.Size(10,62)
$listBoxLojasVendas.Size = New-Object System.Drawing.Size(260,20)
$listBoxLojasVendas.Height = 80
$listBoxLojasVendas.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList
$formVendas.Controls.Add($listBoxLojasVendas)

#combobox produtos de vendas
$listBoxProdutosVendas = New-Object System.Windows.Forms.ComboBox
$listBoxProdutosVendas.Location = New-Object System.Drawing.Size(10,142)
$listBoxProdutosVendas.Size = New-Object System.Drawing.Size(260,20)
$listBoxProdutosVendas.Height = 80
$listBoxProdutosVendas.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList
$listBoxProdutosVendas.add_SelectedIndexChanged({
    foreach ($linha in Get-Content .\tbDepartamento.txt){
        if((($linha -split " \| ")[0]) -eq (($listBoxProdutosVendas.SelectedItem -split " \| ")[1])){
            $temp= ($linha -split " \| ")[1]
            $labelDepartamentoVendas.Text = "Departamento: $temp"
            break
        }
    }
    $textboxQuantidadeVendas.Text = "1"

})
$formVendas.Controls.Add($listBoxProdutosVendas)

#listbox com itens da vendas
$listBoxItens = New-Object System.Windows.Forms.ListBox
$listBoxItens.Location = New-Object System.Drawing.Size(10,240)
$listBoxItens.Size = New-Object System.Drawing.Size(260,20)
$listBoxItens.Height = 80
$formVendas.Controls.Add($listBoxItens)

#Label loja venda
$labelLojasVendas = New-Object System.Windows.Forms.Label
$labelLojasVendas.Text = "Selecione a loja onde a venda foi realizada"
$labelLojasVendas.Location =  New-Object System.Drawing.Size(9,25)
$labelLojasVendas.AutoSize = $true
$formVendas.Controls.Add($labelLojasVendas)

#Label n�mero de vendas vendas
$labelNVendasVendas = New-Object System.Windows.Forms.Label
$labelNVendasVendas.Location =  New-Object System.Drawing.Size(9,2)
$labelNVendasVendas.AutoSize = $true
$formVendas.Controls.Add($labelNVendasVendas)

#Label produto vendas
$labelProdutosVendas = New-Object System.Windows.Forms.Label
$labelProdutosVendas.Text = "Selecione o produto vendido"
$labelProdutosVendas.Location =  New-Object System.Drawing.Size(9,105)
$labelProdutosVendas.AutoSize = $true
$formVendas.Controls.Add($labelProdutosVendas)

#Label departamento vendas
$labelDepartamentoVendas = New-Object System.Windows.Forms.Label
$labelDepartamentoVendas.Location =  New-Object System.Drawing.Size(9,165)
$labelDepartamentoVendas.AutoSize = $true
$formVendas.Controls.Add($labelDepartamentoVendas)

#Label quantidade vendas
$labelQuantidadeVendas = New-Object System.Windows.Forms.Label
$labelQuantidadeVendas.Location =  New-Object System.Drawing.Size(9,212)
$labelQuantidadeVendas.AutoSize = $true
$labelQuantidadeVendas.Text = "Qtd:"
$formVendas.Controls.Add($labelQuantidadeVendas)

#Label valor total vendas
$labelTotalVendas = New-Object System.Windows.Forms.Label
$labelTotalVendas.Location =  New-Object System.Drawing.Size(9,340)
$labelTotalVendas.AutoSize = $true
$formVendas.Controls.Add($labelTotalVendas)

#Caixa de texto quantidade vendas
$textboxQuantidadeVendas = New-Object System.Windows.Forms.TextBox
$textboxQuantidadeVendas.Location = New-Object System.Drawing.Size(40,210)
$textboxQuantidadeVendas.Size = New-Object System.Drawing.Size(35,20)
$textboxQuantidadeVendas.Text = "1"
$formVendas.Controls.Add($textboxQuantidadeVendas)

#bot�o menos vendas
$bot�oMenos = New-Object System.Windows.Forms.Button
$bot�oMenos.Location = New-Object System.Drawing.Size(77,210)
$bot�oMenos.Size = New-Object System.Drawing.Size(20,20)
$bot�oMenos.Text = "-"
$bot�oMenos.Add_click({
    
    [int]$inteiro= $textboxQuantidadeVendas.Text
    if ($inteiro -gt 1){
        $inteiro--
        $textboxQuantidadeVendas.Text=$inteiro
    }

})
$formVendas.Controls.Add($bot�oMenos)

#bot�o mais vendas
$bot�oMais = New-Object System.Windows.Forms.Button
$bot�oMais.Location = New-Object System.Drawing.Size(99,210)
$bot�oMais.Size = New-Object System.Drawing.Size(20,20)
$bot�oMais.Text = "+"
$bot�oMais.Add_click({
    [int]$inteiro= $textboxQuantidadeVendas.Text
    $inteiro++
    $textboxQuantidadeVendas.Text=$inteiro

})
$formVendas.Controls.Add($bot�oMais)

#bot�o adicionar vendas
$bot�oAdicionar = New-Object System.Windows.Forms.Button
$bot�oAdicionar.Location = New-Object System.Drawing.Size(121,210)
$bot�oAdicionar.Size = New-Object System.Drawing.Size(76,20)
$bot�oAdicionar.Text = "Adicionar"
$bot�oAdicionar.Add_click({
    if($listBoxProdutosVendas.SelectedIndex -eq -1 -or $listBoxLojasVendas.SelectedIndex -eq -1){
        [System.Windows.MessageBox]::Show('Selecione uma loja e um produto.', 'Erro')
    }
    else{  
        if([int]$textboxQuantidadeVendas.Text -lt 1){
            [System.Windows.MessageBox]::Show('Quantidade deve ser ao menos 1', 'Erro')
        }
        else {
            $idProdVend=    ($listBoxProdutosVendas.SelectedItem -split " \| ")[0]
            $nomeProdVend=  ($listBoxProdutosVendas.SelectedItem -split " \| ")[4]
            $valorProdVend= ($listBoxProdutosVendas.SelectedItem -split " \| ")[2]
            $qtdProdVend= $textboxQuantidadeVendas.Text
            $listBoxItens.Items.Add("$idProdVend | $nomeProdVend | $valorProdVend | $qtdProdVend")

            somarValoresVendas
        }
    }
})
$formVendas.Controls.Add($bot�oAdicionar)

#bot�o remover vendas
$bot�oRemover = New-Object System.Windows.Forms.Button
$bot�oRemover.Location = New-Object System.Drawing.Size(200,210)
$bot�oRemover.Size = New-Object System.Drawing.Size(70,20)
$bot�oRemover.Text = "Remover"
$bot�oRemover.Add_click({
    $listBoxItens.Items.Remove($listBoxItens.SelectedItem)
    somarValoresVendas
})
$formVendas.Controls.Add($bot�oRemover)

#bot�o cancelar vendas
$botaoCancelarVendas = New-Object System.Windows.Forms.Button 
$botaoCancelarVendas.Location = New-Object System.Drawing.Size(130,390)
$botaoCancelarVendas.Size = New-Object System.Drawing.Size(100,20)
$botaoCancelarVendas.Text = "Fechar"
$botaoCancelarVendas.Add_Click({$formVendas.Tag = $formVendas.close()}) 
$formVendas.Controls.Add($botaoCancelarVendas)

#bot�o ok vendas
$botaoOkVendas = New-Object System.Windows.Forms.Button #bot�o ok
$botaoOkVendas.Location = New-Object System.Drawing.Size(20,390)
$botaoOkVendas.Size = New-Object System.Drawing.Size(100,20)
$botaoOkVendas.Text = "Ok"
$botaoOkVendas.Add_click({
    if($listBoxLojasVendas.SelectedIndex -eq -1){
        [System.Windows.MessageBox]::Show('Selecione uma loja.', 'Erro')
    }
    else{
        if($listBoxItens.Items.Count -eq 0){
            [System.Windows.MessageBox]::Show('Necess�rio ao menos 1 item', 'Erro')
        }
        else{

            #Adiciona a venda na tabela
            $idLojaAdicionado=($listBoxLojasVendas.SelectedItem -split " \| ")[0]
            $total=somarValoresVendas
            Add-Content -Value "$idVenda | $idLojaAdicionado | $horaVenda | $total" -Path .\tbVenda.txt

            #Adiciona os itens na tabela
            foreach ($item in $listBoxItens.Items){
                $idProdutoAdicionado= ($item -split " \| ")[0]
                $qtdProdutoAdicionado= ($item -split " \| ")[3]
                Add-Content -Value "$idVenda | $idProdutoAdicionado | $qtdProdutoAdicionado" -Path .\tbItemVenda.txt
            }

            #Atualiza o ixTbVenda
            [int]$idVenda=$idVenda #vari�vel � convertida para int
            $idVenda++ #e � incrementada
            [string]$idVenda=([string]$idVenda).PadLeft(4,'0') #vari�vel volta a ser string padronizada com zeros � esquerda
            Clear-Content -Path .\ixTbVenda.txt 
            Add-Content -Value $idVenda -Path .\ixTbVenda.txt 
      

            $formVendas.Tag = $formVendas.close()
            [System.Windows.MessageBox]::Show('Venda cadastrada')
        }
  
    }
})
$formVendas.Controls.Add($botaoOkVendas)




# Fun��es ######################################################################################################################################################

function popularLojas{ #preenche a listbox de lojas
    $listBoxLojas.items.Clear()
    foreach ($linha in Get-Content .\tbLoja.txt){ [void]$listBoxLojas.Items.Add($linha) } 
}
function popularLojasVendas{ #preenche a listbox de lojas vendas
    $listBoxLojasVendas.items.Clear()
    foreach ($linha in Get-Content .\tbLoja.txt){ [void]$listBoxLojasVendas.Items.Add($linha) } 
}

function popularDptProduto{ #preenche a listbox departamentos no formul�rio de produto
    $listboxProduto.items.Clear()
    foreach ($linha in Get-Content .\tbDepartamento.txt){ [void]$listboxProduto.Items.Add($linha) } 
}

function popularProdutosVendas{ #preenche a listbox de produtos vendas
    $listBoxProdutosVendas.items.Clear()
    foreach ($linha in Get-Content .\tbProduto.txt){ [void]$listBoxProdutosVendas.Items.Add($linha) } 
}

function exibeDepartamentos{
    $listBoxSaida.items.Clear()

    foreach ($dpt in Get-Content .\tbDepartamento.txt){

        $listBoxSaida.items.add($dpt)

        foreach ($rel in Get-Content .\rlLojaDepto.txt){
            if( ( (($dpt -split " \| ")[0]) -eq (($rel -split " \| ")[1]) ) -and ( (($rel -split " \| ")[0]) -eq (($listBoxLojas.SelectedItem -split " \| ")[0]) ) ){
                $listBoxSaida.items.remove($dpt)
            }
        }
    }

}

function somarValoresVendas {
    [float]$soma=0
    foreach ($linha in $listBoxItens.Items){ #soma os valores
        $soma=$soma + ([float] ((($linha -split " \| ")[2]) -replace ',','.')) * ([float] ((($linha -split " \| ")[3]) -replace ',','.'))
    }
    [string]$total=$soma
    $total= $total -replace '\.',',' #converte pontos em v�rgulas e adiciona na vari�vel
    $labelTotalVendas.Text = "Total: R$ $total"
    return $total

}





#
#
#In�cio do programa
#
#
$labelIdLoja.Text = "codLoja: " + (Get-Content .\ixTbLoja.txt) + ":" #preenche o labelLoja
$labelIdDepartamento.Text = "codDpt: " + (Get-Content .\ixTbDepartamento.txt) + ":" #preenche o labelDepartamento
$labelIdProduto.Text = "codProd: " + (Get-Content .\ixTbProduto.txt) + ":" #preenche o labelProduto
popularLojas
popularLojasVendas

[void]$menu.ShowDialog()
