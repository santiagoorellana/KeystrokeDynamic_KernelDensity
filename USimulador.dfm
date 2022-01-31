object Form1: TForm1
  Left = 192
  Top = 114
  Width = 303
  Height = 366
  Caption = 'Simulador KeystrokeDynamic'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    295
    335)
  PixelsPerInch = 96
  TextHeight = 13
  object ButtonComenzarSimulacion: TButton
    Left = 128
    Top = 117
    Width = 161
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Comenzar simulaci'#243'n'
    TabOrder = 0
    OnClick = ButtonComenzarSimulacionClick
  end
  object GroupBoxUmbral: TGroupBox
    Left = 8
    Top = 5
    Width = 281
    Height = 49
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Umbral'
    TabOrder = 1
    DesignSize = (
      281
      49)
    object Label5: TLabel
      Left = 232
      Top = 20
      Width = 20
      Height = 13
      Anchors = [akTop, akRight]
      Caption = '00%'
    end
    object TrackBarUmbral: TTrackBar
      Left = 5
      Top = 16
      Width = 222
      Height = 25
      Anchors = [akLeft, akTop, akRight]
      Max = 100
      Min = 1
      Orientation = trHorizontal
      Frequency = 5
      Position = 1
      SelEnd = 0
      SelStart = 0
      TabOrder = 0
      TickMarks = tmBottomRight
      TickStyle = tsAuto
      OnChange = TrackBarUmbralChange
    end
  end
  object GroupBoxSuavizado: TGroupBox
    Left = 8
    Top = 61
    Width = 281
    Height = 49
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Suavizado'
    TabOrder = 2
    DesignSize = (
      281
      49)
    object Label6: TLabel
      Left = 232
      Top = 20
      Width = 12
      Height = 13
      Anchors = [akTop, akRight]
      Caption = '00'
    end
    object TrackBarSuavizado: TTrackBar
      Left = 5
      Top = 16
      Width = 222
      Height = 25
      Anchors = [akLeft, akTop, akRight]
      Max = 80
      Min = 1
      Orientation = trHorizontal
      Frequency = 1
      Position = 1
      SelEnd = 0
      SelStart = 0
      TabOrder = 0
      TickMarks = tmBottomRight
      TickStyle = tsAuto
      OnChange = TrackBarSuavizadoChange
    end
  end
  object GroupBox3: TGroupBox
    Left = 7
    Top = 145
    Width = 282
    Height = 181
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Resultados'
    TabOrder = 3
    DesignSize = (
      282
      181)
    object Label2: TLabel
      Left = 54
      Top = 80
      Width = 43
      Height = 13
      Caption = 'Precisi'#243'n'
    end
    object Label3: TLabel
      Left = 30
      Top = 19
      Width = 69
      Height = 13
      Caption = 'Usuario patr'#243'n'
    end
    object Label4: TLabel
      Left = 7
      Top = 42
      Width = 92
      Height = 13
      Caption = 'Usuario que intenta'
    end
    object Label7: TLabel
      Left = 35
      Top = 106
      Width = 63
      Height = 13
      Caption = 'Tasa de error'
    end
    object Label8: TLabel
      Left = 77
      Top = 132
      Width = 21
      Height = 13
      Caption = 'FAR'
    end
    object Label9: TLabel
      Left = 77
      Top = 157
      Width = 22
      Height = 13
      Caption = 'FRR'
    end
    object EditPrecision: TEdit
      Left = 104
      Top = 76
      Width = 172
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
    object EditUsuarioPatron: TEdit
      Left = 104
      Top = 14
      Width = 172
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
    end
    object EditUsuarioIntenta: TEdit
      Left = 104
      Top = 38
      Width = 172
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 2
    end
    object EditTasaError: TEdit
      Left = 104
      Top = 102
      Width = 172
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 3
    end
    object EditFAR: TEdit
      Left = 104
      Top = 128
      Width = 172
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 4
    end
    object EditFRR: TEdit
      Left = 104
      Top = 153
      Width = 172
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 5
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 50
    OnTimer = Timer1Timer
    Left = 80
    Top = 117
  end
end
