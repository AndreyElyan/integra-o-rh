object frmIntegraRH: TfrmIntegraRH
  Left = 355
  Top = 161
  Width = 848
  Height = 545
  VertScrollBar.Range = 16
  VertScrollBar.Visible = False
  Caption = 'Integra'#231#227'o RH'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = True
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object SBar: TStatusBar
    Left = 0
    Top = 490
    Width = 832
    Height = 16
    Panels = <>
    SimplePanel = True
  end
  object pgcPrincipal: TPageControl
    Left = 0
    Top = 0
    Width = 832
    Height = 490
    ActivePage = tabOffLine
    Align = alClient
    TabOrder = 1
    object tabOffLine: TTabSheet
      Caption = 'Integra'#231#227'o Off-line'
      object pgcIntegraRH: TPageControl
        Left = 0
        Top = 0
        Width = 824
        Height = 462
        ActivePage = ImportacaoSAP
        Align = alClient
        MultiLine = True
        TabOrder = 0
        object tabImporta: TTabSheet
          Caption = 'Importa'#231#227'o Metadados'
          object Label1: TLabel
            Left = 5
            Top = 7
            Width = 115
            Height = 13
            Caption = 'Arquivo a ser importado'
          end
          object Label3: TLabel
            Left = 19
            Top = 215
            Width = 315
            Height = 52
            Caption = 
              'O C'#243'digo Auxiliar do Estabelecimento s'#243' '#233' gerado quando a op'#231#227'o ' +
              #39'Gravar o C'#243'digo Auxiliar do Estabelecimento?'#8217', estiver com a op' +
              #231#227'o '#39'Sim, posi'#231#227'o 143 (layout 1)'#8217' selecionada na exporta'#231#227'o da M' +
              'etadados.'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clTeal
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            WordWrap = True
          end
          object btnIniciaImportacao: TBitBtn
            Left = 237
            Top = 367
            Width = 135
            Height = 26
            Caption = 'Iniciar Importa'#231#227'o'
            Enabled = False
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000120B0000120B00001000000010000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
              33333333333FFFFFFFFF333333000000000033333377777777773333330FFFFF
              FFF03333337F333333373333330FFFFFFFF03333337F3FF3FFF73333330F00F0
              00F03333F37F773777373330330FFFFFFFF03337FF7F3F3FF3F73339030F0800
              F0F033377F7F737737373339900FFFFFFFF03FF7777F3FF3FFF70999990F00F0
              00007777777F7737777709999990FFF0FF0377777777FF37F3730999999908F0
              F033777777777337F73309999990FFF0033377777777FFF77333099999000000
              3333777777777777333333399033333333333337773333333333333903333333
              3333333773333333333333303333333333333337333333333333}
            NumGlyphs = 2
            TabOrder = 7
            OnClick = btnIniciaImportacaoClick
          end
          object btnFechar: TBitBtn
            Left = 427
            Top = 367
            Width = 135
            Height = 26
            Caption = '&Fechar'
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000120B0000120B00001000000010000000000000000000
              80000080000000808000800000008000800080800000C0C0C000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00330000000000
              033333FFFFFFFFFFF3333301BBBBBBBB033333F877777777F33333011BBBBBBB
              033333F887777777F333330111BBBBBB033333F888777777F3333301110BBBBB
              033333F888F77777F3333301110BBBBB033333F888F77777F3333301110BBBBB
              033333F888F77777F3333301110BBBBB033333F888F77777F3333301110BBBBB
              033333F888F77777F3333301110BBBBB033333F888F77777F333330111B0BBBB
              033333F8887F7777F3333301110BBBBB033333F888F77777F3333301110BBBBB
              033333F888F77777F3333301110BBBBB033333F888F77777F3333301110BBBBB
              033333F888F77777F333330000000000033333FFFFFFFFFFF333}
            NumGlyphs = 2
            TabOrder = 8
            OnClick = btnFecharClick
          end
          object btnSelArquivo: TBitBtn
            Left = 408
            Top = 21
            Width = 28
            Height = 25
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000120B0000120B00001000000010000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
              5555555555555555555555555555555555555555555555555555555555555555
              555555555555555555555555555555555555555FFFFFFFFFF555550000000000
              55555577777777775F55500B8B8B8B8B05555775F555555575F550F0B8B8B8B8
              B05557F75F555555575F50BF0B8B8B8B8B0557F575FFFFFFFF7F50FBF0000000
              000557F557777777777550BFBFBFBFB0555557F555555557F55550FBFBFBFBF0
              555557F555555FF7555550BFBFBF00055555575F555577755555550BFBF05555
              55555575FFF75555555555700007555555555557777555555555555555555555
              5555555555555555555555555555555555555555555555555555}
            NumGlyphs = 2
            TabOrder = 1
            OnClick = btnSelArquivoClick
          end
          object chkCentroCustoConta: TCheckBox
            Left = 5
            Top = 58
            Width = 244
            Height = 16
            Caption = 'Centro de Custo Vinculado '#224' conta'
            TabOrder = 2
          end
          object cbxRevendaDivisao: TCheckBox
            Left = 5
            Top = 83
            Width = 347
            Height = 31
            Caption = 'Gravar Revenda Divis'#227'o Cont'#225'bil conforme arquivo de importa'#231#227'o'
            TabOrder = 3
            OnClick = cbxRevendaDivisaoClick
          end
          object gbRevendaDivisao: TGroupBox
            Left = 5
            Top = 116
            Width = 349
            Height = 57
            Caption = 'Revenda Divis'#227'o Cont'#225'bil:'
            TabOrder = 4
            object dblRevendaDivisao: TDBLookupComboBox
              Left = 8
              Top = 24
              Width = 321
              Height = 21
              KeyField = 'REVENDA'
              ListField = 'NOME_FANTASIA;REVENDA'
              ListSource = dtsRevendaDivisao
              TabOrder = 0
            end
          end
          object GroupBox1: TGroupBox
            Left = 438
            Top = 116
            Width = 361
            Height = 60
            Caption = 'Documento:'
            TabOrder = 5
            object Label2: TLabel
              Left = 8
              Top = 43
              Width = 328
              Height = 13
              Caption = 
                'Obs.: Utilizado para identificar os lan'#231'amentos da folha  na dig' +
                'ita'#231#227'o'
            end
            object edtDocumento: TEditNumero
              Left = 8
              Top = 17
              Width = 101
              Height = 21
              TabOrder = 0
              Text = ''
              MascaraEdicao = '#########'
              DecimalPlaces = 0
              ShowButton = False
            end
          end
          object cbxUtilizaCodAuxiliar: TCheckBox
            Left = 5
            Top = 192
            Width = 327
            Height = 17
            Caption = 
              'Utiliza o C'#243'digo Auxiliar do Estabelecimento (Posi'#231#245'es 143 a 162' +
              ')'
            TabOrder = 6
          end
          object edtArquivo: TEdit
            Left = 5
            Top = 23
            Width = 401
            Height = 21
            TabOrder = 0
            OnExit = edtArquivoExit
          end
          object pbar: TProgressBar
            Left = 8
            Top = 418
            Width = 808
            Height = 16
            Smooth = True
            Step = 1
            TabOrder = 9
          end
        end
        object ImportacaoSAP: TTabSheet
          Caption = 'Importa'#231#227'o SAP'
          ImageIndex = 2
          object lbl1: TLabel
            Left = 16
            Top = 23
            Width = 115
            Height = 13
            Caption = 'Arquivo a ser importado'
          end
          object edtArquivoSAP: TEdit
            Left = 13
            Top = 50
            Width = 481
            Height = 21
            TabOrder = 0
            OnExit = edtArquivoExit
          end
          object btnSelArquivoSAP: TBitBtn
            Left = 500
            Top = 48
            Width = 28
            Height = 25
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000120B0000120B00001000000010000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
              5555555555555555555555555555555555555555555555555555555555555555
              555555555555555555555555555555555555555FFFFFFFFFF555550000000000
              55555577777777775F55500B8B8B8B8B05555775F555555575F550F0B8B8B8B8
              B05557F75F555555575F50BF0B8B8B8B8B0557F575FFFFFFFF7F50FBF0000000
              000557F557777777777550BFBFBFBFB0555557F555555557F55550FBFBFBFBF0
              555557F555555FF7555550BFBFBF00055555575F555577755555550BFBF05555
              55555575FFF75555555555700007555555555557777555555555555555555555
              5555555555555555555555555555555555555555555555555555}
            NumGlyphs = 2
            TabOrder = 1
            OnClick = btnSelArquivoSAPClick
          end
          object grp1: TGroupBox
            Left = 13
            Top = 153
            Width = 361
            Height = 60
            Caption = 'Documento:'
            TabOrder = 2
            object lbl2: TLabel
              Left = 8
              Top = 43
              Width = 328
              Height = 13
              Caption = 
                'Obs.: Utilizado para identificar os lan'#231'amentos da folha  na dig' +
                'ita'#231#227'o'
            end
            object edtDocumentoSAP: TEditNumero
              Left = 3
              Top = 16
              Width = 101
              Height = 21
              TabOrder = 0
              Text = ''
              MascaraEdicao = '#########'
              DecimalPlaces = 0
              ShowButton = False
            end
          end
          object grpRevendaDivisaoSAP: TGroupBox
            Left = 13
            Top = 248
            Width = 349
            Height = 57
            Caption = 'Revenda Divis'#227'o Cont'#225'bil:'
            TabOrder = 3
            object dblRevendaDivisaoSAP: TDBLookupComboBox
              Left = 3
              Top = 24
              Width = 321
              Height = 21
              KeyField = 'REVENDA'
              ListField = 'NOME_FANTASIA;REVENDA'
              ListSource = dtsRevendaDivisao
              TabOrder = 0
            end
          end
          object cbxRevendaDivisaoSAP: TCheckBox
            Left = 13
            Top = 101
            Width = 344
            Height = 36
            Caption = 'Gravar Revenda Divis'#227'o Cont'#225'bil conforme arquivo de importa'#231#227'o'
            TabOrder = 4
            OnClick = cbxRevendaDivisaoSAPClick
          end
          object btnIniciaImportacaoSAP: TBitBtn
            Left = 239
            Top = 350
            Width = 135
            Height = 39
            Caption = 'Iniciar Importa'#231#227'o'
            Enabled = False
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000120B0000120B00001000000010000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
              33333333333FFFFFFFFF333333000000000033333377777777773333330FFFFF
              FFF03333337F333333373333330FFFFFFFF03333337F3FF3FFF73333330F00F0
              00F03333F37F773777373330330FFFFFFFF03337FF7F3F3FF3F73339030F0800
              F0F033377F7F737737373339900FFFFFFFF03FF7777F3FF3FFF70999990F00F0
              00007777777F7737777709999990FFF0FF0377777777FF37F3730999999908F0
              F033777777777337F73309999990FFF0033377777777FFF77333099999000000
              3333777777777777333333399033333333333337773333333333333903333333
              3333333773333333333333303333333333333337333333333333}
            NumGlyphs = 2
            TabOrder = 5
            OnClick = btnIniciaImportacaoSAPClick
          end
          object btnFecharSAP: TBitBtn
            Left = 459
            Top = 352
            Width = 135
            Height = 37
            Caption = '&Fechar'
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000120B0000120B00001000000010000000000000000000
              80000080000000808000800000008000800080800000C0C0C000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00330000000000
              033333FFFFFFFFFFF3333301BBBBBBBB033333F877777777F33333011BBBBBBB
              033333F887777777F333330111BBBBBB033333F888777777F3333301110BBBBB
              033333F888F77777F3333301110BBBBB033333F888F77777F3333301110BBBBB
              033333F888F77777F3333301110BBBBB033333F888F77777F3333301110BBBBB
              033333F888F77777F3333301110BBBBB033333F888F77777F333330111B0BBBB
              033333F8887F7777F3333301110BBBBB033333F888F77777F3333301110BBBBB
              033333F888F77777F3333301110BBBBB033333F888F77777F3333301110BBBBB
              033333F888F77777F333330000000000033333FFFFFFFFFFF333}
            NumGlyphs = 2
            TabOrder = 6
            OnClick = btnFecharClick
          end
          object pbSap: TProgressBar
            Left = 5
            Top = 395
            Width = 808
            Height = 24
            Smooth = True
            Step = 1
            TabOrder = 7
          end
        end
        object tabLog: TTabSheet
          Caption = 'Log de Execu'#231#227'o'
          ImageIndex = 1
          object mmoLog: TMemo
            Left = 0
            Top = 0
            Width = 816
            Height = 434
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Courier New'
            Font.Style = []
            Lines.Strings = (
              'mmoLog')
            ParentFont = False
            TabOrder = 0
          end
        end
      end
    end
    object tabOnLine: TTabSheet
      Caption = 'Integra'#231#227'o On-line Metadados'
      ImageIndex = 1
      object pnlRodape: TPanel
        Left = 0
        Top = 317
        Width = 824
        Height = 145
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 0
        object pnlDetalhe: TPanel
          Left = 0
          Top = 0
          Width = 824
          Height = 88
          Align = alClient
          BevelKind = bkFlat
          BevelOuter = bvNone
          TabOrder = 0
          DesignSize = (
            820
            84)
          object Label4: TLabel
            Left = 3
            Top = 1
            Width = 114
            Height = 13
            Caption = 'Detalhe do lan'#231'amento:'
          end
          object DBMemo1: TDBMemo
            Left = 3
            Top = 15
            Width = 710
            Height = 0
            Anchors = [akLeft, akTop, akRight, akBottom]
            DataField = 'MENSAGEM'
            DataSource = dtsMetContabilidade
            ReadOnly = True
            TabOrder = 0
          end
        end
        object pnlBotoes: TPanel
          Left = 0
          Top = 88
          Width = 824
          Height = 57
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 1
          object Label5: TLabel
            Left = 3
            Top = 7
            Width = 58
            Height = 13
            Caption = 'Documento:'
          end
          object edtDocumentoOnline: TEditNumero
            Left = 67
            Top = 3
            Width = 101
            Height = 21
            TabOrder = 0
            Text = ''
            MascaraEdicao = '#########'
            DecimalPlaces = 0
            ShowButton = False
          end
          object Panel1: TPanel
            Left = 0
            Top = 27
            Width = 824
            Height = 30
            Align = alBottom
            BevelKind = bkFlat
            BevelOuter = bvNone
            TabOrder = 1
            object BitBtn1: TBitBtn
              Left = 256
              Top = 1
              Width = 135
              Height = 25
              Caption = 'Integrar lan'#231'amentos'
              Glyph.Data = {
                76010000424D7601000000000000760000002800000020000000100000000100
                04000000000000010000120B0000120B00001000000010000000000000000000
                800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
                33333333333FFFFFFFFF333333000000000033333377777777773333330FFFFF
                FFF03333337F333333373333330FFFFFFFF03333337F3FF3FFF73333330F00F0
                00F03333F37F773777373330330FFFFFFFF03337FF7F3F3FF3F73339030F0800
                F0F033377F7F737737373339900FFFFFFFF03FF7777F3FF3FFF70999990F00F0
                00007777777F7737777709999990FFF0FF0377777777FF37F3730999999908F0
                F033777777777337F73309999990FFF0033377777777FFF77333099999000000
                3333777777777777333333399033333333333337773333333333333903333333
                3333333773333333333333303333333333333337333333333333}
              NumGlyphs = 2
              TabOrder = 0
              OnClick = BitBtn1Click
            end
            object BitBtn2: TBitBtn
              Left = 430
              Top = 1
              Width = 135
              Height = 25
              Caption = '&Fechar'
              Glyph.Data = {
                76010000424D7601000000000000760000002800000020000000100000000100
                04000000000000010000120B0000120B00001000000010000000000000000000
                80000080000000808000800000008000800080800000C0C0C000808080000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00330000000000
                033333FFFFFFFFFFF3333301BBBBBBBB033333F877777777F33333011BBBBBBB
                033333F887777777F333330111BBBBBB033333F888777777F3333301110BBBBB
                033333F888F77777F3333301110BBBBB033333F888F77777F3333301110BBBBB
                033333F888F77777F3333301110BBBBB033333F888F77777F3333301110BBBBB
                033333F888F77777F3333301110BBBBB033333F888F77777F333330111B0BBBB
                033333F8887F7777F3333301110BBBBB033333F888F77777F3333301110BBBBB
                033333F888F77777F3333301110BBBBB033333F888F77777F3333301110BBBBB
                033333F888F77777F333330000000000033333FFFFFFFFFFF333}
              NumGlyphs = 2
              TabOrder = 1
              OnClick = btnFecharClick
            end
          end
        end
      end
      object cxMetContabilidade: TcxGrid
        Left = 0
        Top = 0
        Width = 824
        Height = 293
        Align = alClient
        TabOrder = 1
        object grdMetContabilidade: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          OnCustomDrawCell = grdMetContabilidadeCustomDrawCell
          DataController.DataSource = dtsMetContabilidade
          DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          object colPROCESSAR: TcxGridDBColumn
            DataBinding.FieldName = 'PROCESSAR'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ImmediatePost = True
            Properties.ValueChecked = 'S'
            Properties.ValueUnchecked = 'N'
            MinWidth = 24
            Options.Filtering = False
            Options.IncSearch = False
            Options.HorzSizing = False
            Options.Moving = False
            Options.ShowCaption = False
            Width = 24
            IsCaptionAssigned = True
          end
          object colEMPRESA: TcxGridDBColumn
            Caption = 'Emp'
            DataBinding.FieldName = 'EMPRESA'
            HeaderAlignmentHorz = taCenter
            MinWidth = 35
            Options.Editing = False
            Options.HorzSizing = False
            Options.Moving = False
            Width = 35
          end
          object colREVENDA: TcxGridDBColumn
            Caption = 'Rev'
            DataBinding.FieldName = 'REVENDA'
            HeaderAlignmentHorz = taCenter
            MinWidth = 35
            Options.Editing = False
            Options.HorzSizing = False
            Options.Moving = False
            Width = 35
          end
          object colDTA_LANCAMENTO: TcxGridDBColumn
            Caption = 'Data'
            DataBinding.FieldName = 'DTA_LANCAMENTO'
            HeaderAlignmentHorz = taCenter
            MinWidth = 70
            Options.Editing = False
            Options.HorzSizing = False
            Options.Moving = False
            Width = 70
          end
          object colCENTRO_CUSTO: TcxGridDBColumn
            Caption = 'C.Custo'
            DataBinding.FieldName = 'CENTRO_CUSTO'
            HeaderAlignmentHorz = taCenter
            MinWidth = 60
            Options.Editing = False
            Options.HorzSizing = False
            Options.Moving = False
            Width = 60
          end
          object colCONTA_DEBITO: TcxGridDBColumn
            Caption = 'D'#233'bito'
            DataBinding.FieldName = 'CONTA_DEBITO'
            HeaderAlignmentHorz = taCenter
            MinWidth = 95
            Options.Editing = False
            Options.HorzSizing = False
            Options.Moving = False
            Width = 95
          end
          object colCONTA_CREDITO: TcxGridDBColumn
            Caption = 'Cr'#233'dito'
            DataBinding.FieldName = 'CONTA_CREDITO'
            HeaderAlignmentHorz = taCenter
            MinWidth = 95
            Options.Editing = False
            Options.HorzSizing = False
            Options.Moving = False
            Width = 95
          end
          object colVAL_LANCAMENTO: TcxGridDBColumn
            Caption = 'Val.Lan'#231'amento'
            DataBinding.FieldName = 'VAL_LANCAMENTO'
            HeaderAlignmentHorz = taCenter
            MinWidth = 106
            Options.Editing = False
            Options.HorzSizing = False
            Options.Moving = False
            Width = 106
          end
          object colHIST_PADRAO: TcxGridDBColumn
            Caption = 'H.Padr'#227'o'
            DataBinding.FieldName = 'HIST_PADRAO'
            HeaderAlignmentHorz = taCenter
            MinWidth = 55
            Options.Editing = False
            Options.HorzSizing = False
            Options.Moving = False
            Width = 55
          end
          object colHIST_COMPLEMENTAR: TcxGridDBColumn
            Caption = 'Hist.Complementar'
            DataBinding.FieldName = 'HIST_COMPLEMENTAR'
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.Moving = False
          end
          object colERRO: TcxGridDBColumn
            DataBinding.FieldName = 'ERRO'
            Visible = False
          end
        end
        object lvlMetContabilidade: TcxGridLevel
          GridView = grdMetContabilidade
        end
      end
      object Panel2: TPanel
        Left = 0
        Top = 293
        Width = 824
        Height = 24
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 2
        object btnRemover: TSpeedButton
          Left = 1
          Top = 1
          Width = 23
          Height = 22
          Hint = 'Remove lan'#231'amentos selecionados'
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000001000000030000
            0007000000060000000300000006000000080000000400000001000000000000
            00000000000000000000000000000000000000000000000000030B082C4D2619
            99EA110A58A2010003160F0855A3160C7EEA0603244F00000004000000000000
            0001000000060000000A0000000B0000000B0000000B000000112E23A2EA6F85
            EAFF4150CBFF1F1689E63B48C9FF5C74E4FF180E82E700000007000000000000
            000680574CBDB37B69FFB37A68FFB37A68FFB27968FFDCC6BEFF756BC0FF7780
            DDFF6D8BEFFF5872E5FF6381EDFF6972D8FF1A13659F00000005000000000000
            0008B57D6BFFFBF7F3FFFBF6F3FFFBF6F3FFFBF5F2FFFAF5F3FFEFECEFFF4D46
            BDFF6A85EBFF7494F2FF6079E7FF262094E40101041300000002000000000000
            0008B67F6DFFFCF8F5FFF8EFECFFF7EEEAFFF7EEEAFFF9F5F3FF807DD4FF6B7E
            E2FF93B0F6FFA0B3F2FF8AA6F4FF5D6EDBFF1C186AA000000004000000000000
            0008B8826FFFFCF9F6FFCDA493FFCCA393FFCCA393FFEEE3DFFF615ED6FFB1C3
            F6FF8D99EAFF5F5DD2FF8995E7FFA6B8F3FF3B35AEE300000004000000000000
            0007BA8473FFFDF9F8FFF8F1EEFFF8F0EDFFF8F0ECFFFAF5F3FFCECDEEFF6564
            DEFF9291E2FFF2F1F3FF8982D3FF4340BCE71212334600000002000000000000
            0007BB8776FFFDFBF9FFCEA898FFCEA796FFCEA695FFCDA695FFE1CAC0FFEFE5
            E1FFE7D6D0FFFCF9F8FFE3CFC9FF0000000C0000000200000000000000000000
            0006BD8A78FFFDFBFAFFF9F2F0FFF9F2F0FFF8F2EFFFF9F1EFFFF8F1EEFFF9F1
            EEFFF8F0EDFFFDFAF8FFBB8675FF000000080000000000000000000000000000
            0006BF8D7BFFFEFCFBFFD1AE9DFFD0AC9CFFD0AB9BFFCFAA99FFCEA999FFCEA8
            97FFC69C8AFFFDFBF9FFBD8978FF000000080000000000000000000000000000
            0005C39381FFFEFDFDFFFBF6F4FFFBF5F4FFFBF4F2FFFAF4F2FFFAF4F1FFF9F3
            F1FFFAF3F1FFFEFCFBFFC18F7EFF000000070000000000000000000000000000
            0004C69887FFFFFEFEFFD5B2A3FFD4B2A2FFD4B1A0FFD3AF9FFFD2AD9DFFD1AD
            9CFFC9A090FFFEFDFDFFC59684FF000000060000000000000000000000000000
            0003C99B8AFFFFFEFEFFFBF7F6FFFCF7F6FFFCF6F5FFFBF6F5FFFCF6F5FFFBF5
            F5FFFBF6F4FFFFFEFEFFC79887FF000000050000000000000000000000000000
            0003CA9E8DFFFFFFFFFFFFFFFFFFFFFFFEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFE
            FEFFFFFEFEFFFFFEFEFFC99B8AFF000000040000000000000000000000000000
            00029B7F74BFD0AB9CFFD0AB9CFFD0AA9CFFCFA99BFFCFA99AFFCFA999FFCFA8
            99FFCEA899FFCFA898FF997B71C0000000030000000000000000}
          ParentShowHint = False
          ShowHint = True
          OnClick = btnRemoverClick
        end
      end
      object chkMarcar: TCheckBox
        Left = 18
        Top = 3
        Width = 13
        Height = 15
        TabOrder = 3
        OnClick = chkMarcarClick
      end
    end
  end
  object OpenDialog1: TOpenDialog
    FilterIndex = 0
    Left = 698
    Top = 45
  end
  object dtsRevendaDivisao: TDataSource
    Left = 724
    Top = 162
  end
  object dtsMetContabilidade: TDataSource
    DataSet = cdsMetContabilidade
    Left = 476
    Top = 2
  end
  object cdsMetContabilidade: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 720
    Top = 97
  end
end
