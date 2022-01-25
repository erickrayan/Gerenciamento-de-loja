#Assemblies
Add-Type -AssemblyName System.Windows.forms
Add-Type -Assemblyname System.Drawing

#Janela gr�fica
$form1 = New-Object System.Windows.Forms.Form
$form1.text = "Inser��o de loja"
$Form1.size = New-Object System.Drawing.Size(350,200)
#Janela gr�fica
$form2 = New-Object System.Windows.Forms.Form
$form2.text = "Inser��o de departamento"
$Form2.size = New-Object System.Drawing.Size(350,200)

#Janela gr�fica
$menu = New-Object System.Windows.Forms.Form
$menu.text = "Menu principal"
$menu.size = New-Object System.Drawing.Size(350,200)

#Caixa de texto
$caixa1 = New-Object System.Windows.Forms.TextBox
$caixa1.Location = New-Object System.Drawing.Size(100,50)
$caixa1.Size = New-Object System.Drawing.Size(208,20)
$form1.Controls.Add($caixa1) #adiciona a caixa de texto na janela grafica
#Caixa de texto
$dcaixa1 = New-Object System.Windows.Forms.TextBox
$dcaixa1.Location = New-Object System.Drawing.Size(100,50)
$dcaixa1.Size = New-Object System.Drawing.Size(208,20)
$form2.Controls.Add($dcaixa1) #adiciona a caixa de texto na janela grafica

#Label loja
$label = New-Object System.Windows.Forms.label
$label.Text = "Digite o nome da loja a ser inserida:"
$label.Location =  New-Object System.Drawing.Size(20,15)
$label.AutoSize = $true
$form1.Controls.Add($label)

#Label departamento
$dlabel = New-Object System.Windows.Forms.label
$dlabel.Text = "Digite o nome do departamento a ser inserido:"
$dlabel.Location =  New-Object System.Drawing.Size(20,15)
$dlabel.AutoSize = $true
$form2.Controls.Add($dlabel)

#Label menu
$mlabel = New-Object System.Windows.Forms.label
$mlabel.Text = "Este � o menu principal"
$mlabel.Location =  New-Object System.Drawing.Size(20,15)
$mlabel.AutoSize = $true
$menu.Controls.Add($mlabel)

#Mensagem parte inferior loja
$MsgBottom = New-Object System.Windows.Forms.label
$MsgBottom.Location =  New-Object System.Drawing.Size(20,130)
$MsgBottom.AutoSize = $true
$form1.Controls.Add($MsgBottom)

#Mensagem parte inferior departamento
$dMsgBottom = New-Object System.Windows.Forms.label
$dMsgBottom.Location =  New-Object System.Drawing.Size(20,130)
$dMsgBottom.AutoSize = $true
$form2.Controls.Add($dMsgBottom)

#idLoja label
$idLoja = New-Object System.Windows.Forms.label
$idLoja.Location =  New-Object System.Drawing.Size(23,52)
$idLoja.AutoSize = $true
$form1.Controls.Add($idLoja)
#idDepartamento label
$idDepartamento = New-Object System.Windows.Forms.label
$idDepartamento.Location =  New-Object System.Drawing.Size(23,52)
$idDepartamento.AutoSize = $true
$form2.Controls.Add($idDepartamento)


#bot�o cancelar loja
$canc = New-Object System.Windows.Forms.Button 
$canc.Location = New-Object System.Drawing.Size(130,90)
$canc.Size = New-Object System.Drawing.Size(100,20)
$canc.Text = "Fechar"
$canc.Add_Click({$form1.Tag = $form1.close()}) 
$form1.Controls.Add($canc)

#bot�o cancelar departamento
$dcanc = New-Object System.Windows.Forms.Button 
$dcanc.Location = New-Object System.Drawing.Size(130,90)
$dcanc.Size = New-Object System.Drawing.Size(100,20)
$dcanc.Text = "Fechar"
$dcanc.Add_Click({$form2.Tag = $form2.close()}) 
$form2.Controls.Add($dcanc)

#bot�o ok loja
$ok = New-Object System.Windows.Forms.Button 
$ok.Location = New-Object System.Drawing.Size(20,90)
$ok.Size = New-Object System.Drawing.Size(100,20)
$ok.Text = "Ok"
$ok.Add_click({ #essa parte � executada ao clicar no bot�o ok
    if($caixa1.text -eq ""){
        $MsgBottom.Text = "Loja n�o adicionada, caixa de texto vazia"
    }
    else{
        $ultimo=Get-Content .\ixTbLoja.txt #vari�vel recebe conte�do do texto
        $texto=$caixa1.text
        Add-Content -Value "$ultimo|$texto" -Path .\tbLoja.txt #nova linha adicionada no arquivo

        [int]$ultimo=$ultimo #vari�vel � convertida para int
        $ultimo++ #e � incrementada
        [string]$ultimo=([string]$ultimo).PadLeft(4,'0') #vari�vel volta a ser string padronizada com zeros � esquerda
        Clear-Content -Path .\ixTbLoja.txt 
        Add-Content -Value $ultimo -Path .\ixTbLoja.txt 
        $idLoja.Text = "codLoja: " + $ultimo + ":"
        $MsgBottom.Text = "Loja $texto inserida."
        $caixa1.text= ""
    }

})
$form1.Controls.Add($ok)

#bot�o ok departamento
$dok = New-Object System.Windows.Forms.Button #bot�o ok
$dok.Location = New-Object System.Drawing.Size(20,90)
$dok.Size = New-Object System.Drawing.Size(100,20)
$dok.Text = "Ok"
$dok.Add_click({ #essa parte � executada ao clicar no bot�o ok
    if($dcaixa1.text -eq ""){
        $dMsgBottom.Text = "Departamento n�o adicionado, caixa de texto vazia"
    }
    else{
        $dultimo=Get-Content .\ixTbDepartamento.txt #vari�vel recebe conte�do do texto
        $dtexto=$dcaixa1.text
        Add-Content -Value "$dultimo|$dtexto" -Path .\tbDepartamento.txt #nova linha adicionada no arquivo

        [int]$dultimo=$dultimo #vari�vel � convertida para int
        $dultimo++ #e � incrementada
        [string]$dultimo=([string]$dultimo).PadLeft(4,'0') #vari�vel volta a ser string padronizada com zeros � esquerda
        Clear-Content -Path .\ixTbDepartamento.txt 
        Add-Content -Value $dultimo -Path .\ixTbDepartamento.txt 
        $idDepartamento.Text = "codDpt: " + $dultimo + ":"
        $dMsgBottom.Text = "Departamento $dtexto inserido."
        $dcaixa1.text= ""
    }
})
$form2.Controls.Add($dok)

#bot�o inserir loja
$inserirLoja = New-Object System.Windows.Forms.Button 
$inserirLoja.Location = New-Object System.Drawing.Size(20,90)
$inserirLoja.Size = New-Object System.Drawing.Size(130,20)
$inserirLoja.Text = "Inserir loja"
$inserirLoja.Add_click({
    $form1.ShowDialog()
})
$menu.Controls.Add($inserirLoja)

#bot�o inserir departamento
$inserirDepartamento = New-Object System.Windows.Forms.Button #bot�o ok
$inserirDepartamento.Location = New-Object System.Drawing.Size(180,90)
$inserirDepartamento.Size = New-Object System.Drawing.Size(130,20)
$inserirDepartamento.Text = "Inserir departamento"
$inserirDepartamento.Add_click({
    $form2.ShowDialog()  
})
$menu.Controls.Add($inserirDepartamento)



#
#
#In�cio do programa
#
#
$idLoja.Text = "codLoja: " + (Get-Content .\ixTbLoja.txt) + ":"
$idDepartamento.Text = "codDpt: " + (Get-Content .\ixTbDepartamento.txt) + ":"

$menu.ShowDialog()





#$form1.ShowDialog()#mostra a janela gr�fica na tela
#$form2.ShowDialog()
#$idLoja.Text ="codLoja: " + ((Get-Content .\tbLoja.txt -Tail 1) -split "\|")[0]



