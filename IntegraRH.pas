unit IntegraRH;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Buttons, SqlExpr, ExtCtrls, DBCtrls,
  DB, DBClient, EditNumero, Mask, JvExMask, JvToolEdit, JvBaseEdits, System.UITypes,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView, CNPUtils,
  cxGridTableView, cxGridDBTableView, cxGrid, cxCheckBox, System.Math, uFileText;

type
  TfrmIntegraRH = class(TForm)
    SBar: TStatusBar;
    pgcIntegraRH: TPageControl;
    tabImporta: TTabSheet;
    btnIniciaImportacao: TBitBtn;
    btnFechar: TBitBtn;
    btnSelArquivo: TBitBtn;
    OpenDialog1: TOpenDialog;
    tabLog: TTabSheet;
    mmoLog: TMemo;
    chkCentroCustoConta: TCheckBox;
    cbxRevendaDivisao: TCheckBox;
    gbRevendaDivisao: TGroupBox;
    dblRevendaDivisao: TDBLookupComboBox;
    dtsRevendaDivisao: TDataSource;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    edtDocumento: TEditNumero;
    cbxUtilizaCodAuxiliar: TCheckBox;
    pgcPrincipal: TPageControl;
    tabOffLine: TTabSheet;
    tabOnLine: TTabSheet;
    Label1: TLabel;
    edtArquivo: TEdit;
    Label3: TLabel;
    pnlRodape: TPanel;
    grdMetContabilidade: TcxGridDBTableView;
    lvlMetContabilidade: TcxGridLevel;
    cxMetContabilidade: TcxGrid;
    dtsMetContabilidade: TDataSource;
    cdsMetContabilidade: TClientDataSet;
    colEMPRESA: TcxGridDBColumn;
    colREVENDA: TcxGridDBColumn;
    colDTA_LANCAMENTO: TcxGridDBColumn;
    colCENTRO_CUSTO: TcxGridDBColumn;
    colCONTA_DEBITO: TcxGridDBColumn;
    colCONTA_CREDITO: TcxGridDBColumn;
    colVAL_LANCAMENTO: TcxGridDBColumn;
    colHIST_PADRAO: TcxGridDBColumn;
    colHIST_COMPLEMENTAR: TcxGridDBColumn;
    colPROCESSAR: TcxGridDBColumn;
    pnlDetalhe: TPanel;
    pnlBotoes: TPanel;
    Label4: TLabel;
    DBMemo1: TDBMemo;
    edtDocumentoOnline: TEditNumero;
    Label5: TLabel;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    colERRO: TcxGridDBColumn;
    Panel2: TPanel;
    chkMarcar: TCheckBox;
    btnRemover: TSpeedButton;
    ImportacaoSAP: TTabSheet;
    lbl1: TLabel;
    edtArquivoSAP: TEdit;
    btnSelArquivoSAP: TBitBtn;
    grp1: TGroupBox;
    lbl2: TLabel;
    edtDocumentoSAP: TEditNumero;
    grpRevendaDivisaoSAP: TGroupBox;
    dblRevendaDivisaoSAP: TDBLookupComboBox;
    cbxRevendaDivisaoSAP: TCheckBox;
    btnIniciaImportacaoSAP: TBitBtn;
    btnFecharSAP: TBitBtn;
    pbSap: TProgressBar;
    pbar: TProgressBar;
    procedure btnSelArquivoClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnIniciaImportacaoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtArquivoExit(Sender: TObject);
      procedure edtArquivoSAPExit(Sender: TObject);
    procedure cbxRevendaDivisaoClick(Sender: TObject);
    procedure grdMetContabilidadeCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure chkMarcarClick(Sender: TObject);
    procedure btnRemoverClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure btnIniciaImportacaoSAPClick(Sender: TObject);
    procedure btnSelArquivoSAPClick(Sender: TObject);
    procedure cbxRevendaDivisaoSAPClick(Sender: TObject);
  private
    { Private declarations }
    RevendaDivisao,
    Documento : String;
    cdsPvRevenda,
    cdsPvCentroCusto,
    cdsPvHistoricoPadrao,
    cdsPvConta: TClientDataset;
    procedure PreparaTemp;
    procedure CriaTemp;
    procedure IntegraOnLine;
    function RemoveRegistroMetContabilidade : Boolean;
    function VerificaRevenda(linha, revenda: String): boolean;
    function VerificaCCusto(linha, empresa, revenda: String): boolean;
    function VerificaConta(linha, empresa, revenda: String; var item: integer): boolean;
    function VerificaHistPadrao(linha, empresa: String): boolean;

  public
    { Public declarations }
  end;

var
  frmIntegraRH: TfrmIntegraRH;

implementation

uses StrUtils, DBXCommon, UAplicacao, udmConexao, RelIntergraRH,
     udmGeral, Mensagens, udmIntegracaoContabil, udmContabilidade;

{$R *.dfm}

procedure TfrmIntegraRH.btnSelArquivoClick(Sender: TObject);
begin
  OpenDialog1.Filter := 'Todos arquivos (*.*)|*.*';
  if OpenDialog1.Execute then
    begin
      edtArquivo.Text := OpenDialog1.FileName;
      edtArquivoExit(Sender);
    end;
end;

procedure TfrmIntegraRH.btnSelArquivoSAPClick(Sender: TObject);
begin
begin
  OpenDialog1.Filter := 'Todos arquivos (*.*)|*.*';
  if OpenDialog1.Execute then
    begin
      edtArquivoSAP.Text := OpenDialog1.FileName;
      edtArquivoSAPExit(Sender);
    end;
end;
end;

procedure TfrmIntegraRH.BitBtn1Click(Sender: TObject);
begin
  IntegraOnLine;
end;

procedure TfrmIntegraRH.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmIntegraRH.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  cdsMetContabilidade.Close;
  Action := caFree;
  frmIntegraRH := nil;
end;

procedure TfrmIntegraRH.btnIniciaImportacaoClick(Sender: TObject);
var
  arq: TextFile;
  linha, empresa, revenda,
  conta, Mensagem: String;
  item, contador: integer;
  valor, TotalDebito, TotalCredito: Double;
begin
  Screen.Cursor := crHourGlass;
  frmIntegraRH.Enabled := false;

  //Cria o form de relatório e op dataset
  frmRelIntegraRH := TfrmRelIntegraRH.Create(frmIntegraRH);
  frmRelIntegraRH.cdsRelIntegraRH.Close;
  frmRelIntegraRH.cdsRelIntegraRH.FieldDefs.Clear;
  frmRelIntegraRH.cdsRelIntegraRH.FieldDefs.Add('CODIGO', ftInteger, 0, false);
  frmRelIntegraRH.cdsRelIntegraRH.FieldDefs.Add('DESCRICAO', ftString, 20, false);
  frmRelIntegraRH.cdsRelIntegraRH.FieldDefs.Add('EMPRESA', ftString, 20, false);
  frmRelIntegraRH.cdsRelIntegraRH.FieldDefs.Add('REVENDA', ftString, 20, false);
  frmRelIntegraRH.cdsRelIntegraRH.FieldDefs.Add('ITEM', ftString, 20, false);
  frmRelIntegraRH.cdsRelIntegraRH.IndexDefs.Clear;
  frmRelIntegraRH.cdsRelIntegraRH.IndexDefs.Add('IDX_CODIGO', 'CODIGO;EMPRESA;REVENDA', []);
  frmRelIntegraRH.cdsRelIntegraRH.IndexName := 'IDX_CODIGO';
  frmRelIntegraRH.cdsRelIntegraRH.CreateDataSet;

  frmRelIntegraRH.cdsRelIntegraRH.Open;
  AssignFile(arq, edtArquivo.Text);
  //Verifica se o arquivo não possui nenhuma inconsistência
  Reset(arq);
  contador := 0;
  TotalDebito  := 0.00;
  TotalCredito := 0.00;
  SBar.SimpleText := 'Validando arquivo ...';
  SBar.Refresh;
  while not Eof(arq) do
  begin
    Readln(arq, linha);
    inc(contador);
    empresa := IntToStr(Aplicacao.Empresa);

    //Pega a revenda para divisao contabil
    if cbxRevendaDivisao.Checked then
    begin
      if cbxUtilizaCodAuxiliar.Checked then
      begin
        if Length(Trim(Copy(linha, 143,20))) > 0 then
          RevendaDivisao := Trim(Copy(linha, 143,20))
        else
          if Length(Trim(Copy(linha, 9,4))) > 0 then
            RevendaDivisao := Trim(Copy(linha, 9,4))
          else
            RevendaDivisao := IntToStr(Aplicacao.Revenda);
      end
      else
      begin
        if Length(Trim(Copy(linha, 9,4))) > 0 then
          RevendaDivisao := Trim(Copy(linha, 9,4))
        else
          RevendaDivisao := IntToStr(Aplicacao.Revenda);
      end;
    end
    else
    begin
      if dtsRevendaDivisao.DataSet.FieldByName('REVENDA').IsNull then
        RevendaDivisao := IntToStr(Aplicacao.Revenda)
      else
        RevendaDivisao := dtsRevendaDivisao.DataSet.FieldByName('REVENDA').AsString;
    end;

    revenda := IntToStr(Aplicacao.Revenda);

    //Conforme a empresa e revenda, localiza a "revenda padrão" para integração contábil.
    with cdsPvRevenda do
    begin
      if not IsEmpty then
      begin
        if not FieldByName('REVENDA_INTEGRACAO_CONTABIL').IsNull then
          revenda := FieldByName('REVENDA_INTEGRACAO_CONTABIL').AsString;
      end
      else
      begin
        CloseFile(arq);
        MessageDlg(Format(e2179, [empresa, revenda]), mtError, [mbOk], 0);
        mmoLog.Lines.add(Format(e2179, [empresa, revenda]));
        mmoLog.Lines.add('Foram encontrados erros. Não é possível realizar a integração.');
        pgcIntegraRH.ActivePage := tabLog;
        SBar.SimpleText := 'Erro na importação do arquivo ...';
        SBar.Refresh;
        frmIntegraRH.Enabled := true;
        Screen.Cursor := crDefault;
        Abort;
      end;
    end;

    if not VerificaRevenda(linha, revenda) then
    begin
      if not frmRelIntegraRH.cdsRelIntegraRH.Locate('ITEM', Trim(Copy(linha, 09, 04)),[]) then
        frmRelIntegraRH.cdsRelIntegraRH.AppendRecord([1+StrToInt(empresa)+StrToInt(revenda), 'REVENDA', empresa, revenda, Trim(Copy(linha, 09, 04))]);
    end;
    if not VerificaCCusto(linha, empresa, revenda) then
    begin
      if (not frmRelIntegraRH.cdsRelIntegraRH.Locate('ITEM', Trim(Copy(linha, 17, 16)),[])) and
         (Length(Trim(Copy(linha, 17, 16))) > 0) then
        frmRelIntegraRH.cdsRelIntegraRH.AppendRecord([2+StrToInt(empresa)+StrToInt(revenda), 'CENTRO DE CUSTO', empresa, revenda, Trim(Copy(linha, 17, 16))]);
    end;
    if not VerificaHistPadrao(linha, empresa) then
    begin
      if (not frmRelIntegraRH.cdsRelIntegraRH.Locate('ITEM', Trim(Copy(linha, 114, 04)),[])) and
         (Length(Trim(Copy(linha, 114, 04))) > 0) then
        frmRelIntegraRH.cdsRelIntegraRH.AppendRecord([3+StrToInt(empresa)+StrToInt(revenda), 'HISTORICO PADRAO', empresa, revenda, Trim(Copy(linha, 114, 04))]);
    end;
    if not VerificaConta(linha, empresa, revenda, item) then
    begin
      if item = 0 then
      begin
        if not frmRelIntegraRH.cdsRelIntegraRH.Locate('ITEM', Trim(Copy(linha, 74, 20)),[]) then
          frmRelIntegraRH.cdsRelIntegraRH.AppendRecord([4+StrToInt(empresa)+StrToInt(revenda), 'CONTA CONTABIL', empresa, revenda, Trim(Copy(linha, 74, 20))]);
      end;
      if item = 1 then
      begin
        if not frmRelIntegraRH.cdsRelIntegraRH.Locate('ITEM', Trim(Copy(linha, 94, 20)),[]) then
          frmRelIntegraRH.cdsRelIntegraRH.AppendRecord([4+StrToInt(empresa)+StrToInt(revenda), 'CONTA CONTABIL', empresa, revenda, Trim(Copy(linha, 94, 20))]);
      end;
      if item = 2 then
      begin
        if not frmRelIntegraRH.cdsRelIntegraRH.Locate('ITEM', Trim(Copy(linha, 74, 20)),[]) then
          frmRelIntegraRH.cdsRelIntegraRH.AppendRecord([4+StrToInt(empresa)+StrToInt(revenda), 'CONTA CONTABIL', empresa, revenda, Trim(Copy(linha, 74, 20))]);
        if not frmRelIntegraRH.cdsRelIntegraRH.Locate('ITEM', Trim(Copy(linha, 94, 20)),[]) then
          frmRelIntegraRH.cdsRelIntegraRH.AppendRecord([4+StrToInt(empresa)+StrToInt(revenda), 'CONTA CONTABIL', empresa, revenda, Trim(Copy(linha, 94, 20))]);
      end;
    end;

    valor := StrToFloat(Copy(linha,119,15))/100;

    if chkCentroCustoConta.Checked then
    begin
      if Copy(linha, 118,1) = '-' then
      begin
        conta := Trim(Copy(linha, 79,15));
      end
      else
      begin
        conta := Trim(Copy(linha, 99,15));
      end;
    end
    else
    begin
      if Copy(linha, 118,1) = '-' then
        conta := Trim(Copy(linha, 74,20))
      else
        conta := Trim(Copy(linha, 94,20));
    end;
    if conta = '' then
    begin
      mmoLog.Lines.add('Linha '+IntToStr(contador)+': conta crédito inexistente.');
    end
    else
    begin
      TotalCredito := TotalCredito + valor;
    end;

    if chkCentroCustoConta.Checked then
    begin
      if Copy(linha, 118,1) = '-' then
      begin
        conta := Trim(Copy(linha, 99,15));
      end
      else
      begin
        conta := Trim(Copy(linha, 79,15));
      end;
    end
    else
    begin
      if Copy(linha, 118,1) = '-' then
        conta := Trim(Copy(linha, 94,20))
      else
        conta := Trim(Copy(linha, 74,20));
    end;
    if conta = '' then
    begin
      mmoLog.Lines.add('Linha '+IntToStr(contador)+': conta débito inexistente.');
    end
    else
    begin
      TotalDebito := TotalDebito + valor;
    end;

  end;

  if edtDocumento.Text <> '' then
    Documento := edtDocumento.Text
  else
    Documento := 'null';

  if not frmRelIntegraRH.cdsRelIntegraRH.IsEmpty then
  begin
    mmoLog.Lines.add('Não foi possível realizar a Integração ...');
    mmoLog.Lines.add('Verifique o relatório gerado antes de prosseguir.');
    SBar.SimpleText := 'Não foi possível realizar a Integração ...';
    SBar.Refresh;
    pgcIntegraRH.ActivePage := tabLog;
    frmRelIntegraRH.RelIntegraRH.PreviewModal;
  end
  else
  begin
    try
      if TotalDebito <> TotalCredito then
      begin
        Mensagem := 'O somatório dos débitos é diferente do somatório dos créditos.'+#13#10+
                    'Total de Débitos : '+FormatFloat('###,###,###,##0.00',TotalDebito)+#13#10+
                    'Total de Créditos : '+FormatFloat('###,###,###,##0.00',TotalCredito)+#13#10+
                    'Detalhes na aba <Log de execução>.'+#13#10+
                    'Deseja continuar a importação?';
        if MessageDlg(Mensagem, mtConfirmation, [mbYes,mbNo], 0, mbNo) = mrNo then
        begin
          Mensagem := 'O somatório dos débitos é diferente do somatório dos créditos.'+#13#10+
                      'Total de Débitos : '+FormatFloat('###,###,###,##0.00',TotalDebito)+#13#10+
                      'Total de Créditos : '+FormatFloat('###,###,###,##0.00',TotalCredito);
          mmoLog.Lines.add(Mensagem);
          mmoLog.Lines.add('Foram encontrados erros. Não é possível realizar a integração.');
          pgcIntegraRH.ActivePage := tabLog;
          SBar.SimpleText := 'Erro na importação do arquivo ...';
          SBar.Refresh;
          frmIntegraRH.Enabled := true;
          Screen.Cursor := crDefault;
          CloseFile(arq);
          Abort;
        end;
      end;
      SBar.SimpleText := 'Importando lançamentos contábeis ...';
      SBar.Refresh;
      pbar.Max := contador;
      pbar.Position := 0;
      contador := 0;
      //Inicia uma transacao para garantir que só grave se der tudo certo
      dmConexao.IniciaTransacao;

      //Se não houver inconsistências realiza a importação
      Reset(arq);
      while not Eof(arq) do
      begin
        inc(contador);
        pbar.Position := contador;
        Readln(arq, linha);
        //Pega a revenda para divisao contabil
        if cbxRevendaDivisao.Checked then
        begin
          if cbxUtilizaCodAuxiliar.Checked then
          begin
            if Length(Trim(Copy(linha, 143,20))) > 0 then
              RevendaDivisao := Trim(Copy(linha, 143,20))
            else
              if Length(Trim(Copy(linha, 9,4))) > 0 then
                RevendaDivisao := Trim(Copy(linha, 9,4))
              else
                RevendaDivisao := IntToStr(Aplicacao.Revenda);
          end
          else
          begin
            if Length(Trim(Copy(linha, 9,4))) > 0 then
              RevendaDivisao := Trim(Copy(linha, 9,4))
            else
              RevendaDivisao := IntToStr(Aplicacao.Revenda);
          end;
        end
        else
        begin
          if dtsRevendaDivisao.DataSet.FieldByName('REVENDA').IsNull then
            RevendaDivisao := IntToStr(Aplicacao.Revenda)
          else
            RevendaDivisao := dtsRevendaDivisao.DataSet.FieldByName('REVENDA').AsString;
        end;
        dmContabilidade.GravaLancamento(linha, empresa, revenda, Documento,
          RevendaDivisao, chkCentroCustoConta.Checked);
      end;
      dmConexao.ComitaTransacao;
      SBar.SimpleText := 'Integração concluída com sucesso ...';
      SBar.Refresh;
      btnIniciaImportacao.Enabled := False;
    Except
      on E: Exception  do
      begin
        dmConexao.RollbackTransacao;
        mmoLog.Lines.add('Não foi possível realizar a Integração ...');
        mmoLog.Lines.add('ERRO:');
        mmoLog.Lines.Add(E.Message);
        SBar.SimpleText := 'Não foi possível realizar a Integração ...';
        SBar.Refresh;
        pgcIntegraRH.ActivePage := tabLog;
      end;
    end;
  end;
  CloseFile(arq);
  FreeAndNil(cdsPvRevenda);
  FreeAndNil(cdsPvCentroCusto);
  FreeAndNil(cdsPvHistoricoPadrao);
  FreeAndNil(cdsPvConta);

  PreparaTemp;

  frmIntegraRH.Enabled := true;
  Screen.Cursor := crDefault;
end;

procedure TfrmIntegraRH.btnIniciaImportacaoSAPClick(Sender: TObject);
var
  arq: TextFile;
  arquivo: TArquivo;
  linha, empresa, revenda,
  conta, Mensagem: String;
  item, contador: integer;
  valor, TotalDebito, TotalCredito: Double;
  dLcDtalancamento: TDateTime;
  ctaRazaoSAP,
  ctaRazaoLegado: string;
  sLcLinha, sLcHistPadrao: string;
  cCustoSAP: string;
  dLcTexto: string;
  dLcValorLancamento: Double;
  sLcValorLancamento: string;
  dLcItem: string;
  sLcNatureza: string;
  sLcCodRevendaSAP: string;
  sLcDtaLancamento: string;
  iLcLcoOrigem: integer;
  cCustoSAParquivo: string;
  sLcTipoContaDebito: string;
  sLcTipoContaCredito: string;
  sLcCCustoNaRevIntegracao: string;
  contadorPBar: Integer;

  function Formatar(Texto : string; TamanhoDesejado : integer; AcrescentarADireita : boolean = true; CaracterAcrescentar : char = ' ') : string;
  var
     QuantidadeAcrescentar,
     TamanhoTexto,
     PosicaoInicial,
     i : integer;
  begin
     case CaracterAcrescentar of
       '0'..'9','a'..'z','A'..'Z' : ;{Não faz nada}
     else
       CaracterAcrescentar := ' ';
     end;

     Texto := Trim(AnsiUpperCase(Texto));
     TamanhoTexto := Length(Texto);
     for i := 1 to (TamanhoTexto) do
     begin
        if Pos(Texto[i],' 0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ`~''"!@#$%^&*()_-+=|/\{}[]:;,.<>') = 0 then
        begin
           case Texto[i] of
             'Á','À','Â','Ä','Ã' : Texto[i] := 'A';
              'á','à','â','ä','ã' : Texto[i] := 'a';
             'É','È','Ê','Ë' : Texto[i] := 'E';
             'é','è','ê','ë' : Texto[i] := 'e';
             'Í','Ì','Î','Ï' : Texto[i] := 'I';
             'í','ì','î','ï' : Texto[i] := 'i';
             'Ó','Ò','Ô','Ö','Õ' : Texto[i] := 'O';
             'ó','ò','ô','ö','õ' : Texto[i] := 'o';
             'Ú','Ù','Û','Ü' : Texto[i] := 'U';
             'ú','ù','û','ü' : Texto[i] := 'u';
             'Ç' : Texto[i] := 'C';
             'ç' : Texto[i] := 'ç';
             'Ñ' : Texto[i] := 'N';
             'ñ' : Texto[i] := 'ñ';
           else
             Texto[i] := ' ';
           end;
        end;
     end;

     QuantidadeAcrescentar := TamanhoDesejado - TamanhoTexto;
     if QuantidadeAcrescentar < 0 then
        QuantidadeAcrescentar := 0;
     if CaracterAcrescentar = '' then
        CaracterAcrescentar := ' ';
     if TamanhoTexto >= TamanhoDesejado then
        PosicaoInicial := TamanhoTexto - TamanhoDesejado + 1
     else
        PosicaoInicial := 1;

     if AcrescentarADireita then
        Texto := Copy(Texto,1,TamanhoDesejado) + StringOfChar(CaracterAcrescentar,QuantidadeAcrescentar)
     else
        Texto := StringOfChar(CaracterAcrescentar,QuantidadeAcrescentar) + Copy(Texto,PosicaoInicial,TamanhoDesejado);

     Result := AnsiUpperCase(Texto);
  end;

function BuscaCCusto (pEmpresa, pRevenda, pCCustoSAP : string) : string;
var
  sLcComando : String;
begin
  Result := '';
    sLcComando := 'SELECT CENTRO_CUSTO FROM CTB_CENTRO_CUSTO'+
                    ' WHERE EMPRESA = ' + pEmpresa  +
                    ' AND   REVENDA = ' +  pRevenda +
                    ' AND   CENTRO_CUSTO_TERCEIROS = ' + QuotedStr(pCCustoSAP);

      dmConexao.RetornaDataset(cdsPvCentroCusto,sLcComando);
  with cdsPvCentroCusto do
  begin
    if not IsEmpty then
    begin
        Result := FieldByName('CENTRO_CUSTO').AsString;
    end
  end;
end;

function BuscaCCustoNaRevendaIntegracao (pCCusto, pRevenda, pEmpresa : string) : string;
var
  sLcComando: string;
begin
  Result := '';
  sLcComando :=   ' select CC.CENTRO_CUSTO' +
                  ' from ctb_centro_custo CC' +
                  ' WHERE CC.CENTRO_CUSTO_TERCEIROS = ' + QuotedStr(pCCusto) +
                  ' AND CC.REVENDA = ' + pRevenda +
                  ' AND CC.EMPRESA = ' + pEmpresa ;

  dmConexao.RetornaDataset(cdsPvCentroCusto,sLcComando);

  with cdsPvCentroCusto do
  begin
    if not IsEmpty then
    begin
        Result := FieldByName('CENTRO_CUSTO').AsString;
    end
  end;

end;

function BuscaRevenda (pEmpresa, pCCusto : string) : string;
var
  sLcComando : String;
begin
  Result := '';
    sLcComando := ' SELECT REVENDA ' +
                  ' FROM CTB_CENTRO_CUSTO  ' +
                  ' WHERE CENTRO_CUSTO_TERCEIROS = ' + QuotedStr(pCCusto) ;

  dmConexao.RetornaDataset(cdsPvRevenda,sLcComando);
  with cdsPvRevenda do
  begin
    if not IsEmpty then
    begin
      Result := FieldByName('REVENDA').AsString;
    end
  end;
end;

function BuscaRevendaIntegracao (pCodClienteSap : string) : Boolean;
var
  sLcComando : String;
begin
  Result := False;
       sLcComando := 'SELECT R.REVENDA, R.EMPRESA, R.REVENDA_INTEGRACAO_CONTABIL, R.CLIENTE' + #13#10 +
                      '  FROM GER_REVENDA R' + #13#10 +
                      ' INNER JOIN FAT_CLIENTE C ON (R.CLIENTE = C.CLIENTE)' +
                      ' where R.EMPRESA = '+ IntToStr(Aplicacao.Empresa) +
                      '  and R.REVENDA = '+ IntToStr(Aplicacao.Revenda) +
                      '  and C.COD_CLIENTE_SAP = ' + QuotedStr(pCodClienteSap);

  dmConexao.RetornaDataset(cdsPvRevenda,sLcComando);
  with cdsPvRevenda do
  begin
    if not IsEmpty then
    begin
      if not FieldByName('REVENDA_INTEGRACAO_CONTABIL').IsNull then
      begin
        Result := True
      end;


    end
  end;
end;


function StrParaData(pTexto: String): TDateTime;  // Converte DDMMYYYY -> TDateTime
begin
  Result := EncodeDate(StrToIntDef(Copy(pTexto,5,4),1980),
                       StrToIntDef(Copy(pTexto,3,2),1),
                       StrToIntDef(Copy(pTexto,1,2),1));
end;

begin
  Screen.Cursor := crHourGlass;
  frmIntegraRH.Enabled := false;
  //Cria o form de relatório e op dataset
  frmRelIntegraRH := TfrmRelIntegraRH.Create(frmIntegraRH);
  frmRelIntegraRH.cdsRelIntegraRH.Close;
  frmRelIntegraRH.cdsRelIntegraRH.FieldDefs.Clear;
  frmRelIntegraRH.cdsRelIntegraRH.FieldDefs.Add('CODIGO', ftInteger, 0, false);
  frmRelIntegraRH.cdsRelIntegraRH.FieldDefs.Add('DESCRICAO', ftString, 700, false);
  frmRelIntegraRH.cdsRelIntegraRH.FieldDefs.Add('EMPRESA', ftString, 20, false);
  frmRelIntegraRH.cdsRelIntegraRH.FieldDefs.Add('REVENDA', ftString, 20, false);
  frmRelIntegraRH.cdsRelIntegraRH.FieldDefs.Add('ITEM', ftString, 20, false);
  frmRelIntegraRH.cdsRelIntegraRH.IndexDefs.Clear;
  frmRelIntegraRH.cdsRelIntegraRH.IndexDefs.Add('IDX_CODIGO', 'CODIGO;EMPRESA;REVENDA', []);
  frmRelIntegraRH.cdsRelIntegraRH.IndexName := 'IDX_CODIGO';
  frmRelIntegraRH.cdsRelIntegraRH.CreateDataSet;

  frmRelIntegraRH.cdsRelIntegraRH.Open;
  AssignFile(arq, edtArquivoSAP.Text);
  arquivo := TArquivo.Create(Application);
  arquivo.ArquivoNome := edtArquivoSAP.Text;
  arquivo.Open;
  pbSap.Position := 1;
  pbSap.Max := (arquivo.NumLinha);
  //Verifica se o arquivo não possui nenhuma inconsistência
  Reset(arq);
  TotalDebito  := 0.00;
  TotalCredito := 0.00;
  contador     := 0;

  while not Eof(arq) do
  begin
    Readln(arq, linha);
    empresa := IntToStr(Aplicacao.Empresa);
    inc(contador);

    if (SeparaCampos(linha, 1, ';' ) <> '0') and
       (SeparaCampos(linha, 1, ';' ) <> '9') then
    begin
      if (SeparaCampos(linha, 1, ';' ) = '1') then
      begin
        iLcLcoOrigem := 0;

        //Busca Revenda do Arquivo
        sLcCodRevendaSAP := SeparaCampos(linha, 2, ';');

        if not BuscaRevendaIntegracao(sLcCodRevendaSAP) then
        begin
          with cdsPvRevenda do
          begin
            CloseFile(arq);
            MessageDlg(Format(e2179, [empresa, revenda]), mtError, [mbOk], 0);
            mmoLog.Lines.add(Format(e2179, [empresa, revenda]));
            mmoLog.Lines.add('Linha: '+IntToStr(contador)+ ' revenda de integração não localizada para o código SAP: ' + sLcCodRevendaSAP);
            pgcIntegraRH.ActivePage := tabLog;
            SBar.SimpleText := 'Erro na importação do arquivo ...';
            SBar.Refresh;
            frmIntegraRH.Enabled := true;
            Screen.Cursor := crDefault;
            Abort;
          end;
        end
        else
          revenda := cdsPvRevenda.FieldByName('REVENDA_INTEGRACAO_CONTABIL').AsString;

        sLcDtaLancamento := SeparaCampos(linha, 6,';');
        dLcDtalancamento := StrParaData (sLcDtaLancamento);
      end;

      if (SeparaCampos(linha, 1, ';' ) = '2') then
      begin
          //Leitura do arquivo registro 2
         dLcItem := SeparaCampos(linha, 2, ';');
         ctaRazaoSAP := SeparaCampos(linha, 8, ';');
         ctaRazaoLegado := SeparaCampos(linha, 9, ';');

         if sLcHistPadrao = '' then
         begin
            sLcHistPadrao := 'null';
         end;

         cCustoSAParquivo := SeparaCampos(linha, 14, ';' );

           //Pega a revenda para divisao contabil
         if cbxRevendaDivisaoSAP.Checked then
         begin
            if Length(SeparaCampos(linha, 14, ';' )) > 0 then
            begin
              //Busca revenda divisão do Apollo/BRAVOS
              RevendaDivisao := BuscaRevenda(empresa, cCustoSAParquivo)
            end
            else
              RevendaDivisao := IntToStr(Aplicacao.Revenda);
         end
         else
         begin
           if dtsRevendaDivisao.DataSet.FieldByName('REVENDA').IsNull then
              RevendaDivisao := IntToStr(Aplicacao.Revenda)
           else
             RevendaDivisao := dtsRevendaDivisao.DataSet.FieldByName('REVENDA').AsString;
         end;

         sLcValorLancamento := StringReplace(SeparaCampos(linha, 10, ';'),'.', '',[rfReplaceAll]);
         dLcValorLancamento := StrToFloat(sLcValorLancamento);
         dLcTexto := Formatar(SeparaCampos(linha, 21, ';' ), 32);

         if (SeparaCampos(linha, 6, ';')) <> '' then
         begin
            //Verifica se é debito
            if (SeparaCampos(linha, 6, ';')) = 'S' then
            begin
              sLcNatureza := 'D';
              sLcTipoContaDebito := ctaRazaoLegado;
            end
            else
            //Verifica se é credito
            if (SeparaCampos(linha, 6, ';')) = 'H' then
            begin
              sLcNatureza := 'C';
              sLcTipoContaCredito := ctaRazaoLegado;
            end;
         end;

         //Busca Centro de Custo
         if RevendaDivisao <> '' then
         begin
            cCustoSAP := BuscaCCusto(empresa, RevendaDivisao, cCustoSAParquivo);

            if cCustoSAP <> '' then
            begin
              sLcCCustoNaRevIntegracao := BuscaCCustoNaRevendaIntegracao(cCustoSAParquivo, revenda, empresa);

              if sLcCCustoNaRevIntegracao = '' then
              begin
                CloseFile(arq);
                mmoLog.Lines.add('Linha: '+IntToStr(contador)+ ' Não encontrado o centro de custo: ' + cCustoSAP + ' na Revenda de Integração Contábil: ' + revenda);
                pgcIntegraRH.ActivePage := tabLog;
                SBar.SimpleText := 'Erro na importação do arquivo ...';
                SBar.Refresh;
                frmIntegraRH.Enabled := true;
                Screen.Cursor := crDefault;
                Abort;
              end;
            end
            else
            begin
              CloseFile(arq);
              mmoLog.Lines.add('Linha: '+IntToStr(contador)+ ' Não encontrado o Centro de Custo: ' + cCustoSAParquivo);
              pgcIntegraRH.ActivePage := tabLog;
              SBar.SimpleText := 'Erro na importação do arquivo ...';
              SBar.Refresh;
              frmIntegraRH.Enabled := true;
              Screen.Cursor := crDefault;
              Abort;
            end
         end
         else
         begin
           mmoLog.Lines.add('Linha: '+IntToStr(contador)+ ' Não encontrado a revenda divisão contábil para o Centro de Custo: ' + cCustoSAParquivo);
           pgcIntegraRH.ActivePage := tabLog;
           SBar.SimpleText := 'Erro na importação do arquivo ...';
           SBar.Refresh;
           frmIntegraRH.Enabled := true;
         end;

         SBar.SimpleText := 'Verificando lançamento ' + contador.ToString + '/' + pbSap.Max.ToString;
         SBar.Refresh;


        // Monta linha para permitir usar a mesma rotina de gravação do lançamento contábil
         sLcLinha := '            '
                    + Formatar(cCustoSAP,4)
                    + '                '
                    + FormatDateTime('yymmdd',dLcDtalancamento)
                    + '   '
                    + Formatar(Copy(dLcTexto, 1, 32),32)
                    + Formatar(sLcTipoContaDebito,20)
                    + Formatar(sLcTipoContaCredito,20)
                    + Formatar(sLcHistPadrao,4)
                    + ' '
                    + StringReplace(StringReplace(FormatFloat('0000000000000.00', dLcValorLancamento),'.','',[rfReplaceAll,rfIgnoreCase]), ',', '', [rfReplaceAll,rfIgnoreCase]);//  'VVVVVVVVVVVVVVV';

        //Inicia uma transacao para garantir que só grave se der tudo certo
          //dmConexao.IniciaTransacao;

        if RevendaDivisao = '' then
        begin
          if not frmRelIntegraRH.cdsRelIntegraRH.Locate('ITEM', Trim(Copy(cCustoSAParquivo, 01, 10)),[]) then
            frmRelIntegraRH.cdsRelIntegraRH.AppendRecord([4+StrToInt(empresa)+StrToInt(revenda), 'Não encontrado a revenda divisão contábil para o Centro de Custo: ', empresa, revenda, Trim(Copy(cCustoSAParquivo, 01, 10))]);
        end;

        if cCustoSAP = '' then
        begin
          if (not frmRelIntegraRH.cdsRelIntegraRH.Locate('ITEM', Trim(Copy(sLcLinha, 17, 16)),[])) and
             (Length(Trim(Copy(sLcLinha, 17, 16))) > 0) then
            frmRelIntegraRH.cdsRelIntegraRH.AppendRecord([2+StrToInt(empresa)+StrToInt(revenda), 'CENTRO DE CUSTO', empresa, revenda, Trim(Copy(sLcLinha, 17, 16))]);
        end;
        if not VerificaConta(sLcLinha, empresa, revenda, item) then
        begin
          if item = 0 then
          begin
            if not frmRelIntegraRH.cdsRelIntegraRH.Locate('ITEM', Trim(Copy(sLcLinha, 74, 20)),[]) then
              frmRelIntegraRH.cdsRelIntegraRH.AppendRecord([4+StrToInt(empresa)+StrToInt(revenda), 'CONTA CONTABIL', empresa, revenda, Trim(Copy(sLcLinha, 74, 20))]);
          end;
          if item = 1 then
          begin
            if not frmRelIntegraRH.cdsRelIntegraRH.Locate('ITEM', Trim(Copy(sLcLinha, 94, 20)),[]) then
              frmRelIntegraRH.cdsRelIntegraRH.AppendRecord([4+StrToInt(empresa)+StrToInt(revenda), 'CONTA CONTABIL', empresa, revenda, Trim(Copy(sLcLinha, 94, 20))]);
          end;
          if item = 2 then
          begin
            if not frmRelIntegraRH.cdsRelIntegraRH.Locate('ITEM', Trim(Copy(sLcLinha, 74, 20)),[]) then
              frmRelIntegraRH.cdsRelIntegraRH.AppendRecord([4+StrToInt(empresa)+StrToInt(revenda), 'CONTA CONTABIL', empresa, revenda, Trim(Copy(sLcLinha, 74, 20))]);
            if not frmRelIntegraRH.cdsRelIntegraRH.Locate('ITEM', Trim(Copy(sLcLinha, 94, 20)),[]) then
              frmRelIntegraRH.cdsRelIntegraRH.AppendRecord([4+StrToInt(empresa)+StrToInt(revenda), 'CONTA CONTABIL', empresa, revenda, Trim(Copy(sLcLinha, 94, 20))]);
          end;
        end;

        valor := dLcValorLancamento;

        if ctaRazaoLegado = '' then
        begin
          mmoLog.Lines.add('Linha '+IntToStr(contador)+': conta inexistente.');
        end
        else
        begin
          if sLcNatureza = 'D' then
          begin
            TotalDebito := TotalDebito + valor;
          end
          else
            TotalCredito := TotalCredito + valor;
        end;
      end;
    end;
  end;


  if not frmRelIntegraRH.cdsRelIntegraRH.IsEmpty then
  begin
    mmoLog.Lines.add('Não foi possível realizar a Integração ...');
    mmoLog.Lines.add('Verifique o relatório gerado antes de prosseguir.');
    SBar.SimpleText := 'Não foi possível realizar a Integração ...';
    SBar.Refresh;
    pgcIntegraRH.ActivePage := tabLog;
    frmRelIntegraRH.RelIntegraRH.PreviewModal;
  end
  else
  begin
    try
      if CompareValue(TotalCredito, TotalDebito, 0.001) <> 0 then
      begin
        Mensagem := 'O somatório dos débitos é diferente do somatório dos créditos.'+#13#10+
                    'Total de Débitos : '+FormatFloat('###,###,###,##0.00',TotalDebito)+#13#10+
                    'Total de Créditos : '+FormatFloat('###,###,###,##0.00',TotalCredito)+#13#10+
                    'Detalhes na aba <Log de execução>.'+#13#10+
                    'Deseja continuar a importação?';
        if MessageDlg(Mensagem, mtConfirmation, [mbYes,mbNo], 0, mbNo) = mrNo then
        begin
          Mensagem := 'O somatório dos débitos é diferente do somatório dos créditos.'+#13#10+
                      'Total de Débitos : '+FormatFloat('###,###,###,##0.00',TotalDebito)+#13#10+
                      'Total de Créditos : '+FormatFloat('###,###,###,##0.00',TotalCredito);
          mmoLog.Lines.add(Mensagem);
          mmoLog.Lines.add('Foram encontrados erros. Não é possível realizar a integração.');
          pgcIntegraRH.ActivePage := tabLog;
          SBar.SimpleText := 'Erro na importação do arquivo ...';
          SBar.Refresh;
          frmIntegraRH.Enabled := true;
          Screen.Cursor := crDefault;
          CloseFile(arq);
          Abort;
        end;
      end;
      //Aqui entra o loop da leitura do arquivo novamente para gravar no bancos de dados

      //Inicia uma transacao para garantir que só grave se der tudo certo
      dmConexao.IniciaTransacao;
      //Se não houver inconsistências realiza a importação
      Reset(arq);
      contadorPBar := 0;
      while not Eof(arq) do
      begin
//        contador := 0;
        inc(contadorPBar);
        SBar.SimpleText := contadorPBar.ToString + '/' + pbSap.Max.ToString + ' Importando lançamentos contábeis ...';
        SBar.Refresh;
        pbSap.Position := pbSap.Position + 1;
        Readln(arq, linha);

       if edtDocumentoSAP.Text <> '' then
          Documento := edtDocumentoSAP.Text
       else
          Documento := 'null';


        if (SeparaCampos(linha, 1, ';' ) <> '0') and
               (SeparaCampos(linha, 1, ';' ) <> '9') then
        begin
          if (SeparaCampos(linha, 1, ';' ) = '1') then
          begin
            iLcLcoOrigem := 0;
            sLcTipoContaDebito := '';
            sLcTipoContaCredito := '';

            //Busca Revenda do Arquivo
            sLcCodRevendaSAP := SeparaCampos(linha, 2, ';');
            sLcDtaLancamento := SeparaCampos(linha, 6,';');
            dLcDtalancamento := StrParaData (sLcDtaLancamento);
          end;

          if (SeparaCampos(linha, 1, ';' ) = '2') then
          begin
            //Leitura do arquivo registro 2
           dLcItem := SeparaCampos(linha, 2, ';');
           ctaRazaoSAP := SeparaCampos(linha, 8, ';');
           ctaRazaoLegado := SeparaCampos(linha, 9, ';');

            if sLcHistPadrao = '' then
            begin
                  sLcHistPadrao := 'null';
            end;

           cCustoSAParquivo := SeparaCampos(linha, 14, ';' );

               //Pega a revenda para divisao contabil
           if cbxRevendaDivisaoSAP.Checked then
           begin
              if Length(SeparaCampos(linha, 14, ';' )) > 0 then
              begin
                //Busca revenda divisão do Apollo/BRAVOS
                RevendaDivisao := BuscaRevenda(empresa, cCustoSAParquivo)
              end
              else
                RevendaDivisao := IntToStr(Aplicacao.Revenda);
           end
           else
           begin
             if dtsRevendaDivisao.DataSet.FieldByName('REVENDA').IsNull then
                RevendaDivisao := IntToStr(Aplicacao.Revenda)
             else
               RevendaDivisao := dtsRevendaDivisao.DataSet.FieldByName('REVENDA').AsString;
           end;

           sLcValorLancamento := StringReplace(SeparaCampos(linha, 10, ';'),'.', '',[rfReplaceAll]);
           dLcValorLancamento := StrToFloat(sLcValorLancamento);
           dLcTexto := Formatar(SeparaCampos(linha, 21, ';' ), 32);

            if (SeparaCampos(linha, 6, ';')) <> '' then
            begin
              //Verifica se é debito
              if (SeparaCampos(linha, 6, ';')) = 'S' then
              begin
                sLcNatureza := 'D';
                sLcTipoContaDebito := ctaRazaoLegado;
              end
              else
              //Verifica se é credito
              if (SeparaCampos(linha, 6, ';')) = 'H' then
              begin
                sLcNatureza := 'C';
                sLcTipoContaCredito := ctaRazaoLegado;
              end;
            end;
              //Busca Centro de Custo
             if RevendaDivisao <> '' then
             begin
              cCustoSAP := BuscaCCusto(empresa, RevendaDivisao, cCustoSAParquivo);
             end
             else
             begin
               mmoLog.Lines.add('Linha: '+IntToStr(contador)+ ' Não encontrado a revenda divisão contábil para o Centro de Custo: ' + cCustoSAParquivo);
               pgcIntegraRH.ActivePage := tabLog;
               SBar.SimpleText := 'Erro na importação do arquivo ...';
               SBar.Refresh;
               frmIntegraRH.Enabled := true;
             end;


            // Monta linha para permitir usar a mesma rotina de gravação do lançamento contábil
             sLcLinha := '            '
                        + Formatar(cCustoSAP,4)
                        + '                '
                        + FormatDateTime('yymmdd',dLcDtalancamento)
                        + '   '
                        + Formatar(Copy(dLcTexto, 1, 32),32)
                        + Formatar(sLcTipoContaDebito,20)
                        + Formatar(sLcTipoContaCredito,20)
                        + Formatar(sLcHistPadrao,4)
                        + ' '
                        + StringReplace(StringReplace(FormatFloat('0000000000000.00', dLcValorLancamento),'.','',[rfReplaceAll,rfIgnoreCase]), ',', '', [rfReplaceAll,rfIgnoreCase]);

            dmContabilidade.GravaLancamentoSAP(sLcLinha, empresa, revenda, Documento,
            RevendaDivisao, sLcNatureza, False, iLcLcoOrigem);
          end;
        end;
      end;
      dmConexao.ComitaTransacao;
      SBar.SimpleText := 'Integração concluída com sucesso ...';
      MessageDlg('Lançamentos integrados na contabilidade com sucesso!', mtInformation, [mbOk], 0);
      SBar.Refresh;
    Except
      on E: Exception  do
       begin
          dmConexao.RollbackTransacao;
          mmoLog.Lines.add('Não foi possível realizar a Integração ...');
          mmoLog.Lines.add('ERRO:');
          mmoLog.Lines.Add(E.Message);
          SBar.SimpleText := 'Não foi possível realizar a Integração ...';
          SBar.Refresh;
          pgcIntegraRH.ActivePage := tabLog;
       end;
    end;
  end;
  CloseFile(arq);
  FreeAndNil(cdsPvRevenda);
  FreeAndNil(cdsPvCentroCusto);
  FreeAndNil(cdsPvHistoricoPadrao);
  FreeAndNil(cdsPvConta);

  PreparaTemp;
  frmIntegraRH.Enabled := true;
  Screen.Cursor := crDefault;
end;

procedure TfrmIntegraRH.btnRemoverClick(Sender: TObject);
var
  iLcPos : Integer;
begin
  with cdsMetContabilidade do
  begin
    iLcPos := FieldByName('LANCAMENTO').AsInteger;
    Last;
    while not Bof do
    begin
      if FieldByName('PROCESSAR').AsString = 'S' then
      begin
        if RemoveRegistroMetContabilidade then
          Delete
        else
          Prior;
      end
      else
        Prior;
    end;
    Locate('LANCAMENTO',iLcPos,[]);
    EnableControls;
  end;
end;

function TfrmIntegraRH.VerificaCCusto(linha, empresa, revenda: String): boolean;
var
  ccusto: integer;
begin
  //Verifica se na linha não há nenhum centro de custo que não esteja cadastrado no sistema
  Result := false;
  if Length(Trim(Copy(linha, 13, 4))) > 0 then
  begin
    if chkCentroCustoConta.Checked then
    begin
      ccusto := StrToInt(Trim(Copy(linha, 74,5)));
      with cdsPvCentroCusto do
      begin
        if FindKey([ccusto]) then
          Result := true;
      end;
      ccusto := StrToInt(Trim(Copy(linha, 94,5)));
      with cdsPvCentroCusto do
      begin
        if FindKey([ccusto]) then
          Result := true;
      end;
    end
    else
    begin
      ccusto := StrToInt(Trim(Copy(linha, 13, 4)));
      with cdsPvCentroCusto do
      begin
        if FindKey([ccusto]) then
          Result := true;
      end;
    end;
  end;
end;

function TfrmIntegraRH.VerificaConta(linha, empresa, revenda: String; var item: integer): boolean;
var
  conta: String;
begin
//Verifica se na linha não há nenhum conta contábil que não esteja cadastrado no sistema
// Obs.: As contas para lancamento devem ser analíticas.
  Result := false;
  item := -1;
  if Length(Trim(Copy(linha, 74, 20))) > 0 then
  begin
    if chkCentroCustoConta.Checked then
    begin
      conta := Trim(Copy(linha, 79, 15));
      with cdsPvConta do
      begin
        if FindKey([conta]) then
          Result := true
        else
        begin
          inc(item);
          Result := false;
        end;
      end;
    end
    else
    begin
      conta := Trim(Copy(linha, 74, 20));
      with cdsPvConta do
      begin
        if FindKey([conta]) then
          Result := true
        else
        begin
          inc(item);
          Result := false;
        end;
      end;
    end;
  end;
  if Length(Trim(Copy(linha, 94, 20))) > 0 then
  begin
    if chkCentroCustoConta.Checked then
    begin
      conta := Trim(Copy(linha, 99, 15));
      with cdsPvConta do
      begin
        if FindKey([conta]) then
        begin
          if item = -1 then
            Result := true;
        end
        else
        begin
          if item = 0 then
            item := 2
          else
            item := 1;
          Result := false;
        end;
      end;
    end
    else
    begin
      conta := Trim(Copy(linha, 94, 20));
      with cdsPvConta do
      begin
        if FindKey([conta]) then
        begin
          if item = -1 then
            Result := true;
        end
        else
        begin
          if item = 0 then
            item := 2
          else
            item := 1;
          Result := false;
        end;
      end;
    end;
  end;
  if (Length(Trim(Copy(linha, 74, 20))) = 0) and
     (Length(Trim(Copy(linha, 94, 20))) = 0) then
  begin
    inc(item);
    Result := false;
  end;
end;


function TfrmIntegraRH.VerificaHistPadrao(linha, empresa: String): boolean;
var
  hist: integer;
begin
//Verifica se na linha não há nenhum histórico padrão que não esteja cadastrado no sistema
   Result := false;
  if Length(Trim(Copy(linha, 114, 04))) > 0 then
  begin
    hist := StrToInt(Trim(Copy(linha, 114, 04)));
    with cdsPvHistoricoPadrao do
    begin
      if FindKey([hist]) then
        Result := true;
    end;
  end;
end;



procedure TfrmIntegraRH.FormCreate(Sender: TObject);
begin
  dtsRevendaDivisao.DataSet := dmGeral.cdsRevenda;
  with (dtsRevendaDivisao.DataSet as TClientDataSet) do
  begin
    Close;
    Params.ParamByName('EMPRESA').AsBCD := Aplicacao.Empresa;
    Open;
  end;
  mmoLog.Clear;
  PreparaTemp;
  CriaTemp;
end;

procedure TfrmIntegraRH.grdMetContabilidadeCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if AViewInfo.GridRecord.Values[colERRO.Index] = 'S' then
    ACanvas.Font.Color := clRed
  else
    ACanvas.Font.Color := clBlack;
end;

procedure TfrmIntegraRH.IntegraOnLine;
var
  Documento,
  sLcLinha : String;

  function Formatar(Texto : string; TamanhoDesejado : integer; AcrescentarADireita : boolean = true; CaracterAcrescentar : char = ' ') : string;
  var
     QuantidadeAcrescentar,
     TamanhoTexto,
     PosicaoInicial,
     i : integer;
  begin
     case CaracterAcrescentar of
       '0'..'9','a'..'z','A'..'Z' : ;{Não faz nada}
     else
       CaracterAcrescentar := ' ';
     end;

     Texto := Trim(AnsiUpperCase(Texto));
     TamanhoTexto := Length(Texto);
     for i := 1 to (TamanhoTexto) do
     begin
        if Pos(Texto[i],' 0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ`~''"!@#$%^&*()_-+=|/\{}[]:;,.<>') = 0 then
        begin
           case Texto[i] of
             'Á','À','Â','Ä','Ã' : Texto[i] := 'A';
             'É','È','Ê','Ë' : Texto[i] := 'E';
             'Í','Ì','Î','Ï' : Texto[i] := 'I';
             'Ó','Ò','Ô','Ö','Õ' : Texto[i] := 'O';
             'Ú','Ù','Û','Ü' : Texto[i] := 'U';
             'Ç' : Texto[i] := 'C';
             'Ñ' : Texto[i] := 'N';
           else
             Texto[i] := ' ';
           end;
        end;
     end;

     QuantidadeAcrescentar := TamanhoDesejado - TamanhoTexto;
     if QuantidadeAcrescentar < 0 then
        QuantidadeAcrescentar := 0;
     if CaracterAcrescentar = '' then
        CaracterAcrescentar := ' ';
     if TamanhoTexto >= TamanhoDesejado then
        PosicaoInicial := TamanhoTexto - TamanhoDesejado + 1
     else
        PosicaoInicial := 1;

     if AcrescentarADireita then
        Texto := Copy(Texto,1,TamanhoDesejado) + StringOfChar(CaracterAcrescentar,QuantidadeAcrescentar)
     else
        Texto := StringOfChar(CaracterAcrescentar,QuantidadeAcrescentar) + Copy(Texto,PosicaoInicial,TamanhoDesejado);

     Result := AnsiUpperCase(Texto);
  end;

  procedure RemoveIntegrados;
  var
    iLcPos : Integer;
  begin
    with cdsMetContabilidade do
    begin
      DisableControls;
      iLcPos := FieldByName('LANCAMENTO').AsInteger;
      Last;
      while not Bof do
      begin
        if FieldByName('INTEGRADO').AsString = 'S' then
        begin
          if RemoveRegistroMetContabilidade then
            Delete
          else
            Prior;
        end
        else
          Prior;
      end;
      Locate('LANCAMENTO',iLcPos,[]);
      EnableControls;
    end;
  end;
begin
  if edtDocumentoOnline.Text <> '' then
    Documento := edtDocumentoOnline.Text
  else
    Documento := 'null';
  try
    dmConexao.IniciaTransacao;
    with cdsMetContabilidade do
    begin
      First;
      while not Eof do
      begin
        if (FieldByName('PROCESSAR').AsString = 'S') and
           (FieldByName('ERRO').AsString <> 'S')then
        begin
          // Monta linha para ficar conforme integração off-line para permitir usar a mesma rotina de gravação do lançamento contábil
          sLcLinha := '            '
                    + Formatar(FieldByName('CENTRO_CUSTO').AsString,4)
                    + '                '
                    + FormatDateTime('yymmdd', FieldByName('DTA_LANCAMENTO').AsDateTime)
                    + '   '
                    + Formatar(Copy(FieldByName('HIST_COMPLEMENTAR').AsString, 1, 32),32)
                    + Formatar(FieldByName('CONTA_DEBITO').AsString,20)
                    + Formatar(FieldByName('CONTA_CREDITO').AsString,20)
                    + Formatar(FieldByName('HIST_PADRAO').AsString,4)
                    + ' '
                    + StringReplace(StringReplace(FormatFloat('0000000000000.00', FieldByName('VAL_LANCAMENTO').AsFloat),'.','',[rfReplaceAll,rfIgnoreCase]), ',', '', [rfReplaceAll,rfIgnoreCase]);//  'VVVVVVVVVVVVVVV';

           dmContabilidade.GravaLancamento(sLcLinha, IntToStr(Aplicacao.Empresa), IntToStr(Aplicacao.Revenda), Documento, FieldByName('REVENDA').AsString, False);
           Edit;
           FieldByName('INTEGRADO').AsString := 'S';
        end;
        Next;
      end;
      RemoveIntegrados;
      dmConexao.ComitaTransacao;
      MessageDlg('Lançamentos integrados na contabilidade com sucesso!'+sLineBreak+'Os registros integrados serão removidos da tabela temporária', mtInformation, [mbOk], 0);
    end;
  except on E: Exception do
    dmConexao.RollbackTransacao;
  end;
end;

procedure TfrmIntegraRH.PreparaTemp;
var
  Revenda,
  sLcComando : String;
begin
   sLcComando := 'select REVENDA_INTEGRACAO_CONTABIL from GER_REVENDA'+
                ' where EMPRESA = ' + IntToStr(Aplicacao.Empresa) +
                ' and   REVENDA = ' + IntToStr(Aplicacao.Revenda);
  dmConexao.RetornaDataset(cdsPvRevenda, sLcComando);
  if cdsPvRevenda.IsEmpty then
    Revenda := IntToStr(Aplicacao.Revenda)
  else
    Revenda := cdsPvRevenda.FieldByName('REVENDA_INTEGRACAO_CONTABIL').AsString;

  sLcComando := 'select CENTRO_CUSTO from CTB_CENTRO_CUSTO ' +
                ' where EMPRESA = '+ IntToStr(Aplicacao.Empresa) +
                ' and   REVENDA = '+ Revenda;
  dmConexao.RetornaDataset(cdsPvCentroCusto, sLcComando);
  cdsPvCentroCusto.IndexDefs.Clear;
  cdsPvCentroCusto.IndexDefs.Add('IDX_CHAVE', 'CENTRO_CUSTO', [ixPrimary, ixUnique]);
  cdsPvCentroCusto.IndexName := 'IDX_CHAVE';

  sLcComando := 'select HISTORICO_PADRAO from CTB_HISTORICO_PADRAO ' +
                ' where EMPRESA = '+ IntToStr(Aplicacao.Empresa);
  dmConexao.RetornaDataset(cdsPvHistoricoPadrao, sLcComando);
  cdsPvHistoricoPadrao.IndexDefs.Clear;
  cdsPvHistoricoPadrao.IndexDefs.Add('IDX_CHAVE', 'HISTORICO_PADRAO', [ixPrimary, ixUnique]);
  cdsPvHistoricoPadrao.IndexName := 'IDX_CHAVE';

  sLcComando := 'select CONTA from CTB_CONTA ' +
                ' where EMPRESA = '+ IntToStr(Aplicacao.Empresa) +
                ' and   REVENDA = '+ Revenda +
                ' and   NIVEL   = ''A''' ;
  dmConexao.RetornaDataset(cdsPvConta, sLcComando);
  cdsPvConta.IndexDefs.Clear;
  cdsPvConta.IndexDefs.Add('IDX_CHAVE', 'CONTA', [ixPrimary, ixUnique]);
  cdsPvConta.IndexName := 'IDX_CHAVE';
end;

function TfrmIntegraRH.RemoveRegistroMetContabilidade : Boolean;
var
  sLcComando : String;
begin
  with cdsMetContabilidade do
  begin
    sLcComando := 'delete from MET_CONTABILIZACAO '
                + ' where CENTROCUSTO = ' + QuotedStr(FieldByName('CENTROCUSTO').AsString)
                + '   and DATALANCAMENTO = ' + DataHoraPSql(FieldByName('DATALANCAMENTO').AsDateTime,Aplicacao.BancoDados)
                + '   and CONTADEBITO = ' + QuotedStr(FieldByName('CONTADEBITO').AsString)
                + '   and CONTACREDITO = ' + QuotedStr(FieldByName('CONTACREDITO').AsString)
		            + '   and TPPESSOADEBITO = ' + QuotedStr(FieldByName('TPPESSOADEBITO').AsString)
                + '   and CGCCPFDEBITO = ' + QuotedStr(FieldByName('CGCCPFDEBITO').AsString)
                + '   and TPPESSOACREDITO = ' + QuotedStr(FieldByName('TPPESSOACREDITO').AsString)
                + '   and CGCCPFCREDITO = ' + QuotedStr(FieldByName('CGCCPFCREDITO').AsString);

    Result := dmConexao.ExecutaDML(sLcComando);
  end;
end;

function TfrmIntegraRH.VerificaRevenda(linha, revenda: String): boolean;
begin
  //Verifica se na linha não há nenhuma revenda que não exista no cadastro
  Result := false;
  if Length(Trim(revenda)) > 0 then
  begin
    with cdsPvRevenda do
    begin
      if not IsEmpty then
        Result := true;
    end;
  end;
end;

procedure TfrmIntegraRH.edtArquivoExit(Sender: TObject);
begin
  if FileExists(edtArquivo.Text) then
    btnIniciaImportacao.Enabled := true;
end;

procedure TfrmIntegraRH.edtArquivoSAPExit(Sender: TObject);
begin
  if FileExists(edtArquivoSAP.Text) then
    btnIniciaImportacaoSAP.Enabled := true;
end;


procedure TfrmIntegraRH.cbxRevendaDivisaoClick(Sender: TObject);
begin
     if cbxRevendaDivisao.Checked then begin
        dblRevendaDivisao.Enabled := False;
        gbRevendaDivisao.Enabled := False;
     end
     else begin
        gbRevendaDivisao.Enabled := True;
        dblRevendaDivisao.Enabled := True;
     end;
end;

procedure TfrmIntegraRH.cbxRevendaDivisaoSAPClick(Sender: TObject);
begin
     if cbxRevendaDivisaoSAP.Checked then
     begin
        dblRevendaDivisaoSAP.Enabled := False;
        grpRevendaDivisaoSAP.Enabled := False;
     end
     else
     begin
        grpRevendaDivisaoSAP.Enabled := True;
        dblRevendaDivisaoSAP.Enabled := True;
     end;
end;

procedure TfrmIntegraRH.chkMarcarClick(Sender: TObject);
var
  iLcPos : Integer;
begin
  with cdsMetContabilidade do
  begin
    DisableControls;
    iLcPos := FieldByName('LANCAMENTO').AsInteger;
    First;
    while not Eof do
    begin
      Edit;
      if chkMarcar.Checked then
        FieldByName('PROCESSAR').AsString := 'S'
      else
        FieldByName('PROCESSAR').AsString := 'N';
      Post;
      Next;
    end;
    Locate('LANCAMENTO',iLcPos,[]);
    EnableControls;
  end;
end;

procedure TfrmIntegraRH.CriaTemp;
var
  iLcLancamento : Integer;
  sLcComando : String;
  cdsMetAux: TClientDataset;
  sLcMensagem: String;
begin
  dtsMetContabilidade.DataSet.DisableControls;
  with cdsMetContabilidade do
  begin
    Close;
    FieldDefs.Clear;
    FieldDefs.Add('LANCAMENTO',        ftInteger, 0,False);
    FieldDefs.Add('EMPRESA',           ftInteger, 0,False);
    FieldDefs.Add('REVENDA',           ftInteger, 0,False);
    FieldDefs.Add('DTA_LANCAMENTO',    ftDate    ,0,false);
    FieldDefs.Add('CENTRO_CUSTO',      ftString,  20,false);
    FieldDefs.Add('CONTA_DEBITO',      ftString,  20,false);
    FieldDefs.Add('CONTA_CREDITO',     ftString,  20,false);
    FieldDefs.Add('VAL_LANCAMENTO',    ftFloat,   0,false);
    FieldDefs.Add('HIST_PADRAO',       ftString,  4,false);
    FieldDefs.Add('HIST_COMPLEMENTAR', ftString,  40,false);
    FieldDefs.Add('PROCESSAR',         ftString,  1,false); // S-Marcado N-Não marcado
    FieldDefs.Add('ERRO',              ftString,  1,false);
    FieldDefs.Add('MENSAGEM',          ftString,200,false);
    FieldDefs.Add('PROCESSAMENTO',     ftString,200,false);

    FieldDefs.Add('CENTROCUSTO',       ftString,  20,false);
    FieldDefs.Add('DATALANCAMENTO',    ftDateTime,0,false);
    FieldDefs.Add('CONTADEBITO',       ftString,  20,false);
    FieldDefs.Add('CONTACREDITO',      ftString,  20,false);
    FieldDefs.Add('TPPESSOADEBITO',    ftString,  1,false);
    FieldDefs.Add('CGCCPFDEBITO',      ftString,  11,false);
    FieldDefs.Add('TPPESSOACREDITO',   ftString,  1,false);
    FieldDefs.Add('CGCCPFCREDITO',     ftString,  20,false);
    FieldDefs.Add('INTEGRADO',         ftString,  1,false);

    IndexDefs.Clear;
    IndexDefs.Add('', 'CENTROCUSTO;DATALANCAMENTO;CONTADEBITO;CONTACREDITO;TPPESSOADEBITO;CGCCPFDEBITO;TPPESSOACREDITO;CGCCPFCREDITO', [ixPrimary, ixUnique]);
    CreateDataSet;
    Open;
    (cdsMetContabilidade.FieldByName('VAL_LANCAMENTO') as TNumericField).DisplayFormat := '###,###,##0.00';
  end;

  sLcComando := 'select REV.EMPRESA, REV.REVENDA, MET.* '
              + '  from MET_CONTABILIZACAO MET '
              + '       inner join GER_REVENDA REV on (replace(replace(MET.INSCRICAO,''/'',''''),''-'','''') = REV.CNPJ) '
              + '                                 and (REV.EMPRESA = '+IntToStr(Aplicacao.Empresa)+')'
              + ' order by REV.EMPRESA, REV.REVENDA';

  dmConexao.RetornaDataset(cdsMetAux, sLcComando);
  iLcLancamento := 0;
  with cdsMetAux do
  begin
    First;
    while not Eof do
    begin
      if not cdsMetContabilidade.FindKey([FieldByName('CENTROCUSTO').Value,
                                          FieldByName('DATALANCAMENTO').Value,
                                          FieldByName('CONTADEBITO').Value,
                                          FieldByName('CONTACREDITO').Value,
                                          FieldByName('TPPESSOADEBITO').Value,
                                          FieldByName('CGCCPFDEBITO').Value,
                                          FieldByName('TPPESSOACREDITO').Value,
                                          FieldByName('CGCCPFCREDITO').Value]) then
      begin
        cdsMetContabilidade.Append;
        inc(iLcLancamento);
        cdsMetContabilidade.FieldByName('LANCAMENTO').AsInteger    := iLcLancamento;
        cdsMetContabilidade.FieldByName('EMPRESA').Value           := FieldByName('EMPRESA').Value;
        cdsMetContabilidade.FieldByName('REVENDA').Value           := FieldByName('REVENDA').Value;
        cdsMetContabilidade.FieldByName('DTA_LANCAMENTO').Value    := FieldByName('DATALANCAMENTO').Value;
        cdsMetContabilidade.FieldByName('CENTRO_CUSTO').Value      := FieldByName('CENTROCUSTO').Value;
        if FieldByName('VALOR').AsFloat < 0 then
        begin
          cdsMetContabilidade.FieldByName('CONTA_DEBITO').Value      := FieldByName('CONTACREDITO').Value;
          cdsMetContabilidade.FieldByName('CONTA_CREDITO').Value     := FieldByName('CONTADEBITO').Value;
          cdsMetContabilidade.FieldByName('VAL_LANCAMENTO').AsFloat  := FieldByName('VALOR').AsFloat * -1;
        end
        else
        begin
          cdsMetContabilidade.FieldByName('CONTA_DEBITO').Value      := FieldByName('CONTADEBITO').Value;
          cdsMetContabilidade.FieldByName('CONTA_CREDITO').Value     := FieldByName('CONTACREDITO').Value;
          cdsMetContabilidade.FieldByName('VAL_LANCAMENTO').Value    := FieldByName('VALOR').Value;
        end;

        cdsMetContabilidade.FieldByName('HIST_PADRAO').Value       := FieldByName('CODIGOHISTORICO').Value;
        cdsMetContabilidade.FieldByName('HIST_COMPLEMENTAR').Value := FieldByName('DESCRICAOHISTORICO').Value;
        cdsMetContabilidade.FieldByName('PROCESSAR').AsString      := 'N';
        cdsMetContabilidade.FieldByName('ERRO').AsString           := 'N';
        cdsMetContabilidade.FieldByName('INTEGRADO').AsString      := 'N';
        sLcMensagem := '';
        if (FieldByName('CENTROCUSTO').AsString <> '') and
           (not cdsPvCentroCusto.FindKey([FieldByName('CENTROCUSTO').AsString])) then
          sLcMensagem := sLcMensagem + 'Centro de custo: ['+FieldByName('CENTROCUSTO').AsString+'] não encontrado' + sLineBreak;

        if (FieldByName('CONTADEBITO').AsString <> '') and
           (not cdsPvConta.FindKey([FieldByName('CONTADEBITO').AsString])) then
          sLcMensagem := sLcMensagem + 'Conta débito: ['+FieldByName('CONTADEBITO').AsString+'] não encontrada' + sLineBreak;

        if (FieldByName('CONTACREDITO').AsString <> '') and
           (not cdsPvConta.FindKey([FieldByName('CONTACREDITO').AsString])) then
          sLcMensagem := sLcMensagem + 'Conta débito: ['+FieldByName('CONTACREDITO').AsString+'] não encontrada' + sLineBreak;

        if (FieldByName('CODIGOHISTORICO').AsString <> '') and
           (not cdsPvHistoricoPadrao.FindKey([FieldByName('CODIGOHISTORICO').AsString])) then
          sLcMensagem := sLcMensagem + 'Histórico padrão: ['+FieldByName('CODIGOHISTORICO').AsString+'] não encontrado' + sLineBreak;

        cdsMetContabilidade.FieldByName('MENSAGEM').AsString       := sLcMensagem;
        if sLcMensagem <> '' then
          cdsMetContabilidade.FieldByName('ERRO').AsString           := 'S';

        cdsMetContabilidade.FieldByName('PROCESSAMENTO').Value       := null;

        cdsMetContabilidade.FieldByName('CENTROCUSTO').Value     := FieldByName('CENTROCUSTO').Value;
        cdsMetContabilidade.FieldByName('DATALANCAMENTO').Value  := FieldByName('DATALANCAMENTO').Value;
        cdsMetContabilidade.FieldByName('CONTADEBITO').Value     := FieldByName('CONTADEBITO').Value;
        cdsMetContabilidade.FieldByName('CONTACREDITO').Value    := FieldByName('CONTACREDITO').Value;
        cdsMetContabilidade.FieldByName('TPPESSOADEBITO').Value  := FieldByName('TPPESSOADEBITO').Value;
        cdsMetContabilidade.FieldByName('CGCCPFDEBITO').Value    := FieldByName('CGCCPFDEBITO').Value;
        cdsMetContabilidade.FieldByName('TPPESSOACREDITO').Value := FieldByName('TPPESSOACREDITO').Value;
        cdsMetContabilidade.FieldByName('CGCCPFCREDITO').Value   := FieldByName('CGCCPFCREDITO').Value;
        cdsMetContabilidade.Post;
      end
      else
      begin
        cdsMetContabilidade.Edit;
        if FieldByName('VALOR').AsFloat < 0 then
        begin
          cdsMetContabilidade.FieldByName('VAL_LANCAMENTO').AsFloat  := cdsMetContabilidade.FieldByName('VAL_LANCAMENTO').AsFloat + (FieldByName('VALOR').AsFloat * -1);
        end
        else
        begin
          cdsMetContabilidade.FieldByName('VAL_LANCAMENTO').Value    := cdsMetContabilidade.FieldByName('VAL_LANCAMENTO').Value + FieldByName('VALOR').Value;
        end;
        cdsMetContabilidade.Post;
      end;
      Next;
    end;
    Close;
  end;
  FreeAndNil(cdsMetAux);
  dtsMetContabilidade.DataSet.EnableControls;
  cdsMetContabilidade.First;
end;

end.
