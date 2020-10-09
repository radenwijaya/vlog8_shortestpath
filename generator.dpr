program generator;

{$APPTYPE CONSOLE}

uses
  SysUtils;

const
  tsize = 1000000;
  interval = 10;

var
  i, j, x, connection, dest: integer;
  tbl: array [1..tsize, 0..10] of integer;
  uArray : array [1..tsize] of boolean;
begin
  AssignFile(output, 'input.txt');
  rewrite(output);
  randomize();
  writeln(tsize);
  writeln(1, ' ', tsize);
  x:=0;
  for i:=1 to tsize do
    begin
      connection:=random(4)+2; //guarantee minimum 2 and maximum 5
      tbl[i][0]:=connection;

      fillchar(uArray, sizeof(uArray), false);

      j:=1;
      while j<=2*connection do
      begin
        repeat
          dest:=interval*x+random(2*interval)+1; //guarantee to be larger than 0 and uninque
          if (dest>tsize) then
            dest:=random(tsize);
        until (uArray[dest]=false) and (dest<>i);
        uArray[dest]:=true;

        tbl[i][j]:=dest;
        tbl[i][j+1]:=random(5)+1; //guarantee to range 1 to 5

        inc(j, 2);
      end;
      if (i mod interval=0) then inc(x);
    end;

  for i:=1 to tsize do
    begin
        write(tbl[i, 0], ' ');
      for j:=1 to tbl[i, 0]*2 do
        write(tbl[i, j], ' ');
      writeln;
    end;

  close(output);
end.
