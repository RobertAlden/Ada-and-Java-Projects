with MazeNodes; use MazeNodes;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Containers.Vectors;
with Ada.Numerics.Discrete_Random;

procedure Main is
   Dim : constant Integer := 25;
   type Coordinate is mod Dim;
   subtype Size is Integer range 1 .. Dim**2;
   type Maze is array(1..Dim,1..Dim) of aliased MazeNode;
   MazeNodeMap : Maze;


   procedure DrawMaze is
      CurrentNode : MazeNode;
      RealDim : Integer := Dim;
      TopEdge : Boolean := True;
      LeftEdge : Boolean := True;

      procedure DrawTop(N : MazeNode; TEdge : Boolean; LEdge : Boolean) is
      begin
         if TEdge = True then -- Top Left
            if LEdge = True then
               Put("||");
            end if;
            If N.NorthWall = True then -- Top Middle
               Put("||");
            else
               Put("  ");
            end if;
            Put("||"); -- Top Right
         end if;

      end DrawTop;
      procedure DrawMid(N : MazeNode; Edge : Boolean) is
      begin
         if Edge = True then -- Middle Left
            Put("||");
         end if;

         Put("  "); -- Center

         If N.EastWall = True then -- Middle Right
            Put("||");
         else
            Put("  ");
         end if;
      end DrawMid;
      procedure DrawBot(N : MazeNode; Edge : Boolean) is
      begin
         if Edge = True then -- Bottom Left
            Put("||");
         end if;
         if N.SouthWall = True then
            Put("||");
         else
            Put("  ");
         end if;
         Put("||");
      end DrawBot;
   begin
      For I in 1..Dim loop
         For K in 1..Dim loop
            TopEdge := (I = 1);
            LeftEdge := (K = 1);
            CurrentNode := MazeNodeMap(K,I);
            DrawTop(CurrentNode,TopEdge, LeftEdge);
         end loop;
         if TopEdge = True then
            Put_Line("");
         end if;
         For K in 1..Dim loop
            LeftEdge := (K = 1);
            CurrentNode := MazeNodeMap(K,I);
            DrawMid(CurrentNode,LeftEdge);
         end loop;
         Put_Line("");
         For K in 1..Dim loop
            LeftEdge := (K = 1);
            CurrentNode := MazeNodeMap(K,I);
            DrawBot(CurrentNode,LeftEdge);
         end loop;
         Put_Line("");
      end loop;
   end DrawMaze;

   procedure MazeGenBacktrack is
      subtype Random_Direction is Direction range North..West;
      subtype Random_Coordinate is Integer range 1..Dim;

      package R is new
        Ada.Numerics.Discrete_Random (Random_Direction);
      use R;

      G : Generator;
      Dir : Random_Direction;

      package MazeNodeVector is new
        Ada.Containers.Vectors
          (Index_Type   => Natural,
           Element_Type => Integer);
      use MazeNodeVector;

      Stack : aliased MazeNodeVector.Vector;
      Visited : aliased MazeNodeVector.Vector;

      -- ConnectionPointer : ptr_MazeNode;
      CurrentCell : ptr_MazeNode;
      NextCell : ptr_MazeNode;
      UnvisitedNeighbor : Boolean;
      ValidDirection : Boolean;
      CellX : Integer;
      CellY : Integer;

      function IndexToPtr(Index : Integer) return ptr_MazeNode is
         pCellX : Integer;
         pCellY : Integer;
      begin
         pCellX := (Index mod Dim) + 1;
         pCellY := (Index / Dim) + 1;
         return MazeNodeMap(pCellX,pCellY)'Unchecked_Access;
      end IndexToPtr;
   begin
      Reset(G);

      --Choose the initial cell, mark it as visited and push it to the stack
      CurrentCell := MazeNodeMap(Dim/2,Dim/2)'Unchecked_Access;
      CurrentCell.Visited := True;
      Stack.Append(CurrentCell.all.Index);
      --While the stack is not empty
      While not Stack.Is_Empty loop
         --Pop a cell from the stack and make it a current cell
         CurrentCell := IndexToPtr(Stack.First_Element);
         Stack.Delete_First;
         --If the current cell has any neighbours which have not been visited
         UnvisitedNeighbor := False;
         For D in North..West loop
            CellX := (CurrentCell.Index mod Dim) + 1;
            CellY := (CurrentCell.Index / Dim) + 1;
            case D is
               when North =>
                  CellY := CellY - 1;
               when East  =>
                  CellX := CellX + 1;
               when South =>
                  CellY := CellY + 1;
               when West  =>
                  CellX := CellX - 1;
            end case;
            if CellX in 1..Dim and CellY in 1..Dim then
               if MazeNodeMap(CellX,CellY).Visited = False then
                  UnvisitedNeighbor := True;
               end if;
            end if;
         end loop;
         if UnvisitedNeighbor = True then
            --Push the current cell to the stack
            Stack.Append(CurrentCell.Index);
            --Choose one of the unvisited neighbours
            ValidDirection := False;
            While ValidDirection = False loop
               CellX := (CurrentCell.Index mod Dim) + 1;
               CellY := (CurrentCell.Index / Dim) + 1;
               Dir := Random(G);
               case Dir is
               when North =>
                  CellY := CellY - 1;
               when East  =>
                  CellX := CellX + 1;
               when South =>
                  CellY := CellY + 1;
               when West  =>
                  CellX := CellX - 1;
               end case;
               if CellX in 1..Dim and CellY in 1..Dim then
                  if MazeNodeMap(CellX,CellY).Visited = False then
                     ValidDirection := True;
                     NextCell := MazeNodeMap(CellX,CellY)'Unchecked_Access;
                  end if;
               end if;
            end loop;
            --Remove the wall between the current cell and the chosen cell
            CurrentCell.Connect(NextCell,Dir);
            Put_Line(Integer'Image(CurrentCell.Index) & " to" & Integer'Image(NextCell.Index));
            Put_Line(Direction'Image(Dir));
            --Mark the chosen cell as visited and push it to the stack
            NextCell.Visited := True;
            Stack.Prepend(NextCell.Index);
         end if;
      end loop;
      NextCell := MazeNodeMap(1,1)'Unchecked_Access;
      MazeNodeMap(1,1).Connect(NextCell,North);
      NextCell := MazeNodeMap(Dim,Dim)'Unchecked_Access;
      MazeNodeMap(Dim,Dim).Connect(NextCell,South);
   end MazeGenBacktrack;

begin

   For I in 1..Dim loop
      For K in 1..Dim loop
         declare
            MazeNodeInst : MazeNode := (Connection => null,
                                        Conn_Dir => None,
                                        NorthWall => True,
                                        EastWall  => True,
                                        SouthWall => True,
                                        WestWall  => True,
                                        Index => (K-1)*Dim + (I-1),
                                        Visited => False
                                       );
         begin
            MazeNodeMap(I,K) := MazeNodeInst;
         end;
      end loop;
   end loop;
   MazeGenBacktrack;
   DrawMaze;
end Main;
