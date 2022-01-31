///////////////////////////////////////////////////////////////////////////////
// Programador: Santiago A. Orellana Pérez
// Creado: 13/12/2013
// Prueba el algoritmo de clasificación de patrones por Densidad de Kernel.
///////////////////////////////////////////////////////////////////////////////

unit USimulador;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Math, UBaseDatosChenChangeLoy, Spin, ComCtrls,
  ExtCtrls;

const RangoMax = 1000;
const Incremento = 0.001;

type TKernel = (Epanechnikov,
                ArcoCoseno,
                Biweigth,
                Triweigth,
                Triangular,
                Gauss,
                Rectangular
                );

type TPatron = Array [1..CMuestras] of Array [1..CParametros] of Integer;
type TEntrada = Array [1..CParametros] of Integer;                

type
  TForm1 = class(TForm)
    ButtonComenzarSimulacion: TButton;
    GroupBoxUmbral: TGroupBox;
    TrackBarUmbral: TTrackBar;
    Label5: TLabel;
    GroupBoxSuavizado: TGroupBox;
    Label6: TLabel;
    TrackBarSuavizado: TTrackBar;
    GroupBox3: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    EditPrecision: TEdit;
    EditUsuarioPatron: TEdit;
    Label4: TLabel;
    EditUsuarioIntenta: TEdit;
    Label7: TLabel;
    EditTasaError: TEdit;
    Timer1: TTimer;
    Label8: TLabel;
    EditFAR: TEdit;
    Label9: TLabel;
    EditFRR: TEdit;
    procedure ButtonComenzarSimulacionClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TrackBarUmbralChange(Sender: TObject);
    procedure TrackBarSuavizadoChange(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    _u1, _u2, _m: Integer;
    Aceptados, Rechazados, _FAR, _FRR: Integer;
    function Kernel(t: Double; k: TKernel): Double;
    Function DensidadKernel(t, h: Double; X: Array of Double; tk: TKernel): Double;
    Function DensidadMaximaDeKernel(t, h: Double; X: Array of Double; tk: TKernel): Double;
    function EvaluarPuntuacion(p: Array of Double; Valor: Double): Double;
    function Validar(P: TPatron; E: TEntrada): Boolean;
    function CalcularUmbralDeUsuario(user: Integer): Integer;
  end;

var
  Form1: TForm1;

implementation


{$R *.dfm}

//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
procedure TForm1.FormCreate(Sender: TObject);
begin
DoubleBuffered := True;
EditPrecision.DoubleBuffered := True;
EditUsuarioPatron.DoubleBuffered := True;
EditUsuarioIntenta.DoubleBuffered := True;

TrackBarUmbral.Position := 65;
TrackBarUmbralChange(Self);
TrackBarSuavizado.Position := 1;
TrackBarSuavizadoChange(Self);
end;

//-----------------------------------------------------------------------------
// Kernel de densidad
//
// Implementa varios kernel de densidad que se emplean para
// la estimación no paramétrica de la densidad de un grupo
// de mediciones.
//
// Entradas:
// t = Valor para el cual se desea calcular la función kernel.
// k = Tipo de Kernel que se implementa. Estos pueden ser:
//     Epanechnikov, Biweigth, Triweigth, Triangular, Gauss,
//     ArcoCoseno, Rectangular.
//
// Salida:
// Devuelve el valor de la función kernel en t.
//-----------------------------------------------------------------------------
function TForm1.Kernel(t: Double; k: TKernel): Double;
const e = 2.71828182845;                                          //Esta es la constante de Euler.
begin
Result := 0;
try
   case k of
        Epanechnikov:
           if Abs(t) < 1 then
              Result := 3 * (1 - Sqr(t)) / 4;                        //Eficiencia = 1

        ArcoCoseno:
           if Abs(t) < 1 then
              Result := PI / 4 * Cos(PI / 2 * t);                    //Eficiencia -> 1

        Biweigth:
           if Abs(t) < 1 then
              Result := 15 * Power(1 - Sqr(t), 2) / 16;              //Eficiencia = 0.994

        Triweigth:
           if Abs(t) < 1 then
              Result := 35 * Power(1 - Sqr(t), 3) / 32;              //Eficiencia = 0.987

        Triangular:
           if Abs(t) < 1 then
              Result := 1 - Abs(t);                                  //Eficiencia = 0.986

        Gauss:
           Result := (1 / Sqrt(2 * PI)) * Power(e, -0.5 * Sqr(t));   //Eficiencia = 0.951

        Rectangular:
           if Abs(t) < 1 then
              Result := 0.5;                                         //Eficiencia = 0.930
        end;
except
   ShowMessage('Error aritmético...');
end;
end;

//-----------------------------------------------------------------------------
// Función de densidad
//
// Implementa la estimación de la función de densidad de un grupo
// de mediciones mediante el método no paramétrico conocido como
// "Método de los Kernel".
//
// Entradas:
// t  = Valor para el cual se desea calcular la función de densidad.
// h  = Parámetro de suavizado (Dandwith)
// X  = Arreglo que contiene los valores de las mediciones.
// tk = Especifica el tipo de Kernel que se empleará.
//
// Salida:
// Devuelve el valor de la función de densidad en t.
//-----------------------------------------------------------------------------
Function TForm1.DensidadKernel(t, h: Double; X: Array of Double; tk: TKernel): Double;
var i, n: Integer;
    S: Double;
begin
//h := Power(1.06 * StdDev(X) * Length(X), -0.25);

S := 0;
n := Length(X);
for i := 0 to n - 1 do
    S := S + Kernel(Abs(t - X[i]) / h, tk);
Result := S / (n * h);
end;

Function TForm1.DensidadMaximaDeKernel(t, h: Double; X: Array of Double; tk: TKernel): Double;
var i, n: Integer;
    S, v: Double;
begin
S := 0;
n := Length(X);
for i := 0 to n - 1 do
    S := Max(S, Kernel(Abs(t - X[i])*n, tk));
Result := S;
end;

//-----------------------------------------------------------------------------
// Asigna una puntuación al parámetro.
//-----------------------------------------------------------------------------
function TForm1.EvaluarPuntuacion(p: Array of Double;
                                  Valor: Double
                                  ): Double;
var n: Integer;
    v, h, r, s: Double;
    yMax: Double;
begin
Result := 0;

//Normaliza los datos en un rango de 0 a 1.
for n := 0 to Length(p) - 1 do
    begin
    p[n] := p[n] / RangoMax;
    if p[n] > 1 then p[n] := 1;
    end;
Valor := Valor / RangoMax;
if Valor > 1 then Valor := 1;    

//Calcula la densidad por el método de los kernel
//y determina el máximo de la función.
yMax := 0;
h := TrackBarSuavizado.Position * Incremento;
for n := 0 to RangoMax do
    yMax := Max(yMax, DensidadKernel(n / RangoMax, h, p, Triweigth));          

//Devuelve la puntuación.
Result := DensidadKernel(Valor, h, p, Triweigth) / yMax;
end;

//-----------------------------------------------------------------------------
// Devuelve TRUE si el usuario es válido.
// FALSE si no es válido.
//
// Entradas:
// UP = Usuario patrón.
// UE = Usuario entrante.
// Muestra = Muestra del usuario entrante que se valida.
//-----------------------------------------------------------------------------
function TForm1.Validar(P: TPatron; E: TEntrada): Boolean;
var vp: Array of Double;
    vr: Array of Double;
    n, m: Integer;
begin
Result := False;
SetLength(vr, CParametros);                            //Crea el arreglo para la puntuaciòn de cada parámetro.
SetLength(vp, CMuestras);                              //Crea el arreglo para los valores de los parámetros.
for n := 1 to CParametros do                           //Por cada parámetro del patrón:
    begin
    for m := 1 to CMuestras do vp[m - 1] := P[m, n];   //Guarda los valores que tiene el parámetro en cada una de las muestras tomadas.
    vr[n - 1] := EvaluarPuntuacion(vp, E[n]);          //Asigna una puntuación al parámetro entrante según el patrón.
    Application.ProcessMessages;
    end;
for n := 0 to CParametros - 1 do vr[n] := 1 - vr[n];
Result := Norm(vr) / Sqrt(CParametros) < 1 - (TrackBarUmbral.Position / TrackBarUmbral.Max);                  //Calcula la puntuación final y evalúa por un umbral.
end;

//-----------------------------------------------------------------------------
// Devuelve un valor de umbral para el usuario indicado.
//-----------------------------------------------------------------------------
function TForm1.CalcularUmbralDeUsuario(user: Integer): Integer;
var vp: Array of Double;
    vr: Array of Double;
    n, m, i: Integer;
    valor, puntos, p: Double;
begin
SetLength(vr, CParametros);                              //Crea el arreglo para la puntuaciòn de cada parámetro.
SetLength(vp, CMuestras);                                //Crea el arreglo para los valores de los parámetros.
for n := 1 to CParametros do                             //Por cada parámetro del patrón:
    begin
    for m := 1 to CMuestras do vp[m - 1] := CDB[user, m, n];   //Guarda los valores que tiene el parámetro en cada una de las muestras tomadas.

    //Busca la muestra de parámetro con puntuación mínima.
    puntos := MaxDouble;
    for i := 0 to CParametros - 1 do
        begin
        p := EvaluarPuntuacion(vp, vp[i]);
        if p < puntos then puntos := p;
        end;
    vr[n - 1] := puntos;                                 //Asigna una puntuación al parámetro entrante según el patrón.
    end;

//for n := 0 to CParametros - 1 do vr[n] := 1 - vr[n];
valor := Norm(vr) / Sqrt(CParametros) * 1.0;                  //Calcula la puntuación final.

Result := Round(TrackBarUmbral.Max * valor)
end;

//-----------------------------------------------------------------------------
// Prueba cada uno de los usuarios contra el resto para verificar
// que no puedan entrar los que no son válidos.
//-----------------------------------------------------------------------------
procedure TForm1.ButtonComenzarSimulacionClick(Sender: TObject);
var u1, u2, m: Integer;
begin
Timer1.Enabled := True;
Aceptados := 0;
Rechazados := 0;
_FAR := 0;
_FRR := 0;
for u1 := 1 to CUsuarios do
    begin
    _u1 := u1;
    EditUsuarioPatron.Text := IntToStr(u1);
    for u2 := 1 to CUsuarios do
        begin
        TrackBarUmbral.Position := CalcularUmbralDeUsuario(u1);
        Application.ProcessMessages;

        _u2 := u2;
           for m := 1 to CMuestras do
               begin
               _m := m;
               if Validar(TPatron(CDB[u1]), TEntrada(CDB[u2][m])) then
                  begin
                  Inc(Aceptados);
                  if u1 <> u2 then Inc(_FAR); 
                  end
               else
                  begin
                  Inc(Rechazados);
                  if u1 = u2 then Inc(_FRR); 
                  end;
               end;
        end;
    end;
end;

//-----------------------------------------------------------------------------
// Establece el umbral.
//-----------------------------------------------------------------------------
procedure TForm1.TrackBarUmbralChange(Sender: TObject);
begin
Label5.Caption := IntToStr(TrackBarUmbral.Position);
end;

//-----------------------------------------------------------------------------
// Establece el suavizado.
//-----------------------------------------------------------------------------
procedure TForm1.TrackBarSuavizadoChange(Sender: TObject);
begin
Label6.Caption := FloatToStrF(TrackBarSuavizado.Position * Incremento, ffFixed, 15, 4);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var T: Integer;
begin
T := _FAR + _FRR;

EditUsuarioPatron.Text := IntToStr(_u1);
EditUsuarioIntenta.Text := IntToStr(_u2) + ' (Muestra: ' + IntToStr(_m) + ')';

EditPrecision.Text := IntToStr((100*100*10) - T) + ' (' + FloatToStrF(100-T/(100*100*10)*100, ffFixed, 15, 4) + '%)';
EditTasaError.Text := IntToStr(T) + ' (' + FloatToStrF(T/(100*100*10)*100, ffFixed, 15, 4) + '%)';

EditFAR.Text := IntToStr(_FAR) + ' (' + FloatToStrF(_FAR/(100*99*10)*100, ffFixed, 15, 4) + '%)';
EditFRR.Text := IntToStr(_FRR) + ' (' + FloatToStrF(_FRR/(100*10)*100, ffFixed, 15, 4) + '%)';
end;

end.
