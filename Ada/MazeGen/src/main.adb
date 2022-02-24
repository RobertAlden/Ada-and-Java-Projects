with MazeNodes; use MazeNodes;
with Ada.Text_IO; use Ada.Text_IO;

procedure Main is
   Dim : constant Integer := 5;
   type Coordinate is mod Dim;
   subtype Size is Integer range 1 .. Dim**2;
   type Maze is array(Size) of MazeNode;
   MazeNodeMap : Maze;
   function GetMazeNode(X : Coordinate;
                        Y : Coordinate) return MazeNode is
   begin
      return MazeNodeMap(Integer(Y)*Dim + (Integer(X)+1));
   end GetMazeNode;

   procedure DrawNode (N : MazeNode) is
      Edge : Boolean := False;
      procedure DrawTop(N : MazeNode; Edge : Boolean) is
      begin

         if Edge = True then -- Top Left
            Put("#");
            If N.NorthWall = True then -- Top Middle
               Put("#");
            else
               Put(" ");
            end if;
            Put("#"); -- Top Right
         end if;

      end DrawTop;
      procedure DrawMid(N : MazeNode; Edge : Boolean) is
      begin
         if Edge = True then -- Middle Left
            Put("#");
         end if;

         Put(" "); -- Center

         If N.EastWall = True then -- Middle Right
            Put("#");
         else
            Put(" ");
         end if;
      end DrawMid;
      procedure DrawBot(N : MazeNode; Edge : Boolean) is
      begin
         if Edge = True then -- Bottom Left
            Put("#");
         end if;
         if N.SouthWall = True then
            Put("#");
         else
            Put(" ");
         end if;
         Put("#");
      end DrawBot;

   begin
      DrawTop(N,Edge);
      DrawMid(N,Edge);
      DrawBot(N,Edge);
   end DrawNode;

   procedure DrawMaze is
      CurrentNode : MazeNode;
      RealDim : Integer := Dim * 3;
      CellX : Integer;
      CellY : Integer;
      CellIndex : Integer;
   begin
      For I in Size'First..Size'Last*9 loop
         CellX := (((I-1) mod RealDim) / 3) + 1;
         CellY := (Integer(Float'Truncation(Float(I-1) / Float(RealDim))) / 3) + 1;
         CellIndex := (CellY-1) * Dim + CellX;
         CurrentNode := MazeNodeMap(CellIndex);
         DrawNode(CurrentNode);
         if (I) mod (Dim * 3) = 0 then
            Put_Line("");
         end if;
      end loop;
   end DrawMaze;


begin
   For I in Size'First..Size'Last loop
      declare
         MazeNodeInst : MazeNode := (Connection => null,
                                     Conn_Dir => None,
                                     NorthWall => True,
                                     EastWall  => True,
                                     SouthWall => True,
                                     WestWall  => True,
                                     Index => I);
      begin
         MazeNodeMap(I) := MazeNodeInst;
      end;
   end loop;
   DrawMaze;

end Main;
