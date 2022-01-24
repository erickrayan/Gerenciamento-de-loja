#Assemblies
Add-Type -AssemblyName System.Windows.forms
Add-Type -Assemblyname System.Drawing

#Janela gráfica
$form1 = New-Object System.Windows.Forms.Form
$form1.text = "Inserção de loja"
$Form1.size = New-Object System.Drawing.Size(350,200)

#Caixa de texto
$caixa1 = New-Object System.Windows.Forms.TextBox
$caixa1.Location = New-Object System.Drawing.Size(100,50)
$caixa1.Size = New-Object System.Drawing.Size(208,20)
$form1.Controls.Add($caixa1) #adiciona a caixa de texto na janela grafica

#Label
$label = New-Object System.Windows.Forms.label
$label.Text = "Digite o nome da loja a ser inserida:"
$label.Location =  New-Object System.Drawing.Size(20,15)
$label.AutoSize = $true
$form1.Controls.Add($label)

#Label sucesso
$MsgBottom = New-Object System.Windows.Forms.label
$MsgBottom.Location =  New-Object System.Drawing.Size(20,130)
$MsgBottom.AutoSize = $true
$form1.Controls.Add($MsgBottom)

#idLoja
$idLoja = New-Object System.Windows.Forms.label
$idLoja.Location =  New-Object System.Drawing.Size(23,52)
$idLoja.AutoSize = $true
$form1.Controls.Add($idLoja)


#botoes
$canc = New-Object System.Windows.Forms.Button #botão cancelar
$canc.Location = New-Object System.Drawing.Size(130,90)
$canc.Size = New-Object System.Drawing.Size(100,20)
$canc.Text = "Fechar"
$canc.Add_Click({$form1.Tag = $form1.close()}) #fecha a janela gráfica
$form1.Controls.Add($canc)

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

#$idLoja.Text ="codLoja: " + ((Get-Content .\tbLoja.txt -Tail 1) -split "\|")[0]

$idLoja.Text = "codLoja: " + (Get-Content .\ixTbLoja.txt) + ":"



$form1.ShowDialog()#mostra a janela gráfica na tela




