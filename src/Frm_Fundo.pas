unit Frm_Fundo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, System.Math, Vcl.ExtCtrls;

type
  TFormFundo = class(TForm)
    lbl: TLabel;
    ProgressBar: TProgressBar;
    lblMensagem: TLabel;
    pnl: TGridPanel;
  private
    { Private declarations }
    FFormPai         : TObject;
    FFormSender      : TObject;
    FEsmaecer        : Boolean;

    procedure AjustarTamanhoFonteLabel(ALabel: TLabel; ATamanhoMaximoFonte: Integer);
  public
    { Public declarations }
    procedure Exibir(ASender: TObject; AExibirAguarde: Boolean = True; AMensagem: String = '';
      AExibirBarraDeProgresso: Boolean = False; AExibirTelaCheia: Boolean = False);
    procedure Fechar;

    procedure Atualizar(Const AMensagem: String); Overload;
    procedure Atualizar(Const APercentual: Real); Overload;
    procedure Atualizar(Const APosição, ATotal: Integer); Overload;
    procedure ExecuteThread(AProc: TProc; AProcTerminate: TNotifyEvent);

    constructor CreateNew(AOwner: TComponent; AEsmaecer: Boolean = True); reintroduce;
  end;

var
  FormFundo: TFormFundo;

implementation

{$R *.dfm}

procedure TFormFundo.Atualizar(const AMensagem: String);
begin
  Application.ProcessMessages;
  lblMensagem.Caption := AMensagem;
  lblMensagem.Visible := AMensagem <> EmptyStr;

  AjustarTamanhoFonteLabel(lbl, 40);
  if AMensagem <> EmptyStr then
    AjustarTamanhoFonteLabel(lblMensagem, 16);
  Application.ProcessMessages;
end;

procedure TFormFundo.Atualizar(const APercentual: Real);
begin
  Application.ProcessMessages;
  ProgressBar.Visible  := True;
  ProgressBar.Max      := 100;
  ProgressBar.Position := Abs(Floor(APercentual));
  Application.ProcessMessages;
end;

procedure TFormFundo.AjustarTamanhoFonteLabel(ALabel: TLabel; ATamanhoMaximoFonte: Integer);
var
  lbl: TLabel;
begin
  lbl           := TLabel.Create(Self);
  lbl.Left      := 0;
  lbl.Caption   := ALabel.Caption;
  lbl.AutoSize  := True;
  lbl.WordWrap  := False;
  lbl.Font      := ALabel.Font;
  lbl.Font.Size := 1;

  while (lbl.Width < Self.Width) and (lbl.Font.Size < ATamanhoMaximoFonte) do
    lbl.Font.Size := lbl.Font.Size + 1;

  ALabel.Font.Size := lbl.Font.Size -1;
  Application.ProcessMessages;

  lbl.Free;
end;

procedure TFormFundo.Atualizar(const APosição, ATotal: Integer);
begin
  Application.ProcessMessages;
  ProgressBar.Visible  := True;
  ProgressBar.Max      := ATotal;
  ProgressBar.Position := APosição;
  Application.ProcessMessages;
end;

/// <summary> Cria o FormFundo na aplicação</summary>
/// <param name="AOwner">Form pai (form principal da aplicação)</param>
/// <param name="AEsmaecer">Para deixar com fundo escuro</param>
/// <param name="AMonitorNum">Para exibir no monitor específico caso AOwner = nill</param>
/// <param name="ATamanhoFontes">Para mudar o tamanho da fonte padrão, colocando numero negatido diminui o tamanho</param>
constructor TFormFundo.CreateNew(AOwner: TComponent; AEsmaecer: Boolean);
begin
  FFormPai  := AOwner;
  FEsmaecer := AEsmaecer;
  inherited CreateNew(AOwner);
  Left := 0;
  Top := 0;

  AlphaBlend  := True;
  BorderStyle := bsNone;
  Color       := clBlack;

  pnl        := TGridPanel.Create(Self);
  pnl.Parent := Self;
  pnl.Align  := alClient;

  pnl.RowCollection.Clear;
  pnl.RowCollection.Add;
  pnl.RowCollection.Add;
  pnl.RowCollection.Add;
  pnl.RowCollection.Add;
  pnl.RowCollection.Add;
  pnl.ColumnCollection.Clear;
  pnl.ColumnCollection.Add;

  lbl                  := TLabel.Create(pnl);
  lbl.Parent           := pnl;
  lblMensagem          := TLabel.Create(pnl);
  lblMensagem.Parent   := pnl;
  ProgressBar          := TProgressBar.Create(pnl);
  ProgressBar.Parent   := pnl;
  
  pnl.ControlCollection[0].SetLocation(0, 1, True);
  pnl.ControlCollection[1].SetLocation(0, 2, True);
  pnl.ControlCollection[2].SetLocation(0, 3, True);

  pnl.ColumnCollection[0].SizeStyle := ssPercent;
  pnl.ColumnCollection[0].Value     := 100;

  pnl.RowCollection[0].SizeStyle := ssPercent;
  pnl.RowCollection[0].Value     := 53;
  pnl.RowCollection[1].SizeStyle := ssAbsolute;
  pnl.RowCollection[1].Value     := 70;
  pnl.RowCollection[2].SizeStyle := ssAbsolute;
  pnl.RowCollection[2].Value     := 50;
  pnl.RowCollection[3].SizeStyle := ssAbsolute;
  pnl.RowCollection[3].Value     := 30;
  pnl.RowCollection[4].SizeStyle := ssPercent;
  pnl.RowCollection[4].Value     := 50;

  lbl.Align       := alClient;
  lbl.Caption     := 'Aguarde processando solicitação...';
  lbl.Font.Name   := 'Tahoma';
  lbl.Font.Color  := clWhite;
  lbl.Font.Size   := 40;
  lbl.Font.Style  := [fsBold];
  lbl.Alignment   := taCenter;
  lbl.Layout      := tlCenter;
  lbl.Transparent := False;
  lbl.ParentColor := False;
  lbl.Color       := $00790138;
  lbl.Visible     := False;

  lblMensagem.Caption     := EmptyStr;
  lblMensagem.Font.Name   := 'Tahoma';
  lblMensagem.Font.Color  := clWhite;
  lblMensagem.Font.Size   := 16;
  lblMensagem.Font.Style  := [fsBold];
  lblMensagem.Alignment   := taCenter;
  lblMensagem.Layout      := tlCenter;
  lblMensagem.Transparent := True;
  lblMensagem.ParentColor := False;
  lblMensagem.Visible     := False;

  ProgressBar.Width  := 451;
  ProgressBar.Height := 25;
end;

procedure TFormFundo.ExecuteThread(AProc: TProc; AProcTerminate: TNotifyEvent);
begin
  var LThread := TThread.CreateAnonymousThread(AProc);
  if Assigned(AProcTerminate) then
    LThread.OnTerminate := AProcTerminate;
  LThread.Start;
end;

procedure TFormFundo.Exibir(ASender: TObject; AExibirAguarde: Boolean; AMensagem: String;
                     AExibirBarraDeProgresso: Boolean; AExibirTelaCheia: Boolean);
begin
  if not Assigned(Self) then
    Exit;
  if Assigned(ASender) then
    FFormSender := ASender
  else
    FFormSender := nil;

  lbl.Visible           := AExibirAguarde;
  lblMensagem.Visible   := AMensagem <> EmptyStr;
  ProgressBar.Visible   := AExibirBarraDeProgresso;
  ProgressBar.Position  := 0;

  Show;
  if AExibirTelaCheia then
  begin
    Position := poDesigned;
    if not Assigned(FFormPai) then
    begin
      WindowState := TWindowState.wsMaximized;
      Height := Height - 50;
    end else
    begin
      Width := (FFormPai as TForm).Monitor.Width;
      Height := (FFormPai as TForm).Monitor.Height - 50;
      Position := poScreenCenter;
    end;
  end else
  begin
    Width    := TForm(FFormPai).Width - 14;
    Height   := TForm(FFormPai).Height - 7;
    Left     := TForm(FFormPai).Left + 7;
    Top      := TForm(FFormPai).Top;
  end;

  if AExibirAguarde then
  begin
    AlphaBlendValue := 200;
    AjustarTamanhoFonteLabel(lbl, 40);
  end else
  begin
    if FEsmaecer then
      AlphaBlendValue := 128
    else
      AlphaBlendValue := 0;
  end;
  if AMensagem <> EmptyStr then
  begin
    lblMensagem.Caption := AMensagem;
    AjustarTamanhoFonteLabel(lblMensagem, 16);
  end;

  Application.ProcessMessages;
end;

/// <summary> Fechar o form </summary>
/// <param name="Item">  </param>
/// <param name="Collection">  </param>
procedure TFormFundo.Fechar;
begin
  Hide;
  if Assigned(FFormSender) then
    if Assigned(TForm(FFormSender).ActiveControl)then
      PostMessage(TForm(FFormSender).ActiveControl.Handle,WM_SETFOCUS,0,0);
end;

end.
