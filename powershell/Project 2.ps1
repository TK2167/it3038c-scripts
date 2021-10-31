$delay = 60
$Counter_Form = New-Object System.Windows.Forms.Form
$Counter_Form.Text = "Timer"
$Counter_Form.Width = 300
$Counter_Form.Height = 150
$Counter_Label = New-Object System.Windows.Forms.Label
$Counter_Label.AutoSize = $true 
$Counter_Form.Controls.Add($Counter_Label)
while ($delay -ge 0)
{
  $Counter_Form.Show()
  $Counter_Label.Text = "Time Remaining: $($delay)"
  start-sleep 1
  $delay -= 1
}
$Counter_Form.Close() 