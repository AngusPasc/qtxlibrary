unit qtx.storage.reader;

interface

//#############################################################################
//
//  Author:     Jon Lennart Aasenden [cipher diaz of quartex]
//  Copyright:  Jon Lennart Aasenden, all rights reserved
//
//
//  _______           _______  _______ _________ _______
// (  ___  )|\     /|(  ___  )(  ____ )\__   __/(  ____ \|\     /|
// | (   ) || )   ( || (   ) || (    )|   ) (   | (    \/( \   / )
// | |   | || |   | || (___) || (____)|   | |   | (__     \ (_) /
// | |   | || |   | ||  ___  ||     __)   | |   |  __)     ) _ (
// | | /\| || |   | || (   ) || (\ (      | |   | (       / ( ) \
// | (_\ \ || (___) || )   ( || ) \ \__   | |   | (____/\( /   \ )
// (____\/_)(_______)|/     \||/   \__/   )_(   (_______/|/     \|
//
//
// The QUARTEX library for Smart Mobile Studio is copyright
// Jon Lennart Aasenden. All rights reserved. This is a commercial product.
//
// Jon Lennart Aasenden LTD is a registered Norwegian company:
//
//      Company ID: 913494741
//      Legal Info: http://w2.brreg.no/enhet/sok/detalj.jsp?orgnr=913494741
//
//  The QUARTEX library of units is subject to international copyright
//  laws and regulations regarding intellectual properties.
//
//#############################################################################

uses 
  System.types,
  SmartCL.System;


type

  TQTXReader = Class(TObject)
  private
    FBuffer:  Variant;
  public
    function    Deserialize:String;
    procedure   Serialize(value:String);

    function    ReadStr(name:String;const decode:Boolean):String;
    function    ReadStrA(name:String):Array of String;

    function    ReadInt(name:String):Integer;
    function    ReadIntA(name:String):Array of integer;

    function    ReadBool(name:String):Boolean;
    function    ReadBoolA(name:String):Array of boolean;

    function    ReadFloat(name:String):float;
    function    ReadFloatA(name:String):Array of float;

    function    ReadDateTime(name:String):TDateTime;
    function    ReadDateTimeA(name:String):Array of TDateTime;

    function    Read(name:String):Variant;

    Constructor Create(const aBuffer:Variant);virtual;
  end;

implementation


uses qtx.helpers;

//############################################################################
// TQTXReader
//###########################################################################

Constructor TQTXReader.Create(const aBuffer:Variant);
begin
  inherited Create;
  if not aBuffer.IsUnassigned then
  Begin
    if not TVariant.IsNull(aBuffer) then
    begin
      (* The constructor can accept serialized JSON strings *)
      if TVariant.IsString(aBuffer) then
      serialize(aBuffer) else
      Fbuffer:=aBuffer;
    end else
    FBuffer:=TVariant.CreateObject;
  end else
  FBuffer:=TVariant.CreateObject;
end;

function TQTXReader.Deserialize:String;
begin
  if (FBuffer<>unassigned)
  and (FBuffer<>NULL) then
  result:=JSON.Stringify(FBuffer);
end;

procedure TQTXReader.Serialize(value:String);
begin
  value:=trim(Value);
  if value.length>0 then
  FBuffer:=JSON.Parse(value) else
  FBuffer:=TVariant.CreateObject;
end;

function TQTXReader.Read(name:String):Variant;
begin
  result:=FBuffer[name];
end;

function TQTXReader.ReadStr(name:String;const decode:Boolean):String;
begin
  result:=FBuffer[name];
  if decode then
  begin
    asm
      @result = atob(@result);
    end;
  end;
end;

function TQTXReader.ReadStrA(name:String):Array of String;
begin
  asm
    @result = @FBuffer[@name];
  end;
end;

function TQTXReader.ReadInt(name:String):Integer;
begin
  result:=FBuffer[name];
end;

function TQTXReader.ReadIntA(name:String):Array of integer;
begin
  asm
    @result = @FBuffer[@name];
  end;
end;

function TQTXReader.ReadBool(name:String):Boolean;
begin
  result:=FBuffer[name];
end;

function TQTXReader.ReadBoolA(name:String):Array of boolean;
begin
  asm
    @result = @FBuffer[@name];
  end;
end;

function TQTXReader.ReadFloat(name:String):float;
begin
  result:=FBuffer[name];
end;

function TQTXReader.ReadFloatA(name:String):Array of float;
begin
  asm
    @result = @FBuffer[@name];
  end;
end;

function TQTXReader.ReadDateTime(name:String):TDateTime;
begin
  result:=FBuffer[name];
end;

function TQTXReader.ReadDateTimeA(name:String):Array of TDateTime;
begin
  asm
    @result = @FBuffer[@name];
  end;
end;


end.
