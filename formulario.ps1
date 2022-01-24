#Assemblies
Add-Type -AssemblyName System.Windows.forms
Add-Type -Assemblyname System.Drawing

#Janela gráfica
$form1 = New-Object System.Windows.Forms.Form
$form1.text = "Inserção de loja"
$Form1.size = New-Object System.Drawing.Size(350,200)
#Janela gráfica
$form2 = New-Object System.Windows.Forms.Form
$form2.text = "Inserção de departamento"
$Form2.size = New-Object System.Drawing.Size(350,200)

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

#Label
$label = New-Object System.Windows.Forms.label
$label.Text = "Digite o nome da loja a ser inserida:"
$label.Location =  New-Object System.Drawing.Size(20,15)
$label.AutoSize = $true
$form1.Controls.Add($label)
#Label
$dlabel = New-Object System.Windows.Forms.label
$dlabel.Text = "Digite o nome do departamento a ser inserido:"
$dlabel.Location =  New-Object System.Drawing.Size(20,15)
$dlabel.AutoSize = $true
$form2.Controls.Add($dlabel)

#Label sucesso
$MsgBottom = New-Object System.Windows.Forms.label
$MsgBottom.Location =  New-Object System.Drawing.Size(20,130)
$MsgBottom.AutoSize = $true
$form1.Controls.Add($MsgBottom)
#Label sucesso
$dMsgBottom = New-Object System.Windows.Forms.label
$dMsgBottom.Location =  New-Object System.Drawing.Size(20,130)
$dMsgBottom.AutoSize = $true
$form2.Controls.Add($dMsgBottom)

#idLoja
$idLoja = New-Object System.Windows.Forms.label
$idLoja.Location =  New-Object System.Drawing.Size(23,52)
$idLoja.AutoSize = $true
$form1.Controls.Add($idLoja)
#idLoja
$idDepartamento = New-Object System.Windows.Forms.label
$idDepartamento.Location =  New-Object System.Drawing.Size(23,52)
$idDepartamento.AutoSize = $true
$form2.Controls.Add($idDepartamento)


#botoes
$canc = New-Object System.Windows.Forms.Button #botão cancelar
$canc.Location = New-Object System.Drawing.Size(130,90)
$canc.Size = New-Object System.Drawing.Size(100,20)
$canc.Text = "Próximo"
$canc.Add_Click({$form1.Tag = $form1.close()}) #fecha a janela gráfica
$form1.Controls.Add($canc)

$dcanc = New-Object System.Windows.Forms.Button #botão cancelar
$dcanc.Location = New-Object System.Drawing.Size(130,90)
$dcanc.Size = New-Object System.Drawing.Size(100,20)
$dcanc.Text = "Fechar"
$dcanc.Add_Click({$form2.Tag = $form2.close()}) #fecha a janela gráfica
$form2.Controls.Add($dcanc)


$ok = New-Object System.Windows.Forms.Button #botão ok
$ok.Location = New-Object System.Drawing.Size(20,90)
$ok.Size = New-Object System.Drawing.Size(100,20)
$ok.Text = "Ok"
$ok.Add_click({ #essa parte é executada ao clicar no botão ok
    $ultimo=Get-Content .\ixTbLoja.txt #variável recebe conteúdo do texto
    $texto=$caixa1.text
    Add-Content -Value "$ultimo|$texto" -Path .\tbLoja.txt #nova linha adicionada no arquivo

    [int]$ultimo=$ultimo #variável é convertida para int
    $ultimo++ #e é incrementada
    [string]$ultimo=([string]$ultimo).PadLeft(4,'0') #variável volta a ser string padronizada com zeros à esquerda
    Clear-Content -Path .\ixTbLoja.txt 
    Add-Content -Value $ultimo -Path .\ixTbLoja.txt 
    $idLoja.Text = "codLoja: " + $ultimo + ":"
    $MsgBottom.Text = "Loja $texto inserida."
    
    
})
$form1.Controls.Add($ok)


$dok = New-Object System.Windows.Forms.Button #botão ok
$dok.Location = New-Object System.Drawing.Size(20,90)
$dok.Size = New-Object System.Drawing.Size(100,20)
$dok.Text = "Ok"
$dok.Add_click({ #essa parte é executada ao clicar no botão ok
    $dultimo=Get-Content .\ixTbDepartamento.txt #variável recebe conteúdo do texto
    $dtexto=$dcaixa1.text
    Add-Content -Value "$dultimo|$dtexto" -Path .\tbDepartamento.txt #nova linha adicionada no arquivo

    [int]$dultimo=$dultimo #variável é convertida para int
    $dultimo++ #e é incrementada
    [string]$dultimo=([string]$dultimo).PadLeft(4,'0') #variável volta a ser string padronizada com zeros à esquerda
    Clear-Content -Path .\ixTbDepartamento.txt 
    Add-Content -Value $dultimo -Path .\ixTbDepartamento.txt 
    $idDepartamento.Text = "codDpt: " + $dultimo + ":"
    $dMsgBottom.Text = "Departamento $dtexto inserido."
})
$form2.Controls.Add($dok)

#$idLoja.Text ="codLoja: " + ((Get-Content .\tbLoja.txt -Tail 1) -split "\|")[0]

$idLoja.Text = "codLoja: " + (Get-Content .\ixTbLoja.txt) + ":"
$idDepartamento.Text = "codDpt: " + (Get-Content .\ixTbDepartamento.txt) + ":"



$interruptor=0
$form1.ShowDialog()#mostra a janela gráfica na tela
$form2.ShowDialog()




