#Assemblies
Add-Type -AssemblyName System.Windows.forms
Add-Type -Assemblyname System.Drawing

#Janela grafica
$form1 = New-Object System.Windows.Forms.Form
$form1.text = "Formul�rio"
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
$msgSucesso = New-Object System.Windows.Forms.label
$msgSucesso.Location =  New-Object System.Drawing.Size(20,130)
$msgSucesso.AutoSize = $true
$form1.Controls.Add($msgSucesso)

#idLoja
$idLoja = New-Object System.Windows.Forms.label
$idLoja.Location =  New-Object System.Drawing.Size(23,52)
$idLoja.AutoSize = $true
$form1.Controls.Add($idLoja)


#botoes
$canc = New-Object System.Windows.Forms.Button #botao cancelar
$canc.Location = New-Object System.Drawing.Size(130,90)
$canc.Size = New-Object System.Drawing.Size(100,20)
$canc.Text = "Cancelar"
$canc.Add_Click({$form1.Tag = $form1.close()}) #fecha a janela grafica
$form1.Controls.Add($canc)

$ok = New-Object System.Windows.Forms.Button #botao ok
$ok.Location = New-Object System.Drawing.Size(20,90)
$ok.Size = New-Object System.Drawing.Size(100,20)
$ok.Text = "Ok"
$ok.Add_click({ #essa parte ï¿½ executada ao clicar no botao ok
    $ultimo=Get-Content .\ixTbLoja.txt #variï¿½vel recebe conteï¿½do do texto
    $texto=$caixa1.text
    Add-Content -Value "$ultimo|$texto" -Path .\tbLoja.txt #nova linha adicionada no arquivo

    [int]$ultimo=$ultimo #variï¿½vel ï¿½ convertida para int
    $ultimo++ #e ï¿½ incrementada
    [string]$ultimo=([string]$ultimo).PadLeft(4,'0') #variï¿½vel volta a ser string padronizada com zeros ï¿½ esquerda
    Clear-Content -Path .\ixTbLoja.txt 
    Add-Content -Value $ultimo -Path .\ixTbLoja.txt 
    $idLoja.Text = "codLoja: " + $ultimo + ":"
    $msgSucesso.Text = "Loja inserida com sucesso."
    
    
})
$form1.Controls.Add($ok)

#$idLoja.Text ="codLoja: " + ((Get-Content .\tbLoja.txt -Tail 1) -split "\|")[0]

$idLoja.Text = "codLoja: " + (Get-Content .\ixTbLoja.txt) + ":"



$form1.ShowDialog()#mostra a janela grafica na tela




