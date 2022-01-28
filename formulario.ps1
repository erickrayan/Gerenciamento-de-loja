#Assemblies
Add-Type -AssemblyName System.Windows.forms
Add-Type -Assemblyname System.Drawing
Add-Type -AssemblyName PresentationFramework #para janelas de erro ou sucesso

#menu ####################################################################################################################
#Janela principal menu
$menu = New-Object System.Windows.Forms.Form
$menu.text = "Relacionamento loja/departamento"
#$menu.size = New-Object System.Drawing.Size(350,200)
$menu.size = New-Object System.Drawing.Size(460,500)
$menu.StartPosition = "CenterScreen"

#listbox do menu
$listBoxLojas = New-Object System.Windows.Forms.Listbox
$listBoxLojas.Location = New-Object System.Drawing.Size(10,200)
$listBoxLojas.Size = New-Object System.Drawing.Size(260,20)
$listBoxLojas.Height = 80
$menu.Controls.Add($listBoxLojas)

#listbox de saída do menu
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

#botão inserir loja do menu
$inserirLoja = New-Object System.Windows.Forms.Button 
$inserirLoja.Location = New-Object System.Drawing.Size(20,90)
$inserirLoja.Size = New-Object System.Drawing.Size(130,20)
$inserirLoja.Text = "Criar loja"
$inserirLoja.Add_click({
    $textboxLoja.Text=""
    $result=$formLoja.ShowDialog()
    if($result -eq "Cancel"){
        popularLojas
    }
    $msgBottomLoja.Text= ""
    
    
})
$menu.Controls.Add($inserirLoja)

#botão inserir departamento do menu
$inserirDepartamento = New-Object System.Windows.Forms.Button 
$inserirDepartamento.Location = New-Object System.Drawing.Size(180,90)
$inserirDepartamento.Size = New-Object System.Drawing.Size(130,20)
$inserirDepartamento.Text = "Criar departamento"
$inserirDepartamento.Add_click({
    $dcaixa1.Text=""
    $formDepartamento.ShowDialog() 
    popularLojas
    $listBoxSaida.items.Clear() 
    $msgBottomDepartamento.Text= ""
    
})
$menu.Controls.Add($inserirDepartamento)

#botão inserir produto do menu
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

#botão Teste
$botaoTeste = New-Object System.Windows.Forms.Button 
$botaoTeste.Location = New-Object System.Drawing.Size(290,200)
$botaoTeste.Size = New-Object System.Drawing.Size(130,20)
$botaoTeste.Text = "Botão teste"
$botaoTeste.Add_click({

})
#$menu.Controls.Add($botaoTeste)

#botão Criar relacionamento
$botaoRelacionar = New-Object System.Windows.Forms.Button 
$botaoRelacionar.Location = New-Object System.Drawing.Size(290,350)
$botaoRelacionar.Size = New-Object System.Drawing.Size(130,20)
$botaoRelacionar.Text = "Criar relacionamento"
$botaoRelacionar.Add_click({

    #[System.Windows.MessageBox]::Show('Opção em desenvolvimento')

    if ($null -eq $listBoxLojas.SelectedItem -or $null -eq $listBoxSaida.SelectedItem){
        [System.Windows.MessageBox]::Show('Selecione uma loja e um departamento.', 'Erro')
    }
    else{
        $lojaAdicionada=($listBoxLojas.SelectedItem -split "\|")[0]
        $departamentoAdicionado=($listBoxSaida.SelectedItem -split "\|")[0]
        Add-Content -Value "$lojaAdicionada|$departamentoAdicionado" -Path .\relacionamentos.txt
        exibeDepartamentos
        [System.Windows.MessageBox]::Show('Relacionamento criado')

    }

})
$menu.Controls.Add($botaoRelacionar)

#Loja ######################################################################################################################
#Janela Inserção de loja
$formLoja = New-Object System.Windows.Forms.Form
$formLoja.text = "Inserção de loja"
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

#botão cancelar loja
$botaoCancelarLoja = New-Object System.Windows.Forms.Button 
$botaoCancelarLoja.Location = New-Object System.Drawing.Size(130,90)
$botaoCancelarLoja.Size = New-Object System.Drawing.Size(100,20)
$botaoCancelarLoja.Text = "Fechar"
$botaoCancelarLoja.Add_Click({$formLoja.Tag = $formLoja.close()}) 
$formLoja.Controls.Add($botaoCancelarLoja)

#botão ok loja
$botaoOkLoja = New-Object System.Windows.Forms.Button 
$botaoOkLoja.Location = New-Object System.Drawing.Size(20,90)
$botaoOkLoja.Size = New-Object System.Drawing.Size(100,20)
$botaoOkLoja.Text = "Ok"
$botaoOkLoja.Add_click({ #essa parte é executada ao clicar no botão ok
    if($textboxLoja.text -eq ""){
        $msgBottomLoja.Text = "Loja não adicionada, caixa de texto vazia"
    }
    else{
        $cont=0
        foreach ($linha in Get-Content .\tbLoja.txt){ #verifica se já existe algum com o mesmo nome
            if(($linha -split "\|")[1] -eq $textboxLoja.text){
                $cont++
                break
            }

        }
        if($cont -eq 0){
            $ultimo=Get-Content .\ixTbLoja.txt #variável recebe conteúdo do texto
            $texto=$textboxLoja.text
            Add-Content -Value "$ultimo|$texto" -Path .\tbLoja.txt #nova linha adicionada no arquivo

            [int]$ultimo=$ultimo #variável é convertida para int
            $ultimo++ #e é incrementada
            [string]$ultimo=([string]$ultimo).PadLeft(4,'0') #variável volta a ser string padronizada com zeros à esquerda
            Clear-Content -Path .\ixTbLoja.txt 
            Add-Content -Value $ultimo -Path .\ixTbLoja.txt 
            $labelIdLoja.Text = "codLoja: " + $ultimo + ":"
            $msgBottomLoja.Text = "Loja $texto inserida."
            $textboxLoja.text= ""
        }
        else{
            $msgBottomLoja.Text = "Loja já existente"
        }
        
    }

})
$formLoja.Controls.Add($botaoOkLoja)



# Departamento ############################################################################################################
#Janela Inserção de departamento
$formDepartamento = New-Object System.Windows.Forms.Form
$formDepartamento.text = "Inserção de departamento"
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

#botão cancelar departamento
$botaoCancelarDepartamento = New-Object System.Windows.Forms.Button 
$botaoCancelarDepartamento.Location = New-Object System.Drawing.Size(130,90)
$botaoCancelarDepartamento.Size = New-Object System.Drawing.Size(100,20)
$botaoCancelarDepartamento.Text = "Fechar"
$botaoCancelarDepartamento.Add_Click({$formDepartamento.Tag = $formDepartamento.close()}) 
$formDepartamento.Controls.Add($botaoCancelarDepartamento)

#botão botao ok departamento
$botaoOkDepartamento = New-Object System.Windows.Forms.Button #botão ok
$botaoOkDepartamento.Location = New-Object System.Drawing.Size(20,90)
$botaoOkDepartamento.Size = New-Object System.Drawing.Size(100,20)
$botaoOkDepartamento.Text = "Ok"
$botaoOkDepartamento.Add_click({
    if($textboxDepartamento.text -eq ""){
        $msgBottomDepartamento.Text = "Departamento não adicionado, caixa de texto vazia"
    }
    else{
        $cont=0
        foreach ($linha in Get-Content .\tbDepartamento.txt){ #verifica se já existe algum com o mesmo nome
            if(($linha -split "\|")[1] -eq $textboxDepartamento.text){
                $cont++
                break
            }

        }
        if($cont -eq 0){
            $dultimo=Get-Content .\ixTbDepartamento.txt #variável recebe conteúdo do texto
            $dtexto=$textboxDepartamento.text
            Add-Content -Value "$dultimo|$dtexto" -Path .\tbDepartamento.txt #nova linha adicionada no arquivo

            [int]$dultimo=$dultimo #variável é convertida para int
            $dultimo++ #e é incrementada
            [string]$dultimo=([string]$dultimo).PadLeft(4,'0') #variável volta a ser string padronizada com zeros à esquerda
            Clear-Content -Path .\ixTbDepartamento.txt 
            Add-Content -Value $dultimo -Path .\ixTbDepartamento.txt 
            $labelIdDepartamento.Text = "codDpt: " + $dultimo + ":"
            $msgBottomDepartamento.Text = "Departamento $dtexto inserido."
            $textboxDepartamento.text= ""
        }
        else{
            $msgBottomDepartamento.Text = "Departamento já existente"
        }


        
    }
})
$formDepartamento.Controls.Add($botaoOkDepartamento)

# Produto #############################################################################################################################################
#Janela Inserção de produto
$formProduto = New-Object System.Windows.Forms.Form
$formProduto.text = "Inserção de produto"
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

#Label preço produto
$labelPrecoProduto = New-Object System.Windows.Forms.Label
$labelPrecoProduto.Text = "Digite o preço final do produto a ser criado:"
$labelPrecoProduto.Location =  New-Object System.Drawing.Size(20,175)
$labelPrecoProduto.AutoSize = $true
$formProduto.Controls.Add($labelPrecoProduto)

#Label departamentos para o produto
$labelDptProduto = New-Object System.Windows.Forms.Label
$labelDptProduto.Text = "Selecione o departamento onde o produto será criado:"
$labelDptProduto.Location =  New-Object System.Drawing.Size(20,255)
$labelDptProduto.AutoSize = $true
$formProduto.Controls.Add($labelDptProduto)

#botão cancelar produto
$botaoCancelarProduto = New-Object System.Windows.Forms.Button 
$botaoCancelarProduto.Location = New-Object System.Drawing.Size(130,390)
$botaoCancelarProduto.Size = New-Object System.Drawing.Size(100,20)
$botaoCancelarProduto.Text = "Fechar"
$botaoCancelarProduto.Add_Click({$formProduto.Tag = $formProduto.close()}) 
$formProduto.Controls.Add($botaoCancelarProduto)

#botão botao ok produto
$botaoOkProduto = New-Object System.Windows.Forms.Button #botão ok
$botaoOkProduto.Location = New-Object System.Drawing.Size(20,390)
$botaoOkProduto.Size = New-Object System.Drawing.Size(100,20)
$botaoOkProduto.Text = "Ok"
$botaoOkProduto.Add_click({
    [System.Windows.MessageBox]::Show('Opção em desenvolvimento')
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

#Caixa de texto preço produto
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



# Funções ######################################################################################################################################################

function popularLojas{ #preenche a listbox de lojas
    $listBoxLojas.items.Clear()
    foreach ($linha in Get-Content .\tbLoja.txt){ [void]$listBoxLojas.Items.Add($linha) } 
}

function popularDptProduto{ #preenche a listbox departamentos no formulário de produto
    $listboxProduto.items.Clear()
    foreach ($linha in Get-Content .\tbDepartamento.txt){ [void]$listboxProduto.Items.Add($linha) } 
}

function exibeDepartamentos{
    $listBoxSaida.items.Clear()


    foreach ($dpt in Get-Content .\tbDepartamento.txt){

        $listBoxSaida.items.add($dpt)

        foreach ($rel in Get-Content .\relacionamentos.txt){
            if( ( (($dpt -split "\|")[0]) -eq (($rel -split "\|")[1]) ) -and ( (($rel -split "\|")[0]) -eq (($listBoxLojas.SelectedItem -split "\|")[0]) ) ){
                $listBoxSaida.items.remove($dpt)
            }
        }
    }

}




#
#
#Início do programa
#
#
$labelIdLoja.Text = "codLoja: " + (Get-Content .\ixTbLoja.txt) + ":" #preenche o labelLoja
$labelIdDepartamento.Text = "codDpt: " + (Get-Content .\ixTbDepartamento.txt) + ":" #preenche o labelDepartamento
$labelIdProduto.Text = "codProd: " + (Get-Content .\ixTbProduto.txt) + ":" #preenche o labelProduto
popularLojas




$listBoxLojas.add_SelectedIndexChanged({ #Essa parte é executada quando o usuário clica em uma loja
    #$sel=$listBoxLojas.SelectedIndex
    #$mLabel.Text = "index $sel"
    exibeDepartamentos
})




[void]$menu.ShowDialog()




#$mLabel.Text =$listBoxLojas.SelectedIndex
#$formLoja.ShowDialog()#mostra a janela gráfica na tela
#$formDepartamento.ShowDialog()
#$labelIdLoja.Text ="codLoja: " + ((Get-Content .\tbLoja.txt -Tail 1) -split "\|")[0]



