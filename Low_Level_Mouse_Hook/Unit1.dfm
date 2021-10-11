object Form1: TForm1
  Left = 225
  Top = 135
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Low Level Mouse Hook'
  ClientHeight = 232
  ClientWidth = 520
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnDestroy = FormDestroy
  PixelsPerInch = 120
  TextHeight = 16
  object gbHookStatus: TGroupBox
    Left = 5
    Top = 5
    Width = 338
    Height = 80
    Caption = ' Mouse Hook Status '
    TabOrder = 0
    object btnStopHook: TButton
      Left = 224
      Top = 30
      Width = 98
      Height = 30
      Caption = 'Stop Hook'
      Enabled = False
      TabOrder = 0
      OnClick = btnStopHookClick
    end
    object btnStartHook: TButton
      Left = 15
      Top = 30
      Width = 98
      Height = 30
      Caption = 'Start Hook'
      TabOrder = 1
      OnClick = btnStartHookClick
    end
    object btnUpdateHook: TButton
      Left = 119
      Top = 30
      Width = 99
      Height = 30
      Caption = 'Update Hook'
      Enabled = False
      TabOrder = 2
      OnClick = btnUpdateHookClick
    end
  end
  object gbFilterOptions: TGroupBox
    Left = 5
    Top = 89
    Width = 338
    Height = 114
    Caption = ' Mouse Filter Options '
    TabOrder = 1
    object cbBlockLeftButton: TCheckBox
      Left = 15
      Top = 27
      Width = 129
      Height = 21
      Caption = 'Block Left Button'
      TabOrder = 0
    end
    object cbBlockMiddleButton: TCheckBox
      Left = 15
      Top = 54
      Width = 146
      Height = 21
      Caption = 'Block Middle Button'
      TabOrder = 1
    end
    object cbBlockRightButton: TCheckBox
      Left = 15
      Top = 81
      Width = 139
      Height = 21
      Caption = 'Block Right Button'
      TabOrder = 2
    end
    object cbBlockMouseMove: TCheckBox
      Left = 177
      Top = 27
      Width = 144
      Height = 21
      Caption = 'Block Mouse Move'
      TabOrder = 3
    end
    object cbBlockWheel: TCheckBox
      Left = 177
      Top = 54
      Width = 97
      Height = 21
      Caption = 'Block Wheel'
      TabOrder = 4
    end
  end
  object gbStayOnTop: TGroupBox
    Left = 350
    Top = 5
    Width = 163
    Height = 199
    Caption = ' Mouse State '
    TabOrder = 2
    object cbLeftMouseClick: TCheckBox
      Left = 10
      Top = 22
      Width = 127
      Height = 21
      Caption = 'Left Mouse Click'
      TabOrder = 0
    end
    object cbMiddleMouseClick: TCheckBox
      Left = 10
      Top = 53
      Width = 139
      Height = 21
      Caption = 'Middle Mouse Click'
      TabOrder = 1
    end
    object cbRightMouseClick: TCheckBox
      Left = 10
      Top = 84
      Width = 134
      Height = 21
      Caption = 'Right Mouse Click'
      TabOrder = 2
    end
  end
  object cbStayOnTop: TCheckBox
    Left = 8
    Top = 209
    Width = 97
    Height = 21
    Caption = 'Stay On Top'
    TabOrder = 3
    OnClick = cbStayOnTopClick
  end
end
