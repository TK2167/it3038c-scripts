param([int]$delay=0, [string]$EventLabel = "Countdown Time")

#Gets the resolution of monitor
$monitordetails = [System.Windows.Forms.SystemInformation]::PrimaryMonitorSize
$monitorheight = $monitordetails.Height
$monitorwidth = $monitordetails.Width

#Sets up the starting form
$Counter_Form = New-Object System.Windows.Forms.Form
$Counter_Form.Text = "Countdown Timer!"
$Counter_Form.Height = $monitorheight * .80
$Counter_Form.Width = $monitorwidth * .80
$Counter_Form.WindowState = "Normal"
$Counter_Form.Top = $monitorheight *.10
$Counter_Form.Left = $monitorwidth *.10
$Counter_Form.StartPosition = "manual"

#Sets up the normal font  
$normalfont = New-Object System.Drawing.Font("Times New Roman",32)

#Sets up the starting label and normal font 
$Counter_Label = New-Object System.Windows.Forms.Label
$Counter_Label.ForeColor = "Blue"
$Counter_Label.Font = $normalfont
$Counter_GetDelay_Label = New-Object System.Windows.Forms.Label
$Counter_GetDelay_Label.AutoSize = $true
$Counter_GetDelay_Label.Text = "Enter In Seconds:"
$Counter_GetDelay_Label.Left = 550
$Counter_GetDelay_Label.Top = $Counter_Form.Height * .3
$Counter_Form.Controls.Add($Counter_GetDelay_Label)
$Counter_GetDelay_TextBox = New-Object System.Windows.Forms.TextBox
$Counter_GetDelay_TextBox.AutoSize = $true 
$Counter_GetDelay_TextBox.Text = $delay
$Counter_GetDelay_TextBox.Left = $Counter_GetDelay_Label.Left + $Counter_GetDelay_Label.Width + 10
$Counter_GetDelay_TextBox.Top = $Counter_Form.Height * .3
$Counter_Form.Controls.Add($Counter_GetDelay_TextBox)
$EventLabel_Size= [System.Windows.Forms.TextRenderer]::MeasureText($EventLabel, $normalfont)
$Counter_Event_Label = New-Object System.Windows.Forms.Label
$Counter_Event_Label.Width = $EventLabel_Size.Width+6  
$Counter_Event_Label.Height= $EventLabel_Size.Height
$Counter_Event_Label.Text = $EventLabel
$Counter_Event_Label.Left = ($Counter_Form.Width/2)-($EventLabel_Size.Width/2)
$Counter_Event_Label.Top = ($Counter_Form.Height/2)-($EventLabel_Size.Height/2)
$Counter_Event_Label.Font = $normalfont
$Counter_StartButton = New-Object System.Windows.Forms.Button
$Counter_StartButton.AutoSize = $true 
$Counter_StartButton.Text = "Start"
$Counter_StartButton.Left = 650
$Counter_StartButton.Top = $Counter_Form.Height * .35
$Counter_StartButton.Add_Click({
   $delay=$Counter_GetDelay_TextBox.Text
   #Removes things that are not needed
   $Counter_Form.Controls.Remove($Counter_GetDelay_Label)
   $Counter_Form.Controls.Remove($Counter_GetDelay_TextBox)
   $Counter_Form.Controls.Remove($Counter_StartButton)
   $Counter_Form.Controls.Remove($Counter_CancelButton)
   #Adds things that are needed
   $Counter_Form.Controls.Add($Counter_Label)
   $Counter_Form.Controls.Add($Counter_Event_Label)
   while ($delay -gt 0)
   {
      $Counter_Label.Text = "Time Remaining: $($delay)"
      $Counter_LabelSize= [System.Windows.Forms.TextRenderer]::MeasureText($Counter_Label.Text , $normalfont)
      $Counter_Label.Font = $normalfont
      $Counter_Label.AutoSize = $true
      $Counter_Label.Left = ($Counter_Form.Width/2)-($Counter_LabelSize.Width/2)  
      $Counter_Label.Top = $Counter_Form.Height * .3 
      if ($delay -le 5)  
      { 
            
          #Sets up label and font for last couple of seconds
          $Counter_Label.ForeColor = "Red"
          $warningfont = New-Object System.Drawing.Font("Times New Roman",32,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold -bor [System.Drawing.FontStyle]::Underline))
          $Counter_Label.Font = $warningfont
          $Counter_LabelSize= [System.Windows.Forms.TextRenderer]::MeasureText($Counter_Label.Text , $warningfont)
          $Counter_Label.Width = $Counter_LabelSize.Width + 10
          $Counter_Label.Left = ($Counter_Form.Width/2)-($Counter_LabelSize.Width/2)
      } 
      start-sleep 1
      $delay -= 1
  }
  $Counter_Form.Close()
})

#Sets up cancel button
$Counter_Form.Controls.Add($Counter_StartButton)
$Counter_CancelButton = New-Object System.Windows.Forms.Button
$Counter_CancelButton.AutoSize = $true
$Counter_CancelButton.Text = "Cancel"
$Counter_CancelButton.Left = $Counter_StartButton.Left + $Counter_StartButton.Width + 10
$Counter_CancelButton.Top = $Counter_Form.Height * .35
$Counter_CancelButton.Add_Click({$counter_form.Close() })
$Counter_Form.Controls.Add($Counter_CancelButton)



#Shows Dialog
$Counter_Form.ShowDialog() | Out-Null 
 