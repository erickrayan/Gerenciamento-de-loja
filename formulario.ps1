#Assemblies
Add-Type -AssemblyName System.Windows.forms
Add-Type -Assemblyname System.Drawing
Add-Type -AssemblyName PresentationFramework #para janelas de erro ou sucesso

#menu
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

#listbox de sa�da do menu
$listBoxSaida = New-Object System.Windows.Forms.Listbox
$listBoxSaida.Location = New-Object System.Drawing.Size(10,350)
$listBoxSaida.Size = New-Object System.Drawing.Size(260,20)
$listBoxSaida.Height = 80
$menu.Controls.Add($listBoxSaida)

#Label menu
$mLabel = New-Object System.Windows.Forms.label
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
    $caixa1.Text=""
    $result=$formLoja.ShowDialog()
    if($result -eq "Cancel"){
        popularLojas
    }
    $msgBottom.Text= ""
    
    
})
$menu.Controls.Add($inserirLoja)

#bot�o inserir departamento do menu
$inserirDepartamento = New-Object System.Windows.Forms.Button 
$inserirDepartamento.Location = New-Object System.Drawing.Size(180,90)
$inserirDepartamento.Size = New-Object System.Drawing.Size(130,20)
$inserirDepartamento.Text = "Criar departamento"
$inserirDepartamento.Add_click({
    $dcaixa1.Text=""
    $formDepartamento.ShowDialog() 
    popularLojas
    $listBoxSaida.items.Clear() 
    $dMsgBottom.Text= ""
    
})
$menu.Controls.Add($inserirDepartamento)

#bot�o inserir produto do menu
$inserirProduto = New-Object System.Windows.Forms.Button 
$inserirProduto.Location = New-Object System.Drawing.Size(20,130)
$inserirProduto.Size = New-Object System.Drawing.Size(130,20)
$inserirProduto.Text = "Criar produto"
$inserirProduto.Add_click({
    #$dcaixa1.Text=""
    $formProduto.ShowDialog()
    
    #popularLojas
    
    
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

#bot�o Teste
$botaoTeste = New-Object System.Windows.Forms.Button 
$botaoTeste.Location = New-Object System.Drawing.Size(290,200)
$botaoTeste.Size = New-Object System.Drawing.Size(130,20)
$botaoTeste.Text = "Bot�o teste"
$botaoTeste.Add_click({

})
#$menu.Controls.Add($botaoTeste)

#bot�o relacionar
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
        $lojaAdicionada=($listBoxLojas.SelectedItem -split "\|")[0]
        $departamentoAdicionado=($listBoxSaida.SelectedItem -split "\|")[0]
        Add-Content -Value "$lojaAdicionada|$departamentoAdicionado" -Path .\relacionamentos.txt
        exibeDepartamentos
        [System.Windows.MessageBox]::Show('Relacionamento criado')

    }

})
$menu.Controls.Add($botaoRelacionar)

#Janela Inser��o de loja
$formLoja = New-Object System.Windows.Forms.Form
$formLoja.text = "Inser��o de loja"
$formLoja.size = New-Object System.Drawing.Size(350,200)
$formLoja.StartPosition = "CenterScreen"

#Janela Inser��o de departamento
$formDepartamento = New-Object System.Windows.Forms.Form
$formDepartamento.text = "Inser��o de departamento"
$formDepartamento.size = New-Object System.Drawing.Size(350,200)
$formDepartamento.StartPosition = "CenterScreen"

#Janela Inser��o de produto
$formProduto = New-Object System.Windows.Forms.Form
$formProduto.text = "Inser��o de produto"
$formProduto.size = New-Object System.Drawing.Size(350,200)
$formProduto.StartPosition = "CenterScreen"


#Caixa de texto
$caixa1 = New-Object System.Windows.Forms.TextBox
$caixa1.Location = New-Object System.Drawing.Size(100,50)
$caixa1.Size = New-Object System.Drawing.Size(208,20)
$formLoja.Controls.Add($caixa1) #adiciona a caixa de texto na janela grafica
#Caixa de texto
$dCaixa1 = New-Object System.Windows.Forms.TextBox
$dCaixa1.Location = New-Object System.Drawing.Size(100,50)
$dCaixa1.Size = New-Object System.Drawing.Size(208,20)
$formDepartamento.Controls.Add($dCaixa1) #adiciona a caixa de texto na janela grafica

#Label loja
$label = New-Object System.Windows.Forms.label
$label.Text = "Digite o nome da loja a ser criada:"
$label.Location =  New-Object System.Drawing.Size(20,15)
$label.AutoSize = $true
$formLoja.Controls.Add($label)

#Label departamento
$dlabel = New-Object System.Windows.Forms.label
$dlabel.Text = "Digite o nome do departamento a ser criado:"
$dlabel.Location =  New-Object System.Drawing.Size(20,15)
$dlabel.AutoSize = $true
$formDepartamento.Controls.Add($dlabel)



#Mensagem parte inferior loja
$msgBottom = New-Object System.Windows.Forms.label
$msgBottom.Location =  New-Object System.Drawing.Size(20,130)
$msgBottom.AutoSize = $true
$formLoja.Controls.Add($msgBottom)

#Mensagem parte inferior departamento
$dMsgBottom = New-Object System.Windows.Forms.label
$dMsgBottom.Location =  New-Object System.Drawing.Size(20,130)
$dMsgBottom.AutoSize = $true
$formDepartamento.Controls.Add($dMsgBottom)

#idLoja label
$idLoja = New-Object System.Windows.Forms.label
$idLoja.Location =  New-Object System.Drawing.Size(23,52)
$idLoja.AutoSize = $true
$formLoja.Controls.Add($idLoja)
#idDepartamento label
$idDepartamento = New-Object System.Windows.Forms.label
$idDepartamento.Location =  New-Object System.Drawing.Size(23,52)
$idDepartamento.AutoSize = $true
$formDepartamento.Controls.Add($idDepartamento)


#bot�o cancelar loja
$canc = New-Object System.Windows.Forms.Button 
$canc.Location = New-Object System.Drawing.Size(130,90)
$canc.Size = New-Object System.Drawing.Size(100,20)
$canc.Text = "Fechar"
$canc.Add_Click({$formLoja.Tag = $formLoja.close()}) 
$formLoja.Controls.Add($canc)

#bot�o cancelar departamento
$dcanc = New-Object System.Windows.Forms.Button 
$dcanc.Location = New-Object System.Drawing.Size(130,90)
$dcanc.Size = New-Object System.Drawing.Size(100,20)
$dcanc.Text = "Fechar"
$dcanc.Add_Click({$formDepartamento.Tag = $formDepartamento.close()}) 
$formDepartamento.Controls.Add($dcanc)

#bot�o ok loja
$ok = New-Object System.Windows.Forms.Button 
$ok.Location = New-Object System.Drawing.Size(20,90)
$ok.Size = New-Object System.Drawing.Size(100,20)
$ok.Text = "Ok"
$ok.Add_click({ #essa parte � executada ao clicar no bot�o ok
    if($caixa1.text -eq ""){
        $msgBottom.Text = "Loja n�o adicionada, caixa de texto vazia"
    }
    else{
        $cont=0
        foreach ($linha in Get-Content .\tbLoja.txt){ #verifica se j� existe algum com o mesmo nome
            if(($linha -split "\|")[1] -eq $caixa1.text){
                $cont++
                break
            }

        }
        if($cont -eq 0){
            $ultimo=Get-Content .\ixTbLoja.txt #vari�vel recebe conte�do do texto
            $texto=$caixa1.text
            Add-Content -Value "$ultimo|$texto" -Path .\tbLoja.txt #nova linha adicionada no arquivo

            [int]$ultimo=$ultimo #vari�vel � convertida para int
            $ultimo++ #e � incrementada
            [string]$ultimo=([string]$ultimo).PadLeft(4,'0') #vari�vel volta a ser string padronizada com zeros � esquerda
            Clear-Content -Path .\ixTbLoja.txt 
            Add-Content -Value $ultimo -Path .\ixTbLoja.txt 
            $idLoja.Text = "codLoja: " + $ultimo + ":"
            $msgBottom.Text = "Loja $texto inserida."
            $caixa1.text= ""
        }
        else{
            $msgBottom.Text = "Loja j� existente"
        }
        
    }

})
$formLoja.Controls.Add($ok)

#bot�o ok departamento
$dok = New-Object System.Windows.Forms.Button #bot�o ok
$dok.Location = New-Object System.Drawing.Size(20,90)
$dok.Size = New-Object System.Drawing.Size(100,20)
$dok.Text = "Ok"
$dok.Add_click({ #essa parte � executada ao clicar no bot�o ok
    if($dCaixa1.text -eq ""){
        $dMsgBottom.Text = "Departamento n�o adicionado, caixa de texto vazia"
    }
    else{
        $cont=0
        foreach ($linha in Get-Content .\tbDepartamento.txt){ #verifica se j� existe algum com o mesmo nome
            if(($linha -split "\|")[1] -eq $dCaixa1.text){
                $cont++
                break
            }

        }
        if($cont -eq 0){
            $dultimo=Get-Content .\ixTbDepartamento.txt #vari�vel recebe conte�do do texto
            $dtexto=$dCaixa1.text
            Add-Content -Value "$dultimo|$dtexto" -Path .\tbDepartamento.txt #nova linha adicionada no arquivo

            [int]$dultimo=$dultimo #vari�vel � convertida para int
            $dultimo++ #e � incrementada
            [string]$dultimo=([string]$dultimo).PadLeft(4,'0') #vari�vel volta a ser string padronizada com zeros � esquerda
            Clear-Content -Path .\ixTbDepartamento.txt 
            Add-Content -Value $dultimo -Path .\ixTbDepartamento.txt 
            $idDepartamento.Text = "codDpt: " + $dultimo + ":"
            $dMsgBottom.Text = "Departamento $dtexto inserido."
            $dCaixa1.text= ""
        }
        else{
            $dMsgBottom.Text = "Departamento j� existente"
        }


        
    }
})
$formDepartamento.Controls.Add($dok)

function popularLojas{ #preenche a listbox de lojas
    $listBoxLojas.items.Clear()
    foreach ($linha in Get-Content .\tbLoja.txt){ [void]$listBoxLojas.Items.Add($linha) } 
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
#In�cio do programa
#
#
$idLoja.Text = "codLoja: " + (Get-Content .\ixTbLoja.txt) + ":" #preenche o label
$idDepartamento.Text = "codDpt: " + (Get-Content .\ixTbDepartamento.txt) + ":" #preenche o label
popularLojas




$listBoxLojas.add_SelectedIndexChanged({ #Essa parte � executada quando o usu�rio clica em uma loja
    #$sel=$listBoxLojas.SelectedIndex
    #$mLabel.Text = "index $sel"

    exibeDepartamentos


    #$listBoxSaida.items.add(($listBoxLojas.text -split "\|")[1])
    
})




[void]$menu.ShowDialog()




#$mLabel.Text =$listBoxLojas.SelectedIndex
#$formLoja.ShowDialog()#mostra a janela gr�fica na tela
#$formDepartamento.ShowDialog()
#$idLoja.Text ="codLoja: " + ((Get-Content .\tbLoja.txt -Tail 1) -split "\|")[0]



