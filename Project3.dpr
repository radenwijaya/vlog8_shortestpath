program Project3;

{$APPTYPE CONSOLE}

uses
  SysUtils, Diagnostics;

const
  map_size = 50;
  inf = maxint;

type
  intArray = array [0..map_size] of integer;

var
  nodes : integer;
  connArray : array of intArray; //described original connection
  distanceArray : array of intArray;
  distanceList : array of integer;

  backtrackArray : array of integer; //1
  backroute : array of integer;

  src, dest, sum : integer;

  //map [x, 0] is count of element, just like string
  map : array of intArray;

  stopwatch: TStopwatch;

function STP(src, dest : integer) : integer;
var
  loc : integer;
  i, j : integer;
  target : integer;
begin
  for i:=1 to nodes do distanceList[i]:=inf;
  distanceList[src]:=0;

  {
  initialisation
  }
  for i:=1 to distanceArray[src, 0] do
    begin
      target:=distanceArray[src, i];
      inc(map[target, 0]);
      map[target, map[target, 0]]:=connArray[src, i];
      distanceList[connArray[src, i]]:=target;

      backtrackArray[connArray[src, i]]:=src;
    end;

  {
  actual process time
  }
  loc:=0;
  repeat
    for i:=1 to map[loc, 0] do
      for j:=1 to connArray[map[loc, i], 0] do
      begin
        target:=loc+distanceArray[map[loc, i], j];
        if (distanceList[connArray[map[loc, i], j]]>target) then
        begin
          inc(map[target, 0]);
          map[target, map[target, 0]]:=connArray[map[loc, i], j];
          distanceList[connArray[map[loc, i], j]]:=target;

          backtrackArray[connArray[map[loc, i], j]]:=map[loc, i];
        end;
        if (map[loc, 0]>map_size) then
        begin
          writeln('Map too small, please increase');
          STP:=maxint;
          exit;
        end;
      end;
    inc(loc);

  until (distanceList[dest]<=loc) or (loc>=sum);

  STP:=distanceList[dest];
end;

procedure show_route();
var
  count, i : integer;
  backtrack : integer;
begin
  count:=0;
  backtrack:=dest;
  while (backtrack<>src) do
  begin
    inc(count);
    backtrack:=backtrackArray[backtrack];
    backroute[count]:=backtrack;
  end;

  write(src, ' ');
  for i:=count-1 downto 1 do
    write(backroute[i], ' ');
  writeln(dest);
end;

var
  i, j, number_c, connection, distance : integer;
begin
  stopwatch:=TStopWatch.StartNew;
  AssignFile(input, 'input.txt');
  reset(input);
  read(nodes);

  SetLength(connArray, nodes);
  SetLength(distanceList, nodes);
  SetLength(distanceArray, nodes);
  SetLength(backtrackArray, nodes);
  SetLength(backroute, nodes);

  read(src, dest);
  for i:=1 to nodes do
  begin
    read(number_c);
    j:=1;
    while j<=2*number_c do
    begin
      read(connection, distance);
      inc(connArray[i, 0]); //increment the no of connected node
      inc(distanceArray[i, 0]); //increment the no of connected node
      connArray[i, connArray[i, 0]]:=connection; //enter the connected node
      distanceArray[i, distanceArray[i, 0]]:=distance; //enter the distance
      inc(sum, distance);
      inc(j, 2);
    end;
  end;

  SetLength(map, 2*sum);

  close(input);
  writeln('input reading time: ', stopwatch.ElapsedMilliseconds);
  stopwatch.Reset;
  stopwatch.Start;
  writeln(STP(src, dest));
  writeln('process time: ', stopwatch.ElapsedMilliseconds);

  writeln('Route : ');
  show_route;

  AssignFile(input, '');
  readln;
  { TODO -oUser -cConsole Main : Insert code here }
end.
