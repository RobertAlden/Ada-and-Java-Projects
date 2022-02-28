package MazeNodes is

   subtype MazeWall is Boolean;
   type Direction is (North, East, South, West, None);

   type MazeNode;
   type ptr_MazeNode is access all MazeNode;
   type MazeNode is tagged
      record
         Connection : ptr_MazeNode;
         Conn_Dir: Direction;
         NorthWall : MazeWall;
         EastWall : MazeWall;
         SouthWall : MazeWall;
         WestWall : MazeWall;
         Index : Integer;
         Visited : Boolean;
      end record;

   procedure Connect (This : in out MazeNode;
                      Target : in out ptr_MazeNode;
                      D : Direction);
end MazeNodes;
